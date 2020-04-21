#!/usr/bin/sh

# Installing AWS CLI
pip install awscli --cache-dir $PIP_CACHE_DIR

# Setting PATH
export PATH=$PATH:$HOME/.local/bin

# Setting Default Parameter
mkdir ~/.aws
cp ./travis_ci/environment/aws_config ~/.aws/config