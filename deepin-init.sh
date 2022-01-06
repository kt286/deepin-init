#!/bin/bash

#先进到用户下载目录
cd ~/Downloads

# 关闭控制中心自动更新
busctl call com.deepin.lastore /com/deepin/lastore com.deepin.lastore.Updater SetAutoCheckUpdates b 0
busctl call com.deepin.lastore /com/deepin/lastore com.deepin.lastore.Updater SetAutoDownloadUpdates b 0
busctl call com.deepin.lastore /com/deepin/lastore com.deepin.lastore.Updater SetUpdateNotify b 0
busctl call com.deepin.lastore /com/deepin/lastore com.deepin.lastore.Manager SetAutoClean b 0

# 系统设置
gsettings set com.deepin.xsettings dtk-window-radius 8  # 窗口圆角-中

gsettings set com.deepin.dde.dock display-mode 'efficient'  # dock-高效模式
gsettings set com.deepin.dde.dock window-size-efficient 46  # dock-高度增加

gsettings set com.deepin.dde.dock.module.multitasking enable false  # dock-禁用多任务窗口插件（待调整为只关闭，不禁用）
gsettings set com.deepin.dde.dock.module.show-desktop enable false  # dock-禁用显示桌面插件（待调整为只关闭，不禁用）

gsettings set com.deepin.dde.mouse disable-touchpad true  #插入鼠标时禁用触控板

gsettings set com.deepin.dde.power battery-lid-closed-action 'turnOffScreen' #使用电池-笔记本合盖时-关闭屏幕
gsettings set com.deepin.dde.power battery-press-power-button 'showSessionUI' #使用电池-按电源按钮时-不做任何操作
gsettings set com.deepin.dde.power battery-lock-delay 0  #使用电池-自动锁屏 从不
gsettings set com.deepin.dde.power battery-screen-black-delay 300  #使用电池-关闭显示器 5分钟
gsettings set com.deepin.dde.power battery-sleep-delay 0  #使用电池-进入待机模式 从不

gsettings set com.deepin.dde.power line-power-lid-closed-action 'turnOffScreen' #连接电源-笔记本合盖时-关闭屏幕
gsettings set com.deepin.dde.power line-power-press-power-button 'showSessionUI' #连接电源-按电源按钮时-不做任何操作
gsettings set com.deepin.dde.power line-power-lock-delay 0  #连接电源-自动锁屏 从不
gsettings set com.deepin.dde.power line-power-screen-black-delay 900  #连接电源-关闭显示器 15分钟
gsettings set com.deepin.dde.power line-power-sleep-delay 0  #连接电源-进入待机模式 从不

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

#添内测源到source.list.d
sudo sh -c 'echo "deb [trusted=yes] https://proposed-packages.deepin.com/dde-apricot unstable main contrib non-free" > /etc/apt/sources.list.d/deepin-unstable.list'

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
sudo apt-get purge -y deepin-clone
sudo apt-get purge -y deepin-recovery-plugin
sudo apt-get purge -y deepin-ab-recovery
sudo apt-get purge -y deepin-boot-maker
sudo apt-get purge -y gnome-theme*
sudo apt-get purge -y libreoffice*
sudo apt-get purge -y simple-scan
sudo apt-get purge -y printer-driver-deepin-cloud-print
sudo apt-get purge -y org.deepin.browser
sudo apt-get purge -y yelp
sudo apt-get purge -y fcitx*

#这两个是控制中心里修改屏幕色温的，但是切换英伟达驱动后无法修改，所以卸载
sudo apt-get purge -y geoclue-2.0
sudo apt-get purge -y redshift

#更新20.3内测后，卸载这个会导致无法右键跳转到设置，酌情卸载
sudo apt-get purge -y onboard-common

#这个是用来开关机画面的，我个人喜欢看开机输出文字信息，所以卸载
sudo apt-get purge -y plymouth*

#这几个是系统自带小游戏（五子棋和连连看）
sudo apt-get purge -y com.deepin*

