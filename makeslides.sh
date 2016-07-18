#!/bin/bash 

param=" -f markdown+simple_tables -t revealjs --standalone --variable=theme:night --highlight-style=zenburn --variable=css:default.css --variable=mouseWheel:true"

if [ $# -eq 0 ]
then
    find . -name "[Ss]lides*.md"|sed -e 's/\.md//'|xargs -i pandoc $param {}.md -o {}.html 
else
    until [ $# -eq 0 ]
    do 
        pandoc $param $1 -o ${1%%.md}.html
        shift
    done
fi

echo Transform Finish
