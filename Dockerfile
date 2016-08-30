FROM debian:jessie

MAINTAINER johanneshertel

USER root

RUN apt-get update && apt-get install -y python3 python3-pip && apt-get install -y cron

RUN pip3 install requests && pip3 install influxdb

COPY ./script/script.py /home/script.py

RUN crontab -l | { cat; echo "*/1 * * * * python3 /home/script.py > /home/script.log"; } | crontab -

RUN touch /var/log/cron.log

CMD cron && tail -f /var/log/cron.log


