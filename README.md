
ADS-B Receiver for Raspberry Pi
======================================================
Raspberry Pi Based Antenna for IoT ADS-B Base Station.
======================================================
## WIP, Still have a ways to go to get this all working.

## Project Overview:

This project is designed to help people new to ADS-B and Raspberry Pi setup their own, affordable ADS-B receiver base station and feed ADS-B Data to different ADS-B data consumers (FlightAware, OpenSky Network and FightRadar24). This project will allow us to receive the data signals from aircraft and plot the aircraft on a map that will be hosted by a web server on the Raspberry Pi. This project is setup to run on the Raspberry Pi 3 though the Raspberry Pi 2 and Raspberry Pi 0 might also be compatible. This build was able to pick up over 100 nm (nautical miles) or 185.2 km. This was with an indoor antenna placed in a window; better results can be expected with a more optimum antenna placement.

![FlightAware1090 Local Screenshot](https://s3.amazonaws.com/adsbrpi/flightaware_1090_local_screenshot.png)

## What is ADS-B?
ADS-B, Automatic Dependent Surveillance - Broadcast, is used as a secondary system for tracking aircraft (traditional radar is the primary tracking system). If an aircraft is transmitting ADS-B;, it means that Aircraft that are equipped with these transmitters (the "Dependent part", the system is dependent on this equipment being installed on the aircraft) will "Automatically" "Broadcast" their location, altitude, airspeed and other flight data to enable "Surveillance" by base stations and other aircraft. The ADS-B system also uses GPS on the aircraft to ensure accurate location data is being reported. ADS-B is required for all commercial and private aircraft starting in 2017 and will be required in US airspace starting in 2020.

## High-Level Overview of Steps:

Before connecting the antenna and FlightAware Pro Dongle, we will setup some software on the Raspberry Pi.

On your Windows, Mac, or Linux machine.
* Sign up for accounts for; FlightAware, OpenSky Network, FightRadar24 and NoIP. Note, we can sign up for some of these accounts during the installation process which will simplify the process. There will be a step to sign up for each account at the appropriate time.
* Get a Raspbian Image and a few setup scripts on an SD card to use in the Raspberry Pi.

On the Raspberry Pi.
* Setup the Raspberry Pi to get on our wireless network so we can connect to it from another machine.
* Connect to the Raspberry Pi and complete the installation using another setup script provided by this project.

With the Raspberry Pi configured, we will connect all the hardware and place the antenna in a location with good visibility.
* Plugin the Antenna and FlightAware Pro Dongle.
* Start tracking and plotting aircraft!
* Bonus, each service to which we feed will provide different statistics and visualizations of our data as well as access to many more features! 
 
 
# Step By Step:
Setting up the Raspberry Pi to get on the wireless network.
* Get a Raspbian Image on an SD card.
 - This will create a directory at the root of the SD card called boot.
* Copy the setup script to the /boot drive the sd card.
* Eject the disk using Finder or File explorer.

Plug SD card into Raspberry Pi.
Plug mouse, keyboard and monitor into the Raspberry Pi and then plugin the power.


The screen will show some logging while the Raspberry Pi boots up and then you will be prompted to login, use the following (we will be changing this very soon):
default username: pi
default password: raspberry

From here we will get the Raspberry Pi on the our wireless network so we can access it from another machine. At this point, we will not be making available to the internet, only getting on our wireless network.
You will need your wireless network name and wireless network password, have them ready.
From the terminal on the Raspberry Pi, run the following command:
sudo /boot/preconfig.sh

You will be prompted for your wireless network name and wireless network password.

Once the script is complete, your IP will be printed along with an SSH example command to login from a remote machine (SSH is for Mac/Linux; for Windows use Putty).

Make sure you can login to the Raspberry Pi from a remote machine. Once that is successful, you can disconnect the mouse, keyboard and monitor from the Raspberry Pi. From here on out, we will access the Raspberry Pi via another machine.





From there we will logout and login to the Raspberry Pi via SSH or Putty from our Windows, Mac or Linux machine.

Hardware - Connect the Raspberry Pi to keyboard, mouse and display. We will setup the software and get everything going before hooking up the antenna and flightaware dongle. 

Software - 
1. Get Raspbian on the Pi.
//TODO:
2. Install dump1090, mutability fork????????
3. Install feeders:
 * Flightaware
 * OpenSky Network
 * FlightRadar24 (Pending, WIP)

##############Sections to figure out.


## References:

## License





# Prerequisites: 
There are hardware, software, accounts and information that you must provide to complete this project. Here we will go over the different prerequisites by category.

## Information:




Network Info:
* SSID or network name of your home Wifi network.
* Password of your home wifi network.
Note: This information will be stored in plain text on the raspberry pi, but it will only be viewable by the root user or the user pi that has root access. This is another reason why it is critical to update the password before setting up the wireless; we will handle that below.

Location Info:
You will be placing an antenna, hopefully outside or in a window that will be attached to the raspberry pi. 
You will need to know information about the location of the antenna, if attached to your house, just use your home address and a search engine to get this information (Note: When signing up for the OpenSky Network account, there is a step to get the latitude and longitude and altitude of an address you provide.):
 * the altitude above sea level
 * latitude
 * longitude
 


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
# OpenSky Network. 
I recommend setting up this account first. After setting it up, you can get your latitude , longitude and altitude by going to the add feeder page:
 


#Register for NoIP account.
You will be setting up a domain for your raspberry pi.

## Software:

## Install and configure software on the Raspberry Pi.

# Running the setup script.
The script will first prompt you to change your password, always make sure to change the password on your rpi and follow good password/phrase policies to make sure your rpi stays secure and is not used in the next major DDOS. ;-)>




Setting up the OpenSky feeder:

Setup secure way to expose network traffic to OpenSky:
Sign up for free account on no-ip. This will provide a managed DNS to make your rpi available to OpenSky and you.
Install the No-IP client on the rpi.




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


## Motivation:
Pi Day and Wings over the Rockies. Wings Over the Rockies had an example of an ADS-B Receiver station running on the Raspberry Pi. This was an attempt to recreate, simplify and modernize that project.



Further notes on Antennas:
Antennas are used to transmit and receive radio waves, the antenna size and sometimes shape are relative to the frequency of the wave we are receiving. This means that a omnidirectional antenna using line of sight is best for larger wave lengths as they are less likely to penetrate dense objects. Using an omnidirectional antenna (think PVC pipe pointed at the sun at High Noon)

