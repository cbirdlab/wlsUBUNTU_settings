# wlsUBUNTU_settings
The updateSettings.bash script will defeat some of the bugs in the Ubuntu **W**indows **L**inux **S**ubsystem. Most fixes are specific to TAMUCC's computers, but the script can be modified to your institution.  
1. creates environmental variable winhome with path to the windows home directory, ex: `cd $winhome`
2. modifies the .bashrc with `DISPLAY` and `TERM` settings that work well with TAMUCC's hpc
3. associates the name of a remote server with its ip address
4. creates a .ssh/config file to enable X11 functionality (run linux gui apps) if xming is installed and running
5. modifies behavior of cursor when using ssh to connect to a remote server, solving annoying issues with using nano on a rmeote server

After installing Ubuntu and xming, log into your Ubuntu terminal and run the following commands:
```
git clone https://github.com/cbirdlab/wlsUBUNTU_settings.git
. ./wlsUBUNTU_settings/updateSettings.bash
rm -rf wlsUBUNTU_settings
```



