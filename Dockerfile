FROM ubuntu:16.10

MAINTAINER johanneshertel

USER root

RUN apt-get update && apt-get upgrade -y && apt-get install -y python3 && apt-get install -y cron

COPY ./script/script.py /home/script.py

RUN crontab -l | { cat; echo "*/1 * * * * python3 /home/script.py > /home/script.log"; } | crontab -

RUN touch /var/log/cron.log

CMD cron && tail -f /var/log/cron.log


