# ?=は再定義可能
DEBUG ?= 1
ENEABLE_WARNINGS ?= 1
WARNINGS_AS_ERRORS ?= 0
INCLUDE_DIR = include
SOURCE_DIR = src
BUILD_DIR = build
CXX = g++
CXX_STANDARD = c++17
CXX_SOURCES = $(wildcard $(SOURCE_DIR)/*.cpp)
# NOTE: patsubstを使うことでソースに対応する実行ファイルに変換できる
CXX_OBJECTS = $(patsubst $(SOURCE_DIR)/%.cpp, $(BUILD_DIR)/%.o, $(CXX_SOURCES)) # $(patsubst $(SRC_DIR)/%.go, $(BUILD_DIR)/, $(GO_SRC)) # $(patsubst match_pattern, after_conversion_pattern, object_to_be_converted) .cppを.oに変換

# ファイル名と同じ名前のmakeコマンドを実行できるようにする。
.PHONY: create build execute clean all

ifeq ($(ENABLE_WARNINGS), 1)
	CXX_WARNINGS = -Wall -Wextra -Wpedantic
else
	CXX_WARNINGS =
endif
ifeq ($(WARNINGS_AS_ERRORS), 1)
	CXX_WARNINGS += -Werror
endif
# -g: デバッグ情報を付加する
# -Wall: 全ての警告を有効にする
# -Wextra: 追加の警告を有効にする
# -Wpedantic: 標準に準拠するコードを書くように警告する
# -Werror: 警告をエラーとして扱う
# -std: バージョンを指定
CXXFLAGS = $(CXX_WARNINGS) -std=$(CXX_STANDARD) -I $(INCLUDE_DIR)# 実行時のオプション
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


# デフォルトタスク
all: create build

create:
	# @をつけることでコマンドを表示しない
	@mkdir -p $(BUILD_DIR)

# オブジェクトファイルから最終的なリンクファイルを作成する
build: $(CXX_OBJECTS) # 実行ファイルが存在しない，もしくはソースが新しくなっている場合にパターンルールが適用される
	$(CXX_COMPILER_CALL) $(CXX_OBJECTS) $(LDFLAGS) -o $(BUILD_DIR)/$(EXECUTABLE_NAME)

# $@: the file name of the target
# $<: the name of the first dependency
# $^: the names of all prerequisites
# パターンルールは対応するオブジェクトファイルを作成する
$(BUILD_DIR)/%.o: $(SOURCE_DIR)/%.cpp
	$(CXX_COMPILER_CALL) -c $< -o $@

execute:
	./$(BUILD_DIR)/$(EXECUTABLE_NAME)

clean:
	rm -fv $(BUILD_DIR)/*.o
	rm -fv $(BUILD_DIR)/$(EXECUTABLE_NAME)

