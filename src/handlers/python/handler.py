import os


def hello(event, context):
    return 'Invoked with this environment: {}'.format(os.environ['Env'])
