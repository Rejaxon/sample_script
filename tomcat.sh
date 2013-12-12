#!/bin/bash
#
# startup script for the tomcat

# Source function library.
. /etc/rc.d/init.d/functions

# set env
export JAVA_HOME=/usr/java/default
export PATH=$PATH:$JAVA_HOME/bin
export TOMCAT_HOME=/home/r-sakon/app/tomcat-7.0.47
export CATALINA_HOME=/home/r-sakon/app/tomcat-7.0.47
export CLASSPATH=.:$JAVA_HOME/jre/lib:$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar:$CATALINA_HOME/common/lib

LOCK_FILE=/home/r-sakon/tmp/lock/tomcat-7.0.47

start(){
    if [ ! -f $LOCK_FILE ]; then
        echo "Starting tomcat"
        # -f [server.xmlパス]で切り替え可能
        $TOMCAT_HOME/bin/startup.sh "$@"
        touch $LOCK_FILE
    else
        echo "tomcat allready running"
    fi
}

stop(){
    if [ -f $LOCK_FILE ]; then
        echo "Shutting down tomcat"
        $TOMCAT_HOME/bin/shutdown.sh
        rm -f $LOCK_FILE
    else
        echo "tomcat not running"
    fi
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop
        start
        ;;
    status)
        $TOMCAT_HOME/bin/catalina.sh version
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|status}"
esac

exit 0
