all: clean build

clean:
	rm -rf build/
	xcodebuild clean

build:
	javac -d iOSCreator/bin/ iOSCreator/src/Creator.java
	java -classpath iOSCreator/bin/ Creator
	xcodebuild build
