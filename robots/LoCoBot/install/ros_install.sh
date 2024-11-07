ROS_NAME=$1

if [ $(dpkg-query -W -f='${Status}' ros-$ROS_NAME-desktop-full 2>/dev/null | grep -c "ok installed") -eq 0 ]; then 
    if [ $ROS_NAME == "kinetic" ]; then
        UBUNTU_NAME="xenial"
    elif [ $ROS_NAME == "melodic" ]; then
        UBUNTU_NAME="bionic"
    elif [ $ROS_NAME == "noetic" ]; then
        UBUNTU_NAME="focal"
    fi
    sudo sh -c "echo 'deb http://packages.ros.org/ros/ubuntu $UBUNTU_NAME main' > /etc/apt/sources.list.d/ros1-latest.list"
    sudo apt-get update
    sudo apt-get -y install ros-kinetic-desktop-full
    if [ -f /etc/ros/rosdep/sources.list.d/20-default.list ]; then
        sudo rm /etc/ros/rosdep/sources.list.d/20-default.list
    fi
    sudo apt -y install python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
    sudo rosdep init
    rosdep update
    echo "source /opt/ros/$ROS_NAME/setup.bash" >> ~/.bashrc
else
    echo "ros-$ROS_NAME-desktop-full is already installed";
fi
