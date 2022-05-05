#Dockerfile
FROM  jupyter/minimal-notebook:hub-2.2.2
LABEL maintainer="Armadik"

USER root
COPY pip.conf /etc/
COPY dist /tmp/
COPY constraints-3.9.txt /tmp/
COPY supervisord.conf /etc/

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    cron \
    gcc \
    supervisor \
    curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*


RUN cd /usr/local && mkdir airflow && chmod +x airflow && cd airflow
RUN ls /usr/local/
RUN chmod 777 -R /usr/local/airflow

ARG AIRFLOW_USER_HOME=/usr/local/airflow
ENV AIRFLOW_HOME=${AIRFLOW_USER_HOME}
ENV AIRFLOW__WEBSERVER__RBAC="False"
COPY config/webserver_config.py ${AIRFLOW_USER_HOME}/webserver_config.py
COPY config/airflow.cfg ${AIRFLOW_USER_HOME}/airflow.cfg

USER ${NB_UID}

RUN pip install --upgrade pip
RUN pip install apache-airflow==2.2.3 --constraint /tmp/constraints-3.9.txt
RUN pip install /tmp/*.whl

RUN airflow db init

