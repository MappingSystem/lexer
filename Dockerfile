#FROM eq19/setup:latest
FROM google/cloud-sdk:latest
LABEL version=v0.0.1

ADD . /feed

ENV GIT_DISCOVERY_ACROSS_FILESYSTEM=1
ENV PATH=${PATH}:/feed/tools

#RUN apk --update
RUN chmod -R +x /feed/tools/*.sh
#RUN apk add -U bash curl github-cli jq yq openjdk7-jre

ENTRYPOINT ["entrypoint.sh"]
