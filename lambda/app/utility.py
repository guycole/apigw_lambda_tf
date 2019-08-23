#
# Title:utility.py
# Description: helpers
# Development Environment:OS X 10.13.6/Python 3.7.2
# AWS Lambda Environment: Python 3.6 runtime
# Author:Guy Cole (guycole at gmail dot com)
#
import datetime
import uuid


class Utility:

    @staticmethod
    def get_time_stamp():
        """
        :param self:
        :return: current time like 2019-08-21T01:35:25.038928
        """
        return datetime.datetime.utcnow().isoformat()

    @staticmethod
    def get_uuid():
        """
        :param self:
        :return: UUID4 as a string
        """
        return str(uuid.uuid4())

#;;; Local Variables: ***
#;;; mode:python ***
#;;; End: ***
