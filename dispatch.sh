echo -e "\e[34m Install Golang \e[0m"
yum install golang -y &>>/tmp/roboshop.log

echo -e "\e[34m Add Application User \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[34m Create Application Directory \e[0m"
rm -rf /app echo &>>/tmp/roboshop.log
mkdir /app 

echo -e "\e[34m Download Application Content \e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[34m Extract Application Content \e[0m"
unzip /tmp/dispatch.zip &>>/tmp/roboshop.log

echo -e "\e[34m Download Dispatch Dependencies \e[0m"
cd /app 
go mod init dispatch &>>/tmp/roboshop.log
go get &>>/tmp/roboshop.log
go build &>>/tmp/roboshop.log


echo -e "\e[34m Setup Systemd file\e[0m"
cp /home/centos/rbs-shell/dispatch.service /etc/systemd/system/dispatch.service &>>/tmp/roboshop.log

echo -e "\e[34m Start Dispatch Service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable dispatch &>>/tmp/roboshop.log
systemctl start dispatch &>>/tmp/roboshop.log