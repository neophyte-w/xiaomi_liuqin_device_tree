#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/liuqin

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

# A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    vendor \
    odm \
    system \
    product \
    system_ext
BOARD_USES_RECOVERY_AS_BOOT := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 := 
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := kryo300

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a75

# APEX
DEXPREOPT_GENERATE_APEX_IMAGE := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := taro
TARGET_NO_BOOTLOADER := true

# Kernel
BOARD_BOOTIMG_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_KERNEL_IMAGE_NAME := Image
TARGET_KERNEL_CONFIG := liuqin_defconfig
TARGET_KERNEL_SOURCE := kernel/xiaomi/liuqin

# Kernel - prebuilt
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
endif

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 104857600
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 104857600
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor
BOARD_SUPER_PARTITION_SIZE := 9126805504 # TODO: Fix hardcoded value
BOARD_SUPER_PARTITION_GROUPS := xiaomi_dynamic_partitions
BOARD_XIAOMI_DYNAMIC_PARTITIONS_PARTITION_LIST := system system system_ext system_ext product product vendor vendor odm odm mi_ext mi_ext
BOARD_XIAOMI_DYNAMIC_PARTITIONS_SIZE := 9122611200 # TODO: Fix hardcoded value

# Platform
TARGET_BOARD_PLATFORM := taro

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Security patch level
VENDOR_SECURITY_PATCH := 2021-08-01

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# Hack: prevent anti rollback
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION := 16.1.0

# TWRP Configuration
TW_THEME := portrait_hdpi
TW_SCREEN_BLANK_ON_BOOT := true
TW_INCLUDE_REPACKTOOLS := true
ifeq ($(TW_DEVICE_VERSION),)
TW_DEVICE_VERSION=14.0
endif
TW_EXTRA_LANGUAGES := true     #  添加更多国家的语言(包括亚洲语言)
ifeq ($(TW_DEFAULT_LANGUAGE),)
TW_DEFAULT_LANGUAGE := zh_CN     #  设置默认语言为简体中文
endif
BOARD_HAS_NO_REAL_SDCARD:= true    #  禁用sdcard分区之类的东西,如果TWRP不适合于您的Recovery分区,可能会节省一些空间。
TW_NO_BATT_PERCENT:= true     #  在不支持电池信息的设备上禁用电池百分比显示
TW_CUSTOM_POWER_BUTTON:= 107     #  自定义锁屏键所对应的设备按键
#RECOVERY_TOUCHSCREEN_SWAP_XY:= true    #  在X轴和Y轴之间交换触摸映射
TW_MAX_BRIGHTNESS := 255 # 设置最高亮度
TW_DEFAULT_BRIGHTNESS := 155 # 设置默认亮度
TW_IGNORE_MISC_WIPE_DATA := true # 是否在清除 data 时忽略 misc(来自fastboot,系统等的命令)
TW_INCLUDE_CRYPTO := true #是否添加解密支持
TW_INCLUDE_CRYPTO_FBE := true#是否添加解密支持[FBE]
BOARD_USES_METADATA_PARTITION := true #元加密分区
TW_INCLUDE_FBE_METADATA_DECRYPT := true #Metadata解密分区
TARGET_CRYPTFS_HW_PATH := vendor/etc/fstab.qcom # 解密所需依赖的源码路径(高通机型)
RECOVERY_SDCARD_ON_DATA := true # 设置内部存储的数据是否在 data 分区
TW_USE_TOOLBOX := true # 是否使用 ToolBox
AB_OTA_UPDATER := true #是否启用AB(A/B)OTA更新
TW_OZIP_DECRYPT_KEY := true #用于解密oZip文件的密钥
TW_HAPTICS_TSPDRV := true #触觉反馈驱动设置
#TW_CUSTOM_CPU_TEMP_PATH := "/sys/class/thermal/thermal_zone27/temp" #soc温度监测
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_INCLUDE_NTFS_3G := true
TARGET_USES_MKE2FS := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TW_NO_SCREEN_BLANK := true
TW_EXCLUDE_APEX := true
TW_HAS_EDL_MODE := false
# Debug
TWRP_INCLUDE_LOGCAT := true # 是否启用 logcat
TARGET_USES_LOGD := true # 是否启用 logcat
# Kernel modules
TW_LOAD_VENDOR_MODULES_EXCLUDE_GKI := true
# THP fix
TW_XIAOMI_TOUCH_PERMISSION_FIX := true
# Theme
TW_STATUS_ICONS_ALIGN := center
# Serialno
TW_USE_SERIALNO_PROPERTY_FOR_DEVICE_ID := true
