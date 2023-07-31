target_backup:
	@mkdir -p $(backup)	#creating backup directory if there does not exist any backup directory with the given name
	@./backupd.sh $(directory) $(backup) $(interval) $(max) #executing backupd bash script
