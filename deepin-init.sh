#!/bin/bash

#先进到用户下载目录
cd ~/Downloads

#先更新一下
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install wget curl

#关闭开关机logo和不知道干嘛的设置（据说关闭之后会减少卡顿）
gsettings set com.deepin.dde.startdde launch-welcome false
gsettings set com.deepin.dde.startdde swap-sched-enabled false
sudo plymouth-set-default-theme -R details # 修改开机logo为详细信息（个人喜好）

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

#添加第三方wine tim源到source.list.d
wget -q -O - https://yenole.gitee.io/sign.pub | sudo apt-key add -
sudo sh -c 'echo "deb https://yenole.gitee.io stable main" > /etc/apt/sources.list.d/3th-deepinwine-app.list'

#卸载系统自带Flash（Chrome会自动更新的）
sudo apt-get purge libflashplugin-pepper
rm -rf ~/.config/google-chrome/PepperFlash/

#卸载自带QQ（原因不解释，我喜欢TIM）
sudo apt-get purge deepin.com.qq.im

#安装软件
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install google-chrome-stable #Chrome浏览器
sudo apt-get install code #VSCode
sudo apt-get install libappindicator3-1 #Lantern依赖，不安装的话会打不开蓝灯
sudo apt-get install python3.6 #安装Python3.6 系统中会共存2.7 3.5 3.6 通过python3.6 xxx调用
sudo apt-get install qt5-qmake #安装qt5编译工具
sudo apt-get install deepin.com.qq.office #安装TIM
sudo apt-get install deepin.com.wechat.devtools  #微信开发者工具
sudo apt-get install openjdk-8-jdk #安装openjdk8
sudo apt-get install docker-ce #安装docker-ce

#第三方wine APP
sudo apt-get install deepin.apps.com.wechat.devtools  #微信开发者工具
sudo apt-get install deepin.apps.com.wecha  #微信
sudo apt-get install deepin.apps.com.qq.office  #TIM

#安装Lantren
wget -q -O - https://raw.githubusercontent.com/getlantern/lantern-binaries/master/lantern-installer-64-bit.deb | sudo dpkg -i -

#删除Chrome推荐设置
sudo rm /etc/opt/chrome/policies/recommended/*.json

#清理一下
sudo apt-get autoremove --purge



#添加Wine源到source.list.d
#wget -q -O - https://dl.winehq.org/wine-builds/Release.key | sudo apt-key add -
#sudo sh -c 'echo "deb https://dl.winehq.org/wine-builds/debian/ DISTRO main" > /etc/apt/sources.list.d/winehq.list'

#sudo apt-get install winehq-stable #wine deepin自带的那个有点旧

#安装anbox
#wget -q -O - http://ppa.launchpad.net/morphis/anbox-support/ubuntu/pool/main/a/anbox/anbox-common_9_all.deb | sudo dpkg -i -
#wget -q -O - http://ppa.launchpad.net/morphis/anbox-support/ubuntu/pool/main/a/anbox/anbox-modules-dkms_9_all.deb | sudo dpkg -i -
#sudo apt-get install snapd linux-headers-deepin-amd64
#sudo snap install --edge --devmode anbox
#cd /usr/src/anbox-modules-ashmem-9
#ashmem.c
#<<<
#ret = __vfs_read(asma->file, buf, len, pos);
#>>>
#ret = kernel_read(asma->file, buf, len, pos);
#sudo make
#sudo cp ashmem_linux.ko /lib/modules/$(uname -r)/updates/ashmem_linux.ko
#sudo insmod /lib/modules/$(uname -r)/updates/ashmem_linux.ko

