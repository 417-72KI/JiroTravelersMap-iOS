init:
	mint bootstrap
	$(MAKE) xcode
	@cp git-hooks/* .git/hooks
xcode:
	mint run yonaskolb/xcodegen xcodegen
	open JiroTravelersMap.xcodeproj
lint:
	mint run swiftlint
autocorrect:
	mint run swiftlint swiftlint autocorrect

clean:
	git clean -Xfn
