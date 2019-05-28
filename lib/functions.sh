#!/bin/bash
#### Description: This script is a source of functions for the 
#### vpdiffs script. Functions related to locating directories
#### and filenames as well as running squish tools.

# TODO  update variables names, add functions for using all tools, comment purpose of each function


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

getVPName () {
	local vpName=$1
	local tcName=$(getTestCaseName)	
	vpName=${vpName#${tcName}_}	# remove prefix
	vpName=${vpName%.png}		# remove suffix
	echo "$vpName"
}



## Generic functions

# TODO make this take another argument to make it generic
getMatchingVPs () {
	local vpName=$1
	local vpDir=$(getVPDir)
	echo "$(find "$vpDir" -regex ".*/${vpName}\(_[0-9]+\)?$" -print)"	
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


