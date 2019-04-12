#Download base image ubuntu 16.04
FROM ubuntu:18.04


# Update Ubuntu Software repository
RUN apt-get update

# 
RUN apt install python3 -y

RUN mkdir /opt/abcnotd

RUN chown -R www-data:www-data /opt/abcnotd 

COPY index.html /opt/abcnotd/index.html

COPY server.py /opt/server.py

COPY start.sh /opt/start.sh

CMD ["/opt/start.sh"]

EXPOSE 8484
