#!/bin/bash

export K6_WEB_DASHBOARD=true
export K6_WEB_DASHBOARD_PORT=9000
export K6_WEB_DASHBOARD_PERIOD=2s
# export K6_WEB_DASHBOARD_OPEN=true
export K6_WEB_DASHBOARD_EXPORT='./report.html'
export PARTICIPANT=dbiagi

k6 run \
    --summary-export "./logs/k6-$(date +%Y-%m-%dH%H-%M-%S).log" \
    -e PARTICIPANT=$PARTICIPANT \
    "../../rinha-test/rinha.js"
