#!/usr/bin/env bash

enable_ssh() {
  sudo touch /boot/ssh
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
  #sudo echo $"network={\n  ssid=\"$network_name\"\n  psk=\n\"$network_password\"\n}" >> /etc/wpa_supplicant/wpa_supplicant.conf
  sudo echo $"network={"     >> /etc/wpa_supplicant/wpa_supplicant.conf
  sudo echo "  ssid=\"$network_name\"" >> /etc/wpa_supplicant/wpa_supplicant.conf
  sudo echo "  psk=\"$network_password\"" >> /etc/wpa_supplicant/wpa_supplicant.conf
  sudo echo "}" >> /etc/wpa_supplicant/wpa_supplicant.conf
  #sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
  echo "Bringing up the network..."
  sudo ifdown wlan0
  sleep 2
  sudo ifup wlan0
  echo "Network should be coming up, waiting 10 seconds before checking it."
  sleep 10
  echo "Checking Ping; this might take a minute..."
  cd
  if ping -c 1 google.com &> /dev/null
    then
      echo "Network config successful."
    else
      if ping -c 1 google.com &> /dev/null
        then
          echo "Network config successful."
      else
        echo "Failed Network Configuration. Please check connections and try rebooting."
        exit 1
    fi
  fi
}

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

print_ip_info_and_reboot() {
  echo "Gathering IP info..."
  export ip=$(ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')
  echo "Your IP is: $ip"
  echo "To login to your pi, use:"
  echo "pi@$ip"
  echo "and then type in the password for the pi user."
  echo "System will REBOOT now to enable SSH and finish pre configuration"
  echo "Press RETURN to continue:"
  read nada
  sudo reboot now
}

enable_ssh
configure_and_check_network_status

#install_git

echo "Pre-configuration is complete."

print_ip_info_and_reboot

