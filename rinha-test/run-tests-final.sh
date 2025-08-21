#!/usr/bin/env bash

export GIT_EDITOR=true

startContainers() {
  pushd ../payment-processor >/dev/null
  docker compose up --build -d 1>/dev/null 2>&1
  popd >/dev/null
  pushd ../participantes/$1 >/dev/null
  services=$(docker compose config --services | wc -l)
  echo "" >docker-compose-final.logs
  nohup docker compose up --build >>docker-compose-final.logs &
  popd >/dev/null
}

stopContainers() {
  pushd ../participantes/$1
  docker compose down -v --remove-orphans
  docker compose rm -s -v -f
  docker image prune --force --all
  sudo find * -group root | xargs sudo rm -rf
  popd >/dev/null
  pushd ../payment-processor >/dev/null
  docker compose down --volumes >/dev/null
  popd >/dev/null
}

scheduleReboot() {
  epoch=$(date +%s)
  schedule_epochtime=$((epoch + (5 * 60)))
  schedule_datetime=$(date -d @$schedule_epochtime +"%Y-%m-%dT%H:%M:%S")

  aws scheduler create-schedule \
    --name OneTimeScheduler-$epoch \
    --schedule-expression "at($schedule_datetime)" \
    --target "{\"Arn\": \"arn:aws:lambda:us-east-1:${AWS_ACCOUNT}:function:start-ec2-instance\", \"RoleArn\": \"arn:aws:iam::${AWS_ACCOUNT}:role/service-role/start-ec2-instance-role\"}" \
    --flexible-time-window '{"Mode": "OFF"}' \
    --region us-east-1
}

maybeReboot() {
  pushd ../participantes/$1 >/dev/null
  pull_errors=$(grep -l "Error toomanyrequests" docker-compose-final.logs | wc -l)
  if [ $pull_errors -gt 0 ]; then
    echo "Preparing to shutdown due to docker pull limit errors"
    stopContainers $1
    rm docker-compose-final.logs
    rm final-results.json
    scheduleReboot
    sleep 15
    sudo shutdown now
    kill -9 $$
    exit 0
  fi
  popd >/dev/null
}

MAX_REQUESTS=603

start=$(date)

for directory in ../participantes/*; do
  (
    participant=$(echo $directory | sed -e 's/..\/participantes\///g' -e 's/\///g')
    echo ""
    echo ""
    echo "========================================"
    echo "  Participant $participant starting..."
    echo "========================================"

    testedFile="$directory/final-results.json"

    if ! test -f $testedFile; then
      touch $testedFile
      echo "executing test for $participant..."
      stopContainers $participant
      startContainers $participant
      maybeReboot $participant

      success=1
      max_attempts=15
      attempt=1
      while [ $success -ne 0 ] && [ $max_attempts -ge $attempt ]; do
        curl -f -s --max-time 3 localhost:9999/payments-summary
        success=$?
        echo "tried $attempt out of $max_attempts..."
        sleep 5
        ((attempt++))
      done

      if [ $success -eq 0 ]; then
        echo "" >$directory/k6-final.logs
        k6 run -e MAX_REQUESTS=$MAX_REQUESTS -e PARTICIPANT=$participant -e TOKEN=$(uuidgen) --log-output=file=$directory/k6-final.logs rinha-final.js
        stopContainers $participant
        echo "======================================="
        echo "working on $participant"
        sed -i '1001,$d' $directory/docker-compose-final.logs
        sed -i '1001,$d' $directory/k6-final.logs
        echo "log truncated at line 1000" >>$directory/docker-compose-final.logs
        echo "log truncated at line 1000" >>$directory/k6-final.logs
      else
        stopContainers $participant
        echo "[$(date)] Seu backend não respondeu nenhuma das $max_attempts tentativas de GET para http://localhost:9999/payments-summary. Teste abortado." >$directory/error-final.logs
        echo "[$(date)] Inspecione o arquivo docker-compose-final.logs para mais informações." >>$directory/error-final.logs
        echo "Could not get a successful response from backend... aborting test for $participant"
      fi

      echo "================================="
      echo "  Finished testing $participant!"
      echo "================================="

      sleep 5

    else
      echo ""
      echo " skipping $participant..."
      echo ""
    fi
  )
done

date
echo ""=================================""
echo "       Generating results!"
echo ""=================================""

RESULTADOS_FINAIS=../RESULTADOS_FINAIS.md

results=$(find ../participantes/*/final-results.json -size +1b | wc -l)
errors=$(find ../participantes/*/final-results.json -size 0 | wc -l)
total=$(find ../participantes/*/final-results.json | wc -l)

echo -e "# Resultados Finais da Rinha de Backend 2025" >$RESULTADOS_FINAIS
echo -e "Atualizado em **$(date)**" >>$RESULTADOS_FINAIS
echo -e "$total submissões / $results resultados / $errors submissões com erro" >>$RESULTADOS_FINAIS
echo -e "*Testes executados com MAX_REQUESTS=$MAX_REQUESTS*."
echo -e "\n" >>$RESULTADOS_FINAIS
echo -e "| participante | p99 | bônus por desempenho (%) | multa ($) | lucro | submissão |" >>$RESULTADOS_FINAIS
echo -e "| -- | -- | -- | -- | -- | -- |" >>$RESULTADOS_FINAIS

for partialResult in ../participantes/*/final-results.json; do
  (
    participant=$(echo $partialResult | sed -e 's/..\/participantes\///g' -e 's/\///g' -e 's/partial\-results\.json//g')
    link="https://github.com/zanfranceschi/rinha-de-backend-2025/tree/main/participantes/$participant"

    if [ -s $partialResult ]; then
      cat $partialResult | jq -r '(["|", .participante, "|", .p99.valor, "|", .p99.bonus, "|", .multa.total, "|", .total_liquido, "|", "['$participant']('$link')"]) | @tsv' >>$RESULTADOS_FINAIS
    fi
  )
done

echo -e "### Submissões com Erro" >>$RESULTADOS_FINAIS
echo -e "\n" >>$RESULTADOS_FINAIS
echo -e "| participante | submissão |" >>$RESULTADOS_FINAIS
echo -e "| -- | -- |" >>$RESULTADOS_FINAIS
for errorLog in ../participantes/*/error-final.logs; do
  (
    participant=$(echo $errorLog | sed -e 's/..\/participantes\///g' -e 's/\///g' -e 's/error-final\.logs//g')
    link="https://github.com/zanfranceschi/rinha-de-backend-2025/tree/main/participantes/$participant"
    echo "| $participant | [logs]($link) |" >>$RESULTADOS_FINAIS
  )
done

RESULTADOS_FINAIS_JSON=../resultados-finais+participantes-info.json
python3 resultados_finais_json.py $RESULTADOS_FINAIS_JSON

end=$(date)

echo " ACABOU!!! "
echo "Começou em $start e terminou em $end."
