from pyrobot import Robot
import numpy as np
import rospy
import time

if __name__ == "__main__":
	#rospy.init_node('rest_postition_nav', anonymous=True)

	robot = Robot('locobot')
	target_joints = [
        	[0, -0.721, 1.2, 0, 0]
        ]
	#robot.arm.go_home()

	for joint in target_joints:
	    robot.arm.set_joint_positions(joint, plan=False)
	    time.sleep(1)
	    
	#robot.arm.go_home()
