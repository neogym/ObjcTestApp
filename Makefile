PROJECT=ObjcTestApp.xcodeproj
SCHEME=ObjcTestApp
TEST_SDK=iphonesimulator
CONFIGURATION_DEBUG=Debug
DESTINATION="platform=iOS Simulator,name=iPhone 6,OS=8.1"
 
# test コマンド - clean, build, XCTest を実行する
clean:
	xcodebuild \
		-project $(PROJECT) \
		clean

test:
	xcodebuild \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-sdk $(TEST_SDK) \
		-configuration $(CONFIGURATION_DEBUG) \
		-destination $(DESTINATION) \
		TEST_AFTER_BUILD=YES \
		TEST_HOST=

test-with-coverage:
	xcodebuild \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-sdk $(TEST_SDK) \
		-configuration $(CONFIGURATION_DEBUG) \
		TEST_AFTER_BUILD=YES \
		TEST_HOST= \
		GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES \
		GCC_GENERATE_TEST_COVERAGE_FILES=YES

send-coverage:
	coveralls \
		-e ObjcTestAppTests

