#!/usr/bin/env bash

helpFunction()
{
   echo ""
   echo -e "\t-t Decides the type of installation. Available Options: full or sim_only"
   exit 1 # Exit script after printing help
}

while getopts "t:" opt
do
   case "$opt" in
      t ) INSTALL_TYPE="$OPTARG" ;;
      p ) PYTHON_VERSION="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$INSTALL_TYPE" ] ; then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

# Check if the parameters are valid
if [ $INSTALL_TYPE != "full" ] && [ $INSTALL_TYPE != "sim_only" ]; then
	echo "Invalid Installation type";
   helpFunction
fi

echo "$INSTALL_TYPE installation type is chosen for LoCoBot."

trap "exit" INT TERM ERR
trap "kill 0" EXIT
echo -e "\e[1;33m ******************************************* \e[0m"
echo -e "\e[1;33m This is the post configuration for full installation! \e[0m"
echo -e "\e[1;33m This file is not needed hen choosing sim_only! \e[0m"
echo -e "\e[1;33m ******************************************* \e[0m"
sleep 4

PYROBOT_REPO_PATH=$(pwd)

if [ $INSTALL_TYPE == "full" ]; then
	# STEP 1 - Dependencies and config for calibration
	cd $PYROBOT_REPO_PATH
	chmod +x src/pyrobot/robots/LoCoBot/locobot_navigation/orb_slam2_ros/scripts/gen_cfg.py
	rosrun orb_slam2_ros gen_cfg.py
	HIDDEN_FOLDER=~/.robot
	if [ ! -d "$HIDDEN_FOLDER" ]; then
		mkdir ~/.robot
		cp $PYROBOT_REPO_PATH/robots/LoCoBot/locobot_calibration/config/default.json ~/.robot/
	fi
	
	# STEP 2 - Setup udev rules
	cd $PYROBOT_REPO_PATH/robots/LoCoBot
	sudo cp thirdparty/udev_rules/*.rules /etc/udev/rules.d
	sudo service udev reload
	sudo service udev restart
	sudo udevadm trigger
	sudo usermod -a -G dialout $USER
fi
