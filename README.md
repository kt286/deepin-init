# deepin-init
自己用deepin系统初始化脚本

## tips

##### 64位系统编译deepin官方提供的一些lib（不指定的话默认放在/usr/lib/中，系统不认啊。。）
```
mkdir build && cd build && qmake LIB_INSTALL_DIR=/usr/lib/x86_64-linux-gnu .. && make -j4 
```
