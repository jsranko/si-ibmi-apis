#!/bin/bash

INSTALL_DIR=/QIBM/ProdData/OS/WebServices/bin

qsh ${INSTALL_DIR}/stopWebServicesServer.sh -server WSSSIIIA -printErrorDetails && \
qsh ${INSTALL_DIR}/deleteWebServicesServer.sh -server WSSSIIIA -printErrorDetails
