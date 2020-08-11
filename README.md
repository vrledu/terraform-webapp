# terraform-webapp
The purpose of this project is to host a simple web application/page which display text and image in single page. Application is hosted in AWS cloud and entire infra structure/env is done using terraform(IaC).

prerequisites:
a. AWS account
b. AWS cli -  to setup region, access/secret keys
c. Terraform - v0.12.29
d. graphviz - for getting terraform graph as in flowchat

Infa/env details:
Used 3 public/private subnets across different AZ's in a region for HA. 1 EC2 instance on each subnets hosting web/app server on public/private subnets.Auto-scaling group used for scalability purpose for both subnets.Apart from this other aws resources like Internet Gateway(IGW) attached VPC, load balancer, security group etc been used. Webserver(httpd) is setup in instance present in public subnets. SNS alert via sms/email setup for monitoring ec2 instances as part of health checks.

Terraform details:
Modules concepts are used to keep both VPC/EC2 codes as separate entity and within EC2, templates are used for ec2 role/policy and sns email setup.

How to use:
a. check out the repo
b. make sure all the point mentioned in the prerequisites are covered
c. to setup vpc layer, navigate to vpc sub-folder from modules dir
d. update s3 bucket/key names in backend-infra.config file
e. execute the below commands:
    terraform init -backend-config="backend-infra.config"
    terraform validate
    terraform plan -out webapp.plan
    terraform apply "webapp.plan"
f. to setup ec2 instances, navigate to ec2 sub-folder from modules dir
g. update s3 bucket/key names in backend-instance.config file
h. update sns email in variables.tf file
i. execute the below commands:
    terraform init -backend-config="backend-instance.config"
    terraform validate
    terraform plan -out ec2.plan
    terraform apply "ec2.plan"
j. to generate flow chart via terraform graph
    terraform graph > ec2_graph.dot
    cat ec2_graph.dot | dot -Tsvg > ec2_graph.svg

k. to view web page, take the dns name from webserver load balancer and open it in a browser.
expected : should see text saying which instance/id and yoda image.
if you refresh the page again, should see different instance/id and same yoda iamge.
