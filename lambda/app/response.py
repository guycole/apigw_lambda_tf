#
# Title:response.py
# Description: response
# Development Environment:OS X 10.13.6/Python 3.7.2
# AWS Lambda Environment: Python 3.6 runtime
# Author:Guy Cole (guycole at gmail dot com)
#
from .utility import Utility


class ResponseMessage:

    def __init__(self):
        self.message_error = ''
        self.message_status = ''
        self.message_type = ''
        self.message_version = 1
        self.preamble = ''
        self.time_stamp = ''
        self.transaction_uuid = ''

        self.time_stamp = Utility.get_time_stamp()

    def preamble_factory(self, message_error, message_status, message_type, transaction_uuid):
        self.message_status = message_status
        self.message_type = message_type
        self.transaction_uuid = transaction_uuid

        self.preamble = {'messageStatus':self.message_status,
                         'messageType':self.message_type,
                         'messageVersion':self.message_version,
                         'timeStamp':self.time_stamp,
                         'transactionId':self.transaction_uuid}

        if message_error is not None:
            self.message_error = message_error
            self.preamble['messageError'] = self.message_error

        return self.preamble

    def fail_response(self, message_error, reqmsg):
        self.preamble_factory(message_error, 'fail', reqmsg.message_type, reqmsg.transaction_uuid)

    def ok_response(self, reqmsg):
        self.preamble_factory(None, 'ok', reqmsg.message_type, reqmsg.transaction_uuid)

# ;;; Local Variables: ***
# ;;; mode:python ***
# ;;; End: ***