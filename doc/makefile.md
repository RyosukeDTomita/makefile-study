# Makefile

## Makefile の仕様

- 一番最初に見つかったコマンドを実行する。[src_1](./src_1/Makefile)を参照。

```shell
cat Makefile
build:
	g++ main.cpp -o main
execute:
	./main

make # buildが実行される。
g++ main.cpp -o main

cat Makefile
execute:
	./main
build:
	g++ main.cpp -o main

make
./main # executeが実行される。
Hello, World!
```

- ファイル名をタイトルにすることで，そのファイルが作成されていない時のみコンパイルを実行できる。[./src_2/Makefile](./src_2/Makefile)を参照。

```shell
# TARGETS
build:
	g++ main.o sub.o -o main

main.o: # ファイル名をつけることで、main.oが存在しない場合のみ実行される
	g++ main.cpp -c main.o

sub.o:
	g++ sub.cpp -c sub.o

execute:
	./main
clean:
	rm -f *.o
	rm -f main
```

- Makefile 内で変数が使え，環境変数を実行時に書き換えられる。[./src_3/Makefile](./src_3/Makefile)を参照。

```makefile
CXX_STANDARD = 17
CXXFLAGS = -g -Wall -Wextra -Wpedantic -std=c++$(CXX_STANDARD) # 実行時のオプション

COMPILER_CALL = $(CXX) $(CXXFLAGS)
```

```shell
docker compose run -it make-app make
echo g++ -g -Wall -Wextra -Wpedantic -std=c++17
g++ -g -Wall -Wextra -Wpedantic -std=c++17
g++ -g -Wall -Wextra -Wpedantic -std=c++17  main.o sub.o -o main

docker compose run -it make-app make CXX_STANDARD=11
echo g++ -g -Wall -Wextra -Wpedantic -std=c++11
g++ -g -Wall -Wextra -Wpedantic -std=c++11
g++ -g -Wall -Wextra -Wpedantic -std=c++11  main.o sub.o -o main
```

- Makefile 内で条件文技できる。[./src_4/Makefile](./src_4/Makefile)を参照。

```makefile
# DEBUGが1の場合はデバッグ情報を付加する
ifeq ($(DEBUG), 1)
	CXXFLAGS += -g -O0
else
	CXXFLAGS += -O3
endif
```

- 大量のファイルがある時に備えて中間ファイル(.o)を作成する手順を共通化する。[./src_5/Makefile](./src_5/Makefile)を参照。

```makefile
# $@: the file name of the target
# $<: the name of the first dependency
# $^: the names of all prerequisites
%.o: %.cpp
	$(CXX_COMPILER_CALL) -c $< -o $@
```

- ファイル名が増えてもいいように，Makefile 内でファイル名を自動で取得できるようにする。

```makefile
CXX_SOURCES = $(wildcard $(SOURCE_DIR)/*.cpp)
CXX_OBJECTS = $(patsubst $(SOURCE_DIR)/%.cpp, $(BUILD_DIR)/%.o, $(CXX_SOURCES)) # %.cppを%.oに変換する
```

- PHONY を使って，ファイル名と同じ名前のコマンドを実行できるようにする。

```makefile
all: create build
```

- all ターゲットはいつでも実行される

```makefile
.PHONY: create build execute clean all
```

- @をつけたコマンドは出力されなくなる。

```makefile
create:
	@mkdir -p $(BUILD_DIR)
```

- それぞれのコマンドは別々のシェルで実行される。

```makefile
create:
	cd build
	mkdir hoge # build/hogeではなくhogeが作成される
```

- ?=を使って再定義可能な変数を作成できる。

```makefile
CXX ?= g++
```

- ビルドの依存関係を書く。

```makefile
build: create $(CXX_OBJECTS) # buildの前にcreateとCXX_OBJECTSが実行される
```
