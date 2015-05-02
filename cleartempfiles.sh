#!/bin/bash
#First parameter
# @name of the folder where the tex files are file
if [ $1 ]; then
  FOLDER=$1;
else
  echo "Diretório não encontrado";
  exit 0;
fi

if [ ! -d "$FOLDER" ]; then
  echo "Diretório não encontrado";
  exit 0;
fi

cd "$FOLDER";

find -name "*-eps-converted-to.pdf" -exec rm {} \;
find -name "*.acn" -exec rm {} \;
find -name "*.acr" -exec rm {} \;
find -name "*.alg" -exec rm {} \;
find -name "*.aux" -exec rm {} \;
find -name "*.bak" -exec rm {} \;
find -name "*.bbl" -exec rm {} \;
find -name "*.blg" -exec rm {} \;
find -name "*.brf" -exec rm {} \;
find -name "*.glg" -exec rm {} \;
find -name "*.glo" -exec rm {} \;
find -name "*.gls" -exec rm {} \;
find -name "*.glsdefs" -exec rm {} \;
find -name "*.idx" -exec rm {} \;
find -name "*.ilg" -exec rm {} \;
find -name "*.ind" -exec rm {} \;
find -name "*.ist" -exec rm {} \;
find -name "*.lof" -exec rm {} \;
find -name "*.log" -exec rm {} \;
find -name "*.lol" -exec rm {} \;
find -name "*.lot" -exec rm {} \;
find -name "*.mw" -exec rm {} \;
find -name "*.synctex.gz" -exec rm {} \;
find -name "*.toc" -exec rm {} \;
find -name "*.xdy" -exec rm {} \;
