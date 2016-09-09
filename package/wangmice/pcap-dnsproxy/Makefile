#
# Copyright (C) 2011-2016 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Partial taken from
# https://github.com/wongsyrone/openwrt-Pcap_DNSProxy/blob/master/Makefile
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pcap-dnsproxy
PKG_VERSION:=0.4.7.0
PKG_RELEASE:=1

PKG_SOURCE_VERSION:=ffbe6780c65763f66a58772465ac2ad02372e9b7
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/chengr28/Pcap_DNSProxy.git
PKG_SOURCE_PROTO:=git

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/pcap-dnsproxy
	SECTION:=net
	CATEGORY:=Network
	DEPENDS:=+libsodium +libpcap +libstdcpp +libpthread
	TITLE:=WinPcap and LibPcap based DNS server
	URL:=$(PKG_SOURCE_URL)
	SUBMENU:=IP Addresses and Names
	MAINTAINER:=Entware team, http://entware.net
endef

define Package/pcap-dnsproxy/description
 Pcap_DNSProxy is a local DNS server based on WinPcap and LibPcap
endef


CMAKE_OPTIONS += \
	-DPLATFORM_OPENWRT=ON \
	-DENABLE_LIBSODIUM=ON \
	-DENABLE_PCAP=ON

TARGET_CFLAGS += \
	-I$(STAGING_DIR)/opt/include

#-I/home/ws/tomato-arm/release/src-rt-6.x.4708/toolchains/hndtools-arm-linux-2.6.36-uclibc-4.5.3/arm-linux/include/c++/4.5.3 \
#	-I/projects/hnd/tools/linux/hndtools-arm-linux-2.6.36-uclibc-4.5.3/usr/include

define Build/Prepare
	$(call Build/Prepare/Default)
	$(SED) 's,^\xEF\xBB\xBF,,g' $(PKG_BUILD_DIR)/Source/ExampleConfig/*
	$(SED) 's,\x0D,,g' $(PKG_BUILD_DIR)/Source/ExampleConfig/*
endef

define Package/pcap-dnsproxy/conffiles
/opt/etc/pcap-dnsproxy/Config.conf
/opt/etc/pcap-dnsproxy/Hosts.conf
/opt/etc/pcap-dnsproxy/IPFilter.conf
/opt/etc/pcap-dnsproxy/Routing.txt
/opt/etc/pcap-dnsproxy/WhiteList.txt
endef

define Package/pcap-dnsproxy/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) \
	    $(PKG_INSTALL_DIR)/opt/sbin/Pcap_DNSProxy \
	    $(1)/opt/sbin
	$(INSTALL_DIR) $(1)/opt/etc/pcap-dnsproxy
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/Source/ExampleConfig/Config.ini \
	    $(1)/opt/etc/pcap-dnsproxy/Config.conf
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/Source/ExampleConfig/Hosts.ini \
	    $(1)/opt/etc/pcap-dnsproxy/Hosts.conf
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/Source/ExampleConfig/IPFilter.ini \
	    $(1)/opt/etc/pcap-dnsproxy/IPFilter.conf
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/Source/ExampleConfig/Routing.txt \
	    $(1)/opt/etc/pcap-dnsproxy/Routing.txt
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/Source/ExampleConfig/WhiteList.txt \
	    $(1)/opt/etc/pcap-dnsproxy/WhiteList.txt
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S54pcap_dnsproxy $(1)/opt/etc/init.d
endef

$(eval $(call BuildPackage,pcap-dnsproxy))
