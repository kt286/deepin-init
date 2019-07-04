#!/bin/bash

#先进到用户下载目录
cd ~/Downloads

#替换成163的源
sudo sh -c 'echo "deb [by-hash=force] http://mirrors.163.com/deepin/ lion main contrib non-free" > /etc/apt/sources.list'

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

#添加Typora源到source.list.d
wget -q -O - https://typora.io/linux/public-key.asc | sudo apt-key add -
sudo sh -c 'echo "deb https://typora.io/linux ./" > /etc/apt/sources.list.d/typora.list'

#卸载系统自带Flash（Chrome会自动更新的）
sudo apt-get purge libflashplugin-pepper   #貌似新版本没了  下个版本试试
rm -rf ~/.config/google-chrome/PepperFlash/

#卸载自带QQ（原因不解释，我喜欢TIM）
sudo apt-get purge deepin.com.qq.im -y

#卸载深度帮助手册和深度欢迎两个没用还占地方的东西（会同时卸载dde，貌似没啥问题）
sudo apt-get purge deepin-manual -y
sudo apt-get purge dde-introduction -y

#卸载自己不需要的软件
sudo apt-get purge thunderbird -y
sudo apt-get purge deepin-feedback -y
sudo apt-get purge deepin-fpapp-org.deepin.flatdeb.deepin-music -y
sudo apt-get purge deepin-fpapp-org.deepin.flatdeb.deepin-calculator -y

#安装软件
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install qt5-qmake -y    #安装qt5编译工具
sudo apt-get install deepin.com.qq.office -y     #安装TIM
sudo apt-get install deepin.com.wechat.devtools -y      #微信开发者工具
sudo apt-get install deepin.com.wechat -y      #微信
sudo apt-get install openjdk-8-jdk -y     #安装openjdk8
sudo apt-get install docker-ce -y     #安装docker-ce
sudo apt-get install typora -y     #安装typora

#安装Lantren
wget https://raw.githubusercontent.com/getlantern/lantern-binaries/master/lantern-installer-64-bit.deb 
sudo dpkg -i lantern-installer-64-bit.deb 

#删除Chrome推荐设置
sudo rm /etc/opt/chrome/policies/recommended/*.json

#更新TIM到最新版本(需要先运行一下TIM，生成文件夹后再执行)
export WINEPREFIX=~/.deepinwine/Deepin-TIM
wget https://dldir1.qq.com/qqfile/qq/PCTIM2.3.2/21158/TIM2.3.2.21158.exe
deepin-wine tim_pc.exe

#清理一下
sudo apt-get autoremove --purge
