SHELL:=/bin/bash
JIRA_API_TOKEN:=$(shell pass jira_api_token)
JIRA_API_USER:=$(shell pass jira_api_user)
GITHUB_TOKEN:=$(shell pass github_pat)


dev_image:
	mkdir -p keypairs
	cp -r ~/.ssh/* keypairs/
	cp ~/.wakatime.cfg .wakatime.cfg
	
	docker build -f Dockerfile.dev \
		--build-arg JIRA_API_TOKEN="${JIRA_API_TOKEN}" \
		--build-arg JIRA_API_USER="${JIRA_API_USER}" \
		--build-arg GITHUB_TOKEN="${GITHUB_TOKEN}" \
		-t dynamics-dev-image:latest .
	
	rm -rf keypairs
	rm .wakatime.cfg
nvim-devcontainer:
	docker build \
		-t "nvim-dev:latest" \
		--build-arg GH_TOKEN="$(shell pass github_pat)" \
		--build-arg JIRA_API_TOKEN="$(shell pass jira_api_token)" \
		--build-arg JIRA_API_USER="$(shell pass jira_api_user)" \
		-f nvim-devcontainer/Dockerfile \
		.

.PHONY: nvim-devcontainer dev_image
