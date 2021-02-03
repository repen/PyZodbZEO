#docker build -t zodb_cn:latest .
#docker run --name zodbrun -d zodb_cn:latest
#docker run --name zodbrun -d -p 4110:4110 zodb_cn:latest
#docker run --name zodbrun -d -v zodb_box:/script/storage -v zodb_ssl:/script/ssl -p 4110:4110 zodb_cn:latest

FROM python:3.8

ENV BASE_DIR /script
ENV EXTERNAL_WORK true
ENV REMOTE_SERVER 127.0.0.1

WORKDIR ${BASE_DIR}

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY script ${BASE_DIR}

#CMD tail -f /dev/null
CMD python runner.py
