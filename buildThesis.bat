:: batch file to compile the thesis
:: you'll need to change the variable 'STR' (line 4) if you change the name of 'masterThesis.tex'.

SET STR=thesis

:: compile the thesis
pdflatex %STR%
biber %STR%
makeglossaries %STR%
makeindex %STR%.nlo -s nomencl.ist -o %STR%.nls
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
del %STR%.xdy
del %STR%.ist
del %STR%.glsdefs
del %STR%.gls
del %STR%.glg
del %STR%.alg
del %STR%.acr
del %STR%.acn
del %STR%.nlo
del %STR%.glo
del %STR%.nls
del %STR%.ilg
del %STR%.lot
del %STR%.lof
