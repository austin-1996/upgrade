set -x

HOMELOG=$(cat /etc/passwd | grep 1000 | cut -d : -f 1)

HOME=/home/$HOMELOG

crontab -l | grep "/home/austin/git/upgrade/effiecntUpgrade.sh"


$(apt list --upgradeable | grep -v "Listing..." > /tmp/upgrade.tmp)

[ -d $HOME/logs ] || mkdir $HOME/logs

LENGTH=$(cat /tmp/upgrade.tmp | wc -l)

if [ $LENGTH -eq 0 ]
then

cat << EOF >> $HOME/logs/upgrade.log
$(timedatectl | grep Local | awk '{print $4 " " $5 " "$6 }')

$(cat /tmp/upgrade.tmp)

There are 0 Packages to upgrade

EOF
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

apt upgrade -y
apt autoremove -y

fi

apt autoremove -y
