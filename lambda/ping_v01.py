#
# Title:ping_v01.py
# Description: service a ping message
# Development Environment:OS X 10.13.6/Python 3.7.2
# Lambda Environment: Python 3.7 runtime
# Author:Guy Cole (guycole at gmail dot com)
#
#{"preamble": {"messageType": "PING", "messageVersion": 1, "transactionUuid": "35A0542B-5607-428B-ABA6-ACCC70EE4741"}, "pingState": false}
#{"preamble": {"transactionUuid": "35A0542B-5607-428B-ABA6-ACCC70EE4741"}, "pingState": false}
#
import json

def happy201(flag, transaction_uuid):
    return (201, flag, transaction_uuid,)

def sad400(error_message):
    return (400, error_message,)

def preamble_test(payload):
    try:
        preamble = payload['preamble']
        message_type = preamble['messageType']
        message_version = preamble['messageVersion']
        message_verb = preamble['messageVerb']
        transaction_uuid = preamble['transactionUuid']
    except KeyError as keyError:
        print("preamble parser keyError:%s" % keyError)
        return None

    if message_type != 'PING':
        return None

    if message_version != 1:
        return None

    if len(transaction_uuid) != 36:
        return None

    return (transaction_uuid, message_verb,)

def state_flag(payload):
    try:
        return payload['pingState']
    except KeyError as keyError:
        print("state flag parser keyError:%s" % keyError)

    return None

def driver(payload):
    print(payload)
    preamble_parsed = preamble_test(payload)
    if preamble_parsed is None:
        return sad400('parse error')

    transaction_uuid, message_verb = preamble_parsed[0], preamble_parsed[1]

    flag = state_flag(payload)

    return happy201(not flag, transaction_uuid)


def handler(event, context):
    print("Received event: " + json.dumps(event, indent=2))
    print(vars(context))
    print('-x-x-x-x-x-x-x-')

    result = driver(event)
    print(result)

    if result[0] == 201:
        return {'statusCode':result[0], 'pingState':result[1], 'transactionUuid':result[2]}
    else:
        return {'statusCode':result[0], 'transactionUuid':result[1]}

print("start")

if __name__ == "__main__":
    print("main")

    preamble = {}
    preamble['transactionUuid'] = '4c109cdf-49ca-4c9d-922e-e76c5fb235d6'
    preamble['messageVerb'] = 'POST'
    preamble['messageVersion'] = 1
    preamble['messageType'] = 'PING'
    print(preamble)

    message = {}
    message['pingState'] = True
    message['preamble'] = preamble
    print(message)

    result = driver(message)
    print(result)

print("stop")
