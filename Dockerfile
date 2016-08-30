FROM ubuntu:16.10

MAINTAINER johanneshertel

USER root

RUN apt-get update && apt-get upgrade -y && apt-get install python3 -y && apt-get install cron

ADD ./script/script.py /home/script.py

RUN crontab -l | { cat; echo "*/1 * * * * python3 /home/script.py > /home/script.log"; } | crontab -
