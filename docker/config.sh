#!/bin/bash

echo -e "\n**** Configuring timezone ****\n"
echo 'Europe/Kiev' | sudo tee /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata

echo -e "\n**** Pulling image from repo ****\n"
docker pull severchyk/robotix:focal

if [[ $? > 0 ]];
then
    echo -e "\n**** Building image locally ****\n"
    docker build -t severchyk/robotix:focal .
    echo -e "\n**** Starting a container ****\n"
    docker-compose up -d
else
    echo -e "\n**** Starting a container ****\n"
    docker-compose up -d
fi

sleep 5
sed -i -e '$a\\n# start ros2\nsource /opt/ros/galactic/setup.bash' config/.bashrc

if [[ $? > 0 ]];
then
    echo -e "\n**** Error while updating .bashrc ****\n"
else
    echo -e "\n**** .bashrc successfully updated ****\n"
fi