TARGET = :clang
ARCHS = armv7 armv7s arm64

include theos/makefiles/common.mk

TWEAK_NAME = DarkClock
DarkClock_FILES = DarkClock.xm
DarkClock_FRAMEWORKS = UIKit
DarkClock_PRIVATE_FRAMEWORKS = ToneKit

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk