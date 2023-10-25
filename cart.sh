echo -e "\e[34mConfiguring NodeJS Repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>/tmp/roboshop.log

echo -e "\e[34mInsatall NodeJS\e[0m" &>>/tmp/roboshop.log
yum curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[34mAdd Application user\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[34mCreate Application Directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app

echo -e "\e[34mDownload Application Content\e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip  &>>/tmp/roboshop.log
cd /app 

echo -e "\e[34mExtract Application Content\e[0m"
unzip /tmp/cart.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[34mInstall NodeJS Dependiences\e[0m"
npm install &>>/tmp/roboshop.log

echo -e "\e[34mSetup SystemD Service\e[0m"
cp /home/centos/rbs-shell/cart.service /etc/systemd/system/cart.service &>>/tmp/roboshop.log

echo -e "\e[34mStart cart Service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable cart &>>/tmp/roboshop.log
systemctl restart cart &>>/tmp/roboshop.log