PROJECT=HelloJBoss

DIR=$(shell pwd)
CLASSPATH=vg/christophe/${PROJECT}

CC=javac

JBOSS=../jboss-4.2.3.GA
JBOSS_CONFIG=default
JBOSS_INSTANCE=${JBOSS}/server/${JBOSS_CONFIG}
JBOSS_DEPLOY=${JBOSS_INSTANCE}/deploy

WAR=${PROJECT}.war
WAR_DIR=${PROJECT}-war
WAR_SRCS=${WAR_DIR}/src/${CLASSPATH}/*
WAR_TARGET=${WAR_DIR}/target/${WAR_DIR}
WAR_PKG=${WAR_DIR}/target/${WAR}

LIB_SERVLET=${JBOSS_INSTANCE}/lib/servlet-api.jar

all: compile-war

compile-war: ${WAR_SRCS}
	@echo "*** compiling WAR"
	@mkdir -p ${WAR_TARGET}/WEB-INF/classes
	@cp -r ${WAR_DIR}/WEB-INF ${WAR_TARGET}
	@${CC} -classpath ${LIB_SERVLET} \
	   -d ${WAR_TARGET}/WEB-INF/classes ${WAR_SRCS}

deploy: compile-war
	@echo "*** deploying ${WAR}"
	@cp -r ${WAR_TARGET} ${WAR_TARGET}.deploy
	@mv ${WAR_TARGET}.deploy ${JBOSS_DEPLOY}/${WAR}
  
undeploy:
	@echo "*** undeploying ${WAR}"
	@rm -rf ${JBOSS_DEPLOY}/${WAR}

clean:
	@rm -rf */target
