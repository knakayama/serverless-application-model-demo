import sys
import os
sys.path.append(os.path.join(os.path.dirname(os.path.realpath(__file__)), 'vendored'))
import paramiko


def hello(event, context):
    return 'paramiko.GSS_AUTH_AVAILABLE: {}'.format(str(paramiko.GSS_AUTH_AVAILABLE))
