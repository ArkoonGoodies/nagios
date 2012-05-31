#!/bin/bash
#
# check_arkoon_disk.sh
# Check disk usage of an Arkoon by SNMP
# $1 : HOSTADDRESS
# $2 : DISK number 1,2,3,... 

# nagios return values
export STATE_OK=0
export STATE_WARNING=1
export STATE_CRITICAL=2
export STATE_UNKNOWN=3
export STATE_DEPENDENT=4

HOSTNAME=$1
DISKNUM=$2

# Search path name using SNMP
DSK=$(snmpget $HOSTNAME -v2c -c public .1.3.6.1.4.1.2021.9.1.2.$DISKNUM | sed 's/.*STRING: \"//g' | sed 's/"//g')

echo $DSK|grep "No Such Instance currently exists at this OID" >/dev/null
if (( $? == 0 )); then
	echo "Disk not monitored by SNMP"
	exit $STATE_WARNING
fi

# For the first partition
#Path where the disk is mounted: .1.3.6.1.4.1.2021.9.1.2.1
#Path of the device for the partition: .1.3.6.1.4.1.2021.9.1.3.1
#Total size of the disk/partion (kBytes): .1.3.6.1.4.1.2021.9.1.6.1
#Available space on the disk: .1.3.6.1.4.1.2021.9.1.7.1
#Used space on the disk: .1.3.6.1.4.1.2021.9.1.8.1
#Percentage of space used on disk: .1.3.6.1.4.1.2021.9.1.9.1
#Percentage of inodes used on disk: .1.3.6.1.4.1.2021.9.1.10.1

# Search disk usage in percent
PERCENT=$(snmpget $HOSTNAME -v2c -c public .1.3.6.1.4.1.2021.9.1.9.$DISKNUM | sed 's/.*INTEGER: //g')

LIMCRITICAL=90
LIMWARNING=80

if (("$PERCENT" >= "$LIMCRITICAL")); then
	echo "CRITICAL" $DSK $PERCENT "%"
	exit $STATE_CRITICAL
else if (("$PERCENT" >= "$LIMWARNING")); then
	echo "WARNING" $DSK $PERCENT "%"
	exit $STATE_WARNING
else
	echo "OK" $DSK $PERCENT "%"
	exit $STATE_OK
fi
fi

