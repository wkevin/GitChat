#!/bin/bash

function help(){
    echo "build-html [-c]"
    echo "-c: clean"
}

while getopts "c" arg
do
        case $arg in
             c)
			 	find . -path "./assets/*" -prune -o -path ".git/*" -prune -o -path "*/reveal.js/*" -prune -o -name "*.html" -print  -exec rm {} \;
                ;;
             ?)
				help
				exit 1;;
        esac
done

echo "========== building html"
find . -path "*/assets/*" -prune -o -path "*/reveal.js/*" -prune -o -name "*.md" -print| \
awk -F "/" -v base=$PWD '{
	print "---"$0;
	print $NF;
	p=$0; gsub($NF,"",p)
	fb=$NF; split(fb,fs,"."); ft="."fs[length(fs)]; gsub(ft"$","",fb);
	print "filepath:" p
	print "filebase:" fb
	print "fileType:" ft;
	l=""; for(i=2;i<NF;i++){l=l"../"};

	cmd="cd "p" && pandoc  -F "base"/assets/plantuml.py --standalone -f markdown+smart+hard_line_breaks  --highlight-style=zenburn"
	if (fb ~ /[Ss]lide/) {
		cmd=cmd" --css="l"assets/css/slides.css  -V relevatep="l" -t revealjs --template "base"/assets/revealjs.template --slide-level 3 --variable=theme:league --variable=center:true"
	}else{
		cmd=cmd" --css="l"assets/css/md2html.css -V relevatep="l" -t html     --template "base"/assets/toc.template      --toc --toc-depth=4"
	}
	cmd=cmd" --metadata pagetitle="fb" -o "fb".html "$NF
	print cmd
	system(cmd)
}'
