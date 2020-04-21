#!/usr/bin/env /bin/bash

if [ "$ENV" = "dev" ]; then
    echo "Deploy code to S3 dev"
    AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID_DEV
    AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY_DEV
elif [ "$ENV" = "stg" ]; then
    echo "Deploy code to S3 stg"
    AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID_STG
    AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY_STG
elif [ "$ENV" = "prd" ]; then
    echo "Deploy code to S3 prd"
    AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID_PRD
    AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY_PRD
    S3_BUCKET_DIR_NAME="$(echo $TRAVIS_TAG | cut -d'_' -f2)"
    echo "Private S3 Buckett directory: $S3_BUCKET_DIR_NAME"
else
    echo "Incorrect ENV"
    exit 1
fi

if [[  -z ${AWS_ACCESS_KEY_ID} ]] || [[  -z ${AWS_SECRET_ACCESS_KEY} ]]; then
    echo "Missing AWS_ACCESS_KEY_ID or AWS_SECRET_ACCESS_KEY value"
fi

cd $TRAVIS_BUILD_DIR
echo "Sync code to AWS S3 private bucket"
echo "ENV: $ENV"
echo "AWS_ACCESS_KEY_ID: $AWS_ACCESS_KEY_ID"
echo "AWS_SECRET_ACCESS_KEY: $AWS_SECRET_ACCESS_KEY"
echo "S3_BUCKET_DIR_NAME: $S3_BUCKET_DIR_NAME"
aws --version
