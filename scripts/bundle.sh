#!/usr/bin/env bash



change_password() {
  cd
  #echo "Changing password before enabling wifi."
  #TODO: Ask user if they have changed default before moving forward.
  echo "Change password before enabling wifi. Ctrl+C to quit installation and change password."
  passwd
}

configure_and_check_network_status() {
  echo "*************************************************************"
  echo "*************************************************************"
  echo "Configuring network, you will need network name and password."
  echo "Place them in the file as shown below."
  echo "*************************************************************"
  echo "network={"
  echo "  ssid=<The_ESSID_or_network_name>"
  echo "  psk=<Your_wifi_password>"
  echo "  }"
  echo "*************************************************************"
  echo "*************************************************************"
  echo "How about you let the script do it... enter the name of your wireless network:"
  read network_name
  echo "Enter the network password:"
  read network_password
  sudo echo $"network={\n  ssid='$network_name'\n  psk='$network_password'\n}" >> /etc/wpa_supplicant/wpa_supplicant.conf
  #sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
  sudo ifdown wlan0
  sudo ifup wlan0
  sleep 5
  cd
  if ping -c 1 google.com &> /dev/null
    then
      echo "Network config successful."
    else
      echo "Failed Network Configuration. Please check connections and try rebooting."
      exit 1
  fi
}

#enable_ssh() {
#  sudo touch /boot/ssh
#}

install_git() {
  cd
  if sudo apt-get install -y git
    then
      echo "Git installed successfully."
    else
      echo "Git install failed, unable to continue installation."
      exit 1
  fi
}
#End pre-config.


install_dump1090_mutability() {

  echo "****************************************************************************"
  echo "Configuring dump1090 client and server."
  echo "If the installation or configuration fails, the main installation will FAIL."
  echo "Without dump1090, we won't have any data from the aircraft."
  echo "****************************************************************************"

  cd
  if wget https://github.com/mutability/mutability-repo/releases/download/v0.1.1/mutability-repo_0.1.1_armhf.deb &&
     sudo dpkg -i mutability-repo_0.1.1_armhf.deb &&
     #Next update apt and install 1090.
     sudo apt-get update -y && sudo apt-get install dump1090-mutability -y &&
     #Setup the light web server
     sudo apt-get install lighttpd -y && sudo lighty-enable-mod dump1090;
    then
      echo "dump1090 installed successfully."
    else
      echo "**********************************************"
      echo "**********************************************"
      echo "dump1090 install failed, exiting installation."
      echo "**********************************************"
      echo "**********************************************"
      exit 1
  fi
}

install_dump1090_flightaware() {

  echo "****************************************************************************"
  echo "Configuring dump1090 client and server."
  echo "If the installation or configuration fails, the main installation will FAIL."
  echo "Without dump1090, we won't have any data from the aircraft."
  echo "****************************************************************************"

  cd
  #TODO: Change to FlightAware version of dump 1090.
  if wget http://flightaware.com/adsb/piaware/files/packages/pool/piaware/p/piaware-support/piaware-repository_3.3.0_all.deb &&
     sudo apt-get update -y && sudo apt-get install dump1090-fa -y &&
     #Setup the light web server
     sudo apt-get install lighttpd -y && sudo lighty-enable-mod dump1090-fa;
    then
      echo "dump1090 installed successfully."
    else
      echo "**********************************************"
      echo "**********************************************"
      echo "dump1090 install failed, exiting installation."
      echo "**********************************************"
      echo "**********************************************"
      exit 1
  fi
}

install_piaware_fa_feeder() {

  echo "***************************"
  echo "Configuring piaware feeder."
  echo "***************************"

  cd
  #First we setup the repository:
  if wget http://flightaware.com/adsb/piaware/files/packages/pool/piaware/p/piaware-support/piaware-repository_3.3.0_all.deb &&
     sudo dpkg -i piaware-repository_3.3.0_all.deb &&
     #Next update apt and install.
     sudo apt-get update -y && sudo apt-get install piaware -y &&
     #Turn on auto updates:
     sudo piaware-config allow-auto-updates yes &&
     #Turn on manual updates; allows manual remote updates.
     sudo piaware-config allow-manual-updates yes;
     install_dump1090_flightaware
    then
      echo "piaware installed successfully."
    else
      echo "************************************************"
      echo "piaware install failed, continuing installation."
      echo "************************************************"
  fi
}


#This will setup port forwarding for the OpenSky Network feeder.
install_and_configure_upnpc() {
  echo "***********************************************************************************"
  echo "Configuring port forwarding using upnpc at https://github.com/miniupnp/miniupnp"
  echo "This only opens TCP on port 30005 in order to feed the OpenSky Network."
  echo "If the upnpc installation and configuration fails, the main installation will "
  echo "continue; however, the OpenSky Network Feeder will not be installed."
  echo "***********************************************************************************"
  cd
  #if  sudo upnpc -e 'SSH on Raspberry Pi' -r 22 TCP]
  if sudo apt-get install miniupnpc -y &&
     sudo upnpc -e 'Dump1090 port on Raspberry Pi .' -r 30005 TCP &&
     sudo upnpc -e 'HTTP on Raspberry Pi' -r 80 BOTH &&
     sudo upnpc -e 'Port on Raspberry Pi for ADS-B flightaware page.' -r 8080 TCP
    then
      echo "Port forwarding installed successfully."
      is_noIP_installed=true
    else
      echo "Port forwarding failed, continuing installation."
      echo "OpenSky Network will not be configured."
  fi
  cd
}

install_opensky_feeder() {

  echo "***************************"
  echo "Configuring opensky feeder."
  echo "***************************"

  cd /usr/local/src
  #First we setup the repository:
  if wget https://opensky-network.org/files/firmware/opensky-feeder_latest_armhf.deb &&
  sudo dpkg -i opensky-feeder_latest_armhf.deb;
    then
      echo "opensky feeder installed successfully."
    else
      echo "************************************************"
      echo "opensky feeder install failed, continuing installation."
      echo "************************************************"
  fi
  cd
}

install_flightradar24_feeder() {

  echo "*********************************"
  echo "Configuring flightradar24 feeder."
  echo "*********************************"

  cd /usr/local/src
  #First we setup the repository:
  if sudo bash -c "$(wget -O - http://repo.feed.flightradar24.com/install_fr24_rpi.sh)";
    then
      echo "flightradar24 feeder installed successfully."
    else
      echo "*************************************************************"
      echo "flightradar24 feeder install failed, continuing installation."
      echo "*************************************************************"
  fi
  cd
}


#Some feeders don't require the use of NoIP.
#We will only install certain feeders based on the success of the NoIP install.
is_noIP_installed=false

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
  #TODO: Test failure scenario to make sure we fail correctly.
  if sudo make install
    then
      echo "NoIP installed successfully."
      is_noIP_installed=true
    else
      echo "NoIP install failed, continuing installation."
      #TODO: Update link and add to README.
      echo "For installation issues, check out this article----------------- and if that does not help contact the support at No-IP.com."
      echo "OpenSky Network will not be configured."
  fi
  cd
}


change_password
#Network config for t
#configure_and_check_network_status

#not yet needed.
#install_git

echo "Pre-configuration is complete."

sleep 2

echo "Installation and configuration of dump1090 is complete."

#This step will install dump1090, the flight aware version
install_piaware_fa_feeder

echo "Installation and configuration of piaware is complete."

install_flightradar24_feeder

install_noIP

install_and_configure_upnpc
install_opensky_feeder


echo "===================="
echo "Preparing to reboot."
echo "===================="

sleep 5