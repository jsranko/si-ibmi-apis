#!/bin/bash

DIR="$(dirname "$0")"
source "$DIR/iws_config.sh"
source "$DIR/iws_loadConfiguration.sh"

################################################################################
#
#                               Procedures.
#
################################################################################

createWebServicesServer()
{
	echo "Der Server $1 wird initialisiert ..."
	bash ./$(dirname "$0")/iws_remove.sh $5
	
	echo "Der Server $1:$2 fur User:$4 in Version:$3 wird erstellt ..."
	if ! qsh ${INSTALL_DIR}/createWebServicesServer.sh -server $1 -startingPort $2 -userid $4 -version $3 $6> ${LOG_FILE} 2>&1; then
		echo "Der Server $1:$2 fur User:$4 in Version:$3 könnte nicht erstellt werden."
		return 1
	else
		echo "Der Server $1 wird gestartet ..."
		if ! qsh ${INSTALL_DIR}/startWebServicesServer.sh -server $1 $6> ${LOG_FILE} 2>&1; then
			echo "Der Server $1 könnte nicht gestartet werden."
			return 1
		fi	
	fi
}

installWebService()
{
	SERVICE_NAME=$(jq '.name' -r <<< "$2")
	if [ \( ${SERVICE_NAME} != "" \) -a \( ${SERVICE_NAME} != "null" \) ]; then
		SERVICE_NAME="-service ${SERVICE_NAME}"
	else
		SERVICE_NAME=''
	fi

	SERVICE_PGM_OBJECT=$(jq '.programObject' -r <<< "$2")
	if [ \( ${SERVICE_PGM_OBJECT} != "" \) -a \( ${SERVICE_PGM_OBJECT} != "null" \) ]; then
		SERVICE_PGM_OBJECT="-programObject ${SERVICE_PGM_OBJECT}"
	else
		SERVICE_PGM_OBJECT=''
	fi

	SERVICE_PCML=$(jq '.pcml' -r <<< "$2")
	if [ \( ${SERVICE_PCML} != "" \) -a \( ${SERVICE_PCML} != "null" \) ]; then
		SERVICE_PCML="-pcml ${SERVICE_PCML}"
	else
		SERVICE_PCML=''
	fi

	SERVICE_USER=$(jq '.userId' -r <<< "$2")
	if [ \( ${SERVICE_USER} != "" \) -a \( ${SERVICE_USER} != "null" \) ]; then
		SERVICE_USER="-userid ${SERVICE_USER}"
	else
		SERVICE_USER=''
	fi
	SERVICE_FIELD_LENGTH_DETECT=$(jq '.detectFieldLengths' -r <<< "$2")
	if [ \( ${SERVICE_FIELD_LENGTH_DETECT} != "" \) -a \( ${SERVICE_FIELD_LENGTH_DETECT} != "null" \) ]; then
		SERVICE_FIELD_LENGTH_DETECT="-detectFieldLengths"
	else
		SERVICE_FIELD_LENGTH_DETECT=''
	fi

	SERVICE_SERVICE_TYPE=$(jq '.serviceType' -r <<< "$2")
	if [ \( ${SERVICE_SERVICE_TYPE} != "" \) -a \( ${SERVICE_SERVICE_TYPE} != "null" \) ]; then
		SERVICE_SERVICE_TYPE="-serviceType ${SERVICE_SERVICE_TYPE}"
	else
		SERVICE_SERVICE_TYPE=''
	fi

	SERVICE_HOST=$(jq '.host' -r <<< "$2")
	if [ \( ${SERVICE_HOST} != "" \) -a \( ${SERVICE_HOST} != "null" \) ]; then
		SERVICE_HOST="-host ${SERVICE_HOST}"
	else
		SERVICE_HOST=''
	fi

	SERVICE_TARGET_NAMESPACE=$(jq '.targetNamespace' -r <<< "$2")
	if [ \( ${SERVICE_TARGET_NAMESPACE} != "" \) -a \( ${SERVICE_TARGET_NAMESPACE} != "null" \) ]; then
		SERVICE_TARGET_NAMESPACE="-targetNamespace ${SERVICE_TARGET_NAMESPACE}"
	else
		SERVICE_TARGET_NAMESPACE=''
	fi

	SERVICE_PROPERTIES_FILE=$(jq '.propertiesFile' -r <<< "$2")
	PROPERTIES_FILE=${SERVICE_PROPERTIES_FILE}
	if [ \( ${SERVICE_PROPERTIES_FILE} != "" \) -a \( ${SERVICE_PROPERTIES_FILE} != "null" \) ]; then
		SERVICE_PROPERTIES_FILE="-propertiesFile ${SERVICE_PROPERTIES_FILE}"
	else
		SERVICE_PROPERTIES_FILE=''
	fi
	
	SERVICE_LIBRARY_LIST=$(jq '.libraryList' -r <<< "$2")
	if [ \( ${SERVICE_LIBRARY_LIST} != "" \) -a \( ${SERVICE_LIBRARY_LIST} != "null" \) ]; then
		SERVICE_LIBRARY_LIST="-libraryList ${SERVICE_LIBRARY_LIST}"
	else
		SERVICE_LIBRARY_LIST=''
	fi
	
	SERVICE_LIBRARY_LIST_POSITION=$(jq '.libraryListPosition' -r <<< "$2")
	if [ \( ${SERVICE_LIBRARY_LIST_POSITION} != "" \) -a \( ${SERVICE_LIBRARY_LIST_POSITION} != "null" \) ]; then
		SERVICE_LIBRARY_LIST_POSITION="-libraryListPosition ${SERVICE_LIBRARY_LIST_POSITION}"
	else
		SERVICE_LIBRARY_LIST_POSITION=''
	fi

	SERVICE_TRANSPORT_METADATA=$(jq '.transportMetadata' -r <<< "$2")
	if [ \( ${SERVICE_TRANSPORT_METADATA} != "" \) -a \( ${SERVICE_TRANSPORT_METADATA} != "null" \) ]; then
		SERVICE_TRANSPORT_METADATA="-transportMetadata ${SERVICE_TRANSPORT_METADATA}"
	else
		SERVICE_TRANSPORT_METADATA=''
	fi

	SERVICE_TRANSPORT_HEADERS=$(jq '.transportHeaders' -r <<< "$2")
	if [ \( ${SERVICE_TRANSPORT_HEADERS} != "" \) -a \( ${SERVICE_TRANSPORT_HEADERS} != "null" \) ]; then
		SERVICE_TRANSPORT_HEADERS="-transportHeaders ${SERVICE_TRANSPORT_HEADERS}"
	else
		SERVICE_TRANSPORT_HEADERS=''
	fi
	
	SERVICE_USE_PARAM_AS_ELEMENT_NAME=$(jq '.useParamNameAsElementName' -r <<< "$2")
	if [ \( ${SERVICE_USE_PARAM_AS_ELEMENT_NAME} != "" \) -a \( ${SERVICE_USE_PARAM_AS_ELEMENT_NAME} != "null" \) ]; then
		SERVICE_USE_PARAM_AS_ELEMENT_NAME='-useParamNameAsElementName'
	else
		SERVICE_USE_PARAM_AS_ELEMENT_NAME=''
	fi

	echo "Die propertiesFiles:${PROPERTIES_FILE} wird erstellt ..."
	for j in $(jq '.methods | keys | .[]' -r <<< "$2"); do
		methode=$(jq ".methods[${j}]" -r <<< "$2");
		createPropertiesFile "${methode}" ${PROPERTIES_FILE};
	done

	echo "Die Service ${SERVICE_NAME} (${SERVICE_PGM_OBJECT}) wird installiert ..."
	echo "	${INSTALL_DIR}/installWebService.sh -server $1 ${SERVICE_PGM_OBJECT} ${SERVICE_NAME} ${SERVICE_PCML} ${SERVICE_USER} ${SERVICE_FIELD_LENGTH_DETECT} ${SERVICE_SERVICE_TYPE} ${SERVICE_HOST} ${SERVICE_TARGET_NAMESPACE} ${SERVICE_PROPERTIES_FILE} ${SERVICE_LIBRARY_LIST} ${SERVICE_LIBRARY_LIST_POSITION} ${SERVICE_TRANSPORT_METADATA} ${SERVICE_USE_PARAM_AS_ELEMENT_NAME} ${SERVICE_TRANSPORT_HEADERS} ${SERVER_PRINT_ERROR_DETAILS}"
	if ! qsh ${INSTALL_DIR}/installWebService.sh -server $1 ${SERVICE_PGM_OBJECT} ${SERVICE_NAME} ${SERVICE_PCML} ${SERVICE_USER} ${SERVICE_FIELD_LENGTH_DETECT} ${SERVICE_SERVICE_TYPE} ${SERVICE_HOST} ${SERVICE_TARGET_NAMESPACE} ${SERVICE_PROPERTIES_FILE} ${SERVICE_LIBRARY_LIST} ${SERVICE_LIBRARY_LIST_POSITION} ${SERVICE_TRANSPORT_METADATA} ${SERVICE_USE_PARAM_AS_ELEMENT_NAME} ${SERVICE_TRANSPORT_HEADERS} ${SERVER_PRINT_ERROR_DETAILS} > ${LOG_FILE} 2>&1; then
		echo "Die Service ${SERVICE_NAME} (${SERVICE_PGM_OBJECT}) könnte nicht installiert werden."
		return 1
	fi	
	
}

