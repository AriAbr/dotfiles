SHELL:=/bin/bash
JIRA_API_TOKEN:=$(shell pass jira_api_token)
JIRA_API_USER:= $(shell pass jira_api_user)
GITHUB_TOKEN:= $(shell pass github_pat)

 
dev_image: 
	docker build -f Dockerfile.dev \
		--build-arg JIRA_API_TOKEN=${JIRA_API_TOKEN} \
		--build-arg JIRA_API_USER=${JIRA_API_USER} \
		--build-arg GITHUB_TOKEN=${GITHUB_TOKEN} \
		-t dynamics-dev-image:latest .