# CC = gcc
# CFLAGS = -g -Wall -Wextra -Wpedantic -Werror -std=c99
CXX = g++
CXX_STANDARD = 17
# -g: デバッグ情報を付加する
# -Wall: 全ての警告を有効にする
# -Wextra: 追加の警告を有効にする
# -Wpedantic: 標準に準拠するコードを書くように警告する
# -Werror: 警告をエラーとして扱う
# -std: バージョンを指定
CXXFLAGS = -g -Wall -Wextra -Wpedantic -std=c++$(CXX_STANDARD) # 実行時のオプション
LDFLAGS = -lmath # 外部ライブラリmath.hを使えるようにリンクする。

COMPILER_CALL = $(CXX) $(CXXFLAGS)

build:
	echo $(COMPILER_CALL)
	$(COMPILER_CALL) main.o sub.o -o main

main.o: # ファイル名をつけることで、main.oが存在しない場合のみ実行される
	$(COMPILER_CALL) main.cpp -c main.o

sub.o:
	$(COMPILER_CALL) sub.cpp -c sub.o

execute:
	./main
clean:
	rm -f *.o
	rm -f main