FROM sam-test/non-pure-python2

RUN yum install -y \
      libffi-devel \
      openssl-devel

WORKDIR /app
COPY ["requirements.txt", "requirements.txt"]
ENTRYPOINT pip install --no-cache-dir -r requirements.txt -t vendored
