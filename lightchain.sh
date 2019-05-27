#!/bin/bash

check_exit_status() {

    if [ $? -eq 0 ]
    then
        echo
        echo "Success"
        echo
    else
        echo
        echo "[ERROR] Process Failed!"
        echo
		
        read -p "The last command exited with an error. Exit script? (yes/no) " answer

        if [ "$answer" == "yes" ]
        then
            exit 1
        fi
    fi
}

greeting() {

    clear
    echo
    echo "Hello, $USER. This script will install a LiteChain Disciple Node."
    echo
}

update() {

    clear
    echo "------------------------"
    echo "- Updating the System! -"
    echo "------------------------"
    echo

    sudo apt-get update > /dev/null 2>&1;
    check_exit_status

    sudo apt-get upgrade -y > /dev/null 2>&1;
    check_exit_status

    sudo apt-get dist-upgrade -y > /dev/null 2>&1;
    check_exit_status
}

housekeeping() {

	clear
    echo "---------------------------------"
    echo "- Performing Some Housekeeping! -"
    echo "---------------------------------"
    echo

    sudo apt-get autoremove -y > /dev/null 2>&1;
    check_exit_status

    sudo apt-get autoclean -y > /dev/null 2>&1;
    check_exit_status

    sudo updatedb;
    check_exit_status
	
	sudo apt-get install unzip -y > /dev/null 2>&1;
	check_exit_status
}

Firewall() {

	clear
    echo "----------------------------"
    echo "- Now Installing Firewall! -"
    echo "----------------------------"
    echo


	sudo apt-get install ufw > /dev/null 2>&1;
	check_exit_status
	sudo ufw default deny incoming > /dev/null 2>&1;
	check_exit_status
	sudo ufw default allow outgoing > /dev/null 2>&1;
	check_exit_status
	sudo ufw allow ssh > /dev/null 2>&1;
	check_exit_status
	sudo ufw allow 10002 > /dev/null 2>&1;
	check_exit_status
	echo "y" | ufw enable > /dev/null 2>&1;
	check_exit_status
}

LightChain () {

    clear
    echo "-------------------------------------"
    echo "- Now Installing The Disciple Node! -"
    echo "-------------------------------------"
    

	sudo apt-get install screen > /dev/null 2>&1;
	
	check_exit_status
	wget https://github.com/lcxnetwork/LightChain/releases/download/v0.2.2/Linux-v0.2.2.zip > /dev/null 2>&1;
	check_exit_status

	unzip Linux-v0.2.2.zip > /dev/null 2>&1;
	check_exit_status
	
	sudo mv Linux-v0.2.2 LightChain > /dev/null 2>&1;
	check_exit_status
    cd ~/LightChain > /dev/null 2>&1;
	check_exit_status
	
}

leave() {

    clear
    echo "----------------------------------------------------------------------------------------------------------------------------"
    echo "- Installlation Complete! -"
    echo "- Please visit https://nodes.lightchain.net/ -"
	echo "- To register your node -"
	echo " "
	echo "- After you have registered to start the node you will have to enter the command: screen:"
	echo "- and then:- "
	echo "- 
	echo " "
	echo "-To start the node"
	echo "-----------------------------------------------------------------------------------------------------------------------------"
    echo
   
}


greeting
update
housekeeping
Firewall
LightChain
leave	
