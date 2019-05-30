#!/bin/bash
#### Description: This script is a source of functions for the 
#### vpdiffs script. Functions related to locating directories
#### and filenames as well as running squish tools.

# TODO  update variables names, add functions for using all tools, comment purpose of each function
# 


## Test Results functions	
getTimestampDir () {
	local tsDir=~/.squish/Test\ Results/	# directory storing all results
	tsDir="$tsDir$(ls "$tsDir" | tail -1)"	# directory for most recent timestamp
	tsDir="$(find "$tsDir" -maxdepth 1 -mindepth 1 -type d | tail -1)/"
	echo "$tsDir"
}

getTestCaseName () {
	local tsDir=$(getTimestampDir)
	local tcName="$(ls "$tsDir" | grep 'tst' | tail -1)" 
	echo "$tcName"
}

getScreenshotDir () {
	local ssDir="$(getTimestampDir)$(getTestCaseName)/screenshots/"
	echo "$ssDir"
}

getVPDir () {
	local tcName=$(getTestCaseName)
	local vpDir=~/Sources/rvc/AutomatedTests/suites/	# directory of suites
	vpDir="$(find $vpDir -maxdepth 2 -mindepth 2 -type d -name $tcName)"	# directory of test case
	vpDir="${vpDir}/verificationPoints/"
	echo "$vpDir"
}




## Generic functions

getMatchingVPs () {
	local VP_BASE=$1
	local VP_DIR=$2
	echo "$(find "$VP_DIR" -regex ".*/${VP_BASE}\(_[0-9]+\)?$" -print)"	
}

getVPName () {
	local SCREENSHOT_NAME=$1
	local TC_NAME=$2	
	VP_NAME= sed -E 's/(-[1-9]+)?.png$//g' <<< ${SCREENSHOT_NAME#"${TC_NAME}_"}
	echo "$VP_NAME"
}




## Jenkins functions
getJenkinsDataDir() {
	local ARCHIVE_DIR=$1
	echo "${ARCHIVE_DIR}/archive/out/data/"
}

getJenkinsTestCaseName () {
	local ARCHIVE_DIR=$1
	local DATA_DIR=$(getJenkinsDataDir $ARCHIVE_DIR)
	local TEST_CASE_NAME="$(ls "$DATA_DIR" | grep 'tst' | tail -1)" 
	echo "$TEST_CASE_NAME"
}


getJenkinsScreenshotDir () {
	local ARCHIVE_DIR=$1
	local DATA_DIR=$(getJenkinsDataDir $ARCHIVE_DIR)
	local TEST_CAST_NAME=$(getJenkinsTestCaseName $ARCHIVE_DIR)
	local SS_DIR="${DATA_DIR}/${TEST_CASE_NAME}/${TEST_CASE_NAME}/"
	echo "SS_DIR"
}


