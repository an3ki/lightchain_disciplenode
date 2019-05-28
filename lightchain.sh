#!/bin/bash
NODEIP=$(curl -s4 icanhazip.com)
CYAN="\033[0;34m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m" 
PURPLE="\033[0;35m"
GREEN='\033[0;31m'
GREEN="\033[0;32m"
NC='\033[0m'
MAG='\e[1;35m'
check_exit_status() {

    if [ $? -eq 0 ]
    then
        echo -e
        echo -e "Success"
        echo -e
    else
        echo -e
        echo -e "[ERROR] Process Failed!"
        echo -e
		
        read -p "The last command exited with an error. Exit script? (yes/no) " answer

        if [ "$answer" == "yes" ]
        then
            exit 1
        fi
    fi
}

greeting() {

    clear
    echo -e
    echo -e "${YELLOW}Hello, $USER. This script will install a LiteChain Disciple Node.${NC}"
    echo -e ""
    read -n 1 -s -r -p "Press any key to continue....."
}

update() {

    clear
    echo -e "${CYAN}------------------------"
    echo -e "- Updating the System! -"
    echo -e "------------------------${NC}"
    echo -e ""
	echo -e "${GREEN}Loading......Please Wait.........${NC}"
    sudo apt-get update > /dev/null 2>&1;
      
	check_exit_status
	echo -e "${GREEN}Loading......Please Wait.........${NC}"
    sudo apt-get upgrade -y > /dev/null 2>&1;
      
	check_exit_status
	echo -e "${GREEN}Loading......Please Wait.........${NC}"
    sudo apt-get dist-upgrade -y > /dev/null 2>&1;
      
	check_exit_status
}

housekeeping() {

	clear
    echo -e "${CYAN}---------------------------------"
    echo -e "- Performing Some Housekeeping! -"
    echo -e "---------------------------------"
    echo -e ""
	echo -e "${GREEN}Loading......Please Wait.........${NC}"
    sudo apt-get autoremove -y > /dev/null 2>&1;
      
	check_exit_status
	echo -e "${GREEN}Loading......Please Wait.........${NC}"
    sudo apt-get autoclean -y > /dev/null 2>&1;
      
	check_exit_status
	echo -e "${GREEN}Loading......Please Wait.........${NC}"
    sudo updatedb;
      
	check_exit_status
	
	sudo apt-get install unzip -y > /dev/null 2>&1;
	  
	check_exit_status
}

Firewall() {

	clear
    echo -e "${CYAN}-----------------------------------------"
    echo -e "- Now Installing Firewall and Fail2Ban! -"
    echo -e "-----------------------------------------${NC}"
    echo -e ""

	echo -e "${GREEN}Loading......Please Wait.........${NC}"
	sudo apt-get install ufw > /dev/null 2>&1;
	  
	check_exit_status
	echo -e "${GREEN}Loading......Please Wait.........${NC}"
	sudo ufw default deny incoming > /dev/null 2>&1;
	  
	check_exit_status
	echo -e "${GREEN}Loading......Please Wait.........${NC}"
	sudo ufw default allow outgoing > /dev/null 2>&1;
	  
	check_exit_status
	echo -e "${GREEN}Loading......Please Wait.........${NC}"
	sudo ufw allow ssh > /dev/null 2>&1;
	  
	check_exit_status
	sudo ufw allow 10002 > /dev/null 2>&1;
	  
	check_exit_status
	echo -e "${GREEN}Loading......Please Wait.........${NC}"
	echo -e "y" | ufw enable > /dev/null 2>&1;
	  
	check_exit_status
	echo -e "${GREEN}Loading......Please Wait.........${NC}"
	sudo apt-get install -y fail2ban > /dev/null 2>&1;
	  
	check_exit_status
	
	cat << EOF > /etc/fail2ban/jail.local
[sshd]
enabled = true
port = 22
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
EOF
	  
	check_exit_status
	echo -e "${GREEN}Loading......Please Wait.........${NC}"
	sudo systemctl start fail2ban;> /dev/null 2>&1;
	  
	check_exit_status
	echo -e "${GREEN}Loading......Please Wait.........${NC}"
	sudo systemctl enable fail2ban;> /dev/null 2>&1;
	  
	check_exit_status
	}

LightChain () {

    clear
    echo -e "${CYAN}-------------------------------------"
    echo -e "- Now Installing The Disciple Node! -"
    echo -e "-------------------------------------${NC}"
    
	echo -e "${GREEN}Loading......Please Wait.........${NC}"
	sudo apt-get install screen > /dev/null 2>&1;
	
	  
	check_exit_status
	echo -e "${GREEN}Loading......Please Wait.........${NC}"
	wget https://github.com/lcxnetwork/LightChain/releases/download/v0.2.2/Linux-v0.2.2.zip > /dev/null 2>&1;
	  
	check_exit_status
	echo -e "${GREEN}Loading......Please Wait.........${NC}"
	unzip Linux-v0.2.2.zip > /dev/null 2>&1;
	  
	check_exit_status
	echo -e "${GREEN}Loading......Please Wait.........${NC}"
	sudo mv Linux-v0.2.2 LightChain > /dev/null 2>&1;
	  
	check_exit_status
    
	
	
}

leave() {

    clear
    echo -e "${MAG}----------------------------------------------------------------------------------------------------------------------------"
    echo -e "- Installlation Partially Complete! -"
    echo -e "- Please visit ${YELLOW}https://nodes.lightchain.net/ ${MAG}"
	echo -e "- To register your node -"
	echo -e " "
	echo -e "- Your Node IP is:${YELLOW} $NODEIP ${MAG}"
	echo -e "- Your Port is:   ${YELLOW} 10002 ${MAG}"
	echo -e " "
	echo -e " "
	echo -e "-Please enter your vaildate string to continue ( example 5eb11dc9b3bd28f9487f18d8e8579d96 )-"
	echo -e " "
	echo -e " You can get the validate string from the website under the submit button for your node -"
	echo -e " next to ( --validate ) -"
	echo -e "-----------------------------------------------------------------------------------------------------------------------------"
    echo -e "${CYAN}Please enter your Vaildate String:-   ${NC}"
    read -p "" VALIDATE
}

gonode() {

	cat << EOF > /root/startnode.sh
#!/bin/bash
cd LightChain
./LightChaind --enable-blockexplorer --enable-cors "*" --rpc-bind-ip 0.0.0.0 --validate $VALIDATE

EOF
	chmod +x startnode.sh
	  
	check_exit_status


}
startnode() {
 clear
    echo -e "${MAG}----------------------------------------------------------------------------------------------------------------------------"
    echo -e "- Installlation Complete! -"
    echo -e "- -"
	
	echo -e "- Your Node IP is:${YELLOW} $NODEIP ${MAG}"
	echo -e "- Your Port is:   ${YELLOW} 10002 ${MAG}"
	echo -e " "
	echo -e "- To start your node please enter the command: -${NC}"
	echo -e "${YELLOW}screen -d -m ./startnode.sh ${NC}"
	echo -e " "
	echo -e "${MAG}After this your node is complete and you may exit the terminal."
	echo -e ""
	echo -e "${MAG}To view your node working use the command:${YELLOW} screen -r${NC}"
	echo -e ""
	echo -e "${MAG}After you have finished looking at your working node"
	echo -e " "
	echo -e "${MAG}Don't forget to press ${YELLOW}CTRL A ${MAG}then ${YELLOW}CTRL D ${MAG}beofore you exit terminal${NC}"

}

greeting
update
housekeeping
Firewall
LightChain
leave
gonode
startnode	
