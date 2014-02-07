#!/bin/bash

#  Script for Drupal 5.x 

#modules path
modules_path='./modules';
temp_dir='/tmp/modules';

#array of modules to be updated to latest version for drupal 5.x
modules=(
		http://ftp.drupal.org/files/projects/captcha-5.x-3.3.zip
		http://ftp.drupal.org/files/projects/mail_edit-5.x-1.1.zip
		http://ftp.drupal.org/files/projects/mimemail-5.x-1.1.zip
		http://ftp.drupal.org/files/projects/smtp-5.x-1.0.zip
		http://ftp.drupal.org/files/projects/user_register_notify-5.x-1.10.zip
		http://ftp.drupal.org/files/projects/addtoany-5.x-2.6.zip
		http://ftp.drupal.org/files/projects/codefilter-5.x-1.1.zip
		http://ftp.drupal.org/files/projects/comment_mover-5.x-1.x-dev.zip
		http://ftp.drupal.org/files/projects/comment_upload-5.x-0.1.zip
		http://ftp.drupal.org/files/projects/faq-5.x-2.15.zip
		http://ftp.drupal.org/files/projects/google_analytics-5.x-1.9.zip
		http://ftp.drupal.org/files/projects/invisimail-5.x-1.0.zip
		http://ftp.drupal.org/files/projects/nodewords-5.x-1.13.zip
		http://ftp.drupal.org/files/projects/mollom-5.x-1.9.zip 
		http://ftp.drupal.org/files/projects/themesettingsapi-5.x-2.8.zip
		http://ftp.drupal.org/files/projects/taxonomy_access-5.x-2.0.zip 
		http://ftp.drupal.org/files/projects/profile_csv-5.x-1.0.zip
		http://ftp.drupal.org/files/projects/user_badges-5.x-1.5.zip
		http://ftp.drupal.org/files/projects/webform-5.x-2.10.zip
		http://ftp.drupal.org/files/projects/webform_report-5.x-2.6.zip
		http://ftp.drupal.org/files/projects/votingapi-5.x-1.6.zip
		http://ftp.drupal.org/files/projects/views-5.x-1.8.zip
		http://ftp.drupal.org/files/projects/subscriptions-5.x-2.6.zip
		http://ftp.drupal.org/files/projects/userpoints-5.x-3.7.zip
)


#Starting Module Update

#Get the module directory
echo -n "Enter the path for Modules [ `readlink -f $modules_path`]: (y/n) ";
read ans 
ans=${ans:-y}

if [ $ans == 'n' ]
	then
		echo -n "Enter the absolute path for modules: ";
		read ans1;
		modules_path=$ans1;
elif [ $ans == 'y' ]
	then
	modules_path=`readlink -f $modules_path`;
fi

if [ ! -d $modules_path ]
	then
		echo 'Module folder not exist';
		exit;
	fi

for module in "${modules[@]}" 
do
   :
   # do whatever on $module

   #get the module folder name
   module_folder_name=`basename $module | cut -d '-' -f1`;
   echo "$modules_path/$module_folder_name";
   #Check the module is already present. If then delete it
   if [ -d "$modules_path/$module_folder_name" ]
   		then
   			echo "Deleting $modules_path/$module_folder_name";
   			rm -rf "$modules_path/$module_folder_name";
   	fi

   	module_name=`basename $module`;
   	#Download the modules to temp folder
   	mkdir -p $temp_dir;
   	wget $module -O "$temp_dir/$module_name";
   	
   	unzip "$temp_dir/$module_name" -d  $modules_path;
done

echo "Modules downloaded. Run update.php file on your browser"