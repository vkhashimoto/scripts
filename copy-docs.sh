#!/bin/bash

valid=0
destination_folder=""
if [ -z "${DOCS_DESTINATION_FOLDER}" ] && [ -z "$1" ]; then
        echo "Please set the destination folder to the env var DOCS_DESTINATION_FOLDER or provide the folder destination within script call"
elif [ ! -z "$1" ]; then
        destination_folder="$1"
        valid=1
elif [ ! -z "${DOCS_DESTINATION_FOLDER}" ]; then
        destination_folder="${DOCS_DESTINATION_FOLDER}"
        valid=1
fi

if [ $valid -eq 0 ]; then
        echo "Invalid configuration"
        exit -1
fi


echo "Starting service to copy documentation files to the server folder"


project_name=""
project_docs=""

for folder in */ ; do
        project_name="${folder///}"
        echo " - Reading folder: $project_name"
        for file in $folder*.yaml ; do
                project_docs="$file"
        done
        echo " - Found file: $project_docs"

        echo " - Starting copying file $project_docs to $destination_folder"
        cp $project_docs "$destination_folder/$project_name".yaml
        echo " - Finished copyign file $project_docs to $destination_folder"

done

echo "Stopping service to copy documentation to the server folder"
