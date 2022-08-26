## If you need to install Ubuntu on Win10 then follow these instructions first:

### [Installing Linux OS UBUNTU on Windows 10 - WITH AUTOMATION!](installWSL.md)
Enable the windows linux subsystem, install the Ubuntu app, update the settings, and install xming so that you can run gui linux programs.

1. Enable Windows Linux Subsystem
  * In windows search, search on “Features” and select “Turn Windows features on or off”. 
  * Scroll to bottom of features, select “Windows Subsystem for Linux”, and click ok.
  * Restart

2. Install Ubuntu
  * Goto the Microsoft Store and search on “Linux”. 
  * Select “Get the apps” button
  * Select the UBUNTU installer and click “Install” button. 
  * When complete select “Launch”
  * When prompted, type in your username and a password for UBUNTU.

3. Install Xming
  * You need to install xming x server on windows and run it to run gui apps from UBUNTU
  * [Download Xming X Server](https://sourceforge.net/projects/xming)
  * Copy and paste the following code into your Ubuntu terminal
  
  ```bash
  cd ~
  mkdir .ssh
  echo "ForwardX11 yes" > .ssh/config
  ```

# wlsUBUNTU_settings

The updateSettings.bash script will defeat some of the bugs in the Ubuntu **W**indows **L**inux **S**ubsystem. Most fixes are specific to TAMUCC's computers, but the script can be modified to your institution.  
1. creates environmental variable winhome with path to the windows home directory, ex: `cd $winhome`
2. modifies the .bashrc with `DISPLAY` and `TERM` settings that work well with TAMUCC's hpc
3. associates the name of a remote server with its ip address
4. creates a .ssh/config file to enable X11 functionality (run linux gui apps) if xming is installed and running
5. modifies behavior of cursor when using ssh to connect to a remote server, solving annoying issues with using nano on a rmeote server

