# Goal

Main interests of this recipe is to managed video and audio needed to play in docker.
The only element known by host is a docker image (for emulator) and  a docker volume (for configuration, logs, saving and games).

## Build

To build image, simply launch :
```
docker build -t scummvm .
```

## Command to create volume named game-data :
```bash
docker create -v /home/developer/.scummvm -v /home/developer/data --name game-data ubuntu:xenial /bin/true
```

folder .scummvm is managed by scummvm (to write logs) and /docker-entrypoint.sh (to create a symbolic link on .scummvmrc that should be in /home/developer)
folder data contains rom of games


## Run

To launch docker container, a bash alias file is certainly the good option :

```bash
docker_localtime=" -v /etc/localtime:/etc/localtime "
docker_x=" -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -v $HOME/.Xauthority:/home/developer/.Xauthority --net=host "
docker_me=" -e UID=`id -u` -e GID=`id -g`"
docker_pulse=" -v /run/user/`id -u`/pulse:/run/pulse "

function scummvm {
    docker run --name scummvm $docker_x --volumes-from game-data  $docker_pulse $docker_me $docker_localtime --rm -ti  scummvm "$@"
}
```
