#!/bin/bash

# This script contains functions for locating vp and screenshot
# files that are use in other scripts

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

getMatchingVPs () {
	local vpName=$1
	local vpDir=$(getVPDir)
	echo "$(find "$vpDir" -regex ".*/${vpName}\(_[0-9]+\)?$" -print)"	
}
