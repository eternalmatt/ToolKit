all: clean build

CREATOR = iOSCreator
CREATORBIN = $(CREATOR)/bin
CREATORSRC = $(CREATOR)/src

clean:
	rm -rf build/
	xcodebuild clean

build:
	javac -d $(CREATORBIN) $(CREATORSRC)/*.java
	java -classpath $(CREATORBIN) Creator
	xcodebuild build
