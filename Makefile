PROJECT=HelloJBoss

DIR=$(shell pwd)
CLASSPATH=vg/christophe/${PROJECT}

CC=javac
JAR=jar
JAR_MAKE=${JAR} -cf

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

TWIDDLE=${JBOSS}/bin/twiddle.sh
TWIDDLE_DEPLOYER=${TWIDDLE} invoke "jboss.system:service=MainDeployer"
TWIDDLE_DEPLOY=${TWIDDLE_DEPLOYER} deploy
TWIDDLE_UNDEPLOY=${TWIDDLE_DEPLOYER} undeploy

all: compile-war

compile-war: ${WAR_SRCS}
	@echo "*** compiling WAR"
	@mkdir -p ${WAR_TARGET}/WEB-INF/classes
	@cp -r ${WAR_DIR}/WEB-INF ${WAR_TARGET}
	@${CC} -classpath ${LIB_SERVLET} \
	   -d ${WAR_TARGET}/WEB-INF/classes ${WAR_SRCS}

HelloJBoss-war/target/HelloJBoss.war: compile-war
	@echo "*** packaging $@"
	@(cd ${WAR_TARGET}; ${JAR_MAKE} ../${WAR} *)

deploy: ${WAR_PKG}
	@echo "*** deploying $<"
	@${TWIDDLE_DEPLOY} file:${DIR}/${WAR_PKG}

undeploy:
	@echo "*** undeploying ${WAR_PKG}"
	@${TWIDDLE_UNDEPLOY} file:${DIR}/${WAR_PKG}

clean:
	@rm -rf */target
