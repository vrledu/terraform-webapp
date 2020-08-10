#!/bin/bash
yum update -y
yum install httpd wget -y
service httpd start
chkconfig httpd on
cd /var/www/html
wget https://pnghunter.com/get-logo.php?id=21869 -O optimusprime.png
chmod 777 optimusprime.png
export EC2_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
echo "<html><body><h1>This server is from <b>"$EC2_ID"</b></h1><img src="./optimusprime.png" alt="Optimus Prime is the awe-inspiring leader of the Autobot forces. Selfless and endlessly courageous, he is the complete opposite of his mortal enemy Megatron." width="400" height="341"></body></html>" > /var/www/html/index.html
