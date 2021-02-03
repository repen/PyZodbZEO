#docker build -t zodb_cn:latest .
#docker run --name zodbrun -d zodb_cn:latest
#docker run --name zodbrun -d -p 8120:4110 zodb_cn:latest
#docker run --name zodbrun -d -v zodb_box:/script/storage -v zodb_ssl:/script/ssl -p 8120:4110 zodb_cn:latest

FROM python:3.8

ENV BASE_DIR /script
ENV EXTERNAL_WORK true
ENV REMOTE_SERVER localhost

WORKDIR ${BASE_DIR}

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY script ${BASE_DIR}

CMD python runner.py