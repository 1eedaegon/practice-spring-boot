#!/bin/bash

REPOSITORY=/home/ec2-user/app/step2
PROJECT_NAME=practice-spring-boot

echo "> Copy build files"
cp $REPOSITORY/zip/*.jar $REPOSITORY

echo "> Check application running state with pid"
CURRENT_PID=$(ps -ef | grep ${PROJECT_NAME} | grep jar | awk '{print $2}')

echo "> Now running application pid: $CURRENT_PID"
if [ -z "$CURRENT_PID" ]; then
	echo "> Eject, not existed running application."
else
	echo "> Kill -15 ${CURRENT_PID}"
	kill -15 $CURRENT_PID
	sleep 5
fi

echo "> Deploy new application"
JAR_NAME=$(ls -tr $REPOSITORY/*.jar | tail -n 1)

echo "> Jar name: $JAR_NAME"
echo "> Grant execution permission(+x) to $JAR_NAME"
chmod +x $JAR_NAME

echo "> Start Application now!"
nohup java -jar \
	-Dspring.config.location=classpath:/application.properties,/home/ec2-user/app/application-oauth.properties,/home/ec2-user/app/application-real-db.properties,classpath:/application-real.properties \
	-Dspring.profiles.active=real \
	$JAR_NAME > $REPOSITORY/nohup.out 2>&1 &
