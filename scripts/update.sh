#!/bin/bash -ex

: "${STACK_NAME:?Need to set STACK_NAME}"

template_file="tmp/packaged.yaml"

bash scripts/package.sh
aws cloudformation update-stack --template-body "file://$template_file" --stack-name "$STACK_NAME"