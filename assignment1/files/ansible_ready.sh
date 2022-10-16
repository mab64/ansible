#!/bin/bash
# Prepare for ansible usage

# Message colors
RED='\033[0;31m'
NC='\033[0m' # No Color

if [[ -z $1 ]]; then
	username=ansible
else
	username=$1
fi

userok=0

for name in $(cut -f 1 -d : /etc/passwd | grep $username); do 
    if [[ "$name" == "$username" ]]; then 
        userok=1
        break
    fi
done
if [[ $userok == 1 ]]; then
    echo "User $username already present. Exiting"
    exit
fi

echo -n "Creating user $username... "
sudo useradd -m -s /bin/bash -G wheel -p "*" $username || \
    { echo "Cannot create user $username."; exit; }
echo OK

echo -n "Creating sudoers file for user $username... "
echo "$username ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$username > /dev/null || \
    { echo "Fail"; exit; }
echo OK

echo -n "Appending Ansible Control node's public key to authorized keys... "
sudo mkdir /home/${username}/.ssh || { echo "Fail: cannot create dir"; exit; }
cat ~/.temp/ansible_key.pub | sudo tee -a /home/${username}/.ssh/authorized_keys > /dev/null || \
    { echo "Fail: cannot append key."; exit; }
sudo chown -R ${username}:${username} /home/${username}/.ssh || \
    { echo "Fail: cannot assign owner"; exit; }
sudo chmod -R a=,u=rwX /home/${username}/.ssh || \
    { echo "Fail: cannot set rights"; exit; }
echo OK



echo Done
