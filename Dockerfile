FROM ghcr.io/linuxserver/baseimage-guacgui

# set version label
ARG BUILD_DATE
ARG VERSION
ARG PUDDLE_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="xirg"

ENV APPNAME="Puddletag" UMASK_SET="022"

RUN \
 echo "**** install runtime packages ****" && \
 apt-get update && \
 apt-get install -qy \
    dbus \
    wget \
	jq \
 	python3 \
	python3-mutagen \
	python3-configobj \
	python3-pyparsing \
	python3-pyqt5 \
	python3-pyqt5.qtsvg && \
 echo "**** install puddletag ****" && \
 mkdir -p /opt/puddletag && \
 if [ -z ${PUDDLE_RELEASE+x} ]; then \
    PUDDLE_RELEASE=$(curl -sX GET "https://api.github.com/repos/puddletag/puddletag/releases/latest" \
    | jq -r .tag_name); \
 fi && \
 PUDDLE_URL="https://github.com/puddletag/puddletag/releases/download/${PUDDLE_RELEASE}/puddletag-${PUDDLE_RELEASE}.tar.gz" && \
 curl -o \
        /tmp/puddletag.tar.gz -L \
        "$PUDDLE_URL" && \
 tar xvf /tmp/puddletag.tar.gz -C \
  /opt/puddletag --strip 1 && \
 dbus-uuidgen > /etc/machine-id && \
 echo "**** cleanup ****" && \
 apt-get clean && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# add local files
COPY root/ /
