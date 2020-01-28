init:
	mint bootstrap
	$(MAKE) xcode
xcode:
	mint run yonaskolb/xcodegen xcodegen
