# deepin-init
自己用deepin系统初始化脚本

## tips

##### 64位系统编译deepin官方提供的一些lib（不指定的话默认放在 `/usr/lib/` 中，系统不认啊。。） 例如 `dde-qt-dbus-foctory` `dtkwidget`
```
mkdir build && cd build && qmake LIB_INSTALL_DIR=/usr/lib/x86_64-linux-gnu .. && make -j4 
```
##### 某些软件编译的时候指定目录前缀（`/usr`）,例如 `deepin-system-monitor`
```
mkdir build && cd build && qmake PREFIX=/usr .. && make -j4
```
