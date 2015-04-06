#!/ffp/bin/sh

: <<=cut

=head1 NAME

temp - Munin plugin to monitor the internal temperature of DNS 320

=head1 APPLICABLE SYSTEMS

Any DNS 320 with funplug installed (should work with other DNS like 323 not tested)

=head1 CONFIGURATION

This plugin needs root privileges
Set WARNING and CRITICAL directly into the script


=head1 INTERPRETATION

The temperature in degree celsius for case, and both hard disks

=head1 AUTHOR

Copyright (C) 2015 Aurelien LAJOIE, Utix

=head1 LICENSE

GPLv2

=cut
# define warning and critical temperature levels
CASE_WARNING="50"
CASE_CRITICAL="60"
DISK_WARNING="45"
DISK_CRITICAL="50"
FAN_STOP="30"
FAN_ROTATE="35"


case $1 in
config)
cat <<'EOM'
graph_peroid 20
graph_category sensors
graph_title Temperatures
graph_vlabel Celsius
graph_order system hda hdb
system.label System
hda.label Disk A
hdb.label Disk B
fan.label Is Fan rotating
EOM
echo "system.warning $CASE_WARNING"
echo "system.critical $CASE_CRITICAL"
echo "hda.warning $DISK_WARNING"
echo "hda.critical $DISK_CRITICAL"
echo "hdb.warning $DISK_WARNING"
echo "hdb.critical $DISK_CRITICAL"
exit 0;;
esac

Ta=`smartctl -d marvell --all /dev/sda |grep -e ^194 | head -c 40 | tail -c 2`
Tb=`smartctl -d marvell --all /dev/sdb |grep -e ^194 | head -c 40 | tail -c 2`
ST=`FT_testing -T | tail -c 3 | head -c 2`
case `fanspeed g` in
    stop)
    Fan=$FAN_STOP
    ;;
    *)
    Fan=$FAN_ROTATE
    ;;
esac
echo  "system.value"  $ST
echo  "hda.value"  $Ta
echo  "hdb.value"  $Tb
echo  "fan.value" $Fan
