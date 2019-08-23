#
# Title:dispatcher.py
# Description:
# Development Environment:OS X 10.13.6/Python 3.7.2
# AWS Lambda Environment: Python 3.6 runtime
# Author:Guy Cole (guycole at gmail dot com)
#
from .ping import PingRequestV1
from .ping import PingResponseV1

class Dispatcher:

    def ping_handler(self, json_message):
        reqmsg = PingRequestV1()
        resmsg = PingResponseV1()

        if reqmsg.preamble_parser(json_message) and reqmsg.payload_parser(json_message):
            if reqmsg.ping_state is True:
                payload = resmsg.payload(False)
            else:
                payload = resmsg.payload(True, reqmsg)
        else:
            print("ping parse failure")
            resmsg.fail_response('parse failure', reqmsg)
            payload = resmsg.payload()

        return payload

    def stub_handler(self, json_message):
        pass

    def execute(self, message_type, json_message):
        if message_type == "PING":
            return self.ping_handler(json_message)
        elif message_type == "STUB":
            return self.stub_handler(json_message)
        else:
            print(f"unknown message type {message_type}")

#;;; Local Variables: ***
#;;; mode:python ***
#;;; End: ***