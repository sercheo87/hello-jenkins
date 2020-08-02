#!/usr/bin/env bash

echo 'Create image'
docker build --force-rm -t nexussrv.com:14441/novopayment/tools/ci/postman-builder:1.0.0 .

echo 'Push image'
docker push nexussrv.com:14441/novopayment/tools/ci/postman-builder:1.0.0
