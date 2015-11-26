backup_mysql
==

This bash program has been made to backup mysql databases, the using is simple

* clone the repo

```
git clone https://github.com/remijouannet/backup_mysql.git
```

* launch the makefile

```
sudo make install
```


* configure /etc/backup_mysql/backup_mysql.ini

```
#!/bin/bash

####################SETTINGS########################

#the directory where to put the backup
DIR_BACKUP='/tmp/backup'

#Settings for mysql connection
MYSQL_HOST='localhost'
MYSQL_PORT='3306'
MYSQL_USER='user'
MYSQL_PASSWORD='password'

#backup all the databases, this parameter overwrite the parameter MYSQL_DATABASES
MYSQL_DATABASES_ALL=1

#Select the databases you want to backup, MYSQL_DATABASES_ALL must be to 0
MYSQL_DATABASES=('dbA' 'dbB' 'dbC')

#date format for the log file
DATE_FORMAT_LOG="%Y-%m-%d %H:%M:%S" 

#date format for the backups
DATE_FORMAT_BACKUP="%Y%m%d_%H%M%S"

#from_email when the script fail
FROM_MAIL="root@localhost"

#to_email when the script fail
MAIL="root@localhost" 

#log file
LOG_FILE=/var/log/backup_dir/backup_dir.log

#max bytes log file
LOG_FILE_MAXBYTES=5242880

#maximum log file rotate
LOG_FILE_ROTATE=4 


######DAILY#######
DAILY=true #enable daily backup
ROTATE_DAILY=2 #Day Rotate in days
DAYS_DAILY=(1 2 3 4 5 6 7) # day in the week, 1-7, 1 is monday

######WEEKLY######
WEEKLY=true #enable weekly backup
ROTATE_WEEKLY=4 #Week Rotate, in weeks
DAY_WEEKLY=1 #day in the week 1-7, 1 is monday

#####MONTHLY######
MONTHLY=true # enable monthly backup
ROTATE_MONTHLY=12 #Month rotate, in months
DAY_MONTHLY=1 #Day in the month

#command to execute before backup
prebackup(){
	echo $(date +"$DATE_FORMAT_LOG")" beginning"
}

#command to execute after backup
postbackup(){
	echo $(date +"$DATE_FORMAT_LOG")" end"
}

```

* launch the script, **launch the script as root**

```
sudo /usr/sbin/backup_mysql_cron
```

mutliple config files
--

You can have mutliple config files, if you have let's say a conf file named "/etc/backup_mysql/backup_mysql2.ini"
you can use it with the following command

```
/usr/sbin/backup_mysql_cron /etc/backup_mysql/backup_mysql2.ini
```

configuration with cron
--

if you want to run that script every days

* launch cronedit for root

```
sudo crontab -e
```

* add this line for every day, 6AM

```
0 6 * * * /usr/sbin/backup_mysql_cron
```


