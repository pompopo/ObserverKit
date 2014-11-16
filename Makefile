PROJECT = ObserverKitDemo/ObserverKitDemo.xcodeproj
TEST_TARGET = ObserverKitDemo

clean:
	xcodebuild \
	    -project $(PROJECT) \
	    clean

test:
	xcodebuild -project $(PROJECT)\
	    -scheme $(TEST_TARGET) \
	    -destination 'platform=iOS Simulator,name=iPhone 6,OS=8.1' \
	    test

