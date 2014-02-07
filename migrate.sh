#!/bin/bash
SCRIPT_BASE=`dirname $0`;
source $SCRIPT_BASE/includes/params.conf

ssh root@$NEW_DB_SERVER mysqladmin create $NEW_DB_NAME
mysql -uroot -p -h $NEW_DB_SERVER -e"GRANT ALL PRIVILEGES ON $NEW_DB_NAME.* TO $NEW_DB_USER@$NEW_WEBSERVER_IP IDENTIFIED BY '$NEW_DB_PASSWORD'"

wget http://ftp.drupal.org/files/projects/drupal-6.30.zip -O /tmp/drupal-6.30.zip
unzip /tmp/drupal-6.30.zip -d /var/www/
mv /var/www/drupal-6.30 /var/www/forums

rsync -avz --progress -e 'ssh -p22'  root@$OLD_WEBSERVER_NAME:/var/www/forums/files /var/www/forums/files

scp $SCRIPT_BASE/files/drupal6.30/settings.php  /var/www/forums/sites/default/

scp $SCRIPT_BASE/includes/updated.sh root@$OLD_WEBSERVER_NAME:/tmp/

ssh root@$OLD_WEBSERVER_NAME bash /tmp/updated.sh

 read ans 

 if [ $ans == 'yes' ]
 	then

 		 ssh root@$OLD_WEBSERVER_NAME wget http://ftp.drupal.org/files/projects/drupal-5.23.zip -O /tmp/drupal5.23.zip
 		 ssh root@$OLD_WEBSERVER_NAME unzip /tmp/drupal5.23.zip -d /var/www/
 		 ssh root@$OLD_WEBSERVER_NAME mv /var/www/drupal-5.23 /var/www/forums2

 		 scp $SCRIPT_BASE/files/drupal5.23/settings.php root@$OLD_WEBSERVER_NAME:/var/www/forums2/sites/default/
 		 echo "Run setttings.php in your Browser"
 		 read ans1

 		 if [ $ans1 == 'yes' ]
 		 	then

 		 	ssh root@$OLD_DB_SERVER mysqldump -u root -p $OLD_DB_NAME > /tmp/$OLD_DB_NAME.sql
 		 	mysql -u root -p -h $NEW_DB_SERVER $NEW_DB_NAME < /tmp/$OLD_DB_NAME.sql
 		 	echo "Run the update.php in your Browser"

 		 	read ans3

 		 	if [ $ans3 == 'yes' ]
 		 		then
 		 		cd /var/www/forums
 		 		bash $SCRIPT_BASE/includes/updated6x.sh

 		 	fi
 		fi


 fi





