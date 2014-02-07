#!/bin/bash

#  Script for Drupal 6.x 
drush='/home/aneesh/Downloads/drush-master/drush';

modules=(
	mail_edit mimemail user_register_notify addtoany codefilter
	comment_mover comment_upload faq invisimail nodewords
	mollom profile_csv taxonomy_access themesettingsapi
	user_badges webform webform_report quiz multichoice
	captcha subscriptions subscriptions_content subscriptions_ui
	subscriptions_taxonomy userpoints views
	)
for module in "${modules[@]}" 
do
   :
   # do whatever on $module
   $drush en $module -y;
   $drush updb;

done

#echo $drush;

