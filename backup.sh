#!/bin/bash

# This checks if the number of arguments is correct
# If the number of arguments is incorrect ( $# != 2) print error message and exit
if [[ $# != 2 ]]
then
  echo "Usage: backup.sh target_directory_name destination_directory_name"
  exit 1
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit 1
fi

# [TASK 1]
targetDirectory=$1
destinationDirectory=$2

# [TASK 2]
echo "Target Directory: $targetDirectory"
echo "Destination Directory: $destinationDirectory"

# [TASK 3]
currentTS=$(date +"%Y%m%d%H%M%S")

# [TASK 4]
backupFileName="backup-$currentTS.tar.gz"

# We're going to:
# 1: Go into the target directory
# 2: Create the backup file
# 3: Move the backup file to the destination directory

# To make things easier, we will define some useful variables...

# [TASK 5]
origAbsPath=$(pwd)
echo "Original Absolute Path: $origAbsPath"

# [TASK 6]
cd "$destinationDirectory"
destDirAbsPath=$(pwd)
echo "Destination Directory Absolute Path: $destDirAbsPath"

# [TASK 7]
cd "$origAbsPath"
cd "$targetDirectory"
echo "Changed to Target Directory: $(pwd)"

# [TASK 8]
yesterdayTS=$(date -d "yesterday" +"%Y-%m-%d %H:%M:%S")
echo "Yesterday's Timestamp: $yesterdayTS"

declare -a toBackup

# [TASK 9]
for file in $(find . -type f -newermt "$yesterdayTS") 
do
  # [TASK 10]
  if [[ $file -nt $yesterdayTS ]]
  then
    # [TASK 11]
    toBackup+=("$file")
    echo "File to backup: $file"
  fi
done

# [TASK 12]
if [ ${#toBackup[@]} -eq 0 ]; then
  echo "No files to backup."
  exit 0
fi

tar -czf "$origAbsPath/$backupFileName" "${toBackup[@]}"
echo "Backup file created: $backupFileName"

# [TASK 13]
mv "$origAbsPath/$backupFileName" "$destDirAbsPath"
echo "Backup file moved to destination directory: $destDirAbsPath"

# Congratulations! You completed the final project for this course!
