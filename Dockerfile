ARG IMAGE_TAG
from debian:${IMAGE_TAG}

LABEL org.opencontainers.image.title="ti-debian" \
	org.opencontainers.image.description="A version of Debian with TI specific repos enabled and prefered" \
	org.opencontainers.image.authors="Randolph Sapp <rs@ti.com>" \
	org.opencontainers.image.source="https://github.com/StaticRocket/ti-debian-docker"

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
	&& apt-get install -y \
			--no-install-recommends \
		ca-certificates \
	&& apt-get clean -y \
	; rm -rf \
		/tmp/* \
		/var/lib/apt/lists/* \
		/var/tmp/*

COPY root /

ADD https://raw.githubusercontent.com/TexasInstruments/ti-debpkgs/main/ti-debpkgs.sources \
	/etc/apt/sources.list.d/

RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get clean -y \
	; rm -rf \
		/tmp/* \
		/var/lib/apt/lists/* \
		/var/tmp/*

