#! /bin/bash
#find the bashscript location
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

#include configuration
source $DIR/config.sh

# run bumblebee
sudo bumblebeed --daemon

# get the x session
sudo bash $DIR/getx.sh $DIR/config.sh

# run steam with bumblebee, primusrun
sudo -u $steam bash $steamHome"/steam/steam.sh"