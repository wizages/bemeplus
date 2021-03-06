export SDKVERSION=latest
export TARGET = iphone:clang::6.0

# For whatever reason, Sublime Text Absolutely refused to build with the $(THEOS) environment variable
# I hope this work for you still, which it should since you'll most likely have a theos symlink in your
# tweak directory.
include theos/makefiles/common.mk

# armv7s is generally pointless, not even Xcode builds it by default anymore, from what I can recall.
export ARCHS = armv7 arm64

# Include libraries in the local tweak directory, saves copying them to your theos dir.
Beme_LDFLAGS += -L./extras/lib
ADDITIONAL_OBJCFLAGS += -fobjc-arc -I./extras/include

TWEAK_NAME = Beme
Beme_FILES = BMPSettingsManager.m BMPPrivateSettingsViewController.xm BMPSettingsViewController.xm BMPResourceManager.m Tweak.xm upload.xm BMPAlertHandler.m BMPJGProgressHUDCompletionIndicatorView.m 
Beme_FRAMEWORKS = UIKit AVFoundation Foundation CoreGraphics MobileCoreServices CoreMedia
Beme_LIBRARIES = M3U8 JGProgressHUD

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 beme | exit 0"
