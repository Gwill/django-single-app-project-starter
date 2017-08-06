FROM alpine:3.6

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
 && mkdir /root/.pip && printf '[global]\nindex-url = https://mirrors.aliyun.com/pypi/simple/' > /root/.pip/pip.conf \
 && apk add -U build-base postgresql-dev python3-dev \
 && python3 -m ensurepip

COPY requirements.txt /tmp/requirements.txt

RUN pip3 --disable-pip-version-check --no-cache-dir install -r /tmp/requirements.txt
RUN rm -Rf /tmp

COPY . /app
WORKDIR /app

RUN python3 manage.py collectstatic

