#!/usr/bin/env bash

usage() { echo "Usage: $0 [-u (undo)]" 1>&2; exit 1; }

undo='false'
while getopts "uh" o; do
    case "${o}" in
        u)
            undo='true'
            ;;
        h)
            usage
            ;;
        *)
            echo "Unrecognized option ${o} ${OPTARG}"
            usage
            ;;
    esac
done

set -e
set -u

dirs='cloudfront-s3 s3 terraform-state cloudfront-ecs-s3'

namePrefix=$(git remote -v | head -n1 | awk '{print $2}' | cut -f2 -d':' |tr '/' '-'|sed "s/\.git//")

oldTerraformStateBucketName='terraform-state-bucket-name'
oldStaticFilesBucketName='static-files-bucket-name'
oldWebappName='webapp-name'
newTerraformStateBucketName="${namePrefix}-terraform-state"
newStaticFilesBucketName="${namePrefix}-static-files"
newWebappName="${namePrefix}-webapp"

if [ "$undo" != "true" ]; then
    for file in `grep -rl "$oldTerraformStateBucketName" $dirs`; do echo "$file"; sed -i '' "s/$oldTerraformStateBucketName/$newTerraformStateBucketName/g" "$file"; done
    for file in `grep -rl "$oldStaticFilesBucketName" $dirs`; do echo "$file"; sed -i '' "s/$oldStaticFilesBucketName/$newStaticFilesBucketName/g" "$file"; done
    for file in `grep -rl "$oldWebappName" $dirs`; do echo "$file"; sed -i '' "s/$oldWebappName/$newWebappName/g" "$file"; done
else
    for file in `grep -rl "$newTerraformStateBucketName" $dirs`; do echo "$file"; sed -i '' "s/$newTerraformStateBucketName/$oldTerraformStateBucketName/g" "$file"; done
    for file in `grep -rl "$newStaticFilesBucketName" $dirs`; do echo "$file"; sed -i '' "s/$newStaticFilesBucketName/$oldStaticFilesBucketName/g" "$file"; done
    for file in `grep -rl "$newWebappName" $dirs`; do echo "$file"; sed -i '' "s/$newWebappName/$oldWebappName/g" "$file"; done
fi

