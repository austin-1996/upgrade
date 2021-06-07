#set -x

HOMELOG=$(cat /etc/passwd | grep 1000 | cut -d : -f 1)

HOME=/home/$HOMELOG

#crontab -l | grep "/home/austin/git/upgrade/effiecntUpgrade.sh"


$(apt list --upgradeable | grep -v "Listing..." > /tmp/upgrade.txt)

[ -d $HOME/logs ] || mkdir $HOME/logs

LENGTH=$(cat /tmp/upgrade.txt | wc -l)

if [ $LENGTH -eq 0 ]
then

cat << EOF >> $HOME/logs/upgrade.log
$(timedatectl | grep Local | awk '{print $4 " " $5 " "$6 }')

$(cat /tmp/upgrade.tmp)

There are 0 Packages to upgrade

EOF
exit
fi

if [ $LENGTH -eq 1 ]
then

cat << EOF >> $HOME/logs/upgrade.log
$(timedatectl | grep Local | awk '{print $4 " " $5 " "$6 }')

$(cat /tmp/upgrade.tmp)

There is 1 package to upgrade

EOF
fi

if [ $LENGTH -gt 1 ]
then

cat << EOF >> $HOME/logs/upgrade.log
$(timedatectl | grep Local | awk '{print $4 " " $5 " "$6 }')

$(cat /tmp/upgrade.tmp)

There are $LENGTH Packages to upgrade

EOF
fi

if [ $LENGTH -gt 0 ]
then


AUTOREMOVE=$(apt upgrade -y 2>&1 | grep "to remove" | awk '{print $3}')

if [ $AUTOREMOVE -gt 0 ]
then
apt autoremove -y
fi

fi


