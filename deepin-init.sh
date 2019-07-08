#!/bin/bash

#先进到用户下载目录
cd ~/Downloads

#替换成163的源
sudo sh 'echo "deb [by-hash=force] http://mirrors.163.com/deepin/ lion main contrib non-free" > /etc/apt/sources.list'

#添加Chrome源到source.list.d
wget -q -O - http://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list'

#添加VSCode源到source.list.d
wget -q -O - https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo sh 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

#添加Docker源到source.list.d
wget -q -O - https://mirrors.ustc.edu.cn/docker-ce/linux/debian/gpg | sudo apt-key add -
sudo sh 'echo "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/debian jessie stable" > /etc/apt/sources.list.d/docker.list'

#添加Typora源到source.list.d
wget -q -O - https://typora.io/linux/public-key.asc | sudo apt-key add -
sudo sh 'echo "deb https://typora.io/linux ./" > /etc/apt/sources.list.d/typora.list'

#添加yarn源到source.list.d
wget -q -O - https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
sudo sh 'echo "deb [arch=amd64] https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list'

#卸载系统自带Flash（Chrome会自动更新的）
sudo apt-get purge -y libflashplugin-pepper
rm -rf ~/.config/google-chrome/PepperFlash/

#卸载自带QQ（原因不解释，我喜欢TIM）
sudo apt-get purge -y deepin.com.qq.im

#卸载深度帮助手册和深度欢迎两个没用还占地方的东西（会同时卸载dde，貌似没啥问题）
sudo apt-get purge -y deepin-manual
sudo apt-get purge -y dde-introduction

#卸载自己不需要的软件
sudo apt-get purge -y thunderbird
sudo apt-get purge -y deepin-feedback
sudo apt-get purge -y deepin-appstore*
sudo apt-get purge -y deepin-fpapp-org.deepin.flatdeb.deepin-music
sudo apt-get purge -y deepin-music
sudo apt-get purge -y deepin-fpapp-org.deepin.flatdeb.deepin-calculator
sudo apt-get purge -y deepin-calculator
sudo apt-get purge -y plymouth-theme-deepin-logo

#安装软件
sudo apt-get update && sudo apt-get dist-upgrade
sudo apt-get install -y curl
sudo apt-get install -y console-setup
sudo apt-get install -y qt5-qmake
sudo apt-get install -y code
sudo apt-get install -y deepin.com.qq.office
sudo apt-get install -y --no-install-recommends openjdk-8-jdk
sudo apt-get install -y docker-ce
sudo apt-get install -y typora
sudo apt-get install -y --no-install-recommends yarn

#安装Lantren
wget -t 3 -T 15 https://raw.githubusercontent.com/getlantern/lantern-binaries/master/lantern-installer-64-bit.deb 
sudo dpkg -i lantern-installer-64-bit.deb 

#删除Chrome推荐设置
sudo rm /etc/opt/chrome/policies/recommended/*.json

#更新TIM到最新版本
sudo sh '/opt/deepinwine/apps/Deepin-TIM/run.sh -c'
export WINEPREFIX=$HOME/.deepinwine/Deepin-TIM
wget -t 3 -T 15 https://dldir1.qq.com/qqfile/qq/PCTIM2.3.2/21158/TIM2.3.2.21158.exe
deepin-wine tim_pc.exe

# 修改开机logo为详细信息（个人喜好）
sudo plymouth-set-default-theme -R details

#清理一下
sudo apt-get autoremove --purge
