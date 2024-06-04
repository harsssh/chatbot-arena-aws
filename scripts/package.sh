#!/bin/bash -ex

: "${S3_BUCKET:?Need to set S3_BUCKET}"

root_file="cfn/root.yaml"
output_file="tmp/packaged.yaml"

aws cloudformation package --template-file "$root_file" --s3-bucket "$S3_BUCKET" --output-template-file "$output_file"