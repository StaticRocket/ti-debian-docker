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

RUN . /etc/os-release && \
	echo "Setting release to ${VERSION_CODENAME}..." \
	&& sed -i "s/VERSION_CODENAME/${VERSION_CODENAME}/g" \
		/etc/apt/sources.list.d/beagle.list;

RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get upgrade -y \
	&& apt-get clean -y \
	; rm -rf \
		/tmp/* \
		/var/lib/apt/lists/* \
		/var/tmp/*

