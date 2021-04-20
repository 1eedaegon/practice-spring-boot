#!/bin/bash

REPOSITORY=/home/ec2-user/app/step1
PROJECT_NAME=practice-spring-boot

cd $REPOSITORY/$PROJECT_NAME

echo "> Git pull"
git pull

echo "> Project build start"
./gradlew build

echo "> Change directory to ./step1"
cd $REPOSITORY

echo "> Replicate build resources"
cp $REPOSITORY/$PROJECT_NAME/build/libs/*.jar $REPOSITORY/

echo "> Check application running state with pid"
CURRENT_PID=$(pgrep -f ${PROJECT_NAME}.*.jar)

echo "> Now running application pid: $CURRENT_PID"
if [ -z "$CURRENT_PID" ]; then
	echo "> Eject, not existed running application."
else
	echo "> Kill -15 ${CURRENT_PID}"
	kill -15 $CURRENT_PID
	sleep 5
fi

echo "> Deploy new application"
JAR_NAME=$(ls -tr $REPOSITORY/ | grep jar | tail -n 1)

echo "> Jar name: $JAR_NAME"
nohup java -jar \
	-Dspring.config.location=classpath:/application.properties,/home/ec2-user/app/application-oauth.properties \
	$REPOSITORY/$JAR_NAME 2>&1 &
