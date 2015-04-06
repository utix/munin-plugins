#!/ffp/bin/sh
case $1 in
config)
cat <<'EOM'
graph_peroid 20
graph_category sensors
graph_title Temperatures
graph_vlabel Celsius
graph_order system hda hdb
sytem.label System
hda.label Disk A
hdb.label Disk B
EOM
exit 0;;
esac

Ta=`smartctl -d marvell --all /dev/sda |grep -e ^194 | head -c 40 | tail -c 2`
Tb=`smartctl -d marvell --all /dev/sdb |grep -e ^194 | head -c 40 | tail -c 2`
ST=`FT_testing -T | tail -c 3 | head -c 2`
echo  "system.value"  $ST
echo  "hda.value"  $Ta
echo  "hdb.value"  $Tb
