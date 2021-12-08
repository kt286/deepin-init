#!/bin/bash

#先进到用户下载目录
cd ~/Downloads

# 一些系统设置
# 窗口圆角-中
busctl --user set-property com.deepin.daemon.Appearance /com/deepin/daemon/Appearance com.deepin.daemon.Appearance WindowRadius i 8
# 关闭自动更新
busctl call com.deepin.lastore /com/deepin/lastore com.deepin.lastore.Updater SetAutoCheckUpdates b 0
busctl call com.deepin.lastore /com/deepin/lastore com.deepin.lastore.Updater SetAutoDownloadUpdates b 0
busctl call com.deepin.lastore /com/deepin/lastore com.deepin.lastore.Updater SetUpdateNotify b 0
busctl call com.deepin.lastore /com/deepin/lastore com.deepin.lastore.Manager SetAutoClean b 0

#添加Chrome源到source.list.d
wget -q -O - http://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'

#添加VSCode源到source.list.d
wget -q -O - https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

#添加Docker源到source.list.d
wget -q -O - https://mirrors.cloud.tencent.com/docker-ce/linux/debian/gpg | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://mirrors.cloud.tencent.com/docker-ce/linux/debian buster stable" > /etc/apt/sources.list.d/docker.list'

#添加Typora源到source.list.d
wget -q -O - https://typora.io/linux/public-key.asc | sudo apt-key add -
sudo sh -c 'echo "deb https://typora.io/linux ./" > /etc/apt/sources.list.d/typora.list'

#添加Beyond Compare源到source.list.d
wget -q -O - https://www.scootersoftware.com/RPM-GPG-KEY-scootersoftware | sudo apt-key add -
sudo sh -c 'echo "deb https://www.scootersoftware.com/ bcompare4 non-free" > /etc/apt/sources.list.d/scootersoftware.list'

#添加nodejs源到source.list.d
wget -q -O - https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
sudo sh -c 'echo "deb https://deb.nodesource.com/node_16.x buster main" > /etc/apt/sources.list.d/nodesource.list'

#卸载系统自带Flash
sudo apt-get purge -y libflashplugin-pepper
rm -rf ~/.config/google-chrome/PepperFlash/

#卸载深度帮助手册和深度欢迎两个没用还占地方的东西（会同时卸载dde，貌似没啥问题）
sudo apt-get purge -y deepin-manual
sudo apt-get purge -y dde-introduction

#卸载自己不需要的软件
sudo apt-get purge -y deepin-feedback
sudo apt-get purge -y deepin-app-store
sudo apt-get purge -y deepin-deepinid-client
sudo apt-get purge -y deepin-music
sudo apt-get purge -y deepin-calculator
sudo apt-get purge -y deepin-draw
sudo apt-get purge -y deepin-voice-note
sudo apt-get purge -y deepin-album
sudo apt-get purge -y deepin-camera
sudo apt-get purge -y deepin-mail
sudo apt-get purge -y deepin-screensaver*
sudo apt-get purge -y deepin-screen-recorder
sudo apt-get purge -y deepin-clone
sudo apt-get purge -y deepin-recovery-plugin
sudo apt-get purge -y deepin-ab-recovery
sudo apt-get purge -y deepin-boot-maker
sudo apt-get purge -y com.deepin*
sudo apt-get purge -y gnome-theme*
sudo apt-get purge -y plymouth*
sudo apt-get purge -y libreoffice*
sudo apt-get purge -y simple-scan
sudo apt-get purge -y printer-driver-deepin-cloud-print
sudo apt-get purge -y org.deepin.browser
sudo apt-get purge -y onboard-common
sudo apt-get purge -y yelp
sudo apt-get purge -y geoclue-2.0
sudo apt-get purge -y redshift
sudo apt-get purge -y fcitx*

#清理一下
sudo apt-get autoremove -y --purge

#安装软件
sudo apt-get update && sudo apt-get dist-upgrade -y
sudo apt-get install -y curl
sudo apt-get install -y git
sudo apt-get install -y console-setup
sudo apt-get install -y deepin-screenshot
sudo apt-get install -y qt5-qmake
sudo apt-get install -y code
sudo apt-get install -y google-chrome-stable
sudo apt-get install -y com.qq.office.deepin
sudo apt-get install -y com.qq.weixin.deepin
sudo apt-get install -y docker-ce
sudo apt-get install -y typora
sudo apt-get install -y fcitx5-chinese-addons
sudo apt-get install -y com.oray.sunlogin.client
sudo apt-get install -y cn.wps.wps-office
sudo apt-get install -y bcompare
sudo apt-get install -y nodejs

#隐藏启动器中 Device Formatter、fcitx5配置、键盘布局查看工具
sudo sed -i '$a\NoDisplay=true' /usr/share/applications/dde-device-formatter.desktop
sudo sed -i '$a\NoDisplay=true' /usr/share/applications/fcitx5-configtool.desktop 
sudo sed -i '$a\NoDisplay=true' /usr/share/applications/kbd-layout-viewer5.desktop

#修复安装VSCode后，Win + E 打开的是VSCode
xdg-mime default dde-file-manager.desktop inode/directory

#删除Chrome推荐设置
sudo rm /etc/opt/chrome/policies/recommended/*.json

#fcitx5开机自启动
mkdir -p ~/.config/autostart
sudo cp /usr/share/applications/org.fcitx.Fcitx5.desktop ~/.config/autostart/org.fcitx.Fcitx5.desktop

#删除图标主题
sudo rm -rf /usr/share/icons/Adwaita/
sudo rm -rf /usr/share/icons/Papirus/
sudo rm -rf /usr/share/icons/Vintage/
sudo rm -rf /usr/share/icons/locolor/
sudo rm -rf /usr/share/icons/HighContrast/
sudo rm -rf /usr/share/icons/ubuntu-mono-dark/
sudo rm -rf /usr/share/icons/ubuntu-mono-light/

#更新TIM到最新版本
sh -c  '/opt/apps/com.qq.office.deepin/files/run.sh -c'
export WINEPREFIX=$HOME/.deepinwine/Deepin-TIM
rm TIM3.3.8.22043.exe
wget -t 3 -T 15 https://dldir1.qq.com/qqfile/qq/PCTIM/TIM3.3.8/TIM3.3.8.22043.exe
deepin-wine6-stable TIM3.3.8.22043.exe

#更新微信到最新版本
sh -c  '/opt/apps/com.qq.weixin.deepin/files/run.sh -c'
export WINEPREFIX=$HOME/.deepinwine/Deepin-WeChat
rm WeChatSetup.exe
wget -t 3 -T 15 https://dldir1.qq.com/weixin/Windows/WeChatSetup.exe
deepin-wine6-stable WeChatSetup.exe

#清理一下
sudo apt-get autoremove -y --purge

#设置fcitx图标(bloom主题缺少图标)
sudo mv /usr/share/icons/bloom/actions/24/input-keyboard-symbolic.svg /usr/share/icons/bloom/actions/24/input-keyboard-symbolic.svg.bak
sudo ln -s /usr/share/icons/bloom/status/20/keyboard-symbolic.svg /usr/share/icons/bloom/status/20/input-keyboard-symbolic.svg
