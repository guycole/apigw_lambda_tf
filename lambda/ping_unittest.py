#
# Title:ping_unittest.py
# Description: helpers
# Development Environment:OS X 10.13.6/Python 3.7.2
# AWS Lambda Environment: Python 3.6 runtime
# Author:Guy Cole (guycole at gmail dot com)
#
import json
import unittest

from app.utility import Utility

class PingTest(unittest.TestCase):

    def create_preamble(self):
        preamble = {}
        preamble['messageType'] = "PING"
        preamble['messageVersion'] = 1
        preamble['transactionId'] = Utility.get_uuid()

        result = {}
        result['preamble'] = preamble

        return result

    def test1(self):
        print("xxxx")
        print(self.create_preamble())
        self.assertEqual(5, 4, "zzzz")

if __name__ == '__main__':
    unittest.main()

#;;; Local Variables: ***
#;;; mode:python ***
#;;; End: ***
