CC = clang
CXX = clang++
CFLAGS = -std=c23 -Wall -Wextra -pedantic
CXXFLAGS = -std=c++23 -Wall -Wextra -pedantic

compile:
	$(CC) $(CFLAGS) main.c && ./a.exe && rm -rf a.exe
compileX:
	$(CXX) $(CXXFLAGS) main.cpp && ./a.exe && rm -rf a.exe
