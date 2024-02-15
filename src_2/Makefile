# TARGETS
build:
	# g++ main.cpp -c main.o
	# g++ sub.cpp -c sub.o
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