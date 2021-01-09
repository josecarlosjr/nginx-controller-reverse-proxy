FROM nginx

#RUN hwclock --hctosys 

RUN apt-get install -y apt-transport-https software-properties-common

#RUN apt-get install -y apt-transport-https 
#RUN apk update software-properties-common 

RUN apt-get install -y vim net-tools

COPY wrapper.sh /

USER root

#COPY nginx.conf /etc/nginx/
RUN mkdir /usr/share/nginx/html/hello-whale

COPY html /usr/share/nginx/html/hello-whale

EXPOSE 443

EXPOSE 80

EXPOSE 8080

RUN chmod 777 wrapper.sh

CMD ["./wrapper.sh"]
