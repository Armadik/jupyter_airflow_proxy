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
RUN fix-permissions "/usr/local/airflow"
RUN fix-permissions "/var/log/supervisor/"


RUN mkdir -p ${HOME}/dags
RUN fix-permissions "${HOME}/dags"

USER ${NB_UID}

ARG AIRFLOW_USER_HOME=/usr/local/airflow
ENV AIRFLOW_HOME=${AIRFLOW_USER_HOME}
ENV AIRFLOW__WEBSERVER__RBAC="False"
ENV AIRFLOW_DAGS_DIR="${HOME}/dags"
ENV AIRFLOW__CORE__DAGS_FOLDER="${HOME}/dags"
ENV AIRFLOW__WEBSERVER__WORKERS=1

COPY config/webserver_config.py ${AIRFLOW_USER_HOME}/webserver_config.py
COPY config/airflow.cfg ${AIRFLOW_USER_HOME}/airflow.cfg

ARG A_USERNAME=Admin
ARG A_PASSWORD=admin

RUN pip install --upgrade pip
RUN pip install apache-airflow==2.2.3 --constraint /tmp/constraints-3.9.txt
RUN pip install /tmp/*.whl

RUN airflow users create --username ${A_USERNAME}  --firstname FIRST_NAME  --lastname LAST_NAME  --role Admin  --email admin@example.org --password ${A_PASSWORD}

RUN airflow db init

