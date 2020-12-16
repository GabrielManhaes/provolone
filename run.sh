#!/bin/bash

echo -e "$1\n-----\n"
cat $1

bison -d extensor.y
flex extensor.l
gcc -o extensor extensor.tab.c lex.yy.c -ll
./extensor $1

echo -e "\nextendido.txt\n-----\n"
cat extendido.txt

bison -d compilador.y
flex compilador.l
gcc -o compilador compilador.tab.c lex.yy.c -ll
./compilador extendido.txt

echo -e "\nout.lua\n-----\n"
cat out.lua

echo -e "\nExecutando out.lua\n-----\n"
lua out.lua
