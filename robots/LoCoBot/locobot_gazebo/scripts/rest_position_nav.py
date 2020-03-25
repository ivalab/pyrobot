#!/usr/bin/env python

from pyrobot import Robot
import numpy as np
import rospy
import time

if __name__ == "__main__":
	#rospy.init_node('rest_postition_nav', anonymous=True)

	robot = Robot('locobot', use_base=False, use_camera=False, use_gripper=False)
	target_joints = [
        	[0, -1.6, 0.8, 1.6, 0],
    		]
	#robot.arm.go_home()

	for joint in target_joints:
	    robot.arm.set_joint_positions(joint, plan=False)
	    time.sleep(1)
	    
	#robot.arm.go_home()
