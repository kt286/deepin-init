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

busctl --user call com.deepin.dde.Dock /com/deepin/dde/Dock com.deepin.dde.Dock setPluginVisible sb '显示桌面' false  # dock-禁用显示桌面插件
busctl --user call com.deepin.dde.Dock /com/deepin/dde/Dock com.deepin.dde.Dock setPluginVisible sb '屏幕键盘' false  # dock-禁用屏幕键盘插件
busctl --user call com.deepin.dde.Dock /com/deepin/dde/Dock com.deepin.dde.Dock setPluginVisible sb '多任务视图' false  # dock-禁用多任务窗口插件
busctl --user call com.deepin.dde.Dock /com/deepin/dde/Dock com.deepin.dde.Dock setPluginVisible sb '通知中心' false  # dock-禁用通知中心插件
busctl --user call com.deepin.dde.Dock /com/deepin/dde/Dock com.deepin.dde.Dock setPluginVisible sb '全局搜索' false  # dock-禁用全局搜索插件
busctl --user call com.deepin.dde.Dock /com/deepin/dde/Dock com.deepin.dde.Dock setPluginVisible sb '截图录屏' false  # dock-禁用截图录屏插件

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
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'

#添加VSCode源到source.list.d
wget -q -O - https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

#添加Docker源到source.list.d
wget -q -O - https://mirrors.cloud.tencent.com/docker-ce/linux/debian/gpg | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://mirrors.cloud.tencent.com/docker-ce/linux/debian buster stable" > /etc/apt/sources.list.d/docker.list'

#添加Beyond Compare源到source.list.d
wget -q -O - https://www.scootersoftware.com/RPM-GPG-KEY-scootersoftware | sudo apt-key add -
sudo sh -c 'echo "deb https://www.scootersoftware.com/ bcompare4 non-free" > /etc/apt/sources.list.d/scootersoftware.list'
sudo sh -c 'echo "Package: bcompare\nPin: origin www.scootersoftware.com\nPin-Priority: 600" > /etc/apt/preferences.d/scootersoftware'

#添加nodejs源到source.list.d
wget -q -O - https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
sudo sh -c 'echo "deb https://deb.nodesource.com/node_16.x buster main" > /etc/apt/sources.list.d/nodesource.list'

#添加内测源到source.list.d
sudo sh -c 'echo "deb [trusted=yes] https://proposed-packages.deepin.com/dde-apricot unstable main contrib non-free" > /etc/apt/sources.list.d/deepin-unstable.list'

#添加better-dde源到source.list.d
wget -q -O - https://better-dde.github.io/ppa/better-dde.gpg | sudo apt-key add -
sudo sh -c 'echo "deb https://better-dde.github.io/ppa/ ./" > /etc/apt/sources.list.d/better-dde.list'

#卸载系统自带Flash
sudo apt purge -y libflashplugin-pepper
rm -rf ~/.config/google-chrome/PepperFlash/

#卸载深度帮助手册和深度欢迎两个没用还占地方的东西（会同时卸载dde，貌似没啥问题）
sudo apt purge -y deepin-manual
sudo apt purge -y dde-manual-content
sudo apt purge -y dde-introduction

#卸载自己不需要的软件
sudo apt purge -y deepin-feedback
sudo apt purge -y deepin-app-store
sudo apt purge -y deepin-deepinid-client
sudo apt purge -y deepin-calculator
sudo apt purge -y deepin-draw
sudo apt purge -y deepin-voice-note
sudo apt purge -y deepin-album
sudo apt purge -y deepin-camera
sudo apt purge -y deepin-mail
sudo apt purge -y deepin-screensaver*
sudo apt purge -y deepin-clone
sudo apt purge -y deepin-recovery-plugin
sudo apt purge -y deepin-ab-recovery
sudo apt purge -y deepin-boot-maker
sudo apt purge -y gnome-theme*
sudo apt purge -y libreoffice*
sudo apt purge -y simple-scan
sudo apt purge -y printer-driver-deepin-cloud-print
sudo apt purge -y org.deepin.browser
sudo apt purge -y org.deepin.downloader
sudo apt purge -y deepin-deb-installer
sudo apt purge -y uos-release-note
sudo apt purge -y deepin-forum
sudo apt purge -y fcitx*
sudo apt purge -y nano

#更新20.4后，卸载这个会导致无法右键跳转到设置，酌情卸载
#sudo apt purge -y onboard-common

#这个是用来开关机画面的，我个人喜欢看开机输出文字信息，所以卸载
sudo apt purge -y plymouth*

#这几个是系统自带小游戏（五子棋和连连看）
sudo apt purge -y com.deepin*

#清理一下
sudo apt autoremove -y --purge

#安装软件
sudo apt update && sudo apt dist-upgrade -y
sudo apt install -y curl
sudo apt install -y git
sudo apt install -y console-setup
sudo apt install -y cmake-extras
sudo apt install -y extra-cmake-modules
sudo apt install -y build-essential
sudo apt install -y code
sudo apt install -y google-chrome-stable
sudo apt install -y com.qq.office.deepin
sudo apt install -y com.qq.weixin.deepin
sudo apt install -y com.oray.sunlogin.client
sudo apt install -y cn.wps.wps-office
sudo apt install -y docker-ce
sudo apt install -y fcitx5-chinese-addons
sudo apt install -y fcitx5-material-color
sudo apt install -y fcitx5-pinyin-zhwiki
sudo apt install -y fcitx5-flypy
sudo apt install -y bcompare
sudo apt install -y nodejs
sudo apt install -y remmina

#安装nvidia闭源驱动
sudo apt install -y nvidia-detect
nvidia-detect | awk 'match($0, /nvidia-.*/, a) {print a[0]}' | xargs sudo apt -y install

#安装任务栏显卡驱动切换插件
sudo apt install -y dde-dock-graphics-plugin

#隐藏启动器中 fcitx5配置、键盘布局查看工具
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

#修复安装VSCode后，Win + E 打开的是VSCode
xdg-mime default dde-file-manager.desktop inode/directory

#删除Chrome推荐设置
sudo rm /etc/opt/chrome/policies/recommended/*.json

#fcitx5开机自启动
mkdir -p ~/.config/autostart
sudo cp /usr/share/applications/org.fcitx.Fcitx5.desktop ~/.config/autostart/org.fcitx.Fcitx5.desktop

#fcitx5图标美化
sudo mv /usr/share/icons/bloom/actions/24/input-keyboard-symbolic.svg /usr/share/icons/bloom/actions/24/input-keyboard-symbolic.svg.bak
sudo ln -s /usr/share/icons/bloom/status/20/keyboard-symbolic.svg /usr/share/icons/bloom/status/20/input-keyboard-symbolic.svg

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

#大幅降低微信内存占用（牺牲小程序和公众号，慎用）
rm -rf ~/.deepinwine/Deepin-WeChat/drive_c/users/$(whoami)/Application\ Data/Tencent/WeChat/XPlugin/Plugins/XWeb/
touch ~/.deepinwine/Deepin-WeChat/drive_c/users/$(whoami)/Application\ Data/Tencent/WeChat/XPlugin/Plugins/XWeb
chmod 000 ~/.deepinwine/Deepin-WeChat/drive_c/users/$(whoami)/Application\ Data/Tencent/WeChat/XPlugin/Plugins/XWeb 

#清理一下
sudo apt autoremove -y --purge
