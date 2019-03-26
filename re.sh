#!/bin/bash
CONFIG="$1"
COMMAND="$2"

#Move the current execution state to the proper directory
cd /etc/apache2/sites-available
if [ $# -ne 2 ]
then
    echo "$0 requires two parameter {virtual-host} {restart|reload}"
    exit 1
fi

# Disable a vhost
sudo a2dissite *
sudo service apache2 restart
#only allow reload or restart
if [ "$COMMAND" == "reload" ] || [ "$COMMAND" == "restart" ]
then
    cd /etc/apache2/sites-available
    # Disable a vhost
    sudo a2dissite "$CONFIG"
    sudo service apache2 "$COMMAND"

    #Enable 
    sudo a2ensite "$CONFIG"
    sudo service apache2 "$COMMAND"
else
    echo "ERROR: $COMMAND is an invalid service command {restart|reload}"
    exit 1
fi

#Enable 
sudo a2ensite *
sudo service apache2 restart 