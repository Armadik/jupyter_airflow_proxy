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
RUN useradd -ms /bin/bash airflow
RUN usermod -a -G sudo airflow
RUN chmod 666 -R /usr/local/airflow

USER ${NB_UID}

RUN pip install --upgrade pip
RUN pip install apache-airflow==2.2.3 --constraint /tmp/constraints-3.9.txt
RUN pip install /tmp/*.whl

RUN airflow db init

