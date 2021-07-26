#!/bin/bash

INSTALL_DIR=/QIBM/ProdData/OS/WebServices/bin
CONFIGURATION_FILE=
PASE_CCSID=$(jq '.job_ccsid' -r ./config.json)
