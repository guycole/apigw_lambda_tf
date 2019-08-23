#
# Title:request.py
# Description: request
# Development Environment:OS X 10.13.6/Python 3.7.2
# AWS Lambda Environment: Python 3.6 runtime
# Author:Guy Cole (guycole at gmail dot com)
#
from .utility import Utility


class RequestMessage:

    def __init__(self):
        self.message_type = ''
        self.message_version = ''
        self.original = ''
        self.preamble = ''
        self.transaction_uuid = ''

#        self.time_stamp = Utility.get_time_stamp()

    def preamble_parser(self, payload):
        self.original = payload

        try:
            self.preamble = payload['preamble']
            self.message_type = self.preamble['messageType']
            self.message_version = self.preamble['messageVersion']
            self.transaction_uuid = self.preamble['transactionId']
        except KeyError as keyError:
            print("request.parser keyError:%s" % keyError)
            return False

        return True

#    def preamble_factory(self):
#        self.preamble = {json_v01.JSON_MESSAGE_TYPE():self.message_type,
#                         json_v01.JSON_MESSAGE_VERSION():self.message_version,
#                         json_v01.JSON_TIME_STAMP():self.time_stamp,
#                         json_v01.JSON_TRANSACTION_UUID():self.transaction_uuid}
#
#        return self.preamble

#;;; Local Variables: ***
#;;; mode:python ***
#;;; End: ***