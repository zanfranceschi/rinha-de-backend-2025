# Rinha de Backend - 2025

The Rinha de Backend is a challenge where you need to develop a backend solution in any technology, with the main goal of learning and sharing knowledge! This is the third edition of the challenge. The deadline for submitting your entry has not yet been defined.

![running chicken](./misc/imgs/header.jpg)

If you want to know more about the spirit of the Rinha de Backend, check out the repositories for the [first](https://github.com/zanfranceschi/rinha-de-backend-2023-q3) and [second](https://github.com/zanfranceschi/rinha-de-backend-2024-q1) editions, [watch some videos](https://www.youtube.com/results?search_query=rinha+de+backend), or [search the internet](https://www.google.com/search?q=rinha+de+backend) for it – you will find a lot of material!

#### Rinha on social media

[@rinhadebackend](https://x.com/rinhadebackend) on X
[@rinhadebackend.bsky.social](https://bsky.app/profile/rinhadebackend.bsky.social) on Bluesky
[zan](https://www.linkedin.com/in/francisco-zanfranceschi/) on LinkedIn (creator of the rinha)

## The Challenge
In this third edition of the Rinha de Backend, the challenge is to mediate (integrate) payment requests for payment processing services (called **Payment Processor** here) with the lowest financial fee per transaction. There will be two Payment Processor services: the **default** – with the lower fee – and the **fallback**, which has the higher fee and should only be used when the default service is unavailable.

*The source code for the **Payment Processor** is available [here](https://github.com/zanfranceschi/rinha-de-backend-2025-payment-processor).*

![alt text](./misc/imgs/arq-alto-nivel.png)

During the test, both services will experience sporadic instabilities (surprises) in the endpoints responsible for receiving payment processing requests. There are two types of instability:
1. Increased response times: the payments endpoint takes a long time to respond – from very to just slightly slow.
1. Service unavailable: the endpoint returns an HTTP 5XX server error and does not process payments.

It will be up to you to develop the best strategy to process payments as quickly as possible and with the lowest fee – this is the main objective of this edition of the Rinha. Please note that it is possible to send payment requests asynchronously. However, the faster you send payments to a Payment Processor, the better your chances of scoring well because at the end of the test, there will be a count of how many payments were processed. You will get fewer points if there are many payments not yet sent to the Payment Processor services at the end of the test. Obviously, you can also handle the integration synchronously. As mentioned before, it will be up to you to develop a strategy.

![alt text](./misc/imgs/exemplo-proc-assinc.png)

To make it easier to check the availability of the services, a **health-check** endpoint is provided for each service, which shows if the service is experiencing failures and what the minimum response time is for payment processing. However, this endpoint has a rate limit of one call every five seconds. If this limit is exceeded, an `HTTP 429 - Too Many Requests` response will be returned. Use it wisely!

The two Payment Processor services are identical in terms of endpoints – the only real difference is the fee. Again, the more payment processing requests are sent to the **default** service, the lower the fee you will pay, and this will be better for your score in the Rinha.

## How to Participate

People of all skill levels usually participate in the Rinha de Backend – from beginners to very experienced individuals. The most important thing about the Rinha is the spirit of cooperation among participants and learning. However, it is recommended that you have knowledge of some programming language, Docker, and Git – at least the basics. Oh, and you can participate in pairs, teams of three, teams of 15, individually, etc. The important thing is to participate!

The following sections show how to participate in the Rinha.

### Develop a backend with an HTTP API

You will need to create an API with the following endpoints.

#### Payments
The main endpoint that receives payment requests to be processed.
```
POST /payments
{
    "correlationId": "4a7901b8-7d26-4d9d-aa19-4dc1c7cf60b3",
    "amount": 19.90
}

HTTP 2XX
Anything
```
**request**
- `correlationId` is a required and unique field of type UUID.
- `amount` is a required field of type decimal.

**response**
- Any response in the 2XX range (200, 201, 202, etc.) is valid. The response body will not be validated – it can be anything or even empty.

#### Payments Summary
This endpoint needs to return a summary of what has already been processed in terms of payments.
```
GET /payments-summary?from=2020-07-10T12:34:56.000Z&to=2020-07-10T12:35:56.000Z

HTTP 200 - Ok
{
    "default" : {
        "totalRequests": 43236,
        "totalAmount": 415542345.98
    },
    "fallback" : {
        "totalRequests": 423545,
        "totalAmount": 329347.34
    }
}
```
**request**
- `from` is an optional timestamp field in ISO format in UTC.
- `to` is an optional timestamp field in ISO format in UTC.

**response**
- `default.totalRequests` is a required field of type integer.
- `default.totalAmount` is a required field of type decimal.
- `fallback.totalRequests` is a required field of type integer.
- `fallback.totalAmount` is a required field of type decimal.

**Important!**
This endpoint, along with the **Payments Summary** of the Payment Processors, will be called a few times during the test for consistency checks. The values must be consistent; otherwise, there will be a penalty for inconsistency.

#### Integrate your Backend with the two Payment Processors

Your backend must integrate with two Payment Processors. Both services have identical APIs, so the following descriptions apply to both.

#### Payments
This endpoint receives and computes a payment – it is similar to the **Payments** endpoint that your backend needs to provide. It is the main endpoint for you to integrate with your backend.
```
POST /payments
{
    "correlationId": "4a7901b8-7d26-4d9d-aa19-4dc1c7cf60b3",
    "amount": 19.90,
    "requestedAt" : "2025-07-15T12:34:56.000Z"
}

HTTP 200 - Ok
{
    "message": "payment processed successfully"
}
```
**request**
- `correlationId` is a required and unique field of type UUID.
- `amount` is a required field of type decimal.
- `requestedAt` is a required timestamp field in ISO format in UTC.

**response**
- `message` is an always-present field of type string.

#### Health-Check
This endpoint allows you to check the status of the **Payments** endpoint. This endpoint on both Payment Processor services can help you decide which is the best option to process a payment.

```
GET /payments/service-health

HTTP 200 - Ok
{
    "failing": false,
    "minResponseTime": 100
}
```
**request**
    - There are no request parameters. However, this endpoint imposes a rate limit – 1 call every 5 seconds. If this limit is exceeded, you will receive an HTTP 429 - Too Many Requests error response.

**response**
- `failing` is an always-present boolean field that indicates whether the **Payments** endpoint is available. If it is not, it means that requests to the endpoint will receive `HTTP 5XX` errors.
- `minResponseTime` is an always-present integer field indicating the best possible response time for the **Payments** endpoint. For example, if the returned value is `100`, there will be no responses faster than 100ms.

#### Payment Details
You do not need to integrate with this endpoint. It is for troubleshooting, should you want/need it.
```
GET /payments/{id}

HTTP 200 - Ok
{
    "correlationId": "4a7901b8-7d26-4d9d-aa19-4dc1c7cf60b3",
    "amount": 19.90,
    "requestedAt" : 2025-07-15T12:34:56.000Z
}
```
**request**
    - `{id}` is a required parameter of type UUID.

**response**
- `correlationId` is an always-present field of type UUID.
- `amount` is an always-present field of type decimal.
- `requestedAt` is an always-present timestamp field in ISO format in UTC.

#### Payment Processor Administrative Endpoints
The Payment Processor services have administrative endpoints. These endpoints will be used during the test BY THE TEST SCRIPT and you should not integrate with them in the final version. However, they can be useful for simulating failures, slow response times, checking consistency, etc. All the following endpoints require a token that must be provided in the `X-Rinha-Token` header of the request.

#### Payments Summary
This endpoint is similar to the **Payments Summary** endpoint you need to develop in your backend.
```
GET /admin/payments-summary?from=2020-07-10T12:34:56.000Z&to=2020-07-10T12:35:56.000Z

HTTP 200 - Ok
{
    "totalRequests": 43236,
    "totalAmount": 415542345.98,
    "totalFee": 415542.98,
    "feePerTransaction": 0.01
}
```
**request**
- `from` is an optional timestamp field in ISO format in UTC.
- `to` is an optional timestamp field in ISO format in UTC.

**response**
- `totalRequests` is an always-present integer field. It shows how many payments were processed in the selected period, or all payments if the period is not informed.
- `totalAmount` is an always-present decimal field. It shows the sum of all payments processed in the selected period, or the sum of all payments if the period is not informed.
- `totalFee` is an always-present decimal field. It shows the sum of the fees for payments processed in the selected period, or the sum of the fees for all payments if the period is not informed.
- `feePerTransaction` is an always-present decimal field. It shows the value of the fee per transaction.

**Important!**
This endpoint, along with the **Payments Summary** that your backend needs to provide, will be called a few times during the test for consistency checks. The values must be consistent; otherwise, there will be a penalty for inconsistency.

#### Set Token
This endpoint configures a password for the administrative endpoints. If you change the password in your final submission, the test will be aborted, and you will not receive a score in the Rinha. The initial password is `123`, and you can use it for local testing.
```
PUT /admin/configurations/token
{
    "token" : "any password"
}

HTTP 204 - No Content
```
**request**
- `token` is a required field of type string.

**response**
- N/A

#### Set Delay
This endpoint configures an intentional delay in the **Payments** endpoint to simulate a slower response time.
```
PUT /admin/configurations/delay
{
    "delay" : 235
}

HTTP 204 - No Content
```
**request**
- `delay` is a required integer field to define the delay in milliseconds for the response time of the **Payments** endpoint.

**response**
- N/A

#### Set Failure
This endpoint configures an intentional failure in the **Payments** endpoint to simulate server errors.
```
PUT /admin/configurations/failure
{
    "failure" : true
}

HTTP 204 - No Content
```
**request**
- `failure` is a required boolean field to define whether the **Payments** endpoint will return a failure.

**response**
- N/A

#### Database Purge
This endpoint deletes all payments from the database and is intended only to facilitate development.
```
POST /admin/purge-payments

HTTP 200 - Ok
{
    "message": "All payments purged."
}
```
**request**
- N/A

**response**
- `message` is an always-present field of type string.

#### Summary of Endpoints

The tables below provide a summary to facilitate a general overview of the solution.

**Endpoints to be developed**

| Endpoint                          | Description       |
| -                                 | -                 |
| POST /payments                    | Mediates the request for processing a payment. |
| GET /payments-summary             | Displays details of payment processing requests. |

**Endpoints available in the two Payment Processor services**
| Endpoint                          | Description       |
| -                                 | -                 |
| POST /payments                    | Requests the processing of a payment. |
| GET /payments/service-health      | Checks the operational status of the payments endpoint. Limit of 1 call every 5 seconds. |
| GET /payments/{id}                | Displays details of a payment processing request. |
| GET /admin/payments-summary       | Displays details of payment processing requests. |
| PUT /admin/configurations/token   | Resets an access token required for all endpoints prefixed with '/admin/'. |
| PUT /admin/configurations/delay   | Configures the delay in the payments endpoint. |
| PUT /admin/configurations/failure | Configures failure in the payments endpoint. |
| POST /admin/purge-payments        | Deletes all payments from the database. For development only. |

## Architecture

The following diagram shows the high-level design of the Rinha solution as a whole. The test will access your backend through port **9999** (you need to expose your endpoints on this port). And you will integrate with the two Payment Processors through the addresses `http://payment-processor-default:8080` and `http://payment-processor-fallback:8080`.

![general architecture](./misc/imgs/arquitetura-geral.png)

The Rinha – in parts – simulates real systems on a micro-scale (with very important differences such as low resilience, lack of scalability, focus on extreme performance with low resource consumption, etc.) and the easiest and cheapest way to do this is by using containers integrated with docker-compose. For this edition, the complete solution (the backend you will develop and the Payment Processors) will use two docker-compose files simulating different networks. You will need to create your `docker-compose.yml` file which will connect to the network of the Payment Processors' [docker-compose.yml](./payment-processor/docker-compose.yml).

![alt text](./misc/imgs/docker-compose-redes.png)

Snippet of the network and service definitions from the Payment Processors' [docker-compose.yml](./payment-processor/docker-compose.yml).
```yaml
# etc...

services:
  payment-processor-1:
    image: zanfranceschi/payment-processor
    networks:
      - payment-processor
    hostname: payment-processor-default
    ports:
      - 8001:8080
    # etc...

  payment-processor-2:
    image: zanfranceschi/payment-processor
    networks:
      - payment-processor
    hostname: payment-processor-fallback
    ports:
      - 8002:8080
    # etc...

networks:
  payment-processor:
    name: payment-processor
    driver: bridge
```

Example of network definitions and joining a service to the Payment Processors' network in the `docker-compose.yml` you might create.
```yaml
# etc...

services:
  my-backend:
    image: your-user/my-backend:latest
    networks:
      - backend
      - payment-processor
    environment:
      - PAYMENT_PROCESSOR_URL_DEFAULT=http://payment-processor-default:8080
      - PAYMENT_PROCESSOR_URL_FALLBACK=http://payment-processor-fallback:8080
    # etc...

networks:
  backend:
    driver: bridge
  payment-processor:
    external: true
```

This way, containers that declare both networks will be able to access the Payment Processors. The use of environment variables is an example of how you can reference the URLs of the Payment Processors. Note that the Docker DNS entries are `payment-processor-default` and `payment-processor-fallback` on port `8080`.

To integrate, develop, and explore the Payment Processors, just run the docker-compose for the Payment Processors. You will be able to access both services from your host machine at the addresses http://localhost:8001 and http://localhost:8002. The root URL shows some information and provides a link to explore the APIs as shown in the following image.

![image of two browsers with the initial page and a Redoc API explorer.](./misc/imgs/imagens-payment-processor-browser.png)

*****In summary****: your containers must integrate via http://payment-processor-default:8080 and http://payment-processor-fallback:8080 with the Payment Processors (don't forget to define the external network `payment-processor` in your docker-compose.yml) and you can also access them from the host machine via localhost on ports 8001 and 8002 (default and fallback respectively).*

**Important Note!**
After you have created your `docker-compose.yml` with your services, it is important that you start the Payment Processors' [docker-compose.yml](./payment-processor/docker-compose.yml) first so that the `payment-processor` network is created. Otherwise, you may receive a network-related error message when starting your containers.
```
network payment-processor declared as external, but could not be found
```

**Note for Mac Users**
Use [docker-compose-arm64.yml](./payment-processor/docker-compose-arm64.yml) if your processor is arm64.

### Restrictions

In previous editions, there were technology restrictions – for example, only certain databases could be used, load balancers, etc. In this edition, the technology restrictions have been relaxed – practically any technology can be used. However, the following container restrictions* must be applied:

- The network mode must be **bridge** – **host** mode is not allowed.
- **privileged** mode is not allowed.
- The use of [replicated](https://docs.docker.com/reference/compose-file/deploy/#replicas) services is not allowed – this makes it difficult to verify the resources used.

<sub><sup>* Any other restrictions may be added or removed during the event at the discretion of the event organizers.</sup></sub>

One of the essences of the Rinha de Backend is the restriction of computational resources. These restrictions must be declared along with the service declarations (or templates) in your `docker-compose.yml` and cannot exceed the following* (distributed as you wish among all services):

- 1.5 CPU units
- 350MB of memory

<sub><sup>* Subject to change during the event at the discretion of the event organizers.</sup></sub>

Use the `MB` unit to declare memory restrictions.

Example of resource restriction.
```yaml
services:
  load-balancer:
    image: nginx:latest
    deploy:
      resources:
        limits:
          cpus: "0.25"
          memory: "15MB"
    # etc...

# etc...
```

#### HTTP API Restrictions
Your backend must have at least two container instances that serve the HTTP endpoints – web servers. Unlike previous editions of the Rinha, you can have more than two instances of web servers, but not fewer than two.

![alt text](./misc/imgs/duas-instancias.png)

### How to Submit Your Backend

To have your backend officially tested by the Rinha de Backend, see the results in comparison with other submissions, and have your name listed as a participant, you will need to do the following:

- Have a public git repository (e.g., GitHub) with the source code and all artifacts related to the Rinha submission.

- Have your images declared in `docker-compose.yml` available in a public image registry (e.g., https://hub.docker.com/). The images must be built for the `linux/amd64` platform – this is especially important if you develop on Mac or Windows. Example of how to build a docker image for `linux/amd64`: `docker buildx build --platform linux/amd64 -t your-image-name:tag .`.

- Open a PR in this repository adding a directory with your identification in [participants](participants/). In this PR you must:
    - Do not include the source code in the submission! Your source code must be in another public repository as mentioned before.
    - Include a `README.md` explaining the technologies used and a link to the repository with the source code of your submission.
    - Include the `docker-compose.yml` file in the root of this repository with its dependencies (database scripts, configurations, etc.).
    - Include an `info.json` file with the following structure to facilitate the collection of the technologies used:
    ```json
    {
        "name": "Débora Nis Zanfranceschi",
        "social": ["https://x.com/debora-zan", "https://bsky.app/profile/debora-zan.bsky.social"],
        "source-code-repo": "https://github.com/debora-zan/rinha-de-backend-2025",
        "langs": ["node"],
        "storages": ["postgresql", "redis"],
        "messaging": ["rabbitmq", "nats"],
        "load-balancers": ["nginx"],
        "other-technologies": ["xpto"] // include anything that doesn't fit into the other categories
    }
    ```
    - Example of a submission PR file structure:
    ```
    ├─ participants/
    |  ├─ debs-node-01/
    |  |  ├─ docker-compose.yml
    |  |  ├─ info.json
    |  |  ├─ nginx.config
    |  |  ├─ sql/
    |  |  |  ├─ ddl.sql
    |  |  |  ├─ dml.sql
    |  |  ├─ README.md
    ```

**There is no limit on submissions per person. In past editions, some people submitted up to 4 backends in different technologies or architectures!** Obviously, each submission needs a different entry in the `participants` directory.

### How to Test Your Backend Locally

The most important part of the Rinha de Backend process (besides learning and fun) is testing. Therefore, it makes perfect sense that you should be able to test your backend more or less the same way as in the official test. In the last two editions, the Gatling tool was used, but many people asked for and suggested [k6](https://k6.io/), so for this edition, the tool used will be k6!!!

In the [rinha-test](./rinha-test) directory, you will find the necessary artifacts to test your backend locally. Note that the test provided here will not be exactly the same as the one used for the official tests, but it should be similar enough for you to develop, improve, and have fun locally during your development process. The [README.md](./rinha-test/README.md) file provides detailed instructions on how to run the tests.

That's it! Have fun and don't forget to post your progress on the Rinha de Backend's social networks (https://x.com/rinhadebackend, https://bsky.app/profile/rinhadebackend.bsky.social, and https://www.linkedin.com/in/francisco-zanfranceschi/).

## Open Points

The following are issues that have not yet been addressed or are open points:

- Deadline for submissions and results
- Repository to store the results (or keep them in the same one?)
- Scoring definition
- Automation of test execution
- Final test script
- Final format of the `info.json` file in submissions

Please contribute to this event by reviewing texts, reporting problems, bugs, and inconsistencies, giving suggestions, and spreading the word. Be a part of this community

