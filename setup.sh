#!/bin/bash
# Build & Tag the jenkins to proper gcr
docker build -t jenkins .
docker tag jenkins <DOCKER_REGISTRY>/jenkins:latest