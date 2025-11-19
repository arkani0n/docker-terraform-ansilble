#!/bin/bash
IMAGE_TAG="1.0"
REPO="SOME"
docker build -t $REPO:$IMAGE_TAG .
docker push $REPO:$IMAGE_TAG