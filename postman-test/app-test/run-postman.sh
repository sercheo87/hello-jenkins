#!/usr/bin/env bash

echo "Run postman"
newman run app-hello-jenkins.postman_collection.json \
  -e test-app-hello-jenkins.postman_environment.json \
  --reporters cli,junit,htmlextra \
  --reporter-junit-export 'postman-report.xml' \
  --reporter-htmlextra-export 'postman-report.html' \
  --reporter-htmlextra-title 'Report app-hello-jenkins' \
  --reporter-htmlextra-browserTitle 'Novopayment Report' \
  --reporter-htmlextra-logs \
  --insecure

echo 'Files...'
ls -la postman-test
