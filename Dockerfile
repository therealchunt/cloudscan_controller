FROM tomcat:8.5.11 
MAINTAINER "chunt"

#args used during building of this container
ARG MY_FILES_DIR=files
ARG TMP_DIR=/root/mytemp
ARG CC_TMP=/root/cloudscan_controller
ARG CC_NAME="HPE_Security_Fortify_CloudScan_Controller_16.20"
ARG CC_TAR="${CC_NAME}_Linux_x64.tar.gz"
ARG TOMCAT_DIR=/usr/local/tomcat

#create temp dir for needed files
RUN mkdir $TMP_DIR/
COPY $MY_FILES_DIR/* $TMP_DIR/

RUN mkdir $CC_TMP

#clear out "default" apps that tomcat includes
RUN rm -rf $TOMCAT_DIR/webapps/*

#extract controller contents
RUN tar -xvf $TMP_DIR/$CC_TAR -C $CC_TMP/

#add cloud-ctrl to webapps dir
RUN cp -R $CC_TMP/$CC_NAME/tomcat/webapps/cloud-ctrl/ $TOMCAT_DIR/webapps/
#RUN tar -xvf $TMP_DIR/cloud-ctrl.tar -C $TOMCAT_DIR/webapps/

#overwrite properties file
RUN mv $TMP_DIR/config.properties $TOMCAT_DIR/webapps/cloud-ctrl/WEB-INF/classes/

#cleanup temp dir
RUN rm -rf $TMP_DIR
