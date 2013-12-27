#! /bin/bash
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

RUNFILE=$DIR"/bootstrap.sh"
PERM=`sudo -l | grep $RUNFILE`
if [ "" == "$PERM" ]
then
	EXEC="/usr/local/bin/steam"
	echo "please add the following line to the opening editor:"
	echo "%wheel ALL=(root) NOPASSWD: $RUNFILE"
	sudo visudo
	echo "installing executable"
	sudo ln -s $DIR"/run.sh" $EXEC
	sudo chmod +x $EXEC
	sudo -K
	echo "now rerun this script"
else
	sudo $RUNFILE
fi
