# deepin-init
自己用deepin系统初始化脚本

## tips

##### 64位系统编译一些lib指定安装目录（不指定的话默认放在 `/usr/lib/` 中，系统不认） 例如 `dde-qt-dbus-foctory` `dtkwidget`
```
mkdir build && cd build && qmake LIB_INSTALL_DIR=/usr/lib/x86_64-linux-gnu .. && make -j4 && sudo make install
```
##### 某些软件编译的时候指定目录前缀（`/usr`）,例如 `deepin-system-monitor`
```
mkdir build && cd build && qmake PREFIX=/usr .. && make -j4 && sudo make install
```
##### 编译前检查依赖
```
dpkg-checkbuilddeps
```
##### 打成deb包
```
dpkg-buildpackage -r
```
