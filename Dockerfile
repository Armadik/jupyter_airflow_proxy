#Dockerfile
FROM  jupyter/minimal-notebook:hub-2.2.2
LABEL maintainer="Armadik"

USER root
COPY pip.conf /etc/
COPY dist /tmp/

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER ${NB_UID}

RUN pip install --upgrade pip
RUN pip install apache-airflow==2.2.3 --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-2.2.3/constraints-3.9.txt"
RUN pip install /tmp/*.whl

