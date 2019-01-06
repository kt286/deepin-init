#!/bin/bash

#先进到用户下载目录
cd ~/Downloads

#先更新一下
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install wget curl console-setup -y

#关闭开关机logo
sudo plymouth-set-default-theme -R details  # 修改开机logo为详细信息（个人喜好）

#添加Chrome源到source.list.d
wget -q -O - http://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list'

#添加VSCode源到source.list.d
wget -q -O - https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor - > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

#添加Docker源到source.list.d
wget -q -O - https://mirrors.ustc.edu.cn/docker-ce/linux/debian/gpg | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/debian jessie stable" > /etc/apt/sources.list.d/docker.list'

#添加Teamviewer源到source.list.d
wget -q -O - https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc | sudo apt-key add -
sudo sh -c 'echo "deb http://linux.teamviewer.com/deb stable main" > /etc/apt/sources.list.d/teamviewer.list'

#添加Typora源到source.list.d
wget -q -O - https://typora.io/linux/public-key.asc | sudo apt-key add -
sudo sh -c 'echo "deb https://typora.io/linux ./" > /etc/apt/sources.list.d/typora.list'

#卸载系统自带Flash（Chrome会自动更新的）
sudo apt-get purge libflashplugin-pepper
rm -rf ~/.config/google-chrome/PepperFlash/

#卸载自带QQ（原因不解释，我喜欢TIM）
sudo apt-get purge deepin.com.qq.im

#安装软件
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install qt5-qmake -y    #安装qt5编译工具
sudo apt-get install deepin.com.qq.office -y     #安装TIM
sudo apt-get install deepin.com.wechat.devtools -y      #微信开发者工具
sudo apt-get install deepin.com.wechat -y      #微信
sudo apt-get install openjdk-8-jdk -y     #安装openjdk8
sudo apt-get install docker-ce -y     #安装docker-ce
sudo apt-get install teamviewer -y     #安装teamviewer 
sudo apt-get install typora -y     #安装typora

#安装Lantren
wget -q https://raw.githubusercontent.com/getlantern/lantern-binaries/master/lantern-installer-64-bit.deb 
sudo dpkg -i lantern-installer-64-bit.deb 

#删除Chrome推荐设置
sudo rm /etc/opt/chrome/policies/recommended/*.json

#更新TIM到最新版本(需要先运行一下TIM，生成文件后后再执行)
export WINEPREFIX=~/.deepinwine/Deepin-TIM
wget -q https://qd.myapp.com/myapp/qqteam/tim/down/tim_pc.exe
deepin-wine tim_pc.exe

#清理一下
sudo apt-get autoremove --purge





## 以下内容待移除

#添加Wine源到source.list.d
#wget -q -O - https://dl.winehq.org/wine-builds/Release.key | sudo apt-key add -
#sudo sh -c 'echo "deb https://dl.winehq.org/wine-builds/debian/ DISTRO main" > /etc/apt/sources.list.d/winehq.list'
#sudo apt-get install winehq-stable #wine

#添加第三方wine tim源到source.list.d
#wget -q -O - https://yenole.gitee.io/sign.pub | sudo apt-key add -
#sudo sh -c 'echo "deb https://yenole.gitee.io stable main" > /etc/apt/sources.list.d/3th-deepinwine-app.list'

#第三方wine APP
#sudo apt-get install deepin.apps.com.wechat.devtools  #微信开发者工具
#sudo apt-get install deepin.apps.com.wechat  #微信
#sudo apt-get install deepin.apps.com.qq.office  #TIM

#sudo apt-get install libappindicator3-1 -y   #Lantern依赖，不安装的话会打不开蓝灯（Deepin 15.7+ 已安装）
#sudo apt-get install google-chrome-stable -y    #Chrome浏览器（Deepin 15.8+ 已安装）
#sudo apt-get install code -y    #VSCode（Deepin 15.8+ 已安装）
#sudo apt-get install python3.6 -y   #安装Python3.6 （Deepin 15.8+ 已安装）


