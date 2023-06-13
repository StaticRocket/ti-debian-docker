# Beagle Docker

This is a template project to convert a standard Debian image to the beagle
equivalent by adding the required packaging GPG key and adding the repo source
list for the selected release.


## Usage

Simply run the following:

```bash
make
```

This will automatically select `bookworm-slim` as the image tag to use. From
here the required system changes will be made. If you would like to build for
an older or newer release (assuming that release was previously or is currently
supported by the Beagle project), then simply add the image tag to the make
command as follows:

```bash
make IMAGE_TAG=<tag>
```

This takes any of the tags listed under the [official Debian
image](https://hub.docker.com/_/debian).


## FAQ

> Why is ca-certificates installed?

Because the default package repository currently 301's to the HTTPS version so
we need certs.
