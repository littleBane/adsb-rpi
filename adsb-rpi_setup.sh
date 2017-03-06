#!/usr/bin/env bash

check_network_status



check_network_status() {
  if ping -c 1 google.com &> /dev/null
    then
      echo "Network config successful."
    else
      echo "Failed Network Configuration. Please check connections and try rebooting."
      exit 1
  fi
}
sudo iwlist wlan0 scan
wpa-supplicant
vi nano /etc/wpa_supplicant/wpa_supplicant.conf
sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
clear
sudo vi /etc/wpa_supplicant/wpa_supplicant.conf
sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
passwd
sudo reboot
wget https://opensky-network
ping google.com
ping https://google.com
ifconfig
sudo ifdown wlan0
sudo ifup wlan0