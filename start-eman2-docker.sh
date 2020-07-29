#!/bin/bash

NAME=`hostname -s`"eman2"
HOSTNAME=`hostname -s`"eman2"

function run_eman2 {

    docker run --name $NAME --hostname=$HOSTNAME --mac-address "90:b1:1c:3d:e0:7a" -e DISPLAY=host.docker.internal:0 -d  \
    -v `pwd`/opt:/opt \
    -v `pwd`/extra:/extra \
    -t andrewklau/centos-lamp
}

echo "  "
echo "  Checking if your OS has dockers installed"
if ! type "docker" > /dev/null; then
    echo "  "
    echo "  docker not present, please install it. Available on:"
    echo "  https://www.docker.com/products/docker-desktop "
    echo "  exiting..."
    exit 1
else
    echo "  docker seems to be present, continuing..."
fi

echo "  "
echo "  Setting up your eman2 docker "
echo "  "

### docker name
echo "  Default docker name now: " $NAME
read -p "   Is the name OK (Y/N)?" yn
case $yn in
    [Yy]* ) 
            echo "  Continuing"
            ;;
    [Nn]* )
            read -p "  Please introduce docker name :" NAME
            echo "  docker will be named: " $NAME
            echo "  Continuing"
            ;;
    * ) echo "  Please answer yes or no.";;
esac

### check image is already installed
if [[ "$(docker images -q andrewklau/centos-lamp 2> /dev/null)" == "" ]]; then
    echo "  Base image not present, pulling docker image"
    docker pull andrewklau/centos-lamp
    echo "  Image installed"
else
    echo "  Image installed already, using it"
fi

# ### check a docker with the same name is created
isthere=`docker ps -a | grep $NAME`
if [ -z "$isthere" ]; then
    echo "  No docker named "$NAME" listed. Creating it"
    run_eman2
    echo "  A docker "$NAME" created. Running post-creation and first run"
    docker exec $NAME extra/extra-packages.sh
else
    echo "  Something named "$NAME" is there. "
    read -r -p "  Would you like to remove it? (y/N) " response
    case "$response" in
        [yY][eE][sS]|[yY])
            docker rm $NAME
            echo "  docker removed: run the script again to create it anew"
            ;;
        *)
            echo "  Starting the existing docker "
            docker start $NAME
            echo "  Started : please check your docker is running"
            ;;
    esac
fi
