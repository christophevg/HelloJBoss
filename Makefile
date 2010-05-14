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

EJB=${PROJECT}.jar
EJB_DIR=${PROJECT}-ejb
EJB_SRCS=${EJB_DIR}/src/${CLASSPATH}/*
EJB_TARGET=${EJB_DIR}/target/${EJB_DIR}
EJB_PKG=${EJB_DIR}/target/${EJB}

WAR=${PROJECT}.war
WAR_DIR=${PROJECT}-war
WAR_SRCS=${WAR_DIR}/src/${CLASSPATH}/*
WAR_TARGET=${WAR_DIR}/target/${WAR_DIR}
WAR_PKG=${WAR_DIR}/target/${WAR}

EAR=${PROJECT}.ear
EAR_DIR=${PROJECT}-ear
EAR_SRCS=${EJB_PKG} ${WAR_PKG} ${EAR_DIR}/src/db-ds.xml
EAR_TARGET=${EAR_DIR}/target/${EAR_DIR}
EAR_PKG=${EAR_DIR}/target/${EAR}

LIB_SERVLET=${JBOSS_INSTANCE}/lib/servlet-api.jar
LIB_EJB3=${JBOSS_INSTANCE}/lib/jboss-ejb3x.jar

TWIDDLE=${JBOSS}/bin/twiddle.sh
TWIDDLE_DEPLOYER=${TWIDDLE} invoke "jboss.system:service=MainDeployer"
TWIDDLE_DEPLOY=${TWIDDLE_DEPLOYER} deploy
TWIDDLE_UNDEPLOY=${TWIDDLE_DEPLOYER} undeploy

all: HelloJBoss-ear/target/HelloJBoss.ear

compile-ejb: ${EJB_SRCS}
	@echo "*** compiling EJB"
	@mkdir -p ${EJB_TARGET}
	@cp -r ${EJB_DIR}/META-INF ${EJB_TARGET}
	@${CC} -classpath ${LIB_EJB3} -d ${EJB_TARGET} ${EJB_SRCS}

HelloJBoss-ejb/target/HelloJBoss.jar: compile-ejb
	@echo "*** packaging $@"
	@(cd ${EJB_TARGET}; ${JAR_MAKE} ../${EJB} *)

compile-war: ${WAR_SRCS}
	@echo "*** compiling WAR"
	@mkdir -p ${WAR_TARGET}/WEB-INF/classes
	@cp -r ${WAR_DIR}/WEB-INF ${WAR_TARGET}
	@${CC} -classpath ${LIB_SERVLET}:${LIB_EJB3}:${EJB_PKG} \
	   -d ${WAR_TARGET}/WEB-INF/classes ${WAR_SRCS}

HelloJBoss-war/target/HelloJBoss.war: compile-war
	@echo "*** packaging $@"
	@(cd ${WAR_TARGET}; ${JAR_MAKE} ../${WAR} *)

HelloJBoss-ear/target/HelloJBoss.ear: ${EAR_SRCS}
	@echo "*** packaging $@"
	@mkdir -p ${EAR_TARGET}
	@cp -r ${EAR_SRCS} ${EAR_TARGET}
	@cp -r ${EAR_DIR}/META-INF ${EAR_TARGET}
	@(cd ${EAR_TARGET}; ${JAR_MAKE} ../${EAR} *)

deploy: ${EAR_PKG}
	@echo "*** deploying $<"
	@${TWIDDLE_DEPLOY} file:${DIR}/$<

undeploy:
	@echo "*** undeploying ${EAR_PKG}"
	@${TWIDDLE_UNDEPLOY} file:${DIR}/${EAR_PKG}

redeploy: undeploy deploy

clean:
	@rm -rf */target
	@rm -f twiddle.log