createPropertiesFile()
{
	touch $2
	entries=$(jq 'to_entries' -r <<< "$1")
	for k in $(jq '. | keys | .[]' -r <<< "${entries}"); do
		key=$(jq ".[${k}].key" -r <<< "${entries}")
		value=$(jq ".[${k}].value" -r <<< "${entries}")
		echo "${key}=${value}" >> $2
	done
	echo "" >> $2
}

################################################################################
#
#                               Main
#
################################################################################

if loadConfiguration $1;  then
    echo "Die Konfiguration-Datei:$1 erfolgreich geladen."
else 
    echo "Fehler bei laden der Konfiguration-Datei:$1."
    exit 1
fi


SERVER_NAME=$(jq '.server.name' -r <<< "${CONFIGURATION_FILE}")
SERVER_PORT=$(jq '.server.port' -r <<< "${CONFIGURATION_FILE}")
SERVER_USER=$(jq '.server.userId' -r <<< "${CONFIGURATION_FILE}")
SERVER_VERSION=$(jq '.server.version' -r <<< "${CONFIGURATION_FILE}")
SERVER_PRINT_ERROR_DETAILS=$(jq '.server.printErrorDetails' -r <<< "${CONFIGURATION_FILE}")
if [ ${SERVER_PRINT_ERROR_DETAILS} == "true" ]; then
	SERVER_PRINT_ERROR_DETAILS='-printErrorDetails'
else
	SERVER_PRINT_ERROR_DETAILS=' '
fi

LOG_FILE=/tmp/${SERVER_NAME}.log

if ! createWebServicesServer ${SERVER_NAME} ${SERVER_PORT} ${SERVER_VERSION} ${SERVER_USER} $1 ${SERVER_PRINT_ERROR_DETAILS}; then
	exit 1
fi

echo "Die Services werden installiert ..."
for i in $(jq '.services | keys | .[]' -r <<< "${CONFIGURATION_FILE}"); do
	service=$(jq ".services[${i}]" -r <<< "${CONFIGURATION_FILE}");
	if ! installWebService ${SERVER_NAME} "${service}"; then
		exit 1
	fi
done





