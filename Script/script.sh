#! /bin/bash 

sourceDirectory="/home/jakub/Project/sourceDirectory"

targetDirectory="/home/jakub/Project/targetDirectory1"

currentDate=$(date +"%Y-%m-%d")

currentTime=$(date +"%H:%M:%S")

counter=1

email="kuba.tylinski51@gmail.com"

sendEmail() {
   subject=$1
   body=$2
   echo -e "Subject: $subject \n $body" | /usr/bin/sendmail "$email"
}

if [ ! -d "$sourceDirectory" ]
then
    echo "Ups... Source directory does not exist"
    sendEmail "Backup error" "Source diretory does not exist"
    exit 0
fi

if [ ! -d "$targetDirectory" ]
then
    echo "Target directory does not exist. I will make a new folder"
    mkdir targetDirectory-${currentDate}
    sendEmail "New target directory" "The specified directory does not exist. New one created"
    $targetDirectory="/home/jakub/Project/targetDirectory-${currentDate}"
fi

backupPrefix="backup"

if [ "$(ls -A "$sourceDirectory")" ]
then

numberOfFiles=$(ls "sourceDirectory" | wc -l)

sendEmail "Backup has been created" "The files have been successfully moved to the target directory"

while [ $counter -le $numberOfFiles ]
do

   firstFile=$(ls "sourceDirectory" | head -n 1)

   archivedFile=$firstFile-${currentDate}-${currentTime}-$backupPrefix

   mv "$sourceDirectory/$firstFile" "$targetDirectory/$archivedFile"

   echo "File content $firstFile has been moved to the target directory: $targetDirectory"

   ((counter++))

done

else
echo "Source directory is empty"
sendEmail "Backup has not been created" "Source directory is empty"
fi

maxBackups=20

numberOfBackUpFiles=$(ls -1 "$targetDirectory" | grep -c "$backupPrefix")
if [ "$numberOfBackUpFiles" -gt "$maxBackups" ]
then
    
  backupsToDelete=$(ls -1 "$targetDirectory" | grep "$backupPrefix" | sort -n | head -n "$(($numberOfBackUpFiles - $maxBackups))")
  for backup in $backupsToDelete
  do
    backupToRemove="$targetDirectory/$backup"
    rm -rf "$backupToRemove"
    echo "The older backup $backup has been deleted"
  done
  sendEmail "Older backups deleted" "The number of copies allowed in the target directory has been exceeded. The oldest ones have been deleted"
fi

echo "To change the maximum number of backups in the target file, press A"
echo "To view all backups, press B"
echo "To restore backups from a given day, press C"

read choice

case $choice in
"A")
echo "Enter a new number of possible backups in the directory"
read $newMaximum
maxBackups=$newMaximum;;
 
 "B")
 ls -1 "$targetDirectory";;
 
 "C") 
 read -p "Enter the date to restore backup (YYYY-MM-DD): " enteredDate

numberOfFilesToRestore=$(ls -1 "$targetDirectory" | grep -c "$enteredDate")

if [ "$numberOfFilesToRestore" -eq 0 ]
then
  echo "No backup found for the provided date: $enteredDate"
  sendEmail "Recovering the backup failed" "No backups found on date $enteredDate"
  exit 1
fi

while [ "$counter" -le "$numberOfFilesToRestore" ]
do 
   recoveryCopy=$(ls -1 "$targetDirectory" | grep "$enteredDate" | sort -n | head -n 1 ) 
   mv $targetDirectory/$recoveryCopy $sourceDirectory
   echo "Backup $recoveryCopy has been restored successfully"
    ((counter++)) 
done

if [ "$numberOfFilesToRestore" -gt 0 ]
then
sendEmail "The restore was successful" "Backups from $enteredDate have been restored to the source directory"
fi;;

*) echo "Incorrect option"

esac
