# rcll-edison-control

This project aims for controlling all 12 MPS in an robocup logistics league game in a comfortable and easy manner.
It makes use of tmux and tmuxinator, which need to be installed to use this project.

Adjustments
-----------
	The start_ssh.sh needs the password for the MPS.

	Change the root variable in the edisons.yml to the absolute path of this directory.

	```
	mv ./edisons.yml .tmuxinator/
	```
Use
---
	```
	tmuxinator edisons
	```
	
		


