echo -e "\e[34mConfiguring Nodejs Repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[34mInstall Nodejs\e[0m"
yum install nodejs -y

echo -e "\e[34mAdd Application User\e[0m"
useradd roboshop

echo -e "\e[34m Create Application Directory\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[34m Dowmload Application Content\e[0m"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>/tmp/roboshop.log
cd /app 

echo -e "\e[34m Extract Application Content \e[0m"
unzip /tmp/cart.zip
cd /app

echo -e "\e[34m Install Nodejs Dependencies\e[0m"
npm install

echo -e "\e[34m Setup SystemD Service \e[0m"
cp /home/centos/rbs-shell/cart.service /etc/systemd/system/cart.service

echo -e "\e[34mStart cart Service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable cart &>>/tmp/roboshop.log
systemctl restart cart &>>/tmp/roboshop.log