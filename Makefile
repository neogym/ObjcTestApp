PROJECT=ObjcTestApp.xcodeproj
SCHEME=ObjcTestApp
TEST_SDK=iphonesimulator
CONFIGURATION_DEBUG=Debug
DESTINATION="platform=iOS Simulator,name=iPhone 6,OS=8.1"
 
# test コマンド - clean, build, XCTest を実行する
test:
	xcodebuild \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-sdk $(TEST_SDK) \
		-configuration $(CONFIGURATION_DEBUG) \
		-destination $(DESTINATION) \
		clean build test
