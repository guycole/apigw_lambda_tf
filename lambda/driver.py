#
# Title:driver.py
# Description:
# Development Environment:OS X 10.13.6/Python 3.7.2
# Lambda Environment: Python 3.7 runtime
# Legalise:Copyright (C) 2019 Shasta Traction, INC.
# Author:Guy Cole (guy at shastrax dot com)
#
#
#{"preamble": {"messageType": "PING", "messageVersion": 1, "transactionUuid": "35A0542B-5607-428B-ABA6-ACCC70EE4741"}, "pingState": false}
#
import json

from app.dispatcher import Dispatcher

print("start")

if __name__ == "__main__":
    print("main")

    raw_message = "{\"preamble\": {\"messageType\": \"PING\", \"messageVersion\": 1, \"transactionId\": \"35A0542B-5607-428B-ABA6-ACCC70EE4741\"}, \"pingState\": false}"
    json_message = json.loads(raw_message)
    print(json_message)

    dispatcher = Dispatcher()
    response = dispatcher.execute("PING", json_message)
    print(response)

print("stop")