ARG IMAGE_TAG
from debian:${IMAGE_TAG}

RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y \
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
	&& DEBIAN_FRONTEND=noninteractive apt-get upgrade -y \
	&& apt-get clean -y \
	; rm -rf \
		/tmp/* \
		/var/lib/apt/lists/* \
		/var/tmp/*

