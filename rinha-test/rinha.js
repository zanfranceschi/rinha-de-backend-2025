import { textSummary } from 'https://jslib.k6.io/k6-summary/0.1.0/index.js';
import { uuidv4 } from "https://jslib.k6.io/k6-utils/1.4.0/index.js";
import { sleep } from "k6";
import exec from "k6/execution";
import { Counter } from "k6/metrics";
import {
  token,
  setPPToken,
  setPPDelay,
  setPPFailure,
  resetPPDatabase,
  getPPPaymentsSummary,
  resetBackendDatabase,
  getBackendPaymentsSummary,
  requestBackendPayment
} from "./requests.js";

const MAX_REQUESTS = __ENV.MAX_REQUESTS ?? 500;

export const options = {
  summaryTrendStats: [
    "p(99)",
    "count",
  ],
  thresholds: {
    //http_req_failed: [{ threshold: "rate < 0.01", abortOnFail: false }],
    //payments_inconsistency: ["count == 0"]
    //http_req_duration: ['p(99) < 50'],
    //payments_count: ['count > 3500'],
  },
  scenarios: {
    payments: {
      exec: "payments",
      executor: "ramping-vus",
      startVUs: 1,
      gracefulRampDown: "0s",
      stages: [{ target: MAX_REQUESTS, duration: "60s" }],
    },
    payments_consistency: {
      exec: "checkPayments",
      executor: "constant-vus",
      //startTime: "5s",
      duration: "60s",
      vus: "1",
    },
    stage_00: {
      exec: "define_stage",
      startTime: "1s",
      executor: "constant-vus",
      vus: 1,
      duration: "1s",
      tags: {
        defaultDelay: "0",
        defaultFailure: "false",
        fallbackDelay: "0",
        fallbackFailure: "false",
      },
    },
    stage_01: {
      exec: "define_stage",
      startTime: "10s",
      executor: "constant-vus",
      vus: 1,
      duration: "1s",
      tags: {
        defaultDelay: "100",
        defaultFailure: "false",
        fallbackDelay: "0",
        fallbackFailure: "false",
      },
    },
    stage_02: {
      exec: "define_stage",
      startTime: "20s",
      executor: "constant-vus",
      vus: 1,
      duration: "1s",
      tags: {
        defaultDelay: "100",
        defaultFailure: "true",
        fallbackDelay: "0",
        fallbackFailure: "false",
      },
    },
    stage_03: {
      exec: "define_stage",
      startTime: "30s",
      executor: "constant-vus",
      vus: 1,
      duration: "1s",
      tags: {
        defaultDelay: "2000",
        defaultFailure: "true",
        fallbackDelay: "1000",
        fallbackFailure: "true",
      },
    },
    stage_04: {
      exec: "define_stage",
      startTime: "40s",
      executor: "constant-vus",
      vus: 1,
      duration: "1s",
      tags: {
        defaultDelay: "20",
        defaultFailure: "false",
        fallbackDelay: "20",
        fallbackFailure: "false",
      },
    },
    stage_05: {
      exec: "define_stage",
      startTime: "50s",
      executor: "constant-vus",
      vus: 1,
      duration: "1s",
      tags: {
        defaultDelay: "0",
        defaultFailure: "false",
        fallbackDelay: "5000",
        fallbackFailure: "false",
      },
    },
  },
};

const transactionsSuccessCounter = new Counter("transactions_success");
const transactionsFailureCounter = new Counter("transactions_failure");
const totalTransactionsAmountCounter = new Counter("total_transactions_amount");
const balanceInconsistencyCounter = new Counter("balance_inconsistency_amount");

const defaultTotalAmountCounter = new Counter("default_total_amount");
const defaultTotalRequestsCounter = new Counter("default_total_requests");
const fallbackTotalAmountCounter = new Counter("fallback_total_amount");
const fallbackTotalRequestsCounter = new Counter("fallback_total_requests");

const defaultTotalFeeCounter = new Counter("default_total_fee");
const fallbackTotalFeeCounter = new Counter("fallback_total_fee");

export async function setup() {
  await resetPPDatabase("default");
  await resetPPDatabase("fallback");
  await resetBackendDatabase();
  await setPPToken("default", token);
  await setPPToken("fallback", token);
}

export async function teardown() {
  
  const to = new Date();
  const from = new Date(to.getTime() - 70 * 1000); // 1 minuto e 10 segundos atrás

  console.info(`summaries from ${from.toISOString()} to ${to.toISOString()}`);

  const defaultResponse = await getPPPaymentsSummary("default", from.toISOString(), to.toISOString());
  const fallbackResponse = await getPPPaymentsSummary("fallback", from.toISOString(), to.toISOString());
  const backendPaymentsSummary = await getBackendPaymentsSummary(from.toISOString(), to.toISOString());

  totalTransactionsAmountCounter.add(
    backendPaymentsSummary.default.totalAmount +
    backendPaymentsSummary.fallback.totalAmount);

  defaultTotalAmountCounter.add(backendPaymentsSummary.default.totalAmount);
  defaultTotalRequestsCounter.add(backendPaymentsSummary.default.totalRequests);
  fallbackTotalAmountCounter.add(backendPaymentsSummary.fallback.totalAmount);
  fallbackTotalRequestsCounter.add(backendPaymentsSummary.fallback.totalRequests);

  const defaultTotalFee = defaultResponse.feePerTransaction * backendPaymentsSummary.default.totalAmount;
  const fallbackTotalFee = fallbackResponse.feePerTransaction * backendPaymentsSummary.fallback.totalAmount;

  defaultTotalFeeCounter.add(defaultTotalFee);
  fallbackTotalFeeCounter.add(fallbackTotalFee);
}

