#!/bin/bash
if [[ `which gpg` && `which git` ]];
then
echo " Good to go "
else
echo " Install gpg and git "
exit
fi
if [[ `gpg --list-keys` ]];
then
echo " Select option "
echo " 1 use an existing one "
echo " 2 Generate new "
echo " 3 Delete "
read -p " Enter choice (1/2/3)" choice
if [[ $choice==1 ]];
then
gpg --list-secret-keys --keyid-format=long
read -p  " Enter the gpg key id " key
git config --global users.signingkey $key
git config --global commit.gpgsign true
gpg --export --armour $key
elif [[ $choice==2 ]];
then
gpg --full-generate-key
elif [[ $choice==3 ]];
then
gpg --list-secret-keys --keyid-format=long
read -p " Enter gpg key id " key
gpg --delete-secret-key $key
gpg --delete-key $key
else
echo " Invalid entry "
fi
else
gpg --full-generate-key
echo " Key is generated "
echo " Rerun the script to set it up "
fi