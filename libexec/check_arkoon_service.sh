#!/bin/bash
#
# check_arkoon_service.sh
# Check if a service is running on an Arkoon by snmpwalking
# $1 : HOSTADDRESS
# $2 : servicename

# nagios return values
export STATE_OK=0
export STATE_WARNING=1
export STATE_CRITICAL=2
export STATE_UNKNOWN=3
export STATE_DEPENDENT=4

HOSTNAME=$1
SERVICENAME=$2

if /usr/bin/snmpwalk -v 2c -c public $HOSTNAME iso.3.6.1.2.1.25.4.2.1.2 |/bin/grep $SERVICENAME >/dev/null; then
	echo "OK : service" $SERVICENAME "is running"
	exit $STATE_OK
else
	echo "CRITICAL : service" $SERVICENAME "is not running"
	exit $STATE_CRITICAL
fi

