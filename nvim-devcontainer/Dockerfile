FROM ghcr.io/centers-health/dev:1.18


RUN mkdir /home/docker/dots
WORKDIR /home/docker/dots
COPY . .
RUN ls

USER root
# RUN rm /home/docker/.bashrc /home/docker/.bash_profile
RUN ./devcontainer-installer.sh
RUN chown -R docker. /home/docker
WORKDIR /app
USER docker

ARG GH_TOKEN
ARG JIRA_API_TOKEN
ARG JIRA_API_USER

ENV GH_TOKEN=${GH_TOKEN} \
    JIRA_API_TOKEN=${JIRA_API_TOKEN} \
    JIRA_API_USER=${JIRA_API_USER}
