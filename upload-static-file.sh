#!/usr/bin/env bash

if [ -z "${AWS_DEFAULT_REGION}" ]; then
  echo "set AWS_DEFAULT_REGION"
  exit 1;
fi

docker run --rm \
	-t $(tty &>/dev/null && echo "-i") \
	-e "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" \
	-e "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" \
	-e "AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}" \
	-v "$(pwd):/project" \
	mesosphere/aws-cli \
	s3 cp /project/hello-world.txt s3://cloudfront-ecs-s3/
