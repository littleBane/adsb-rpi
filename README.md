ADS-B Reciever for Raspberry Pi
===============================
## WIP, Still have a ways to go to get this all working.

## Project Overview

This project is designed to help people new to ADS-B and Raspberry Pi setup their own, affordable ADS-B receiver base station and feed ADS-B Data to different ADS-B consumers.

ADS-B stands for Automatic Dependent Surveillance - Broadcast which is used as a secondary radar sysem for aircraft. It means that Aircraft that are equipped with these transmitters (the "Dependent part", the system is dependent on this equipment being installed on the aircraft) will "Automatically" "Broadcast" their location, altitude, airspeed and other flight data to enable "Surveillance" by base stations. The ADS-B system also uses GPS on the aircraft to ensure accurate location data is being reported.

![FlightAware1090 Local Screenshot](https://s3.amazonaws.com/adsbrpi/flightaware_1090_local_screenshot.png)

This project was initially run on the Raspberry Pi 3, though I hope to set it up on a Pi 0 very soon.


##############Sections to figure out.
## Motivation:

## References:

## License





# Prerequisites: 
There are hardware, software, accounts and information that you must provide to complete this project. Here we will go over the different prerequisites by category.

## Information:
You will be placing an antenna, hopefully outside or in a window that will be attached to the raspberry pi. You will need to know the altitude above sea level and the latitude and longitude of the antenna once it is in place. When signing up for the OpenSky Network account, there is a step to get the latitude and longitude of an address you provide.

#Register for NoIP account.
You will be setting up a domain for your raspberry pi.

## Hardware list:

Required Hardware/Equipment:
 Raspberry Pi 3
### FlightAware Plus Dongle
#### This dongle has a filter built in and can be used with non FlightAware ADS-B consumers such as the [OpenSky Network][].
### Micro SD card.

Optional Hardware/Equipment:
* Antenna
** Buy a cheap one.
** Buy a more expesive one (you get for what you pay).
** Build your own.
I personally chose to buy cheap and build my own with the goal of getting better performance from the one I build over the cheap antenna.

## Accounts:
OpenSky Network. I recommend setting up this account first. After setting it up, you can get your latituie , during the setup process you can 


## Software:

## Install and configure software on the Raspberry Pi.

# Running the setup script. 
The setup script will walk you through the software installation and configuration on the Raspberry Pi.
It requires the following:
* NoIP Account info
- email
- password
- it will confirm your domain assuming you only have one.
#

# Install NoIP client.
When prompted enter the email associated with your account.
Next will be your password.
Then your domain will be confirmed, if you only have one you will see something like the message below (note, replace your NoIP domain below instead of <domain_name_for_your_account>):
    Only one host [<domain_name_for_your_account>.hopto.org>] is registered to this account.
    It will be used.
    
    
The next prompt will look like:
    Do you wish to run something at successful update?[N] (y/N)

Just click enter to accept the default of "No".
The NoIP installation should finish with the following messages:
    New configuration file '/tmp/no-ip2.conf' created.
    
    mv /tmp/no-ip2.conf /usr/local/etc/no-ip2.conf
    NoIP installed successfully.
 
    
# Setting Up Port Forwarding.
Port forwarding is enabled using [miniupnpc](https://github.com/miniupnp/miniupnp).


Notes:
Get Git
Git this project
cd into project
chmod u+x setup_pi.sh


Resources:
Port forwarding via upnp:
https://pavelfatin.com/access-your-raspberry-pi-from-anywhere/


