# Terraform-S3
10/20/2022 Thursday 

1. git lfs doc --> https://git-lfs.github.com/
2. git lfs push --all origin 
3. git lfs migrate import 
4. git push 
5. git lfs ls-files 

In order connect from ec2 to mysql db --> mysql agent/client must be installed 
Scenario: How do you build RDS database with backup solutions?
1. Create RDS cluster (MySQL/Postgres edition)
2. In case writer instance goes down, reader instance becomes writer (primary) instance

Scenario: In order to SSH instance between different folks how can pem be shared?

1. Use SSM (System manager)
2. wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
3.  sudo yum -y localinstall amazon-ssm-agent.rpm 
4.  sudo systemctl enable amazon-ssm-agent
5.  sudo systemctl start amazon-ssm-agent
6.  sudo systemctl status amazon-ssm-agent
7.  sudo tail -f /var/log/amazon/ssm/amazon-ssm-agent.log --> Check the logs 


RDS: 

Connect to writer instance: 

CREATE DATABASE ratings; USE ratings; SELECT DATABASE(); SHOW TABLES; 

CREATE TABLE ratings (author VARCHAR(20), rating TINYINT, timerated DATETIME); 

SHOW TABLES; 

DESCRIBE ratings; 

INSERT INTO ratings ( author, rating, timerated ) VALUES ( "Tia Williams", 10, "2018-06-26 10:06:47"), ( "Adrian Cantril", 10, "2018-06-23 10:06:27”); 

Select * from ratings;

Connect to Reader instance and run: 
INSERT INTO ratings (author,ratings,timerated) VALUES ("Ivanka Z.", 1, "2025-25-25 10:10:10","Ravana G.", 4,"2026-26-26 10:10:10", "Sophia H.", 7, "2027-27-27 10:10:10");


Homework: 

Take existing configuration and make sure wordpress is connected to backend mysql instance and up and running.

Acceptance criteria: You can hit the wordpress website in the browser using instance public IP. 
