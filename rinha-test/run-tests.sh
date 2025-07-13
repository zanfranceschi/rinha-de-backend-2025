#!/usr/bin/env bash

startContainers() {
    pushd ../payment-processor > /dev/null
        docker compose up --build -d 1> /dev/null 2>&1
    popd > /dev/null
    pushd ../participantes/$1 > /dev/null
        services=$(docker compose config --services | wc -l)
        cat /dev/null >| docker-compose.logs 
        nohup docker compose up --build >> docker-compose.logs &
    popd > /dev/null
    #expectedServicesUp=$(( services + 4 ))
    #servicesUp=$(docker ps | grep ' Up ' | wc -l)
}

stopContainers() {
    pushd ../participantes/$1
        docker compose rm -f
        docker compose down --volumes
        docker compose rm -v -f
    popd > /dev/null
    pushd ../payment-processor > /dev/null
        docker compose down --volumes > /dev/null
    popd > /dev/null
}

MAX_REQUESTS=500

while true; do
    for directory in ../participantes/*; do
    (
        git pull
        participant=$(echo $directory | sed -e 's/..\/participantes\///g' -e 's/\///g')
        echo "participant: $participant"

        testedFile="$directory/partial-results.json"

        if ! test -f $testedFile; then
            echo "executing test for $participant..."
            stopContainers $participant
            startContainers $participant
            sleep 12
            k6 run -e MAX_REQUESTS=$MAX_REQUESTS -e PARTICIPANT=$participant --log-output=file=$directory/k6.logs rinha.js
            stopContainers $participant
            if test -f $testedFile; then
                git add $testedFile
                git add $directory/k6.logs
                git add $directory/docker-compose.logs
                git commit -m "add $participant's partial result"
                git push
            fi
            #echo "submissão '$participant' já testada - ignorando"
            #rm -rf "$RESULTS_WORKSPACE/$participant"
            #countAPIsToBeTested
            #startApi $participant
            #startTest $participant
            #stopApi $participant
            #echo "testada em $(date)" > $testedFile
            #echo "abra um PR removendo esse arquivo caso queira que sua API seja testada novamente" >> $testedFile
        else
            echo "skipping $participant"
        fi
    )
    done

    date
    echo "generating results preview..."
    
    echo -e "# Prévia do Resultados da Rinha de Backend 2025" > ../PREVIA_RESULTADOS.md
    echo -e "Atualizado em **$(date)**" >> ../PREVIA_RESULTADOS.md
    echo -e "*Testes executados com MAX_REQUESTS=$MAX_REQUESTS*."
    echo -e "\n" >> ../PREVIA_RESULTADOS.md
    echo -e "| participante | bônus p99 | multa | lucro |" >> ../PREVIA_RESULTADOS.md
    echo -e "| -- | -- | -- | -- |" >> ../PREVIA_RESULTADOS.md

    for partialResult in ../participantes/*/partial-results.json; do
    (
        if test -f $partialResult; then
            cat $partialResult | jq -r '(["|", .participante, "|", .p99.bonus, "|", .multa.total, "|", .total_liquido, "|"]) | @tsv' >> ../PREVIA_RESULTADOS.md
        fi
    )

    git pull
    git add ../PREVIA_RESULTADOS.md
    git commit -m "previa resultados @ $(date)"
    git push
    done
    sleep 60
done
