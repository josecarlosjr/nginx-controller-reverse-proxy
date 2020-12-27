FROM nginx

RUN apt-get update && apt-get install -y apt-transport-https software-properties-common tcptraceroute
#RUN apk update 

RUN apt-get install -y vim net-tools

COPY wrapper.sh /

#COPY nginx.conf /etc/nginx/

COPY html /usr/share/nginx/html

EXPOSE 443

EXPOSE 80

EXPOSE 8080

CMD ["./wrapper.sh"]
