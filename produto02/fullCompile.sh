#!/bin/bash
#First parameter
# @name of .tex file
if [ $1 ]; then 
  NAME=$1; 
else
  NAME='produto';
fi

#Second Parameter
# @name of .bib file
if [ $2 ]; then 
  BIB=$2; 
else
  BIB=$NAME;
fi

pdflatex -synctex=1 -interaction=nonstopmode $NAME.tex || { exit 1; }
pdflatex -synctex=1 -interaction=nonstopmode $NAME.tex || { exit 1; }
bibtex $BIB || { exit 1; }
# Glossary
makeindex  -s "$NAME.ist" -t "$NAME.glg" -o "$NAME.gls" "$NAME.glo" || { exit 1; }
# Acronym List
makeindex  -s "$NAME.ist" -t "$NAME.alg" -o "$NAME.acr" "$NAME.acn" || { exit 1; }
pdflatex -synctex=1 -interaction=nonstopmode $NAME.tex || { exit 1; }
pdflatex -synctex=1 -interaction=nonstopmode $NAME.tex || { exit 1; }

