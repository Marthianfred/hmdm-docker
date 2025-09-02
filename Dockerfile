# syntax=docker/dockerfile:1

FROM tomcat:9-jdk11-temurin-jammy

RUN apt-get update \
    && apt-get upgrade -y
RUN apt-get install -y \
    aapt \
    wget \
    sed \
        postgresql-client \
    && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /usr/local/tomcat/conf/Catalina/localhost
RUN mkdir -p /usr/local/tomcat/ssl

# Set to 1 to force updating the config files
# If not set, they will be created only if there's no files
#ENV FORCE_RECONFIGURE=true
ENV FORCE_RECONFIGURE=true

ENV INSTALL_LANGUAGE=en
ENV ADMIN_EMAIL=marthianfred@gmail.com
ENV SHARED_SECRET=TU-MAMA-EN-TANGAS-C3z9vi54
ENV HMDM_VARIANT=os
ENV HMDM_URL=https://h-mdm.com/files/hmdm-5.30.3-$HMDM_VARIANT.war
ENV CLIENT_VERSION=6.14

ENV SQL_HOST=devserver-dbbackend-ozqyrv
ENV SQL_PORT=5432
ENV SQL_BASE=hmdm
ENV SQL_USER=neoestudio-ai
ENV SQL_PASS=CJ4hIuF7p1YzLQXiuGux

ENV PROTOCOL=http
ENV BASE_DOMAIN=personals-mdm-k6e50b-9ceca1-82-29-168-192.traefik.me

ENV HTTPS_LETSENCRYPT=true
ENV HTTPS_CERT=cert.pem
ENV HTTPS_FULLCHAIN=fullchain.pem
ENV HTTPS_PRIVKEY=privkey.pem

EXPOSE 8080
EXPOSE 8443
EXPOSE 31000

COPY docker-entrypoint.sh /
COPY update-web-app-docker.sh /opt/hmdm/
COPY tomcat_conf/server.xml /usr/local/tomcat/conf/server.xml
ADD templates /opt/hmdm/templates/

ENTRYPOINT ["/docker-entrypoint.sh"]