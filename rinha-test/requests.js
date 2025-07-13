import { Httpx } from 'https://jslib.k6.io/httpx/0.1.0/index.js';
import exec from 'k6/execution';

const initialToken = '123';
export const token = __ENV.TOKEN ?? initialToken;

const paymentProcessorDefaultHttp = new Httpx({
    baseURL: 'http://localhost:8001',
    headers: {
        'Content-Type': 'application/json',
        'X-Rinha-Token': token
    },
    timeout: 1500,
});

const paymentProcessorFallbacktHttp = new Httpx({
    baseURL: 'http://localhost:8002',
    headers: {
        'Content-Type': 'application/json',
        'X-Rinha-Token': token
    },
    timeout: 1500,
});

const backendHttp = new Httpx({
    baseURL: "http://localhost:9999",
    //baseURL: "http://localhost:5123",
    headers: {
        "Content-Type": "application/json",
    },
    timeout: 1500,
});

const paymentProcessorHttp = {
    "default": paymentProcessorDefaultHttp,
    "fallback": paymentProcessorFallbacktHttp,
};

export async function setPPToken(service, token) {

    const httpClient = paymentProcessorHttp[service];
    const params = { headers: { 'X-Rinha-Token': initialToken } };

    const payload = JSON.stringify({
        token: token
    });

    const response = await httpClient.asyncPut('/admin/configurations/token', payload, params);

    if (response.status != 204) {
        exec.test.abort(`Erro ao definir token para ${service} (HTTP ${response.status}).`);
    }
}

export async function setPPDelay(service, ms) {

    const httpClient = paymentProcessorHttp[service];

    const payload = JSON.stringify({
        delay: ms
    });

    const response = await httpClient.asyncPut('/admin/configurations/delay', payload);

    if (response.status != 200) {
        exec.test.abort(`Erro ao definir delay para ${service} (HTTP ${response.status}).`);
    }
}

export async function setPPFailure(service, failure) {

    const httpClient = paymentProcessorHttp[service];

    const payload = JSON.stringify({
        failure: failure
    });

    const response = await httpClient.asyncPut('/admin/configurations/failure', payload);

    if (response.status != 200) {
        exec.test.abort(`Erro ao definir failure para ${service} (HTTP ${response.status}).`);
    }
}

export async function resetPPDatabase(service) {

    const httpClient = paymentProcessorHttp[service];
    const response = await httpClient.asyncPost('/admin/purge-payments');

    if (response.status != 200) {
        exec.test.abort(`Erro ao resetar database para ${service} (HTTP ${response.status}).`);
    }
}

export async function getPPPaymentsSummary(service, from, to) {

    const httpClient = paymentProcessorHttp[service];
    const response = await httpClient.asyncGet(`/admin/payments-summary?from=${from}&to=${to}`);

    if (response.status == 200) {
        return JSON.parse(response.body);
    }

    console.error(`Não foi possível obter resposta de '/admin/payments-summary?from=${from}&to=${to}' para ${service} (HTTP ${response.status})`);

    return {
        totalAmount: 0,
        totalRequests: 0,
        feePerTransaction: 0,
        totalFee: 0
    }
}

export async function resetBackendDatabase() {

    try {
        await backendHttp.asyncPost('/purge-payments');
    } catch (error) {
        console.info("Seu backend provavelmente não possui um endpoint para resetar o banco. Isso não é um problem.", error.message);
    }
}

export async function getBackendPaymentsSummary(from, to) {

    const response = await backendHttp.asyncGet(`/payments-summary?from=${from}&to=${to}`);

    if (response.status == 200) {
        return JSON.parse(response.body);
    }

    console.error(`Não foi possível obter resposta de '/payments-summary?from=${from}&to=${to}' para o backend (HTTP ${response.status})`);

    return {
        default: {
            totalAmount: 0,
            totalRequests: 0
        },
        fallback: {
            totalAmount: 0,
            totalRequests: 0
        }
    }
}

export async function requestBackendPayment(payload) {

    const response = await backendHttp.asyncPost('/payments', JSON.stringify(payload));
    return response;
}
