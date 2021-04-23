#!/usr/bin/env bash

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)

REPOSITORY=/home/ec2-user/app/step3
PROJECT_NAME=practice-spring-boot
source ${ABSDIR}/profile.sh

echo "> Copy build files"
echo "> cp $REPOSITORY/zip/*.jar $REPOSITORY/"
cp $REPOSITORY/zip/*.jar $REPOSITORY/

echo "> Deploy New application"
JAR_NAME=$(ls -tr $REPOSITORY/*.jar | tail -n 1)
echo "> JAR Name: $JAR_NAME"

echo "> Grant permission on $JAR_NAME: +x"
chmod +x $JAR_NAME

echo "> Start application $JAR_NAME"
IDLE_PROFILE=$(find_idle_profile)

echo "> Start $JAR_NAME on profile=$IDLE_PROFILE"
nohup java -jar \
-Dspring.config.location=classpath:/application.properties,classpath:/application-$IDLE_PROFILE.properties,/home/ec2-user/app/application-oauth.properties,/home/ec2-user/app/application-real-db.properties \
	-Dspring.profiles.active=real \
	-Dspring.profiles.active=$IDLE_PROFILE \
	$JAR_NAME > $REPOSITORY/nohup.out 2>&1 &
