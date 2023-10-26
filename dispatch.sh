echo -e "\e[34m Install Golang \e[0m"
yum install golang -y

echo -e "\e[34m Add Application User \e[0m"
useradd roboshop

echo -e "\e[34m Create Application Directory \e[0m"
rm -rf /app
mkdir /app 

echo -e "\e[34m Download Application Content \e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip 
cd /app

echo -e "\e[34m Extract Application Content \e[0m"
unzip /tmp/dispatch.zip

echo -e "\e[34m Download Dispatch Dependencies \e[0m"
cd /app 
go mod init dispatch
go get 
go build


echo -e "\e[34m Setup Systemd file\e[0m"
cp /home/centos/rbs-shell/dispatch.service /etc/systemd/system/dispatch.service &>>/tmp/roboshop.log

echo -e "\e[34m Start Dispatch Service\e[0m"
systemctl daemon-reload
systemctl enable dispatch 
systemctl start dispatch