:: batch file to compile the thesis
:: you'll need to change the variable 'STR' (line 4) if you change the name of 'masterThesis.tex'.

SET STR=thesis

:: compile the thesis
pdflatex %STR%
biber %STR%
pdflatex %STR%
pdflatex %STR%


:: clean up auxiliary files
del %STR%.aux
del %STR%.bcf
del %STR%.aux
del %STR%.log
del %STR%.out
del %STR%.run.xml
del %STR%.bbl
del %STR%.blg
del %STR%.toc
del %STR%.synctex
