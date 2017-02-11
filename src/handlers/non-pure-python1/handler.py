from urlparse import urlparse
import urllib2
import sys
import os
sys.path.append(os.path.join(os.path.dirname(os.path.realpath(__file__)), 'vendored'))
from PIL import Image


def hello(event, context):
    url = os.environ['Url']
    image_path = os.path.join('/tmp', os.path.basename(urlparse(url).path))

    with open(image_path, 'w') as f:
        f.write(urllib2.urlopen(url).read())

    return Image.open(image_path).filename
