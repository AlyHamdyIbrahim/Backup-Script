# Automatic Directory Backup
## _Description_
This program offers a safe way of backing up a target directory to another backup directory upon a change is detected.
## _How it works?_
The user provides the program with 4 parameters:
- Name of directory to be Backed up.
- Name of directory to which the backup will be stored.
- Time between every scan for changes.
- Maximum number of backups stored in given backup directory.

Upon running the program, a backup for the given directory is stored in the given backup directory, and the directory's info is saved for future checking of changes.
```sh
BACKUP STORED: ./backupdir/2022-10-18-18-27-00
```

Then, every interval of seconds _(predefined by the user)_ a scan for changes is made to check if the directory was changed,
- If a change is detected; a copy of the directory renamed to the date and time fo backup is stored in the backup directory, and new directory info is stored for future checking ofr changes.
```sh
SCAN RESULT: CHANGE DETECTED IN TARGET DIRECTORY
```
Then, if the number of backups stored in the backup directory exceeds the maximum number of backups _(predefined by the user)_, only the most recent number _(check note)_ of backups are stored and all other older backups are deleted.
_Note: The number of backups not deleted (kept stored) is the maximum number of backups given by the user_
```sh
MAXIMUM NUMBER OF STORED BACKUPS REACHED IN backupdir
BACKUPS DELETED: 2022-10-18-18-27-00
```

- Else if no change is detected, no backup will be stored as it would be a duplicate for another backup in the same backup directory therefore offering better memory management by the program.
```sh
SCAN RESULT: NO CHANGE DETECTED IN TARGET DIRECTORY
```

## _How to use?_
First, The user should make sure that _make_ is installed on the system by typing this command in the terminal:
```sh
man make
```
If it is not installed, the user should install it by typing the next command:
```sh
sudo apt install make
```
Then, the user should go to the parent directory of the target directory _(that needs to be backed up)_ and start running the program by typing the next command in the terminal:
```sh
make directory=dir backup=backupdir interval=10 max=5
```
Where the user should replace the given arguments with his own arguments as following:
- directory= The target directory to be backed up.
- backup= The backup directory name where backups will be stored.
- interval= The number of seconds between every scan for changes.
- max= The maximum number of backups to be stored in the backup directory.

## Input Restrictions:
- Number of arguments must be valid.
```sh
NON-VALID NUMBER OF ARGUMENTS
```
- If Target Directory does not exist, user will be prompted to re-enter a valid Target Directory.
```sh
TARGET DIRECTORY: direc DOES NOT EXIST RE-ENTER TARGET DIRECTORY:
```
- If the name of the backup directory is given but no directory with this name exists, a new directory with this name will be created.
- Interval and Maximum number of backups both must be non-negtive integers, otherwise the user will be prompted to re-enter a valid non-negative integer.
```sh
INTERVAL: -10 IS NOT VALID. RE-ENTER VALID INTERVAL (NON-NEGATIVE INTEGER):  
```
```sh
MAXIMUM NUMBER OF BACKUPS: seven IS NOT VALID. RE-ENTER VALID MAXIMUM NUMBER OF BACKUPS (NON-NEGATIVE INTEGER): "
```
## Warnings:
- If the backup directory given by the user originally have other directories they are at risk of being deleted by the program. Therefore, The user should make sure to give an empty directory or give a name of a non-existing directory and the program will create a new empty one.
# Author: Aly Hamdy Ibrahim Hassan
