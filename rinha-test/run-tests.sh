#!/usr/bin/env bash

startContainers() {
    pushd ../payment-processor > /dev/null
        docker compose up --build -d 1> /dev/null 2>&1
    popd > /dev/null
    pushd ../participantes/$1 > /dev/null
        services=$(docker compose config --services | wc -l)
        docker compose up --build -d 1> /dev/null 2>&1
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
while true; do
    for directory in ../participantes/*; do
        (
            git pull
            participant=$(echo $directory | sed -e 's/..\/participantes\///g' -e 's/\///g')
            echo "participant: $participant"

            testedFile="$directory/partial-result.json"

            if ! test -f $testedFile; then
                echo "executing test for $participant..."
                stopContainers $participant
                startContainers $participant
                sleep 12
                k6 run -e MAX_REQUESTS=850 -e PARTICIPANT=$participant rinha.js
                stopContainers $participant
                if test -f $testedFile; then
                    git add $testedFile
                    git commit -m "add $participant's partial result"
                    git push
                end
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
    sleep 60
done