#清理一下
sudo apt-get autoremove -y --purge

#安装软件
sudo apt-get update && sudo apt-get dist-upgrade -y
sudo apt-get install -y curl
sudo apt-get install -y git
sudo apt-get install -y console-setup
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

#卸载fcitx时会同时卸载qdbus，导致截图录屏无法使用快捷键呼出，重新安装修复(安装 qdbus-qt5 也可以，不知道有什么区别)
sudo apt-get install -y qdbus

#安装nvidia闭源驱动
sudo apt-get install -y nvidia-detect
nvidia-detect | awk 'match($0, /nvidia-.*/, a) {print a[0]}' | xargs sudo apt-get install

#隐藏启动器中 Device Formatter、fcitx5配置、键盘布局查看工具
sudo sed -i '$a\NoDisplay=true' /usr/share/applications/dde-device-formatter.desktop
sudo sed -i '$a\NoDisplay=true' /usr/share/applications/fcitx5-configtool.desktop 
sudo sed -i '$a\NoDisplay=true' /usr/share/applications/kbd-layout-viewer5.desktop

#修复命令行安装TIM、微信、向日葵、WPS，启动器中没有图标
mkdir -p ~/.local/share/applications/

cp -r /opt/apps/com.qq.office.deepin/entries/icons/* ~/.local/share/icons/
cp -r /opt/apps/com.qq.office.deepin/entries/applications/* ~/.local/share/applications/

cp -r /opt/apps/com.qq.weixin.deepin/entries/icons/* ~/.local/share/icons/
cp -r /opt/apps/com.qq.weixin.deepin/entries/applications/* ~/.local/share/applications/

cp -r /opt/apps/com.oray.sunlogin.client/entries/icons/* ~/.local/share/icons/
cp -r /opt/apps/com.oray.sunlogin.client/entries/applications/* ~/.local/share/applications/

cp -r /opt/apps/cn.wps.wps-office/entries/icons/* ~/.local/share/icons/
cp -r /opt/apps/cn.wps.wps-office/entries/applications/* ~/.local/share/applications/

#修复卸载多个软件后重启，启动器中又出现已卸载的图标
rm -rf ~/.config/deepin/dde-launcher-app-used-sorted-list.conf

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

#TIM使用公共deepin-wine6-stable
sudo rm -rf /opt/apps/com.qq.office.deepin/files/helper_archive.7z
sudo rm -rf /opt/apps/com.qq.office.deepin/files/helper_archive.md5sum
sudo rm -rf /opt/apps/com.qq.office.deepin/files/wine_archive.7z
sudo rm -rf /opt/apps/com.qq.office.deepin/files/wine_archive.md5sum

sudo cp /opt/apps/com.qq.office.deepin/files/run.sh /opt/apps/com.qq.office.deepin/files/run.sh.bak
sudo cp -r /opt/apps/com.qq.weixin.deepin/files/run.sh /opt/apps/com.qq.office.deepin/files/run.sh
sudo sed -i 's/Deepin-WeChat/Deepin-TIM/g' /opt/apps/com.qq.office.deepin/files/run.sh
sudo sed -i 's/3.2.1.154deepin14/3.3.5.22018deepin8/g' /opt/apps/com.qq.office.deepin/files/run.sh
sudo sed -i 's/WeChat\/WeChat/TIM\/Bin\/TIM/g' /opt/apps/com.qq.office.deepin/files/run.sh
sudo sed -i 's/com.qq.weixin.deepin/com.qq.office.deepin/g' /opt/apps/com.qq.office.deepin/files/run.sh

#更新TIM到最新版本
sh -c  '/opt/apps/com.qq.office.deepin/files/run.sh -c'
export WINEPREFIX=$HOME/.deepinwine/Deepin-TIM
rm TIM3.3.9.22051.exe
wget -t 3 -T 15 https://dldir1.qq.com/qqfile/qq/TIM3.3.9/TIM3.3.9.22051.exe
deepin-wine6-stable TIM3.3.9.22051.exe

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
