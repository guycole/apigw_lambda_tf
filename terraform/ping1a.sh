#!/bin/bash
#
# Title:ping1a.sh
# Description: Exercise ping post
# Development Environment:OS X 10.13.6
# Author:Guy Cole (guycole at gmail dot com)
#
URL=https://spwfffijce.execute-api.us-west-2.amazonaws.com/v01/ping
URL=https://9qbdxzd2w8.execute-api.us-west-2.amazonaws.com/v01/ping
URL=https://17g7mtoir5.execute-api.us-west-2.amazonaws.com/v01/ping
URL=https://juln2hi6pk.execute-api.us-west-2.amazonaws.com/v01/ping
#
curl -v -H "Content-Type:application/json" -d '{"preamble": {"messageType": "PING", "messageVersion": 1, "transactionUuid": "35A0542B-5607-428B-ABA6-ACCC70EE4741"}, "pingState": false}' $URL
#