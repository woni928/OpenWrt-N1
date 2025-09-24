#!/bin/bash
#

# 修改IP   第一行19.07的路径   第二行23.05的路径
#sed -i 's/192.168.1.1/192.168.123.2/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/192.168.123.2/g' package/base-files/luci2/bin/config_generate

# 修改主机名
#sed -i 's/LEDE/OpenWrt/g' package/base-files/files/bin/config_generate
sed -i 's/LEDE/OpenWrt/g' package/base-files/luci2/bin/config_generate

# 拉取源码
git clone https://github.com/gdy666/luci-app-lucky.git package/lucky
git clone https://github.com/sbwml/luci-app-openlist2 package/openlist
rm -rf package/luci-app-amlogic
git clone https://github.com/ophub/luci-app-amlogic.git package/luci-app-amlogic
rm -rf feeds/packages/net/v2ray-geodata
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata


# passwall官方方法：移除 openwrt feeds 自带的核心库
rm -rf feeds/packages/net/{xray-core,v2ray-geodata,sing-box,chinadns-ng,dns2socks,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-libev,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,trojan-plus,tuic-client,v2ray-plugin,xray-plugin,geoview,shadow-tls}
git clone https://github.com/xiaorouji/openwrt-passwall-packages package/passwall-packages
# 移除 openwrt feeds 过时的luci版本
rm -rf feeds/luci/applications/luci-app-passwall
git clone https://github.com/xiaorouji/openwrt-passwall package/passwall-luci


# 备份科学插件源：移除 openwrt feeds 自带的核心包
#rm -rf feeds/packages/net/{xray-core,v2ray-core,v2ray-geodata,sing-box}
#git clone https://github.com/sbwml/openwrt_helloworld package/helloworld
# 更新 golang 1.25 版本
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 25.x feeds/packages/lang/golang


# 临时修复acpid,aliyundrive-webdav,xfsprogs,perl-html-parser,v2dat 导致的编译失败问题
#sed -i 's#flto#flto -D_LARGEFILE64_SOURCE#g' feeds/packages/utils/acpid/Makefile
#sed -i 's/stripped/release/g' feeds/packages/multimedia/aliyundrive-webdav/Makefile
#sed -i 's#SYNC#SYNC -D_LARGEFILE64_SOURCE#g' feeds/packages/utils/xfsprogs/Makefile
sed -i 's/REENTRANT -D_GNU_SOURCE/LARGEFILE64_SOURCE/g' feeds/packages/lang/perl/perlmod.mk
sed -i 's#GO_PKG_TARGET_VARS.*# #g' feeds/packages/utils/v2dat/Makefile

# 修复v2ray-plugin编译失败
rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang

# 修正俩处错误的翻译
sed -i 's/<%:Up%>/<%:Move up%>/g' feeds/luci/modules/luci-compat/luasrc/view/cbi/tblsection.htm
sed -i 's/<%:Down%>/<%:Move down%>/g' feeds/luci/modules/luci-compat/luasrc/view/cbi/tblsection.htm
