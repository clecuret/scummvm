#!/bin/bash
set -e

if [ "$1" = 'scummvm' ]; then
	uid=${UID:-1000}
	gid=${GID:-1000}
  lang=${LANG:-fr-FR}
	# create user group
	if ! getent group developer >/dev/null; then
		groupadd -f -g ${gid} developer
	fi

	# create user with uid and gid matching that of the host user
	if ! getent passwd developer >/dev/null; then
		adduser --uid ${uid} --gid ${gid} --disabled-login --gecos 'Developer' developer
	fi
  ln -s  /home/developer/.scummvm/.scummvmrc /home/developer/.scummvmrc
	chown -R ${uid}:${gid} /home/developer/.scummvmrc
	exec su developer -c "/usr/games/scummvm"
fi

exec "$@"
