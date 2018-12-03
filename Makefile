export THEOS_DEVICE_IP=192.168.178.39
export THEOS_DEVICE_PORT=22
export SDKROOT=iphoneos
export SYSROOT=$(THEOS)/sdks/iPhoneOS11.2.sdk
export PACKAGE_VERSION=0.0.2

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = FolderBlur
FolderBlur_FILES = Tweak.xm
FolderBlur_ARCHS = arm64
FolderBlur_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
