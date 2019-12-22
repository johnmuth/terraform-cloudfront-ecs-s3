#!/usr/bin/env bash

dockerImage=terraform-cloudfront-ecs-s3

docker build --build-arg aws_access_key_id="${AWS_ACCESS_KEY_ID}" \
  --build-arg aws_secret_access_key="${AWS_SECRET_ACCESS_KEY}" \
  -t "${dockerImage}"\
  ./aws/

docker run -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY --rm -it "${dockerImage}"
