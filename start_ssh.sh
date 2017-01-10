#!/bin/bash
sshpass -p "password" ssh -o StrictHostKeyChecking=no 'root@'$1'.local'
#cd /home/barcodedetection/
#clear
