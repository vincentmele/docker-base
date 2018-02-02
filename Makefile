#
# Execute with: 
# sudo make APP_NAME=artful DISTRO=ubuntu release
# sudo make APP_NAME=jessie-slim DISTRO=debian release
#
# The result is the registry with update the `latest` and dated tag.
# debian:buster-slim
# debian:buster-slim-20180202 etc

APP_NAME=buster-slim
DISTRO=debian
DOCKER_REGISTRY=registry.sys.inoc.com:5443
DATE=$(shell date +%Y%m%d)
VERSION=$(DATE)

.PHONY: help

build: ## Build the container
	docker build -f $(APP_NAME)/Dockerfile -t $(APP_NAME) .

build-nc: ## Build the container without caching
	docker build --no-cache -f $(APP_NAME)/Dockerfile -t $(APP_NAME) .

release: build-nc publish

publish: publish-latest publish-version ## Publish the `{version}` and `latest` containers

publish-latest: tag-latest ## Publish the `latest` tagged container
	@echo 'publish latest to $(DOCKER_REGISTRY)'
	docker push $(DOCKER_REGISTRY)/$(DISTRO):$(APP_NAME)

publish-version: tag-version ## Publish the `{version}` tagged container
	@echo 'publish $(VERSION) to $(DOCKER_REGISTRY)'
	docker push $(DOCKER_REGISTRY)/$(DISTRO):$(APP_NAME)-$(VERSION)


# Docker tagging
tag: tag-latest tag-version ## Generate container tags for the `{version}` ans `latest` tags

tag-latest: ## Generate container `{version}` tag
	@echo 'create tag latest'
	docker tag $(APP_NAME) $(DOCKER_REGISTRY)/$(DISTRO):$(APP_NAME)

tag-version: ## Generate container `latest` tag
	@echo 'create tag $(VERSION)'
	docker tag $(APP_NAME) $(DOCKER_REGISTRY)/$(DISTRO):$(APP_NAME)-$(VERSION)
