#!/usr/bin/env /bin/bash

if [ "$ENV" = "dev" ]; then
    echo "Deploy code to S3 dev"
    export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID_DEV
    export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY_DEV
elif [ "$ENV" = "stg" ]; then
    echo "Deploy code to S3 stg"
    export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID_STG
    export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY_STG
elif [ "$ENV" = "prd" ]; then
    echo "Deploy code to S3 prd"
    export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID_PRD
    export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY_PRD
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
echo "DEPLOY_S3_SRC_DIR: $DEPLOY_S3_SRC_DIR"
echo "DEPLOY_S3_BUCKET: $DEPLOY_S3_BUCKET"
echo "DEPLOY_S3_OPTIONS: $DEPLOY_S3_OPTIONS"
echo "aws s3 sync $DEPLOY_S3_SRC_DIR s3://$DEPLOY_S3_BUCKET/$S3_BUCKET_DIR_NAME $DEPLOY_S3_OPTIONS"

echo $TRAVIS_TAG

aws s3 ls
