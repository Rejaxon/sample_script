#!/bin/bash

export JAVA_OPTS="-Xms512M -Xmx512M -Xmn170m -XX:PermSize=64m -XX:MaxPermSize=64m"
export JAVA_OPTS="$JAVA_OPTS -javaagent:/home/r-sakon/project/health-dock/WEB-INF/lib/spring-instrument-3.2.4.RELEASE.jar"