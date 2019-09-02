#!/bin/bash
#
# Title:ping1a.sh
# Description: Exercise ping post
# Development Environment:OS X 10.13.6
# Author:Guy Cole (guycole at gmail dot com)
#
URL=https://spwfffijce.execute-api.us-west-2.amazonaws.com/v01/ping
URL=https://urkrc9f02j.execute-api.us-west-2.amazonaws.com/v01/ping
URL=https://0mx3mennw2.execute-api.us-west-2.amazonaws.com/v01/ping
URL=https://k5d2k62wvl.execute-api.us-west-2.amazonaws.com/v01/ping
#
curl -v -H "Content-Type:application/json" -d '{"preamble": {"pingState": false}' $URL
curl -v -H "Content-Type:application/json" -d '{"preamble": {"messageType": "PING", "messageVersion": 1, "transactionUuid": "35A0542B-5607-428B-ABA6-ACCC70EE4741"}, "pingState": false}' $URL
#