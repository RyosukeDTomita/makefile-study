DEBUG = 1
CXX_STANDARD = c++17
CXX = g++
CXX_WARNINGS = -Wall -Wextra -Wpedantic
# -g: デバッグ情報を付加する
# -Wall: 全ての警告を有効にする
# -Wextra: 追加の警告を有効にする
# -Wpedantic: 標準に準拠するコードを書くように警告する
# -Werror: 警告をエラーとして扱う
# -std: バージョンを指定
CXXFLAGS = $(CXX_WARNINGS) -std=$(CXX_STANDARD) # 実行時のオプション
LDFLAGS = 

# DEBUGが1の場合はデバッグ情報を付加する
ifeq ($(DEBUG), 1)
	CXXFLAGS += -g -O0 # 最適化レベル00にすることで最適化を無効化し，デバックしやすくなる。
	EXECUTABLE_NAME = mainDebug
else
	CXXFLAGS += -O3 # 最適化レベルを03にすることでコードのパフォーマンスをあげるようにコンパイルされる。
	EXECUTABLE_NAME = mainRelease
endif


CXX_COMPILER_CALL = $(CXX) $(CXXFLAGS)
CXX_SOURCES = $(wildcard *.cpp)
CXX_OBJECTS = $(patsubst %.cpp, %.o, $(CXX_SOURCES)) # %.cppを%.oに変換する

build: $(CXX_OBJECTS)
	$(CXX_COMPILER_CALL) $(CXX_OBJECTS) $(LDFLAGS) -o $(EXECUTABLE_NAME)

execute:
	./$(EXECUTABLE_NAME)
clean:
	rm -f *.o
	rm -f $(EXECUTABLE_NAME)

# $@: the file name of the target
# $<: the name of the first dependency
# $^: the names of all prerequisites
%.o: %.cpp
	$(CXX_COMPILER_CALL) -c $< -o $@