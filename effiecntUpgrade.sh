set -x

$(apt list --upgradeable | grep -v "Listing..." > /tmp/upgrade.tmp)

[ -d $HOME/logs ] || mkdir $HOME/logs

LENGTH=$(cat /tmp/upgrade.tmp | wc -l)



cat << EOF >> $HOME/logs/upgrade.log
$(timedatectl | grep Local | awk '{print $4 " " $5 " "$6 }')

$(cat /tmp/upgrade.tmp)

There are $LENGTH Packages to upgrade

EOF

if [ $LENGTH -gt 0 ]
then

apt upgrade -y
apt autoremove -y

fi

#apt autoremove -y
