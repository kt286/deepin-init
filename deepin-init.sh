#!/bin/sh

#先进到用户下载目录
cd ~/Downloads

#先更新一下
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install wget curl

#关闭开关机logo和不知道干嘛的设置（据说关闭之后会减少卡顿）
gsettings set com.deepin.dde.startdde launch-welcome false
gsettings set com.deepin.dde.startdde swap-sched-enabled false

#添加Chrome源到source.list.d
wget -q -O - http://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

#添加VSCode源到source.list.d
wget -q -O - https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor - > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

#添加Wine源到source.list.d
wget -q -O - https://dl.winehq.org/wine-builds/Release.key | sudo apt-key add -
sudo sh -c 'echo "deb https://dl.winehq.org/wine-builds/debian/ DISTRO main" >> /etc/apt/sources.list.d/winehq.list'

#卸载系统自带Flash（Chrome会自动更新的，不用Firefox）
sudo apt-get purge libflashplugin-pepper
rm -rf ~/.config/google-chrome/PepperFlash/

#安装软件
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install google-chrome-stable #Chrome浏览器
sudo apt-get install code #VSCode
sudo apt-get install libappindicator3-1 #Lantern依赖，不安装的话会打不开蓝灯
sudo apt-get install winehq-stable #wine deepin自带的那个有点旧
sudo apt-get install python3.6 #更新Python3到3.6
sudo apt-get install qt-sdk #安装qt开发包

#安装Lantren
wget https://raw.githubusercontent.com/getlantern/lantern-binaries/master/lantern-installer-64-bit.deb
sudo dpkg -i lantern-installer-64-bit.deb

#删除Chrome推荐设置
sudo rm /etc/opt/chrome/policies/recommended/*.json

#清理一下
sudo apt-get autoremove
