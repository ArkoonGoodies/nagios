# nagios #

Script, config files and icons to monitor an Arkoon firewall with Nagios

## Installation instructions ##
Files provided in this git repo have been tested using Debian squeeze (6.0.5)

### Nagios installation ###
Nagios has been installed with following [method](http://wiki.monitoring-fr.org/nagios/debian-install).

### Arkoon addons installation ###
Scripts must be copied in this directory :
/usr/local/nagios/libexec

Objects (*.cfg) must be copied in this directory :
/usr/local/nagios/etc/objects

Images (*.gd2, *.gif, *.png) must be copied in this directory :
/usr/local/nagios/share/images/logos

### Configuration instructionsa ###
## Arkoon firewall configuration ##
You must enable SNMP in the Arkoon using an Arkoon manager

## Nagios configuration ##
In Nagios config file : /usr/local/nagios/etc/nagios.cfg add following lines :
* cfg_file=/usr/local/nagios/etc/objects/arkoon-commands.cfg
* cfg_file=/usr/local/nagios/etc/objects/arkoon-templates.cfg
* cfg_file=/usr/local/nagios/etc/objects/arkoon.cfg
or
cfg_file=/usr/local/nagios/etc/objects/arkoon_cluster.cfg

Adapt IP addresses of Arkoon in cfg files

## Configuration check ##
To check or debug your Nagios configuration:
/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg

...

Enjoy !

- - -
####### This file uses Markdown format. ######
* http://daringfireball.net/projects/markdown/
* http://en.wikipedia.org/wiki/Markdown

