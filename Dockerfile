#docker build -t build_name:latest .
#docker run --name container_name -d build_name:latest
#docker run --name container_name -d -p 8120:4110 build_name:latest
#docker run --name container_name -d -v volume:/script/data -p 8120:4110 build_name:latest
FROM python:3.8

ENV BASE_DIR /script
ENV EXTERNAL_WORK true
ENV REMOTE_SERVER localhost

WORKDIR ${BASE_DIR}

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY script ${BASE_DIR}

CMD python runner.py