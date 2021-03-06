# Makefile
TARGET 	= wxhttpclient
OBJECTS = main.o wxhttpclientframe.o

# Mac用の設定
WXCONFIG 	:= wx-config
OUTPUTPATH	= .
PROGRAM		= wxHttpClient
PROGVER		= 1.0
# 適当なアイコンを同じフォルダに用意してあげてください
ICONFILE	= wxmac.icns

# Info.plist用の設定
COMPANY			= Oyatsu
BUNDLEPACKAGE	= APPL
BUNDLESIGNATURE	= ????

# application bundle用の設定
BUNDLE		= $(OUTPUTPATH)/$(PROGRAM).app
MACICON		= $(BUNDLE)/Contents/$(ICONFILE)
MACPKGINFO	= $(BUNDLE)/Contents/PkgInfo
MACINFOPLIST	= $(BUNDLE)/Contents/Info.plist 

# 基本コマンド
RM 		:= rm
CXX 		:= g++
CC 		:= g++

# デバッグ時とリリース時の微調整
CXX_DEBUG_FLAGS		=	-g -O0
CXX_RELEASE_FLAGS	=	-s -O2

# 基本オプション
CPPFLAGS = -Wall -I/usr/include -I include `wx-config --inplace --cxxflags`
LDFLAGS  = -L/usr/lib `wx-config --inplace --libs`
VPATH	 = include src

# make
# debug
.PHONY	: Debug
Debug 	: CXXFLAGS+=$(CXX_DEBUG_FLAGS)
Debug 	: all
# release
.PHONY	: Release
Release	: CXXFLAGS+=$(CXX_RELEASE_FLAGS)
Release	: all

# Bundleその他の生成方法を書く
#  This builds the bundle's directory structure.
$(BUNDLE):$(OBJECTS)
	@echo "==== Building bundle directory structure ===="
	mkdir -p $(OUTPUTPATH)
	mkdir -p $(BUNDLE)/Contents
	mkdir -p $(BUNDLE)/Contents/MacOS
	mkdir -p $(BUNDLE)/Contents/Resources

#  This builds the executable right inside the bundle.
$(BUNDLE)/Contents/MacOS/$(PROGRAM): $(OBJECTS)
	@echo "==== Building executable ===="
	$(CXX) -o $(BUNDLE)/Contents/MacOS/$(PROGRAM) $(OBJECTS) $(LDFLAGS)

#  This copies the icon file into the bundle.
$(MACICON): $(ICONFILE)
	@echo "==== Copying icon file into bundle ===="
	cp -f $(ICONFILE) $(BUNDLE)/Contents/Resources/$(ICONFILE)

#  This creates the Contents/PkgInfo file.
$(MACPKGINFO):
	@echo "==== Creating PkgInfo ===="
	touch $(MACPKGINFO)
	@echo -n "$(BUNDLEPACKAGE)$(BUNDLESIGNATURE)" > $(MACPKGINFO)

#  This creates the Contents/Info.plist file.
$(MACINFOPLIST):
	@echo "==== Creating Info.plist ===="
	touch $(MACINFOPLIST)
	@echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" >> $(MACINFOPLIST)
	@echo -n "<!DOCTYPE plist PUBLIC " >> $(MACINFOPLIST)
	@echo -n "\"-//Apple Computer//DTD PLIST 1.0//EN\" " >> $(MACINFOPLIST)
	@echo "\"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">" >> $(MACINFOPLIST)
	@echo "<plist version=\"1.0\">" >> $(MACINFOPLIST)
	@echo "<dict>" >> $(MACINFOPLIST)
	@echo "   <key>CFBundleDevelopmentRegion</key>" >> $(MACINFOPLIST)
	@echo "   <string>English</string>" >> $(MACINFOPLIST)
	@echo "   <key>CFBundleExecutable</key>" >> $(MACINFOPLIST)
	@echo "   <string>$(PROGRAM)</string>" >> $(MACINFOPLIST)
	@echo "   <key>CFBundleIconFile</key>" >> $(MACINFOPLIST)
	@echo "   <string>$(ICONFILE)</string>" >> $(MACINFOPLIST)
	@echo "   <key>CFBundleName</key>" >> $(MACINFOPLIST)
	@echo "   <string>$(PROGRAM)</string>" >> $(MACINFOPLIST)
	@echo "   <key>CFBundleIdentifier</key>" >> $(MACINFOPLIST)
	@echo "   <string>com.$(COMPANY).$(PROGRAM)</string>" >> $(MACINFOPLIST)
	@echo "   <key>CFBundleInfoDictionaryVersion</key>" >> $(MACINFOPLIST)
	@echo "   <string>6.0</string>" >> $(MACINFOPLIST)
	@echo "   <key>CFBundlePackageType</key>" >> $(MACINFOPLIST)
	@echo "   <string>$(BUNDLEPACKAGE)</string>" >> $(MACINFOPLIST)
	@echo "   <key>CFBundleSignature</key>" >> $(MACINFOPLIST)
	@echo "   <string>$(BUNDLESIGNATURE)</string>" >> $(MACINFOPLIST)
	@echo "   <key>CFBundleVersion</key>" >> $(MACINFOPLIST)
	@echo "   <string>$(PROGVER)</string>" >> $(MACINFOPLIST)
	@echo "   <key>CFBundleShortVersionString</key>" >> $(MACINFOPLIST)
	@echo "   <string>$(PROGVER)</string>" >> $(MACINFOPLIST)
	@echo "   <key>CFBundleGetInfoString</key>" >> $(MACINFOPLIST)
	@echo "   <string>$(PROGRAM), Version $(PROGVER), $(COMPANY)</string>" >> $(MACINFOPLIST)
	@echo "</dict>" >> $(MACINFOPLIST)
	@echo "</plist>" >> $(MACINFOPLIST)

all : $(BUNDLE) $(BUNDLE)/Contents/MacOS/$(PROGRAM) $(MACICON) $(MACPKGINFO) $(MACINFOPLIST)

$(PROGRAM) : $(OBJECTS)
		$(CXX) $^ -o $@ $(LDFLAGS)
wxhttpclientframe.o : wxhttpclientframe.cpp wxhttpclientframe.hpp
		$(CXX) -c $< $(CPPFLAGS)
main.o : main.cpp main.hpp wxhttpclientframe.hpp
		$(CXX) -c $< $(CPPFLAGS)

# make clean
.PHONY: clean
clean:
	rm -f *.o $(TARGET)
