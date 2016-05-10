FROM ubuntu:xenial
MAINTAINER clecuret <clecuret@gmail.com>
ENV HOME=/home/developer UID=1000 GID=1000
RUN apt-get update  && apt-get install -y -qq scummvm alsa-base alsa-utils alsa-oss pulseaudio && apt-get -y clean && rm -rf /var/lib/apt/lists/* && echo enable-shm=no >> /etc/pulse/client.conf
ENV PULSE_SERVER /run/pulse/native
COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["scummvm"]
