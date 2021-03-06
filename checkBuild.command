#!/bin/bash

set -e

base_dir=$(dirname "$0")
cd "$base_dir"

echo ""
echo -e "\nChecking Carthage integrity..."
pbxproj_path='CarthageSupport/APExtensions-example.xcodeproj/project.pbxproj'
swift_files=$(find 'APExtensions/Classes' -type f -name "*.swift" | grep -o "[0-9a-zA-Z+ ]*.swift" | sort -fu)
swift_files_count=$(echo "${swift_files}" | wc -l | tr -d ' ')

build_section_id=$(sed -n -e '/\/\* APExtensions \*\/ = {/,/};/p' "${pbxproj_path}" | sed -n '/PBXNativeTarget/,/Sources/p' | tail -1 | tr -d "\t" | cut -d ' ' -f 1)
swift_files_in_project=$(sed -n "/${build_section_id}.* = {/,/};/p" "${pbxproj_path}" | grep -o "[A-Z].[0-9a-zA-Z+ ]*\.swift" | sort -fu)
swift_files_in_project_count=$(echo "${swift_files_in_project}" | wc -l | tr -d ' ')
if [ "${swift_files_count}" -ne "${swift_files_in_project_count}" ]; then
    echo  >&2 "error: Carthage project missing dependencies."
    echo -e "\nFinder files:\n${swift_files}"
    echo -e "\nProject files:\n${swift_files_in_project}"
    echo -e "\nMissing dependencies:"
    comm -23 <(echo "${swift_files}") <(echo "${swift_files_in_project}")
    echo " "
	exit 1
fi

echo -e "\nBuilding Pods project..."
set -o pipefail && xcodebuild -workspace "Example/APExtensions.xcworkspace" -scheme "APExtensions-Example" -configuration "Release" -sdk iphonesimulator | xcpretty

echo -e "\nBuilding Carthage projects..."
set -o pipefail && xcodebuild -project "CarthageSupport/APExtensions-example.xcodeproj" -sdk iphonesimulator -target "APExtensions-example" | xcpretty

echo -e "\nBuilding with Carthage..."
carthage build --no-skip-current --cache-builds

echo -e "\nPerforming tests..."
simulator_id="$(xcrun simctl list devices available | grep "iPhone SE" | tail -1 | sed -e "s/.*iPhone SE (//g" -e "s/).*//g")"
if [ -z "${simulator_id}" ]; then
    echo "error: Please install 'iPhone SE' simulator."
    echo " "
    exit 1
else
    echo "Using iPhone SE simulator with ID: '${simulator_id}'"
fi

set -o pipefail && xcodebuild -workspace "Example/APExtensions.xcworkspace" -sdk iphonesimulator -scheme "APExtensions-Example" -destination "platform=iOS Simulator,id=${simulator_id}" test | xcpretty

echo ""
echo "SUCCESS!"
echo ""
echo ""
