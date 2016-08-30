FROM ubuntu:16.10

MAINTAINER johanneshertel

USER root

RUN apt-get update && apt-get upgrade -y && apt-get install -y python3 && apt-get install -y cron && apt-get install -y supervisor
#RUN mkdir -p /var/lock/cron /var/log/supervisor

#COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY ./script/script.py /home/script.py

RUN crontab -l | { cat; echo "*/1 * * * * python3 /home/script.py > /home/script.log"; } | crontab -

RUN touch /var/log/cron.log

CMD cron && tail -f /var/log/cron.log

#CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

#CMD ["/bin/bash", "-c", "/usr/sbin/cron"]
#CMD ["/bin/bash"]

