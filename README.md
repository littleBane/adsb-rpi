# ADS-B Receiver for Raspberry Pi
# Raspberry Pi Based Antenna for IoT ADS-B Base Station.

## Project Overview:
This project is designed to help people new to ADS-B and Raspberry Pi setup their own, affordable ADS-B receiver base station and receive broadcasts from aircraft, and use the information in the broadcasts to plot the aircraft on a web server running on the Raspberry Pi. There are multiple ADS-B data consumers so We will also feed ADS-B data to 3 different ADS-B data consumers:
  * [FlightAware.com]
  * [FightRadar24]
  * [OpenSky Network]
  
  This project is setup to run on the Raspberry Pi 3 though the Raspberry Pi 2 and Raspberry Pi 0 might also be compatible. This build was able to pick up over 100 nm (nautical miles) or 185.2 km. This was with an indoor antenna placed in a window; better results can be expected with a more optimum antenna placement.
  
Here is a screenshot of my setup with some aircraft plotted:

![FlightAware1090 Local Screenshot](https://s3.amazonaws.com/adsbrpi/flightaware_1090_local_screenshot.png)

## What is ADS-B?
ADS-B, Automatic Dependent Surveillance - Broadcast, is used as a secondary system for tracking aircraft (traditional radar is the primary tracking system). If an aircraft is transmitting ADS-B;, it means that Aircraft that are equipped with these transmitters (the "Dependent part", the system is dependent on this equipment being installed on the aircraft) will "Automatically" "Broadcast" their location, altitude, airspeed and other flight data to enable "Surveillance" by base stations and other aircraft. The ADS-B system also uses GPS on the aircraft to ensure accurate location data is being reported. ADS-B is required for all commercial and private aircraft starting in 2017 and will be required in US airspace starting in 2020.

ADS-B data consumers collect data from receivers worldwide and use the data to do many different things including:

* Keep the data permanently to make available for research. - [OpenSky-Network.org]
* Use the data for consumer and business applications. - [FlightAware.com], [FilghtRadar24.com]
* Provide a real-time data fire-hose for business and consumer applications. - [FlightAware.com], [FilghtRadar24.com]

While building this project, I found instructions on how to feed to the individual feeders but in some cases, the instructions for one would conflict with the installation of another. This makes it a bit more difficult to make a receiver that can send the signals to multiple collectors. This project aims to simplify that process and looks toward the best of breed when deciding what to use, this means there may be a lighter solution that could be created for the Raspberry Pi 0.

![Setup with bought antenna](https://s3.amazonaws.com/adsbrpi/setup_bought_antenna.JPG)

## High-Level Overview of Steps:
Before connecting the antenna and FlightAware Pro Dongle, we will setup some software on the Raspberry Pi.

### Setup the SD card:
Using a Windows, Mac, or Linux machine:
* Download a Linux image and install it and a few setup scripts on an SD card which we will use in the Raspberry Pi.

### Setting up the Raspberry Pi:
On the Raspberry Pi.
* Setup the Raspberry Pi to get on our wireless network so we can connect to it via SSH (Mac/Linux) or Putty (Windows) from another machine on the same wifi network. We will use the provided pre_config.sh script installed on the SD card to set this up.
* Connect to the Raspberry Pi and complete the installation using another setup script (bundle.sh) provided by this project. This script will walk you through some setup steps that do the following:
  * Install software to read the data coming from the antenna and USB dongle, we will use FlightAware's version of dump1090.
  * Install software to provide a light web server and web page to plot the planes on a map.
  * Install software to feed data to [FlightAware.com].
  * Install software to feed data to [OpenSky-Network.org].
    * This step will install the NoIp client and open a port on the Wifi network to make the Raspberry Pi accessible so it can connect to (OpenSky-Network.org)[].
  * Install software to feed data to [FlightRadar24.com].

### Hooking up the hardware and plotting aircraft:
With the Raspberry Pi configured, we will connect all the hardware and place the antenna in a location with good visibility.
* Plugin the Antenna and FlightAware Pro Dongle.
* Start tracking and plotting aircraft!
* Bonus, each service to which we feed will provide different statistics and visualizations of our data as well as access to many more features!

#### Notes on the Setup:
* There will be a step to sign up for each account at the appropriate time during the setup. We will be setting up accounts for; FlightAware, OpenSky Network, FightRadar24 and NoIP. Again, we can sign up for these accounts during the installation process which will simplify the process.

## Prerequisites: 
There are hardware, software, accounts and information that you must provide to complete this project. Here we will go over the different prerequisites by category.

### Information required during setup process:
#### Network Info:
* SSID or network name of your home Wifi network.
* Password of your home wifi network.
Note: This information will be stored in plain text on the raspberry pi, but it will only be viewable by the root user or the user pi that has root access. This is another reason why it is critical to update the password before setting up the wireless; we will handle that below.
* During the process we will be setting up 4 new accounts so be prepared to create new user names and *unique* passwords for each. 

#### Location Info:
You will be placing an antenna, hopefully outside or in a window that will be attached to the raspberry pi. 
You will need to know information about the location of the antenna, if attached to your house, just use your home address and a search engine to get this information (Note: When signing up for the OpenSky Network account, there is a step to get the latitude and longitude and altitude of an address you provide.):
 * the altitude above sea level
 * latitude
 * longitude
 
### Hardware list:
Required Hardware/Equipment:
 Raspberry Pi 3
#### FlightAware Plus Dongle
##### This dongle has a filter built in and can be used with non FlightAware ADS-B consumers such as the [OpenSky Network][].
#### Micro SD card.
#TODO: Add links for purchasing all hardware, how to build antenna and to lower in page to antenna section.
#### Antenna, see below for options and links to build your own.
 
## Step By Step Detail:
### Accounts:
We will setup a few diffenent accounts during this process, first we will setup the [OpenSky-Network.org] account. After setting it up, you can get your latitude , longitude and altitude by going to the add feeder page:

### Setup the SD card:
This first part will be configuring the SD card we will be using as the Hard Drive for the Raspberry Pi. This part can be done on a Mac, Windows, or Linux machine. Typically a micro SD card adapter is required. 
1. Download the the version of Linux we will be using; Raspbian Jessie Light. It is a flavor of Linux built specifically for the Raspberry Pi and can be downloaded [here.](https://www.raspberrypi.org/downloads/raspbian/)
2. With the Raspbian Operating System downloaded, we will need to write to the SD card. This is a bit more complicated than copying and pasting it onto the SD card unfortunately. Below are links to instructions on how to install the Raspbian image onto the SD card based on your OS. Leave the SD card plugged in to your machine when you finish installing the OS image on the micro SD card. We will copy over a few setup scripts to the SD card before ejecting it and plugging it into the Raspberry Pi.

#TODO: Create a bash script for this.
[Linux Instructions](https://www.raspberrypi.org/documentation/installation/installing-images/linux.md)

[Mac Instructions](https://www.raspberrypi.org/documentation/installation/installing-images/mac.md)

[Windows Instructions](https://www.raspberrypi.org/documentation/installation/installing-images/windows.md)
3. #TODO: Remove this or validate it is necessary. Make the scripts executable if there are issues: chmod u+x setup_pi.sh
4. Installing the Raspbian Image onto the micro SC card creates a directory at the root of the SD card called boot. Copy the scripts (pre_config.sh and bundle.sh) to the /boot drive the sd card.
5. Eject the disk using Finder or File explorer or a similar tool.

### Set up the Raspberry Pi to get on the wireless network.
From here we will get the Raspberry Pi on the our wireless network so we can access it from another machine. At this point, we will not be making the Raspberry Pi available to the internet, only getting on our wireless network.
You will need your wireless network name and wireless network password, have them ready.
1. From the terminal on the Raspberry Pi, run the following command and follow the instructions:

```
sudo /boot/pre_config.sh
```


Note: The script will first prompt you to change your password, always make sure to change the password on your Raspberry Pi. Follow good password/phrase policies to make sure your Raspberry Pi stays secure and is not used in the next major DDOS attack. ;-)>
WE change the password after SSH'ng to the Raspberry Pi, this helps avoid problems that may occur from any characters that might be interpreted differently from different keyboards. We get the Raspberry Pi on the network before changing the password, but we don't give it an external IP until we change the password to help prevent unintended remote access.

You will be prompted for your wireless network name and wireless network password.

Once the script is complete, your IP will be printed along with an SSH example command to login from a remote machine (SSH is for Mac/Linux; for Windows use Putty).

Make sure you can login to the Raspberry Pi from a remote machine. Once that is successful, you can disconnect the mouse, keyboard and monitor from the Raspberry Pi. From here on out, we will access the Raspberry Pi via another machine.

## [OpenSky-Network.org] feeder and NoIP install:
Setup secure way to expose network traffic to OpenSky:
Sign up for free account on no-ip. This will provide a managed DNS to make your rpi available to OpenSky and you when you are not on your home network.
Install the No-IP client on the rpi.

The setup script will walk you through the software installation and configuration on the Raspberry Pi.
It requires the following:
* NoIP Account info
- email
- password
- it will confirm your domain assuming you only have one.

# Install NoIP client.
#Register for NoIP account.
You will be setting up a domain for your raspberry pi.
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

#TODO: Add NoIP client link:
For installation issues, check out [this article]() and if that doesn’t help contact the support at No-IP.com.

## FlightRadar24 install info:
 #This will use the shell script to do an interactive install  the feeder and setup of the account.
 #Need email
 #You will be asked for a key for using a feed before, this can be ignored, just click enter.
 #Choose yes to use participate in MLAT calculations. This will improve locations of aircraft using positions received by other antennas.
 #lat
 #lon
 #altitude
 #accept settings
 #use autoconfig
 #disable logging
 #accept default logging location
 #installation complete message
 #You will get an email about receiver data
 #Sign up for a premium 7 day trial: https://www.flightradar24.com/premium/signup
 #Change username https://www.flightradar24.com/account/change-username
 #Once you change this, click on the statistics button for your radar.
 #It is very difficult to find this option in the menus so I suggest bookmarking the link for your radar's statistics.
 
  #1 - Your ADS-B receiver is connected to this computer or is accessible over network
  #2 - You know your antenna's latitude/longitude up to 4 decimal points and the altitude in feet
  #3 - You have a working email address that will be used to contact you
  #4 - fr24feed service is stopped. If not, please run: sudo service fr24feed stop

![Home built antenna](https://s3.amazonaws.com/adsbrpi/home_built_antenna2.JPG)

![Pi with FlightAware dongle](https://s3.amazonaws.com/adsbrpi/pi_with_dongle.JPG)

## Explanation of the Scripts:
#TODO: Finish script explanation.
#What the script is doing:
* Setup SSH:
To enable SSH on startup, create a file called “SSH” with no extension in the boot partition.
Enable SSH on startup.
Login to PI
cd ../../boot
touch SSH
SSH login should work on next reboot. 
* setup wifi

### Optional Hardware/Equipment:
 * Antenna
 ** Buy a cheap one.
 ** Buy a more expesive one (you get for what you pay).
 ** Build your own.
 I personally chose to buy cheap and build my own with the goal of getting better performance from the one I build over the cheap antenna.

#### Build your own Collinear Omnidirectional Antenna
Further notes on Antennas:
Antennas are used to transmit and receive radio waves, the antenna size and sometimes shape are relative to the frequency of the wave we are receiving. This means that a omnidirectional antenna using line of sight is best for larger wave lengths as they are less likely to penetrate dense objects. Using an omnidirectional antenna (think PVC pipe pointed at the sun at High Noon)

## Choices about software and some background on dump1090:
#TODO: Add a hyperlink and a section below and finish section below:
For more information on the choices of software that is listed, please see this section:
Section below:
dump1090 was originally a hobby project that has since spawned several forks 2 of which seem to be the most prevalent:
* Malcolm Robb
* mutability
Originally tried using mutability as recommended here:
https://opensky-network.org/community/projects/30-dump1090-feeder
Then realized dump1090-fa is based on that fork and has some nice enhancements! 
https://github.com/mutability/dump1090

## References and Resources:
* Setting up SSH:
https://www.raspberrypi.org/documentation/remote-access/ssh/README.md
* Port forwarding via upnp:
https://pavelfatin.com/access-your-raspberry-pi-from-anywhere/
Port forwarding is enabled using [miniupnpc](https://github.com/miniupnp/miniupnp).
* Setting up Wifi:
https://www.raspberrypi.org/documentation/configuration/wireless/wireless-cli.md
* Setting up the [OpenSkyNetwork.org] Feeder:
https://opensky-network.org/community/projects/30-dump1090-feeder
* Dump1090 mutability:
https://opensky-network.org/community/projects/30-dump1090-feeder


## License

[FlightAware.com]: https://flightaware.com
[OpenSkyNetwork.org]: http://opensky-network.org 
[FightRadar24]: https://www.flightradar24.com
