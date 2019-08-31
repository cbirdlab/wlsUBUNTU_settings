#!/bin/bash

#this script updates the Ubuntu terminal in Windows Linux Subsystem with bug fixes and needed settings

#make sure we are in the home directory
cd ~

#add settings to .bashrc
if grep -q 'export winhome' .bashrc; then
	echo no changes, .bashrc already updated
else
	echo updating .bashrc
	echo "" >> .bashrc
	echo "#$USER: add shortcut to windows home directory" >> .bashrc
	echo export winhome="/mnt/c/Users/$USER/" >> .bashrc
	echo "" >> .bashrc
	echo "#$USER: set display" >> .bashrc
	echo export DISPLAY=:0 >> .bashrc
	echo "" >> .bashrc
	echo "#$USER: set TERM to stop nano cursor misbehavior when ssh to server" >> .bashrc
	echo export TERM=xterm >> .bashrc
	echo "" >> .bashrc
	echo "#$USER: initialize the /etc/hosts so that I don't have to type in IP addresses" >> .bashrc
	echo bash initialize.bash >> .bashrc
fi


#make initialization script which replaces the default hosts with my hosts
if [ ! -f "initialize.bash" ];then
	echo making initialize.bash script
	touch intialize.bash
	echo "#!/bin/bash" >> initialize.bash
	echo "#this script initializes cbird's custom settings in UBUNTU on WINDOWS" >> initialize.bash
	echo "sudo chmod 777 /etc/hosts" >> initialize.bash
	echo "cp ~/hosts /etc" >> initialize.bash
	echo "sudo chmod 555 /etc/hosts" >> initialize.bash
else
	echo no changes made, initialize.bash already exists
fi

#copy hosts to home directory & modify. This copy of hosts will overwrite the default at startup
if [ -f "hosts" ];then
	echo hosts file exists
	if grep -q '10.20.1.189' hosts; then
		echo hpcm.tamucc.edu found, no changes made to hosts
	else
		echo adding hpcm.tamucc.edu to hosts
		sudo chmod 777 hosts
		sed 's/\(127\.0\.0\.1\tlocalhost\)/\1\n10\.20\.1\.189\thpcm\.tamucc\.edu/' hosts
		#sed 's/\(10\.20\.1\.189\thpcm\.tamucc\.edu\)/\1\n172\.22\.10\.254\thobiserver\.tamucc\.edu/' hosts
		sudo chmod 555 hosts
	fi
else
	echo hosts file does not exists, copying hosts file to home
	sudo cp /etc/hosts ./hosts
	echo adding hpcm.tamucc.edu to hosts
	sudo chmod 777 hosts
	sed 's/\(127\.0\.0\.1\tlocalhost\)/\1\n10\.20\.1\.189\thpcm\.tamucc\.edu/' hosts
	#sed 's/\(10\.20\.1\.189\thpcm\.tamucc\.edu\)/\1\n172\.22\.10\.254\thobiserver\.tamucc\.edu/' hosts
	sudo chmod 555 hosts
fi

#load new settings
echo sourcing .bashrc
source .bashrc

#add .ssh/config for X11 functionality
if [ ! -d ".ssh" ]; then
	echo making .ssh dir
	mkdir .ssh
else
	echo .ssh dir exists
fi
if [ ! -f .ssh/config ]; then
	echo making .ssh/config file
	touch .ssh/config
	echo "ForwardX11 yes" >> .ssh/config
else
	if grep -q 'ForwardX11 yes' .ssh/config; then
		echo no changes made, .ssh/config already modified
	else
		echo modifying .ssh/config
		echo "ForwardX11 yes" >> .ssh/config
	fi
fi


#modify .profile
if grep -q 'stty sane' .profile; then
	echo no changes made.  .profile was already modified
else
	echo "" >> .profile
	echo "# This ssh alias function resolves an issue with running nano within an ssh session" >> .profile
	echo "function ssh(){" >> .profile
	echo '/usr/bin/ssh -t ${@:1} "stty sane; export TERM=linux; bash"' >> .profile
	echo "}" >> .profile
fi

