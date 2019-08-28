#!/bin/bash 

param=" -f markdown+smart -t revealjs --standalone --highlight-style=zenburn -V theme=league -V css=assets/css/slides.css -V mouseWheel=true -V center=true --quiet"

if [ $# -eq 0 ]
then
    find . -name "[Ss]lides*.md"|sed -e 's/\.md//'|xargs -I {} pandoc $param {}.md -o {}.html 
else
    until [ $# -eq 0 ]
    do 
        pandoc $param $1 -o ${1%%.md}.html
        shift
    done
fi

echo Transform Finish
