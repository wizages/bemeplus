GO_EASY_ON_ME = 1

export SDKVERSION=latest
export TARGET = iphone:clang::6.0

include theos/makefiles/common.mk

TWEAK_NAME = Beme
Beme_FILES = Tweak.xm
Beme_FRAMEWORKS = UIKit AVFoundation Foundation
Beme_LIBRARIES = spex
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 beme | exit 0"
