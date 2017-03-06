#!/usr/bin/env bash

#Some feeders don't require the use of NoIP.
#We will only install certain feeders based on the success of the NoIP install.
is_noIP_installed=false

change_password () {
echo "Changing password before enabling wifi."
passwd
}

check_network_status() {
  if ping -c 1 google.com &> /dev/null
    then
      echo "Network config successful."
    else
      echo "Failed Network Configuration. Please check connections and try rebooting."
      exit 1
  fi
}

install_git() {
  if sudo apt-get install -y git
    then
      echo "Git installed successfully."
    else
      echo "Git install failed, unable to continue installation."
      exit 1
  fi
}

install_noIP() {

  echo "***********************************************************************************"
  echo "Configuring the NoIP client created by noip.org."
  echo "You must have your email and password ready."
  echo "If the NoIP installation and configuration fails, the main installation will "
  echo "continue; however, the OpenSky Network Feeder will not be installed."
  echo "***********************************************************************************"

  cd /usr/local/src/
  sudo wget http://www.no-ip.com/client/linux/noip-duc-linux.tar.gz
  sudo tar xf noip-duc-linux.tar.gz
  #cd noip-2.1.9-1/
  #Use a wildcard to Work with multiple versions.
  cd noip*
  if sudo make install
    then
      echo "NoIP installed successfully."
      is_noIP_installed=true
    else
      echo "NoIP install failed, continuing installation."
      echo "OpenSky Network will not be configured."
  fi
}