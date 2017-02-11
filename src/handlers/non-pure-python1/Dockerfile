FROM sam-test/non-pure-python1

RUN yum install -y \
      zlib-devel \
      libjpeg-turbo-devel

WORKDIR /app
COPY ["requirements.txt", "requirements.txt"]
ENTRYPOINT pip install --no-cache-dir -r requirements.txt -t vendored
