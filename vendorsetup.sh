#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

add_lunch_combo omni_liuqin-user
add_lunch_combo omni_liuqin-userdebug
add_lunch_combo omni_liuqin-eng

export ALLOW_MISSING_DEPENDENCIES=true

FDEVICE="liuqin"
#set -o xtrace

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
   if [ -n "$chkdev" ]; then 
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
    export TARGET_ARCH=arm64 #您的设备是32位还是64位,将其设置为“arm”或“arm64”
    export OF_AB_DEVICE=1 #设备是否为A/B设备,设备是A/B设备设置为1(确保它确实是) - 如果启用此选项,将自动设置以下所有选项为"1": OF_USE_MAGISKBOOT OF_USE_MAGISKBOOT_FOR_ALL_PATCHES - 默认 = 0
    export FOX_REPLACE_BUSYBOX_PS=1 #设置为1以替换(精简版)busybox版本的“ps”命令 - 如果定义了此选项,busybox的“ps”命令将被更完整的(arm64)版本替换 - 默认 = 0 - 此选项不应为arm32设备启用
    export FOX_REPLACE_TOOLBOX_GETPROP=1 # 设置为1以替换(精简版)toolbox版本的“getprop”命令 - 如果定义了此选项,toolbox的“getprop”命令将被更完整的版本(resetprop)替换 - 默认 = 0
    export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system" #系统分区位于默认位置“/dev/block/bootdevice/by-name/system”之外时才设置此选项
    export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor" #系统分区位于默认位置“/dev/block/bootdevice/by-name/vendor”之外时才设置此选项
    export FOX_RECOVERY_SYSTEM_EXT_PARTITION="/dev/block/mapper/system_ext" #系统分区位于默认位置“/dev/block/bootdevice/by-name/system_ext”之外时才设置此选项
    export FOX_RECOVERY_ODM_PARTITION="/dev/block/mapper/odm" #系统分区位于默认位置“/dev/block/bootdevice/by-name/odm”之外时才设置此选项
    export FOX_RECOVERY_PRODUCT_PARTITION="/dev/block/mapper/product" #系统分区位于默认位置“/dev/block/bootdevice/by-name/product”之外时才设置此选项
    export FOX_RECOVERY_MY_STOCK_PARTITION="/dev/block/mapper/my_stock" #系统分区位于默认位置“/dev/block/bootdevice/by-name/my_stock”之外时才设置此选项
    export FOX_RECOVERY_BOOT_PARTITION="/dev/block/bootdevice/by-name/boot"  #系统分区位于默认位置“/dev/block/bootdevice/by-name/boot”之外时才设置此选项
    export OF_DISABLE_MIUI_SPECIFIC_FEATURES=1 #设置任一选项为1以启用stock TWRP兼容模式 - 在此模式下,MIUI OTA和dm-verity/强制加密修补将被禁用 - 默认 = 0
    export OF_USE_MAGISKBOOT=1 #设置为1以使用magiskboot对ROM的boot映像进行修补 - 否则,将使用mkbootimg/unpackbootimg - magiskboot对boot映像的修补效果更好,但速度慢 - 默认 = 0
    export OF_DONT_PATCH_ON_FRESH_INSTALLATION=1 #设置为1以防止在刷入OrangeFox zip时修补dm-verity和强制加密 - 如果ROM启用了dm-verity,并且此选项打开,将会出现启动循环 - 默认 = 0
    export OF_DONT_PATCH_ENCRYPTED_DEVICE=1 #设置为1以避免在加密设备上应用强制加密修补 - 默认 = 0 - 除非默认设置在您的设备上造成问题,否则不应使用此选项
    export OF_SKIP_FBE_DECRYPTION=0 #设置为1以跳过FBE解密例程(防止在Fox标志或Redmi/Mi标志处挂起) - 默认 = 0
    export OF_SKIP_FBE_DECRYPTION_SDKVERSION=34 # 此选项允许您指示OrangeFox避免尝试解密具有特定Android SDK/API级别(及更高)的ROM - 设置为应跳过的Android SDK/API级别。您需要确保提供的值是合理且正确的 - 每当触发跳过代码时,将在日志屏幕上打印警告,并且不会尝试解密分区数据 - 例如:“export OF_SKIP_FBE_DECRYPTION_SDKVERSION=31”(即,不要尝试解密Android 12(SDK/API 31)或更高版本) - 有效的SDK/API级别数字可以在:“https://source.android.com/setup/start/build-numbers”找到 - 注意:如果您正在使用此变量,请勿使用“OF_SKIP_FBE_DECRYPTION”,因为它将取代此变量 - 默认 = 无(即尝试解密所有Android API级别)
    export FOX_DELETE_AROMAFM=1 #设置为1以从zip安装程序中删除AromaFM(对于不工作的设备) - 默认 = 0
    export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1 #设置为1以使用官方TWRP构建系统的工具来构建恢复映像 - 目前推荐设置此选项为1 - 默认 = 0
    export OF_NO_RELOAD_AFTER_DECRYPTION=1 #设置为1以防止OrangeFox在解密后重新运行启动过程 - 默认 = 0
    export OF_OTA_RES_DECRYPT=1 #设置为1以尝试在MIUI OTA恢复期间解密内部存储(而不是因错误退出) - 默认 = 0
    export OF_USE_GREEN_LED=0 #设置为0以移除"绿色LED"设置 - 默认 = 1
    export OF_FLASHLIGHT_ENABLE=1 #是否启用闪光灯功能默认为"1"
    export OF_SCREEN_H=2400 #要计算OF_SCREEN_H,如果您的屏幕宽度不是1080,请使用以下公式:<宽高比高度>*120
    export OF_STATUS_H=106 #使用"export OF_STATUS_H=144"来改变状态栏大小为144,在Android中截屏,并使用任何图形编辑器(例如MSPaint)计算状态栏高度
    export OF_STATUS_INDENT_LEFT=48 #推荐设置为48(当设备有圆角时)
    export OF_STATUS_INDENT_RIGHT=48 #推荐设置为48(当设备有圆角时)
    export OF_ALLOW_DISABLE_NAVBAR=0 #如果设备没有硬件导航按钮,请设置为0
    export OF_DONT_KEEP_LOG_HISTORY=1 #将在/sdcard/Fox/logs/中保存带有时间戳的recovery.log副本(.zip格式)启用此功能以关闭此特性(意味着每次重启恢复时lastrecoverylog.log将被覆盖)
    export TARGET_DEVICE_ALT="liuqin" #如果设备有多个代码名,请使用此选项,以便OrangeFox zip安装器可以支持备用代码名,而不会直接失败
    export OF_SKIP_ORANGEFOX_PROCESS=1 #使用此选项为1以跳过dm-verity/强制加密/boot映像的修补,启用了此选项,则默认也会启用"OF_DONT_PATCH_ON_FRESH_INSTALLATION"
    export OF_SUPPORT_OZIP_DECRYPTION=0 #设置此选项为1以启用对Realme oZip解密的支持,注意:对于搭载Android 10或更高版本发布的realme设备,由于realme已在updater二进制文件中添加了解密器,因此不需要外部解密器。对于升级到Android 10的设备,此功能仅在降级到pie或以下版本时需要。
    export OF_USE_LOCKSCREEN_BUTTON=1 
    export FOX_DRASTIC_SIZE_REDUCTION=1 #这将从构建中移除一些大文件(包括一些字体)；如果在恢复的调试屏幕看到资源错误消息,不必担心
    export FOX_VERSION=a15.0
    export OF_USE_TWRP_SAR_DETECT=1

    # let's see what are our build VARs
    if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
       export | grep "FOX" >> $FOX_BUILD_LOG_FILE
       export | grep "OF_" >> $FOX_BUILD_LOG_FILE
       export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
       export | grep "TW_" >> $FOX_BUILD_LOG_FILE
    fi
fi

