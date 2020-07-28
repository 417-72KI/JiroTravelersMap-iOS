init:
	mint bootstrap
	$(MAKE) xcode
	@cp git-hooks/* .git/hooks
xcode:
	mint run yonaskolb/xcodegen xcodegen
	open JiroTravelersMap.xcodeproj
license:
	mint run LicensePlist license-plist --output-path JiroTravelersMap/Resources/Settings.bundle --add-version-numbers --suppress-opening-directory
lint:
	mint run swiftlint
autocorrect:
	mint run swiftlint swiftlint autocorrect

clean:
	git clean -Xfn
