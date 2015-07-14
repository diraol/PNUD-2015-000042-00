#!/bin/bash
#First parameter
# @name of the folder where the tex files are file
if [ $1 ]; then
  FOLDER=$1;
  echo "parâmetro de diretório passado: $1";
else
  FOLDER='produto';
  echo 'parâmetro de diretório não passado, assumindo "produto"';
fi
CURDIR="${PWD##*/}"
if [ ! $CURDIR = $FOLDER ]; then
    if [ ! -d "$FOLDER" ]; then
      echo "Diretório não encontrado, saindo do script";
      exit 0;
    fi

    echo "Entrando no diretório $FOLDER"
    cd "$FOLDER";
fi

#Second parameter
# @name of .tex file
if [ $2 ]; then
  NAME=$2;
  echo "parâmetro nome do arquivo tex encontrado: $2";
else
  echo 'parâmetro do nome do arquivo tex não encontrado';
  if [ -f "$FOLDER.tex" ]; then
    echo 'arquivo tex com mesmo nome do diretório encontrado';
    NAME="$FOLDER";
  else
    echo 'arquivo tex com nome do diretório não encontrado, assumindo "produto.tex"';
    NAME='produto';
  fi
fi

echo "Iniciando a compilação de $NAME.tex"

echo "Primeira iteração do pdflatex"
pdflatex -synctex=1 -interaction=nonstopmode $NAME.tex || { exit 1; }
echo "Segunda iteração do pdflatex"
pdflatex -sync tex=1 -interaction=nonstopmode $NAME.tex &> /dev/null || { exit 1; }
echo "Rodando o bibtex"
bibtex $NAME &> /dev/null || { exit 1; }
# Glossary
echo "Rodando o makeindex para o Glossário"
makeindex  -s "$NAME.ist" -t "$NAME.glg" -o "$NAME.gls" "$NAME.glo" &> /dev/null || { exit 1; }
# Acronym List
echo "Rodando o makeindex para a lista de Acrônimos"
makeindex  -s "$NAME.ist" -t "$NAME.alg" -o "$NAME.acr" "$NAME.acn" &> /dev/null || { exit 1; }
echo "Terceira iteração do pdflatex"
pdflatex -synctex=1 -interaction=nonstopmode $NAME.tex &> /dev/null || { exit 1; }
echo "Quarta iteração do pdflatex"
pdflatex -synctex=1 -interaction=nonstopmode $NAME.tex &> /dev/null || { exit 1; }

echo "Movendo o PDF para o 'diretório pai' de produtos do projeto"
mv $NAME.pdf ../$FOLDER.pdf
