#!/bin/bash

DIR="$(dirname "$0")"
source "$DIR/iws_config.sh"
source "$DIR/iws_loadConfiguration.sh"

################################################################################
#
#                               Main
#
################################################################################

echo "Der Server wird gelöchst."

if loadConfiguration $1;  then
    echo "Die Konfiguration-Datei:$1 erfolgreich geladen."
else 
    echo "Fehler bei laden der Konfiguration-Datei:$1."
    exit 1
fi

SERVER_NAME=$(jq '.server.name' -r <<< "${CONFIGURATION_FILE}")
SERVER_PRINT_ERROR_DETAILS=$(jq '.server.printErrorDetails' -r <<< "${CONFIGURATION_FILE}")
if [ ${SERVER_PRINT_ERROR_DETAILS} == "true" ]; then
	SERVER_PRINT_ERROR_DETAILS='-printErrorDetails'
else
	SERVER_PRINT_ERROR_DETAILS=''
fi

LOG_FILE=/tmp/${SERVER_NAME}.log

echo "Der Server ${SERVER_NAME} wird gestoppt ..."
if ! qsh ${INSTALL_DIR}/stopWebServicesServer.sh -server ${SERVER_NAME} ${SERVER_PRINT_ERROR_DETAILS} > ${LOG_FILE} 2>&1; then
	echo "Der Server ${SERVER_NAME} könnte nicht gestoppt werden oder existiert nicht."
else
	echo "Der Server ${SERVER_NAME} wird geloescht ..."
	if ! qsh ${INSTALL_DIR}/deleteWebServicesServer.sh -server ${SERVER_NAME} ${SERVER_PRINT_ERROR_DETAILS}> ${LOG_FILE} 2>&1; then
		echo "Der Server ${SERVER_NAME} könnte nicht geloescht werden."
	fi
fi






