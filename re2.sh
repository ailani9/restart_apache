#!/bin/bash
# Move the current execution state to the proper directory
cd /etc/apache2/sites-available

CONFIG="$!"
COMMAND="$2"
if [ $# -ne 2 ]
then
    echo "$0 requires two parameters {virtual-host} {restart|reload}"
    exit 1
fi

#Dissable a vhost
sudo a2dissite "$CONFIG"
sudo service apache2 "$COMMAND"

#Enable 
sudo a2ensite "$CONFIG"
sudo service apache2 "$COMMAND"
