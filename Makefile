IMAGE_NAME ?= ti-debian
IMAGE_TAG ?= bookworm-slim
BUILD_ARGS ?=

ifeq ($(CONTAINER_TOOL),)
  $(info CONTAINER_TOOL unset, checking if docker is present...)
  ifneq ($(shell which docker 2> /dev/null),)
    $(info Using docker for build...)
    CONTAINER_TOOL := docker
  else ifneq ($(shell which podman 2> /dev/null),)
    $(info Using podman for build...)
    CONTAINER_TOOL := podman
  endif
endif

all: Dockerfile $(shell find root/)
	$(CONTAINER_TOOL) build . -t ${IMAGE_NAME}:${IMAGE_TAG} \
		--build-arg IMAGE_TAG=${IMAGE_TAG} \
		--platform arm64 \
		$(BUILD_ARGS)

clean:
	$(CONTAINER_TOOL) image rm ${IMAGE_NAME}:${IMAGE_TAG}
