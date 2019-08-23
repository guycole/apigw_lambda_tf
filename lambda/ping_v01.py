#
# Title:ping_v01.py
# Description: service a ping message
# Development Environment:OS X 10.13.6/Python 3.7.2
# Lambda Environment: Python 3.7 runtime
# Author:Guy Cole (guycole at gmail dot com)
#
#
#{"preamble": {"messageType": "PING", "messageVersion": 1, "transactionUuid": "35A0542B-5607-428B-ABA6-ACCC70EE4741"}, "pingState": false}
#
import json

from app.dispatcher import Dispatcher

print("start")

def driver():
    raw_message = "{\"preamble\": {\"messageType\": \"PING\", \"messageVersion\": 1, \"transactionId\": \"35A0542B-5607-428B-ABA6-ACCC70EE4741\"}, \"pingState\": false}"
    json_message = json.loads(raw_message)
    print(json_message)

    dispatcher = Dispatcher()
    response = dispatcher.execute("PING", json_message)
    print(response)

def handler(event, context):
    print("Received event: " + json.dumps(event, indent=2))
    print('-x-x-x-x-x-x-x-')
    print(vars(context))
    print('-o-o-o-o-o-o-o-')

    print(json.dumps(event))


if __name__ == "__main__":
    print("main")
    driver()

print("stop")