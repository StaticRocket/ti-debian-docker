IMAGE_NAME=debian-beagle
IMAGE_TAG=bookworm-slim

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
		--arch arm64

clean:
	$(CONTAINER_TOOL) image rm ${IMAGE_NAME}:${IMAGE_TAG}
