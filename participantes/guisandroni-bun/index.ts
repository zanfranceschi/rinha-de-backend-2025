import { Elysia, t } from "elysia";
import Redis from "ioredis";
import { availableParallelism } from 'os';
import cluster from 'cluster';

const PORT = process.env['PORT'] || 3000;
const REDIS_URL = process.env['REDIS_URL'];
const PAYMENT_DEFAULT_URL = process.env['PAYMENT_PROCESSOR_DEFAULT'];
const PAYMENT_FALLBACK_URL = process.env['PAYMENT_PROCESSOR_FALLBACK'];

if (!REDIS_URL) {
    throw new Error("A variável de ambiente REDIS_URL é obrigatória.");
}

if (!PAYMENT_DEFAULT_URL || !PAYMENT_FALLBACK_URL) {
    throw new Error("As variáveis de ambiente PAYMENT_PROCESSOR_DEFAULT e PAYMENT_PROCESSOR_FALLBACK são obrigatórias.");
}

const redis = new Redis(REDIS_URL);

const QUEUES = {
    INCOMING: 'payments:queue:incoming',
    PROCESSING: 'payments:queue:processing',
    FAILED: 'payments:queue:failed'
};

const DB_KEYS = {
    PAYMENTS_BY_DATE: 'payments:zset:by_date',
    PAYMENT_DATA_PREFIX: 'payments:hash:'
};

const paymentBodySchema = t.Object({
    correlationId: t.String({ format: "uuid" }),
    amount: t.Number({ minimum: 0.01 })
});

const summaryQuerySchema = t.Object({
    from: t.Optional(t.String({ format: 'date-time' })),
    to: t.Optional(t.String({ format: 'date-time' }))
});

type PaymentPayload = {
    correlationId: string;
    amount: number;
    requestedAt: string;
};

const sleep = (ms: number) => new Promise(resolve => setTimeout(resolve, ms));

async function startWorker(redis: Redis) {
    console.log(`[Worker ${process.pid}] Iniciando processamento da fila...`);

    while (true) {
        try {
            const paymentString = await redis.blmove(QUEUES.INCOMING, QUEUES.PROCESSING, 'RIGHT', 'LEFT', 0);
            
            if (!paymentString) continue;

            console.log(`[Worker ${process.pid}] Processando pagamento: ${paymentString}`);

            const [correlationId, amountStr] = paymentString.split(':');
            const paymentPayload: PaymentPayload = {
                correlationId,
                amount: parseFloat(amountStr),
                requestedAt: new Date().toISOString()
            };

            const success = await processPaymentWithFallback(paymentPayload);

            if (success) {
                const hashKey = `${DB_KEYS.PAYMENT_DATA_PREFIX}${correlationId}`;
                await redis.pipeline()
                    .hset(hashKey, paymentPayload)
                    .zadd(DB_KEYS.PAYMENTS_BY_DATE, new Date(paymentPayload.requestedAt).getTime(), hashKey)
                    .lrem(QUEUES.PROCESSING, 1, paymentString)
                    .exec();
                
                console.log(`[Worker ${process.pid}] Pagamento ${correlationId} processado e salvo.`);
            } else {
                console.error(`[Worker ${process.pid}] Falha final ao processar ${correlationId}. Movendo para dead-letter queue.`);
                await redis.pipeline()
                    .lrem(QUEUES.PROCESSING, 1, paymentString)
                    .rpush(QUEUES.FAILED, paymentString)
                    .exec();
            }

        } catch (error) {
            console.error(`[Worker ${process.pid}] Erro catastrófico no loop do worker:`, error);
            await sleep(1000);
        }
    }
}

async function processPaymentWithFallback(payload: PaymentPayload): Promise<boolean> {
    const MAX_RETRIES = 3;
    let lastError: any;

    for (let attempt = 1; attempt <= MAX_RETRIES; attempt++) {
        try {
            const response = await fetch(PAYMENT_DEFAULT_URL!, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(payload)
            });

            if (response.ok) return true;

            const fallbackResponse = await fetch(PAYMENT_FALLBACK_URL!, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(payload)
            });

            if (fallbackResponse.ok) return true;
            
            lastError = new Error(`Fallback também falhou (status ${fallbackResponse.status})`);

        } catch (error) {
            lastError = error;
        }

        if (attempt < MAX_RETRIES) {
            const delay = 100 * Math.pow(2, attempt);
            await sleep(delay);
        }
    }
    
    console.error(`Todas as ${MAX_RETRIES} tentativas falharam para ${payload.correlationId}.`, lastError);
    return false;
}

function startServer(redis: Redis) {
    const app = new Elysia()
        .onError(({ code, error }) => {
            console.error(`[Elysia Error] Code: ${code}, Error: ${error.toString()}`);
            return new Response(error.toString(), { status: 500 });
        })
        .post('/payments', async ({ body }) => {
            const { correlationId, amount } = body;
            const paymentString = `${correlationId}:${amount}`;

            await redis.lpush(QUEUES.INCOMING, paymentString);

            return { status: "queued", correlationId };
        }, { body: paymentBodySchema })
        .get('/payments-summary', async ({ query }) => {
            const from = query.from ? new Date(query.from).getTime() : '-inf';
            const to = query.to ? new Date(query.to).getTime() : '+inf';

            const paymentKeys = await redis.zrangebyscore(DB_KEYS.PAYMENTS_BY_DATE, from, to);
            
            if (paymentKeys.length === 0) {
                return [];
            }

            const pipeline = redis.pipeline();
            paymentKeys.forEach(key => pipeline.hgetall(key));
            const results = await pipeline.exec();
            
            const payments = results?.map(([err, data]) => {
                if (err || !data) return null;
                const paymentData = data as Record<string, string>;
                return {
                    ...paymentData,
                    amount: parseFloat(paymentData['amount']),
                };
            }).filter(p => p !== null);

            return payments;
        }, { query: summaryQuerySchema });

    app.listen({
        port: PORT as number,
        hostname: '0.0.0.0',
    });
    console.log(`[Server ${process.pid}] 🚀 Elysia rodando em http://0.0.0.0:${PORT}`);
}

if (cluster.isPrimary) {
    const numWorkers = 4; // Limita o número de workers
    console.log(`[Primary ${process.pid}] Processo primário rodando.`);
    console.log(`[Primary ${process.pid}] Criando ${numWorkers} workers...`);

    for (let i = 0; i < numWorkers; i++) {
        cluster.fork();
    }

    cluster.on('exit', (worker, code, signal) => {
        console.error(`[Primary ${process.pid}] Worker ${worker.process.pid} morreu com código ${code} e sinal ${signal}. Reiniciando...`);
        cluster.fork();
    });

    startServer(redis);
} else {
    startWorker(redis);
}