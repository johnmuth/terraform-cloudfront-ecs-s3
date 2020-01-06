#!/usr/bin/env bash

usage() { echo "Usage: $0 -r <region> -b <bucket>" 1>&2; exit 1; }

region=''
bucket=''
while getopts "hr:b:" o; do
    case "${o}" in
        r)
            region=${OPTARG}
            ;;
        b)
            bucket=${OPTARG}
            ;;
        *)
            echo "Unrecognized option ${o} ${OPTARG}"
            usage
            ;;
    esac
done

set -e
set -u

docker run --rm \
	-t $(tty &>/dev/null && echo "-i") \
	-e "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" \
	-e "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" \
	-e "AWS_DEFAULT_REGION=${region}" \
	-v "$(pwd):/project" \
	mesosphere/aws-cli \
	s3 cp /project/hello-world.txt "s3://${bucket}/"
