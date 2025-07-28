DOCKER_COMPOSE = docker compose
DOCKER_COMPOSE_FILE = ./docker-compose.yaml
PROCESSORS_DOCKER_COMPOSE_FILE = ../../payment-processor/docker-compose.yml

.PHONY: infra-up infra-down processors-infra-up processors-infra-down run-k6 start

infra-up:
	${DOCKER_COMPOSE} up -d

infra-down:
	${DOCKER_COMPOSE} down

processors-infra-up:
	${DOCKER_COMPOSE} -f ${PROCESSORS_DOCKER_COMPOSE_FILE} up -d

processors-infra-down:
	${DOCKER_COMPOSE} -f ${PROCESSORS_DOCKER_COMPOSE_FILE} down

run-k6:
	./run.sh

start:
	make processors-infra-down
	make processors-infra-up
	make infra-down
	make infra-up
	make run-k6
