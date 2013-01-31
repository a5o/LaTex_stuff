\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{myseminar}[2003/03/02]

\LoadClass[12pt]{seminar}


\usepackage[T1]{fontenc}
\usepackage[latin1]{inputenc}
\usepackage[italian]{babel}
\usepackage{pslatex}
\usepackage[pdftex]{graphicx}
\usepackage{color}
\usepackage{pause}
\usepackage[bookmarks=true, bookmarksopen=true, pdfstartview=FitH, colorlinks=true, linkcolor=gray]{hyperref}
\input{seminar.bug}
\input{seminar.bg2}

\slidepagestyle{empty}

\setcounter{secnumdepth}{-2}

%% bookmarks
%% to be evaluated ...
  \def\slidetitle#1{\gdef\@slidetitle{#1}}
  \def\@slidetitle{}

  \def\everyslide{%
% set pagecounter to slide-counter to enable anchors from texpower and hyperref
    \setcounter{page}{\value{slide}}
  }

%titlepage
  \def\titlefont{\LARGE\bfseries\sffamily}
  \def\authorfont{\large\sffamily}
  \def\addressfont{\footnotesize\sffamily}
  \def\orgfont{\LARGE\sffamily}
  \def\urlfont{\small\sffamily}
  \def\notesfont{\tiny\sffamily}
  \def\slidemaketitle{\centerslidestrue%\ptsize{8}%
        \def\footnoterule{}%
        \noindent%
        \begin{minipage}[t][\textheight][c]{\textwidth}%
          \begin{center}%
            \null\vskip20truept%
            \ifx\@orgname\@empty\relax\else%
            {\orgfont\@orgname}\\[3truept]\fi%
            \ifx\@orgurl\@empty\null\vskip60truept\else%
            {\urlfont\href{\@orgurl}{\@orgurl}}\\[60truept]\fi%
            {\titlefont\@title}\vfill%
            \ifx\@author\@empty\relax\else%
            {\authorfont\@author}\\[10truept]\fi%
            \begin{quote}%
            {\addressfont\@address}%
            \end{quote}%
            {\ifx\@notes\@empty\relax\else%
              \ \footnotetext{\notesfont\hspace*{-.6\semcm}\parbox[t]{\linewidth}{\@notes}}%
            \fi}%
%           {\ifx\@notes\@empty\relax\else\notesfont\@notes\fi}\\[10truept]\null%
          \end{center}%
        \end{minipage}%
%       \def\footnoterule{\@tmpfootnoterule}%
        \clearpage%
  }
  \long\def\author#1{\long\gdef\@author{#1}}\let\@author\@empty
  \long\def\address#1{\long\gdef\@address{#1}}\let\@address\@empty
  \long\def\notes#1{\long\gdef\@notes{#1}}\let\@notes\@empty
  \long\def\orgname#1{\long\gdef\@orgname{#1}}\let\@orgname\@empty
  \long\def\orgurl#1{\long\gdef\@orgurl{#1}}\let\@orgurl\@empty
  %
  %
%%%% end of titlepage

%% sections

   \def\@seccntformat#1{}

   \renewcommand\section{\@startsection{section}{1}{\z@}%
           {-\z@ \@plus -1ex \@minus -.2ex}%
%           {0pt}%
           {1.25ex \@plus.2ex \@minus .2ex}%
           {\centering\Large\bfseries\sffamily}}

   \renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
           {-3.25ex\@plus -1ex \@minus -.2ex}%
           {1.25ex \@plus .2ex}%
           {\large\bfseries\sffamily}}

   \renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
           {3ex \@plus 1ex \@minus 1ex}%
           {-1em}{\large\bfseries\sffamily}}

   \renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
     {.5\baselineskip\@plus.2\baselineskip\@minus .1\baselineskip}{-.5em}%
     {\normalsize\itshape\sffamily}}

   \renewcommand\subparagraph{\@startsection{subparagraph}{5}{\z@}%
     {.5\baselineskip\@plus.2\baselineskip\@minus .1\baselineskip}{-.5em}%
     {\normalsize\itshape\sffamily}}

  \let\scr@section\section 
% headskip: only positive values allowed!
  \newdimen\headskip \headskip=1\baselineskip
  \def\section{\clearpage{\null\vspace*{-2\baselineskip}\par}\null\vskip\headskip\scr@section}

%% close the document and get the right number of pages!
  \AtEndDocument{%
    \clearpage   \addtocounter{page}{-1}%
    \immediate\write\@auxout{\string\gdef\string\LastSlide{\arabic{slide}}}%
  }

\slideframe{none}

