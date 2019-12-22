#!/usr/bin/env bash

dockerImage=terraform-cloudfront-ecs-s3

docker run -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY --rm -it "${dockerImage}" destroy
