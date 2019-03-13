
ARCHS = armv7 arm64

include $(THEOS)/makefiles/common.mk


TWEAK_NAME = CenteredDate
CenteredDate_FILES = Tweak.xm
CenteredDate_FRAMEWORKS = UIKit CoreGraphics Foundation

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
