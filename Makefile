REGISTRY ?= ventx/newman-reporter
VERSION ?= latest

IMAGE_NAME ?= newman-reporter
CONTAINER_NAME ?= newman-reporter
CONTAINER_INSTANCE ?= newman-reporter

.PHONY: build

build: Dockerfile
	docker build --no-cache=true --build-arg BUILD_DATE=$(shell date -u +'%Y-%m-%dT%H:%M:%SZ') --build-arg VCS_REF=$(shell git rev-parse --short HEAD) -t $(REGISTRY)/$(IMAGE_NAME):$(VERSION) -f Dockerfile .

push:
	docker push $(REGISTRY)/$(IMAGE_NAME):$(VERSION)

shell:
	docker run --rm --name $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) -i -t $(REGISTRY)/$(IMAGE_NAME):$(VERSION) /bin/bash

run:
	docker run --rm --name $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) $(REGISTRY)/$(IMAGE_NAME):$(VERSION)

start:
	docker run -d --name $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) $(REGISTRY)/$(IMAGE_NAME):$(VERSION)

stop:
	docker stop $(CONTAINER_NAME)-$(CONTAINER_INSTANCE)

rm:
	docker rm $(CONTAINER_NAME)-$(CONTAINER_INSTANCE)

release: build
	make push

default: build
