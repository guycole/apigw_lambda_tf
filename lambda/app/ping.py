#
# Title:ping.py
# Description: service a ping message
# Development Environment:OS X 10.13.6/Python 3.7.2
# Lambda Environment: Python 3.6 runtime
# Author:Guy Cole (guycole at gmail dot com)
#
from .request import RequestMessage
from .response import ResponseMessage


class PingRequestV1(RequestMessage):

    def __init__(self):
        RequestMessage.__init__(self)
        self.ping_state = ''

    def preamble_parser(self, payload):
        if super().preamble_parser(payload) is not True:
            print("preamble parse failure noted")
            return False

        if self.message_version != 1:
            print("bad message version")
            return False

        if self.message_type != "PING":
            print("bad message type")
            return False

        return True

    def payload_parser(self, payload):
        try:
            self.ping_state = payload['pingState']
            return True
        except KeyError as keyError:
            print("payload.parser keyError:%s" % keyError)
            return False

    def __str__(self):
        return str(self.original)


class PingResponseV1(ResponseMessage):

    def __init__(self):
        ResponseMessage.__init__(self)

    def payload(self, ping_state, reqmsg):
        self.ok_response(reqmsg)

        if ping_state is None:
            return {"preamble": self.preamble}
        else:
            self.ok_response(reqmsg)
            return {"preamble":self.preamble, "pingState":ping_state}

    def __str__(self):
        return "response"

#;;; Local Variables: ***
#;;; mode:python ***
#;;; End: ***