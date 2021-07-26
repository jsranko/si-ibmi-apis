#!/bin/bash

loadConfiguration()
{
	SCRIPT=$1
	if [[ "${SCRIPT^^}" =~ "/QSYS.LIB" ]]; then
	    CONFIGURATION_FILE=$(cat "$1" | iconv -f IBM-${PASE_CCSID} -t UTF-8 | jq '.' -r)
	else
		echo "Die Konfiguration-Datei:$1 wird geladen ..."
		CONFIGURATION_FILE=$(jq '.' -r $1) && echo "Die Konfiguration-Datei:$1 wurde erfolgreich geladen" || { echo "Die Konfiguration-Datei:$1 nicht gefunden!"; exit 1; }
	fi

}
