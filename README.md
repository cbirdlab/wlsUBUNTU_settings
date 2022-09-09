## If you need to install Ubuntu on Win10 then follow these instructions first:

### [Installing Linux OS UBUNTU on Windows 10 - WITH AUTOMATION!](installWSL.md)
Enable the windows linux subsystem, install the Ubuntu app, update the settings, and install xming so that you can run gui linux programs.

0. Update Windows to the newest version 
   * (Windows 10 version 2004 and higher are required, you do not need Windows 11). To update, type "Check for Updates" in the taskbar search bar.
1. Enable Windows Linux Subsystem
    * In windows search, search on “Features” and select “Turn Windows features on or off”. 
    * Scroll to bottom of features, select “Windows Subsystem for Linux”, and click ok.
    * If that didn't work for you, then 
      * Open "Windows PowerShell". You can search for it in the same location where you typed "Check for Updates". Open Windows PowerShell by right-clicking and then left-clicking "Run as Administrator". 
      * In the PowerShell Terminal, run the following command (do NOT copy and paste): `wsl --install`
    * If that didn't work then [try this](https://ubuntu.com/tutorials/install-ubuntu-on-wsl2-on-windows-10#1-overview)
    * Once you are successful, Restart Computer

2. Install Ubuntu
    * Goto the Microsoft Store and search on “Linux”. 
    * Select “Get the apps” button
    * Select the UBUNTU installer and click “Install” button. 
    * When complete select “Launch”
    * When prompted, type in your username and a password for UBUNTU.
    
3. If when you log into Ubuntu you are "root" then
    * add yourself as a user and give yourself sudo privs
    ```bash
    # you must replace YourUserName below with your actual user name in ubuntu
    sudo adduser YourUserName
    
    # you must replace YourUserName below with your actual user name in ubuntu
    usermod -aG sudo YourUserName
    ```
    * [make it so that when you log in, you are you, rather than root](https://askubuntu.com/questions/1376711/how-do-i-change-the-default-user-that-signs-in-on-wsl)
    ```bash
    # you must replace YourUserName below with your actual user name in ubuntu
    echo -e "[user]\ndefault=YourUserName" > /etc/wsl.conf
    ```
 
4. download [Windows Terminal](https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701?hl=en-us&amp%3Bgl=US)
    * you should use this to run ubuntu.  It has some very nice features, like normal copy and paste keys work here
    * Windows Terminal will open PowerShell automatically. Click the "v" symbol next to the "+" (new tab) button and go to "Settings".
    * The first option under "Startup" is "Default Profile". Change this to "Ubuntu" and save your changes.
    * To open again, just type "Terminal" in the taskbar search bar and open the App.

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

