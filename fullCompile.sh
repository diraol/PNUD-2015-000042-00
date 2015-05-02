#!/bin/bash
#First parameter
# @name of the folder where the tex files are file
if [ $1 ]; then
  FOLDER=$1;
else
  FOLDER='produto';
fi

if [ ! -d "$FOLDER" ]; then
  echo "Diretório não encontrado";
  exit 0;
fi

#Second parameter
# @name of .tex file
if [ $2 ]; then
  NAME=$1;
else
  if [ -f "$FOLDER/$FOLDER.tex" ]; then
    NAME="$FOLDER";
  else
    NAME='produto';
  fi
fi

cd "$FOLDER";

pdflatex -synctex=1 -interaction=nonstopmode $NAME.tex &> /dev/null || { exit 1; }
pdflatex -synctex=1 -interaction=nonstopmode $NAME.tex &> /dev/null || { exit 1; }
bibtex $NAME || { exit 1; }
# Glossary
makeindex  -s "$NAME.ist" -t "$NAME.glg" -o "$NAME.gls" "$NAME.glo" || { exit 1; }
# Acronym List
makeindex  -s "$NAME.ist" -t "$NAME.alg" -o "$NAME.acr" "$NAME.acn" || { exit 1; }
pdflatex -synctex=1 -interaction=nonstopmode $NAME.tex &> /dev/null || { exit 1; }
pdflatex -synctex=1 -interaction=nonstopmode $NAME.tex || { exit 1; }

mv $NAME.pdf ../$FOLDER.pdf
