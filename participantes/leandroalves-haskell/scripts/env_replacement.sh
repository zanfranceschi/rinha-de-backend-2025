#!/bin/bash
cat .env | sed "s/HEAD_SERVER=1/HEAD_SERVER=$HEAD_SERVER/" > .env.tmp
rm .env
mv .env.tmp .env
