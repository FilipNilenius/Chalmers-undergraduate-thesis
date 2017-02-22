#!/bin/sh

# shell script to compile the thesis on Mac OS X
# just double click the file to execute
# you'll need to change the variable 'STR' (line 11) if you change the name of 'masterThesis.tex'.

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR

STR=thesis

# compile the thesis
pdflatex $STR
biber $STR
pdflatex $STR
pdflatex $STR


# clean up auxiliary files
rm $STR.aux
rm $STR.bcf
rm $STR.aux
rm $STR.log
rm $STR.out
rm $STR.run.xml
rm $STR.bbl
rm $STR.blg
rm $STR.toc
rm $STR.synctex