const paymentRequestFixedAmount = 19.90;

export async function payments() {

  const payload = {
    correlationId: uuidv4(),
    amount: paymentRequestFixedAmount
  };

  const response = await requestBackendPayment(payload);

  if ([200, 201, 202, 204].includes(response.status)) {
    transactionsSuccessCounter.add(1);
    transactionsFailureCounter.add(0);
  } else {
    transactionsSuccessCounter.add(0);
    transactionsFailureCounter.add(1);
  }

  sleep(1);
}

export async function checkPayments() {

  const now = new Date();

  const from = new Date(now - 1000 * 10).toISOString();
  const to = new Date(now - 100).toISOString();

  const defaultAdminPaymentsSummary = await getPPPaymentsSummary(
    "default",
    from,
    to,
  );
  const fallbackAdminPaymentsSummary = await getPPPaymentsSummary(
    "fallback",
    from,
    to,
  );
  const backendPaymentsSummary = await getBackendPaymentsSummary(from, to);

  const inconsistencies =
    Math.abs(
      backendPaymentsSummary.default.totalAmount -
      defaultAdminPaymentsSummary.totalAmount,
    ) +
    Math.abs(
      backendPaymentsSummary.fallback.totalAmount -
      fallbackAdminPaymentsSummary.totalAmount,
    );

  balanceInconsistencyCounter.add(inconsistencies);

  sleep(10);
}

export async function define_stage() {
  const defaultMs = parseInt(exec.vu.metrics.tags["defaultDelay"]);
  const fallbackMs = parseInt(exec.vu.metrics.tags["fallbackDelay"]);
  const defaultFailure = exec.vu.metrics.tags["defaultFailure"] === "true";
  const fallbackFailure = exec.vu.metrics.tags["fallbackFailure"] === "true";

  await setPPDelay("default", defaultMs);
  await setPPDelay("fallback", fallbackMs);

  await setPPFailure("default", defaultFailure);
  await setPPFailure("fallback", fallbackFailure);

  sleep(1);
}

export function handleSummary(data) {

  const expected_total_amount = data.metrics.transactions_success.values.count * paymentRequestFixedAmount;
  const actual_total_amount = data.metrics.total_transactions_amount.values.count;
  const difference_total_amount = expected_total_amount - actual_total_amount;

  const default_total_fee = data.metrics.default_total_fee.values.count;
  const fallback_total_fee = data.metrics.fallback_total_fee.values.count;
  const total_fee = default_total_fee + fallback_total_fee;

  const p_99 = data.metrics["http_req_duration{expected_response:true}"].values["p(99)"];
  const p_99_bonus = Math.max((11 - p_99) * 0.02, 0);
  const contains_inconsistencies = difference_total_amount != 0 || data.metrics.balance_inconsistency_amount.values.count != 0;
  const inconsistencies_fine = contains_inconsistencies ? 0.35 : 0;

  const liquid_partial_amount = (actual_total_amount - total_fee);

  const liquid_amount = liquid_partial_amount
    + (liquid_partial_amount * p_99_bonus)
    - (liquid_partial_amount * inconsistencies_fine);

  const name = __ENV.PARTICIPANT ?? "anonymous";

  const custom_data = {
    participante: name,
    descricao: "'total_liquido' é sua pontuação final. Equivale ao seu lucro. Fórmula: total_liquido + (total_liquido * p99.bonus) - (total_liquido * multa.porcentagem)",
    total_liquido: liquid_amount,
    total_bruto: actual_total_amount,
    total_taxas: total_fee,
    p99: {
      valor: `${p_99}ms`,
      bonus: p_99_bonus,
      max_requests: MAX_REQUESTS,
      descricao: "Fórmula para o bônus: max((11 - p99.valor) * 0.02, 0)",
    },
    multa: {
      porcentagem: inconsistencies_fine,
      total: (liquid_partial_amount * inconsistencies_fine),
      composicao: {
        descricao: "Se 'total_bruto' != 'total_bruto_esperado' ou 'total_inconsistencias' > 0, há multa de 35%.",
        total_bruto_esperado: expected_total_amount,
        total_inconsistencias: data.metrics.balance_inconsistency_amount.values.count,
      }
    },
    pagamentos: {
      qtd_sucesso: data.metrics.transactions_success.values.count,
      qtd_falha: data.metrics.transactions_failure.values.count,
    },
    default: {
      total_bruto: data.metrics.default_total_amount.values.count,
      num_pagamentos: data.metrics.default_total_requests.values.count,
      total_taxas: data.metrics.default_total_fee.values.count,
    },
    fallback: {
      total_bruto: data.metrics.fallback_total_amount.values.count,
      num_pagamentos: data.metrics.fallback_total_requests.values.count,
      total_taxas: data.metrics.fallback_total_fee.values.count
    },
  };

  const result = {
    stdout: textSummary(data),
  };

  const participant = __ENV.PARTICIPANT;
  let summaryJsonFileName = `../participantes/${participant}/partial-results.json`

  if (participant == undefined) {
    summaryJsonFileName = `./partial-results.json`
  }

  result[summaryJsonFileName] = JSON.stringify(custom_data, null, 2);

  return result;
}
