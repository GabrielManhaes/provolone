#!/bin/bash

echo -e "in.txt\n-----\n"
cat in.txt

bison -d extensor.y
flex extensor.l
gcc -o extensor extensor.tab.c lex.yy.c -ll
./extensor in.txt

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
