#!/bin/bash

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
cd config

if grep -q ros ".bashrc";
then
    echo -e "\n**** .bashrc already updated ****\n"
else
    echo -e "\n# start ros2\nsource /opt/ros/galactic/setup.bash" >> .bashrc
    if grep -q ros ".bashrc";
    then
        echo -e "\n**** .bashrc successfully updated ****\n"
    else
        echo -e "\n**** Error while updating .bashrc ****\n"
    fi
fi