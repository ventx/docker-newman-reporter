FROM postman/newman:ubuntu

ARG BUILD_DATE
ARG VCS_REF
ARG BUILD_VERSION

LABEL maintainer="hajo@ventx.de" \
      repo="docker-newman-reporter" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="ventx/docker-newman-reporter" \
      org.label-schema.vcs-url="https://github.com/ventx/docker-newman-reporter" \
      org.label-schema.vendor="ventx" \
      org.label-schema.docker.cmd="docker run -d newman-reporter" \
      org.label-schema.vcs-ref=$VCS_REF


RUN apt-get update && \
    apt-get install git -y \
 && rm -rf /var/lib/apt/lists/*

RUN npm i -g newman-reporter-confluence && \
    npm i -g newman-reporter-junitxray && \
    npm i -g newman-reporter-htmlextra && \
    npm i -g npm install newman-reporter-slack

CMD [ "newman", "-v" ]
