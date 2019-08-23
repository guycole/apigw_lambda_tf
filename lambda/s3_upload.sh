#!/bin/bash
#
# Title:s3_upload.sh
# Description: upload lambda to s3
# Development Environment: OS X 10.13.6
# Author: G.S. Cole (guycole at gmail dot com)
#
PATH=/bin:/usr/bin:/etc:/usr/local/bin; export PATH
#
AWS_REGION=us-west-2
AWS_PROFILE=gsc_braingang
AWS_BUCKET=lambda.braingang.net
#
rm -f ping-v01.zip
zip ping-v01.zip ping_v01.py app/*.py
aws s3 cp ping-v01.zip s3://$AWS_BUCKET --profile $AWS_PROFILE
#
