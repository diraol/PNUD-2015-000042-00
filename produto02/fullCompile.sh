#!/bin/bash
pdflatex -synctex=1 -interaction=nonstopmode produto.tex || { exit 1; }
pdflatex -synctex=1 -interaction=nonstopmode produto.tex || { exit 1; }
bibtex produto || { exit 1; }
# Glossary
makeindex  -s "produto.ist" -t "produto.glg" -o "produto.gls" "produto.glo" || { exit 1; }
# Acronym List
makeindex  -s "produto.ist" -t "produto.alg" -o "produto.acr" "produto.acn" || { exit 1; }
pdflatex -synctex=1 -interaction=nonstopmode produto.tex || { exit 1; }
makeTable
pdflatex -synctex=1 -interaction=nonstopmode produto.tex || { exit 1; }

