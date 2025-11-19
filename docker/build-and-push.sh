#!/bin/bash
IMAGE_TAG="1.0"
REPO="arkanion/custom-nginx"


docker build -t $REPO:$IMAGE_TAG .
docker push $REPO:$IMAGE_TAG