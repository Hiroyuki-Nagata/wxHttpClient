# Makefile
TARGET 	= wxhttpclient
OBJECTS = main.o wxhttpclientframe.o

# 基本コマンド
RM 	:= rm
CXX 	:= g++
CC 	:= g++

# デバッグ時とリリース時の微調整
CXX_DEBUG_FLAGS		=	-g -O0
CXX_RELEASE_FLAGS	=	-s -O2

# 基本オプション
CPPFLAGS = -Wall -I/usr/include -I include `wx-config --cxxflags`
LDFLAGS  = -L/lib `wx-config --libs`
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
wxhttpclientframe.o : wxhttpclientframe.cpp wxhttpclientframe.hpp
		$(CXX) -c $< $(CPPFLAGS)
main.o : main.cpp main.hpp wxhttpclientframe.hpp
		$(CXX) -c $< $(CPPFLAGS)

# make clean
.PHONY: clean
clean:
	rm -f *.o $(TARGET)
