#! /bin/bash
#----------storing arguments in array----------
args=("$@")
#----------Validating number of arguments---------
if ! [ ${#args[@]} -eq 4 ]
then
	echo "NON-VALID NUMBER OF ARGUMENTS"
	exit
fi
#----------Validating existence of target directory----------
while [ 1 ]
do
	if [ -d ${args[0]} ]
	then
		break
	else
	
		echo -n "TARGET DIRECTORY: ${args[0]} DOES NOT EXIST RE-ENTER TARGET DIRECTORY: "
		read args[0]
	fi
done
#----------Validating given interval----------
regex='^[0-9]+$'
while [ 1 ]
do
	if ! [[ ${args[2]} =~ $regex ]] ;
	then
		echo -n "INTERVAL: ${args[2]} IS NOT VALID. RE-ENTER VALID INTERVAL (NON-NEGATIVE INTEGER): "
		read args[2]
	else
		break
	fi
done
#----------Validating given max----------
regex='^[1-9]+$'
while [ 1 ]
do
	if ! [[ ${args[3]} =~ $regex ]] ;
	then
		echo -n "MAXIMUM NUMBER OF BACKUPS: ${args[3]} IS NOT VALID. RE-ENTER VALID MAXIMUM NUMBER OF BACKUPS (NON-NEGATIVE INTEGER): "
		read args[3]
	else
		break
	fi
done
#----------saving old directory info----------
ls -lR ${args[0]} > directory-info.last
last=$(cat directory-info.last)
#----------first backup----------
cp -R ${args[0]} ${args[1]}
#----------renaming first backup to current Date----------
date=$(date '+%Y-%m-%d-%H-%M-%S')
mv ./${args[1]}/${args[0]} ./${args[1]}/${date}
echo "BACKUP STORED: ./${args[1]}/${date}"

while [ 1 ]
do
	#----------waiting for given interval----------	
	sleep ${args[2]}
	#----------saving directory new info----------
	ls -lR ${args[0]} > directory-info.new
	new=$(cat directory-info.new)
	#----------comparing directory's old and latest info ----------
	echo -n "SCAN RESULT: "
	if [[ $last == $new ]]
	then #----------no change in directory detected----------
		echo "NO CHANGE DETECTED IN TARGET DIRECTORY"
	else #----------change in directory detected----------
		echo "CHANGE DETECTED IN TARGET DIRECTORY"
		#----------saving the new directory info----------
		last=$new
		#----------backing up and renaming----------
		cp -R -p ${args[0]} ${args[1]}
		date=$(date '+%Y-%m-%d-%H-%M-%S')
		mv ./${args[1]}/${args[0]} ./${args[1]}/${date}
		echo "BACKUP STORED: ./${args[1]}/${date}"
		#----------checking if max number of backups reached----------
		x=$(find ./${args[1]} -mindepth 1 -maxdepth 1 -type d | wc -l) #fetching number of files in backup directory
		if [ $x -gt ${args[3]} ] #if num of backups has exceeded the max num
		then	#----------deleteing all backups except the most recent $(max) backups----------
			echo "MAXIMUM NUMBER OF STORED BACKUPS REACHED IN ${args[1]}"
			oldest=$(ls ./backupdir -1t | tail -n +$((${args[3]} + 1)))
			cd ${args[1]}
			rm -r ${oldest}
			cd ..
			echo "BACKUPS DELETED: ${oldest}"
		fi 
	fi
	
done
