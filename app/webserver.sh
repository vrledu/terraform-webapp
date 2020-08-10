#!/bin/bash
yum update -y
yum install httpd wget -y
service httpd start
chkconfig httpd on
cd /var/www/html
wget https://pnghunter.com/get-logo.php?id=21739 -O yoda.png
export EC2_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
echo "<html><body><h1>This server is from <b>"$EC2_ID"</b></h1><img src="./yoda.png" alt="Yoda, a Force-sensitive male being belonging to a mysterious species, was a legendary Jedi Master" width="400" height="341"></body></html>" > /var/www/html/index.html
