#!/usr/bin/env bash

ABS_PATH=$(readlink -f $0)
ABS_DIR=$(dirname $ABS_PATH)
source ${ABS_DIR}/profile.sh

IDLE_PORT=$(find_idle_port)

echo "> Check pid running on port: $IDLE_PORT"
IDLE_PID=$(lsof -ti tcp:${IDLE_PORT})

if [ -z ${IDLE_PiD} ]
then
  echo "> Eject, Not exists running applications."
else
  echo "> kill -15 $IDLE_PID"
  kill -15 $IDLE_PID
  sleep 5
fi
