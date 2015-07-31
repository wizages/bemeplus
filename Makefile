
include theos/makefiles/common.mk

TWEAK_NAME = Beme
Beme_FILES = Tweak.xm
Beme_FRAMEWORKS = UIKit AVFoundation Foundation
Beme_LIBRARIES = GPAC4iOS TS2MP4
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 beme"
