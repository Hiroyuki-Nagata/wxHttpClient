# Makefile
TARGET 	= wxHttpClient.exe
OBJECTS = Main.o WxHttpClientFrame.o

# 基本コマンド
RM 		:= rm
CXX 	:= g++
CC 		:= g++

# デバッグ時とリリース時の微調整
CXX_DEBUG_FLAGS		=	-g -O0
CXX_RELEASE_FLAGS	=	-s -O2

# 基本オプション
CPPFLAGS = -Wall -I/c/MinGW/include -I include `wx-config --cxxflags`
LDFLAGS  = -L/c/MinGW/lib `wx-config --libs` -static
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

all : $(TARGET)
$(TARGET) : $(OBJECTS)
		$(CXX) $^ -o $@ $(LDFLAGS)
WxHttpClientFrame.o : WxHttpClientFrame.cpp WxHttpClientFrame.h
		$(CXX) -c $< $(CPPFLAGS)
Main.o : Main.cpp Main.h WxHttpClientFrame.h
		$(CXX) -c $< $(CPPFLAGS)

# make clean
.PHONY: clean
clean:
	rm -f *.o