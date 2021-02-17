#!/bin/bash
set -x

docker build -t randyfay/gitpod-bug-repro:latest .
docker push randyfay/gitpod-bug-repro:latest