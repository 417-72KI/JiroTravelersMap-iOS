init:
	mint bootstrap
	$(MAKE) xcode
	@cp git-hooks/* .git/hooks
xcode:
	mint run yonaskolb/xcodegen xcodegen
	open JiroTravelersMap.xcodeproj