% Written by  Mikael Öhman <mikael.ohman@chalmers.se> and adapted by Filip Nilenius <filip.nilenius@chalmers.se>

%% Master's thesis class template for Chalmers University of Technology.
%% This document is released under public domain, but the chalmers logo is trademarked.
%% Some words are translated to swedish if babel langauge is set, otherwise default to English

%% User commands
% \topentry{title}{reference}         - Called by \tableofpapers
% \presectiontitle                    - Called by \maketitle

%% Input commands (self-explanatory).
% \author{Authors separated with \and}
% \title{text}
% \titel{text}                        - Optional
% \subtitle{text}
% \undertitel{text}                   - Optional
% \firstabstract{text}
% \secondabstract{language}{text}     - Optional
% \keywords{comma separated keywords}
% \nyckelord{comma separated keywords}- Optional
% \preface{text}                      - Optional
% \acknowledgements{text}             - Optional
% \coverfigure{text}                  - Optional
% \covercaption{text}                 - Optional
% \copyrightyear{text}
% \reportno{text}
% \ISBN{text}
% \department{text}
% \thesisin{text}


%% Predefined commands (do not need to be set)
% \ISSN{text}
% \printers{text}
% \telephone{text}
% \postcode{text}

%% The predefined babel translations;
% \countryname (Swedish, Sverige)
% \telephonename (Telephone, Telefon)
% \universityname (Chalmers University of Technology, Chalmers tekniska h\"ogskola)
% \covername (Cover, Omslag)
% \acknowledgementsname (Acknowledgements, Tacks\"agelse)
% \keywordsname (Keywords, Nyckelord)
% \masterthesisname (Master's Thesis, Examensarbete)
% \bachelorsthesisname (Bachelor's Thesis, Kandidatarbete)
% \licentiatethesisname (Thesis for the degree of Licentiate of Engineering, Licentiatavhandling)
% \doctoratethesisname (Thesis for the degree of Doctor of Philosophy, Doktorsavhandling)
% \inname (in the Master’s Programme, i)
% \papername (Paper, Artikel)

%% Other
% \presectiontitle{text} - Used for printing titles in the frontmatter
% \presectiontitlestyle{text} - Can be redefined to change the style of the front matter

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{undergraduate-thesis}[2011/04/21 CHALMERS Thesis class]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Macro for checking all required commands are set.
\newcommand{\@checkifdefined}[1]{%
  \@ifundefined{@#1}{\ClassError{master-thesis}{User input `#1` undefined.}{Use the \textbackslash #1{} command to set it.}}{}%
}

% Conditionals
\newif\if@bachelors
\newif\if@masters

\@bachelorsfalse
\@mastersfalse


%% Options of class
% bachelors, masters
\DeclareOption{bachelors}{\global\@bachelorstrue
	\global\@mastersfalse}
\DeclareOption{masters}{\global\@masterstrue
	\global\@bachelorsfalse}
\ProcessOptions

\LoadClass[twoside,12pt]{report}

% Set up with the required packages
\RequirePackage{etoolbox}
\RequirePackage{textcase}
\RequirePackage{titlesec}
\RequirePackage{emptypage}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{microtype}
\RequirePackage{titlesec}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{stix}
\RequirePackage{wrapfig}
\RequirePackage{fancyhdr}
\RequirePackage[titletoc]{appendix}
\RequirePackage[top=0.1\paperheight, bottom=0.1\paperheight, left=0.1\paperwidth, right=0.1\paperwidth]{geometry}

% Makes the chapters act like a big section
%Chapter breytt ur \huge i \large
\RequirePackage{titlesec}
\titleclass{\chapter}{straight}
\newcommand{\chapterbreak}{}
\titleformat{\chapter}[hang]{\bfseries\large}{\thechapter\quad}{0em}{}
\titlespacing*{\chapter}{0pt}{3.5ex plus 1ex minus .2ex}{2.3ex plus .2ex}

% section font size
\titleformat*{\chapter}{\LARGE\bfseries}
\titleformat*{\section}{\Large\bfseries}
\titleformat*{\subsection}{\normalsize\bfseries}

% Parts should start a new right side page;
\titleclass{\part}{straight}
\newcommand{\partbreak}{\cleardoublepage}
\titleformat{\part}[display]{\bfseries\huge\centering}{\LARGE\partname\ \thepart}{0em}{}
\titlespacing*{\part}{0pt}{3.5ex plus 1ex minus .2ex}{2.3ex plus .2ex}

% Adjustments of floats and equations.
\setlength{\intextsep}{12pt}
\setlength{\abovedisplayskip}{6pt}
\setlength{\belowdisplayskip}{6pt}
\setlength{\parindent}{5mm}
\setlength{\abovecaptionskip}{6pt}
\setlength{\belowcaptionskip}{0pt} % Actual skip = \textfloatsep + \belowcaptionskip
\setlength{\itemsep}{0pt}

% Dynamic setup for user loaded packages.
\AtEndPreamble{
 % Check for babel and add more translations
 \@ifpackageloaded{babel}{
  \addto\captionsswedish{%
   \def\countryname{Sverige}%
   \def\cityname{G\"oteborg}%
   \def\telephonename{Telefon}%
   \def\universityname{Chalmers tekniska h\"ogskola}%
   \def\covername{Omslag}%
   \def\colophonname{Kolofon}%
   \def\acknowledgementsname{Tacks\"agelse}%
   \def\keywordsname{Nyckelord}%
   \def\masterthesisname{Examensarbete}%
   \def\bachelorsthesisname{Kandidatarbete}%
   \def\inname{inom}%
  }
 
  \addto\captionsenglish{%
   \def\countryname{Sweden}%
   \def\cityname{Gothenburg}%
   \def\telephonename{Telephone}%
   \def\universityname{Chalmers University of Technology}%
   \def\covername{Cover}%
   \def\colophonname{Colophon}%
   \def\acknowledgementsname{Acknowledgements}%
   \def\keywordsname{Keywords}%
   \def\masterthesisname{Master's thesis}%
   \def\bachelorsthesisname{Bachelor's thesis}%
   \def\inname{in}%
  }
 }{\ClassError{master-thesis}{Package 'babel' required}{}}
 
 % Document metadata setup
 \@ifpackageloaded{hyperref}{
  \@checkifdefined{author}
  \@checkifdefined{title}
  \@checkifdefined{keywords}
  \renewcommand{\and}{, }
  \hypersetup{
    breaklinks,
    bookmarksopen = true,
	bookmarksopenlevel=0,
    pdfauthor     = \@author,
    pdftitle      = \@title,
    pdfkeywords   = \@keywords,
    colorlinks    = true,
    urlcolor      = black,
    citecolor     = black,
    linkcolor     = black,
    filecolor     = black,
	pdfstartview  = FitH,
  }
 }{\ClassWarning{chalmers-thesis}{Package 'hyperref' required}{}}
}

% Needs to be at the end since its language dependent.
\AtEndDocument{
  \hypersetup{
   pdfsubject = \thesisname
  }
}

% User preamble commands
\renewcommand{\author}[1]{\gdef\@author{#1}}
\renewcommand{\title}[1]{\gdef\@title{#1}}
\newcommand{\subtitle}[1]{\gdef\@subtitle{#1}} % Optional
\newcommand{\firstabstract}[1]{\gdef\@firstabstract{#1}} 
\newcommand{\keywords}[1]{\gdef\@keywords{#1}}
\newcommand{\preface}[1]{\gdef\@preface{#1}} % Optional
\newcommand{\acknowledgements}[1]{\gdef\@acknowledgements{#1}} % Optional
\newcommand{\dedication}[1]{\gdef\@dedication{#1}} % Optional
\newcommand{\coverfigure}[1]{\gdef\@coverfigure{#1}}
\newcommand{\covercaption}[1]{\gdef\@covercaption{#1}}
\newcommand{\colophon}[1]{\gdef\@colophon{#1}} % optional
\newcommand{\copyrightyear}[1]{\gdef\@copyrightyear{#1}}
\newcommand{\reportno}[1]{\gdef\@reportno{#1}}
\newcommand{\ISBN}[1]{\gdef\@ISBN{#1}}
\newcommand{\department}[1]{\gdef\@department{#1}}
\newcommand{\division}[1]{\gdef\@division{#1}}
\newcommand{\researchgroup}[1]{\gdef\@researchgroup{#1}}
\newcommand{\thesisin}[1]{\gdef\@thesisin{#1}}


% second languange
\newcommand{\secondarylanguage}[1]{\gdef\@secondarylanguage{#1}}
\newcommand{\titlesecondlang}[1]{\gdef\@titlesecondlang{#1}}
\newcommand{\subtitlesecondlang}[1]{\gdef\@subtitlesecondlang{#1}} % Optional
\newcommand{\abstractsecondlang}[1]{\gdef\@abstractsecondlang{#1}} % Optional
\newcommand{\keywordssecondlang}[1]{\gdef\@keywordssecondlang{#1}}
\newcommand{\departmentsecondlang}[1]{\gdef\@departmentsecondlang{#1}}
\newcommand{\thesisinsecondlang}[1]{\gdef\@thesisinsecondlang{#1}}
\newcommand{\divisionsecondlang}[1]{\gdef\@divisionsecondlang{#1}}
\newcommand{\researchgroupsecondlang}[1]{\gdef\@researchgroupsecondlang{#1}}


\newcommand{\extrafrontmatter}[1]{\gdef\@extrafrontmatter{#1}}

% User commands which shouldn't need to be set.
\newcommand{\ISSN}[1]{\gdef\@ISSN{#1}}
\newcommand{\printers}[1]{\gdef\@printers{#1}}
\newcommand{\telephone}[1]{\gdef\@telephone{#1}}
\newcommand{\postcode}[1]{\gdef\@postcode{#1}}

% Some default settings for Chalmers
\postcode{SE-412 96}
\printers{Chalmers Reproservice}
\telephone{+46 (0)31-772 1000}

% Thesis specific settings
\if@bachelors
\ISSN{1654-4676}
\def\thesisname{\bachelorsthesisname}
\PassOptionsToPackage{english,swedish}{babel}
\newcommand{\refsectitle}{Litteraturförteckning}
\newcommand{\acronymtitle}{Akronymer}
\fi

\if@masters
\ISSN{1652-8557}
\def\thesisname{\masterthesisname}
\PassOptionsToPackage{swedish,english}{babel}
\newcommand{\refsectitle}{References}
\newcommand{\acronymtitle}{Acronyms}
\fi

\def\titlepage@edge{draw}
\def\titlepage@chalmerscolor{black}
\def\titlepage@bg{}
\def\titlepage@logotype{Avancez_white}
\def\@reportseries{\thesisname}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Renew the table of contents title to fit the rest of the frontmatter
\renewcommand{\tableofcontents}{
 \presectiontitle{\contentsname}
 \vskip 1em
 \@starttoc{toc}
 \vskip 1em
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Command for the titles.
\newcommand{\presectiontitlestyle}[1]{\begin{center}\Large\textsc{#1}\raggedright\end{center}}
\newcommand{\presectiontitle}[1]{
  \phantomsection\addcontentsline{toc}{chapter}{#1}
  \presectiontitlestyle{#1}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% All the front pages;

% Introducing some new lengths for the front page
\newlength{\headerheight}
\newlength{\headeroffset}
\setlength{\headerheight}{0.215\paperheight}%~6.4cm in a4
\setlength{\headeroffset}{0.125\headerheight}%~0.8cm in a4

\AtEndPreamble{
\@ifpackageloaded{tikz}{
\newcommand{\makecoverpage}{
 \pagestyle{empty}
 {
 \fontfamily{phv}\selectfont
 \begin{tikzpicture}[remember picture,overlay]
  \node[yshift=-\headerheight] at (current page.north west)
   {\begin{tikzpicture}[remember picture, overlay]
     %\clip[\titlepage@edge] (0,\headerheight) -- +(\paperwidth,0) -- (\paperwidth,0) -- (0.75\paperwidth,0) .. controls (0.725\paperwidth,0) and (0.725\paperwidth,\headeroffset) .. (0.70\paperwidth,\headeroffset) -- (0,\headeroffset) -- cycle; % (0.5\paperwidth,\headeroffset) to[out=0,in=180] (0.6\paperwidth,0cm);
     \titlepage@bg
	\node[anchor=west,xshift=0.1\paperwidth,yshift=0.516\headerheight]{\includegraphics[width=0.5\paperwidth]{img/frontlogo.png}};
   \end{tikzpicture}};
 \end{tikzpicture}
 \vspace{1.2cm}
 \hrule
 \ \vfill
 \begin{center}
  \@ifundefined{@coverfigure}{}{\@coverfigure}
 \end{center}
 {\huge\bfseries\noindent \begin{flushleft} \@title \end{flushleft} \par} % title, 21
 \@ifundefined{@subtitle}{}{{\Large\noindent\begin{flushleft}\@subtitle\end{flushleft}\par}} % subtitle, 16

 \normalsize\noindent\thesisname\ \inname\ \@thesisin\par % 14 thesis in programmename (only bachelor's and master's)
 \vskip 1.5em
 {\renewcommand{\and}{\\}\Large\noindent \MakeUppercase{\@author}\par}% 18
 \vfill
 \hrule\vspace{2mm}
 {\small\noindent\@department\\
  \@ifundefined{@division}{}{\textit{\@division}\\}
  \@ifundefined{@researchgroup}{}{\textit{\@researchgroup}\\}
  \MakeUppercase{\universityname}\\
  \cityname, \countryname\ \@copyrightyear
    \\ \thesisname\ \@reportno
  \par}
 }
 % Second page, blank
 \newpage
 \mbox{}
}
}{\newcommand{\makecoverpage}{\ClassError{chalmers-thesis}{Package 'tikz' necessary.}{Load the 'tikz' package or use the nocover option.}}}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\maketitlepage}{
 \@checkifdefined{thesisin}
 \@checkifdefined{reportno}
 \@checkifdefined{title}
 \@checkifdefined{author}
 \@checkifdefined{department}
 \@checkifdefined{copyrightyear}

 \newpage\thispagestyle{empty}
 \begin{center}
  {\MakeUppercase{\thesisname\ \@reportno}\par}
  \vspace*{\stretch{1}}
  {\Large \@title\par}
  \vskip 1em
  \@ifundefined{@subtitle}{}{{\@subtitle\par}}
  \vskip 1em
  \textit{\thesisname\ \inname\ \@thesisin}\par
  \vskip 1em
  {\renewcommand{\and}{\NoCaseChange{\\}}\MakeTextUppercase{\@author}\par}
  \vspace*{\stretch{3}}
  {\@department\par}
  \@ifundefined{@division}{}{{\textit{\@division}\par}}
  \@ifundefined{@researchgroup}{}{{\textit{\@researchgroup}\par}}
  {\MakeUppercase{\universityname}\par}
  \vskip 0.5em
  {\cityname, \countryname\ \@copyrightyear\par}
 \end{center}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\makeprintinfopage}{
 \@checkifdefined{thesisin}
 \@checkifdefined{reportno}
 \@checkifdefined{title}
 \@checkifdefined{author}
 \@checkifdefined{department}
 \@checkifdefined{copyrightyear}
 \@checkifdefined{ISSN}

 \newpage
 \vspace*{\stretch{1}}
 {\noindent \@title\\
  \@ifundefined{@subtitle}{}{\@subtitle\\}
  \renewcommand{\and}{\\}\MakeUppercase{\@author}
  \@ifundefined{@ISBN}{}{\\ISBN \@ISBN}
  \par}
 \vskip 2em
 {\noindent \copyright\ {\renewcommand{\and}{, }\MakeUppercase{\@author}}, \@copyrightyear\par}
 \vskip 2em
 {\noindent \@reportseries\ \@reportno\\
  ISSN \@ISSN\\
  \@department\\
  \@ifundefined{@division}{}{\@division\\}
  \@ifundefined{@researchgroup}{}{\@researchgroup\\}
  \universityname\\
  \@postcode\ \cityname\\
  \countryname\\
  \telephonename: \@telephone\par}
 \vspace*{\stretch{2}}
 \@ifundefined{@colophon}{}{{\noindent \colophonname:\\ \@colophon\par}}
 \vskip 1em
 \@ifundefined{@covercaption}{}{{\noindent \covername:\\ \@covercaption\par}}
 \vskip 1em
 {\noindent \@printers
  \\ \cityname, \countryname\ \@copyrightyear\par}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\makeabstractpage}{
 \@checkifdefined{thesisin}
 \@checkifdefined{title}
 \@checkifdefined{author}
 \@checkifdefined{department}
 \@checkifdefined{firstabstract}
 \@checkifdefined{keywords}

 \newpage
 \pagenumbering{roman}
 {\noindent \@title\\
  \@ifundefined{@subtitle}{}{\@subtitle\\}
  \thesisname\ \inname\ \@thesisin\\
   {\renewcommand{\and}{\\}\MakeUppercase{\@author}}\\
  \@department\\
  \@ifundefined{@division}{}{\@division\\}
  \@ifundefined{@researchgroup}{}{\@researchgroup\\}
  \universityname
 \par}
 \presectiontitle{\abstractname}
 \@firstabstract
 \vskip 1em
 \noindent \keywordsname: \@keywords
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Trick to fully expand the argument
\newenvironment{Otherlanguage}[1]{%
  \begingroup
  \edef\temp{\endgroup\noexpand\otherlanguage{#1}}%
  \temp
}{\endotherlanguage}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\makesecondabstractpage}{%
 \@checkifdefined{secondarylanguage}
 \@checkifdefined{abstractsecondlang}
 \@checkifdefined{titlesecondlang}
 \@checkifdefined{departmentsecondlang}
 \@checkifdefined{keywordssecondlang}
 \newpage
 \begin{Otherlanguage}{\@secondarylanguage}
  {\noindent \@titlesecondlang\\
  \@ifundefined{@subtitlesecondlang}{}{\@subtitlesecondlang\\}
  \thesisname\ \inname\ \@thesisinsecondlang\\
   {\renewcommand{\and}{\\}\MakeUppercase{\@author}}\\
  \@departmentsecondlang\\
  \@ifundefined{@divisionsecondlang}{}{\@divisionsecondlang\\}
  \@ifundefined{@researchgroupsecondlang}{}{\@researchgroupsecondlang\\}
  \universityname
 \par}
  \presectiontitle{\abstractname}
  \@abstractsecondlang
  \vskip 1em
  \noindent \keywordsname: \@keywordssecondlang
 \end{Otherlanguage}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\makeprefacepage}{%
 \cleardoublepage
 \presectiontitle{\prefacename}
 \@preface
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\makeacknowledgementspage}{% Note: Doesn't need a new page.
 \presectiontitle{\acknowledgementsname}
 \@acknowledgements
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\maketitle}{%
 \setcounter{page}{-100} % Necessary to give the first pages a unique identifier using hyperref.
 \makecoverpage
 \maketitlepage
 \makeprintinfopage
 \makeabstractpage

 % sets up page layout
 \pagestyle{fancy}
 \renewcommand{\footrulewidth}{0pt}
 \renewcommand{\headrulewidth}{0pt}
 \newcommand{\footer}{\chalmerslogo{black}{0.15\textwidth}\hspace{-3.5pt}, \textit{\@department, \thesisname},\medskip}
 \fancyfoot{}
 \fancyhead{}
 \fancyfoot[O] {{\small\footer$\,\,$\@reportno}\hfill\thepage}
 \fancyfoot[E] {\thepage\hfill{\small\footer$\,\,$\@reportno}}
 
 % Empty or second abstract
 \@ifundefined{@abstractsecondlang}{}{
  \makesecondabstractpage
 }

 \@ifundefined{@acknowledgements}{}{
  \makeacknowledgementspage
 }

 \cleardoublepage
 \tableofcontents
 
 % Preface and acknowledgements
 \@ifundefined{@preface}{}{
  \makeprefacepage
 }
 

 \IfFileExists{./chapters/notation.tex}{\cleardoublepage\input{chapters/notation}}{}

 % Sets up page numbering for the rest of the document.
 \cleardoublepage
 \pagenumbering{arabic}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHALMERS logo below. Note that tt is trademarked!
\newcommand{\chalmerslogo}[2]{
\resizebox{#2}{!}{
\begin{tikzpicture}[fill=#1] % This is 11.994 in width, 1.341 in height
% C
\fill (1.481,0.488)
 .. controls (1.385,0.138) and (1.046,0.027) .. (0.742,0.027)
 .. controls (0.304,0.027) and (0,0.256) .. (0,0.687)
 .. controls (0,1.152) and (0.37,1.34) .. (0.76,1.34)
 .. controls (0.901,1.34) and (1.273,1.307) .. (1.437,1.011)
 -- (1.128,0.914)
 .. controls (1.095,0.966) and (0.997,1.102) .. (0.758,1.102)
 .. controls (0.478,1.102) and (0.321,0.919) .. (0.321,0.683)
 .. controls (0.321,0.414) and (0.535,0.271) .. (0.769,0.271)
 .. controls (1.036,0.271) and (1.116,0.411) .. (1.156,0.486)
 -- cycle;

% H
\fill (1.616,1.302) -- (1.925,1.302) -- (1.925,0.827) -- (2.656,0.827) -- (2.656,1.302) -- (2.965,1.302)
 -- (2.965,0.069) -- (2.656,0.069) -- (2.656,0.598) -- (1.925,0.598) -- (1.925,0.069) -- (1.616,0.069)
 -- cycle;

%A
\fill (3.707,1.302) -- (4.041,1.302) -- (4.637,0.069) -- (4.291,0.069) -- (4.168,0.338) -- (3.568,0.338)
 -- (3.449,0.069) -- (3.112,0.069) -- (3.707,1.302) -- cycle
 (3.903,0.923)
 .. controls (3.889,0.955) and (3.876,0.985) .. (3.871,1.021)
 .. controls (3.866,0.986) and (3.851,0.954) .. (3.837,0.922)
 -- (3.668,0.556) -- (4.066,0.556) -- cycle;

% L
\fill (4.796,1.302) -- (5.105,1.302) -- (5.105,0.296) -- (5.728,0.296) -- (5.728,0.069) -- (4.796,0.069) -- cycle;

% M
\fill (5.914,1.302) -- (6.359,1.302) -- (6.687,0.532)
 .. controls (6.721,0.451) and (6.73,0.418) .. (6.743,0.364)
 .. controls (6.756,0.418) and (6.767,0.451) .. (6.8,0.532)
 -- (7.122,1.302) -- (7.564,1.302) -- (7.564,0.069) -- (7.272,0.069) -- (7.272,0.937)
 .. controls (7.272,0.984) and (7.279,1.01) .. (7.285,1.047)
 .. controls (7.272,1.01) and (7.263,0.984) .. (7.243,0.937)
 -- (6.881,0.069) -- (6.6,0.069) -- (6.231,0.937)
 .. controls (6.211,0.984) and (6.205,1.01) .. (6.195,1.047)
 .. controls (6.198,1.01) and (6.205,0.984) .. (6.205,0.937)
 -- (6.205,0.069) -- (5.914,0.069) -- cycle;

% E
\fill (7.85,1.302) -- (8.999,1.302) -- (8.999,1.080) -- (8.159,1.080) -- (8.159,0.802) -- (8.899,0.802)
 -- (8.899,0.584) -- (8.159,0.584) -- (8.159,0.289) -- (9.034,0.289) -- (9.034,0.069) -- (7.850,0.069) -- cycle;

% R
\fill (9.266,1.301) -- (10.128,1.301)
 .. controls (10.219,1.301) and (10.566,1.290) .. (10.566,0.933)
 .. controls (10.566,0.720) and (10.439,0.612) .. (10.246,0.583)
 -- (10.620,0.068) -- (10.265,0.068) -- ( 9.927,0.564) -- ( 9.575,0.564) -- ( 9.575,0.068)
 -- ( 9.266,0.068) -- ( 9.266,1.301) -- cycle
 (9.576,0.782) -- (10.068,0.782)
 .. controls (10.134,0.782) and (10.253,0.791) .. (10.253,0.929)
 .. controls (10.253,1.064) and (10.164,1.085) .. (10.054,1.085)
 -- (9.576,1.085) -- cycle;

% S
\fill (10.956,0.445)
 .. controls (11.028,0.297) and (11.205,0.255) .. (11.373,0.258)
 .. controls (11.448,0.259) and (11.684,0.276) .. (11.681,0.426)
 .. controls (11.680,0.515) and (11.593,0.534) .. (11.527,0.545)
 .. controls (11.476,0.554) and (11.222,0.589) .. (11.164,0.599)
 .. controls (11.051,0.617) and (10.758,0.667) .. (10.758,0.946)
 .. controls (10.758,1.249) and (11.080,1.340) .. (11.326,1.340)
 .. controls (11.612,1.340) and (11.831,1.285) .. (11.981,1.056)
 -- (11.689,0.978)
 .. controls (11.620,1.103) and (11.462,1.121) .. (11.330,1.120)
 .. controls (11.194,1.120) and (11.055,1.089) .. (11.057,0.972)
 .. controls (11.058,0.892) and (11.130,0.872) .. (11.223,0.853)
 .. controls (11.274,0.843) and (11.526,0.805) .. (11.584,0.795)
 .. controls (11.727,0.770) and (11.971,0.723) .. (11.976,0.452)
 .. controls (11.983,0.056) and (11.539,0.033) .. (11.358,0.031)
 .. controls (11.156,0.028) and (10.840,0.057) .. (10.676,0.366)
 -- cycle;
\end{tikzpicture}
}
}
