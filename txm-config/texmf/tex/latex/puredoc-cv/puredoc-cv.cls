%% Start of file `puredoc-cv.cls'.
%
% Class license:
% LPPL v1.3c (http://www.latex-project.org/lppl)

%-------------------------------------------------------------------------------
% Identification
%-------------------------------------------------------------------------------
\ProvidesClass{puredoc-cv}[2018/12/16 puredoc-cv v1.0.0]
\NeedsTeXFormat{LaTeX2e}


%-------------------------------------------------------------------------------
% Class options
%
% (need to be done before the external package loading, for example because
% we need \paperwidth, \paperheight and \@ptsize to be defined before loading
% geometry and fancyhdr)
%-------------------------------------------------------------------------------
% Inherit options of article
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\LoadClass{article}


%-------------------------------------------------------------------------------
% 3rd party packages
%-------------------------------------------------------------------------------
% Needed to handle different languages
\RequirePackage[utf8]{inputenc}
% Needed to make fixed length table
\RequirePackage{array}
% Needed to handle list environment
\RequirePackage{enumitem}
% Needed to handle text alignment
\RequirePackage{ragged2e}
% Needed to configure page layout
\RequirePackage{geometry}
% Needed to make header & footer effeciently
\RequirePackage{fancyhdr}
% Needed to manage colors
\RequirePackage{xcolor}
% Needed to use \ifxetex-\else-\fi statement
\RequirePackage{ifxetex}
% Needed to use \if-\then-\else statement
\RequirePackage{xifthen}
% Needed to use a toolbox of programming tools
\RequirePackage{etoolbox}
% Needed to change line spacing in specific environment
\RequirePackage{setspace}
% Needed to manage fonts
\RequirePackage[quiet]{fontspec}
% To support LaTeX quoting style
\defaultfontfeatures{Ligatures=TeX}
% Needed to manage math fonts
\RequirePackage{unicode-math}
% Needed to use icons from font-awesome
% (https://github.com/posquit0/latex-fontawesome)
\RequirePackage{puredoc-fontawesome}
% \RequirePackage[default,opentype]{sourcesanspro}
% Needed for the photo ID
\RequirePackage[skins]{tcolorbox}
% Needed to deal a paragraphs
\RequirePackage{parskip}
% Needed to deal hyperlink
\RequirePackage[hidelinks,unicode]{hyperref}
\hypersetup{%
  pdftitle={},
  pdfauthor={},
  pdfsubject={},
  pdfkeywords={},
  colorlinks=true,
  urlcolor=blue
}


%-------------------------------------------------------------------------------
% Configuration for directory locations
%-------------------------------------------------------------------------------
% Configure a directory location for fonts(default: 'fonts/')
\newcommand*{\fontdir}[1][fonts/]{\def\@fontdir{#1}}
\fontdir


%-------------------------------------------------------------------------------
% Configuration for layout
%-------------------------------------------------------------------------------
% Configure page margins with geometry
\geometry{left=2.0cm, top=1.5cm, right=2.0cm, bottom=2.0cm, footskip=.5cm}
%% Header & Footer
% Set offset to each header and footer
\fancyhfoffset{0em}
% Remove head rule
\renewcommand{\headrulewidth}{0pt}
% Clear all header & footer fields
\fancyhf{}
% Enable if you want to make header or footer using fancyhdr
\pagestyle{fancy}


%-------------------------------------------------------------------------------
% Configuration for colors
%-------------------------------------------------------------------------------
\definecolor{black}{HTML}{222222}
\definecolor{blue}{HTML}{337ab7}


%-------------------------------------------------------------------------------
% Configuration for font sizes
%-------------------------------------------------------------------------------
% We use latex default font size commands:
% \huge
% \normalsize
% \small
% \footnotesize
% For more details, please refer to https://en.wikibooks.org/wiki/LaTeX/Fonts


%-------------------------------------------------------------------------------
% Configuration for some dimentions / helpers
%-------------------------------------------------------------------------------
\setlength{\parskip}{0pt} % Very important
\newcommand{\titleIconSep}{\space}
\newcommand{\titleSocialSep}{\quad\textbar\quad}
\newenvironment{skipwrapper}{%
  \par%
}{%
  \par\smallskip\par%
}
\newcommand*{\titleSocialArea}[1]{%
  \begin{skipwrapper}%
    {\footnotesize\color{black} #1}%
  \end{skipwrapper}%
}
\newcommand{\cvskip}[1][b]{%
  \ifthenelse{\equal{#1}{b}}%
    {\par\bigskip\par}{}%
  \ifthenelse{\equal{#1}{m}}%
    {\par\medskip\par}{}%
  \ifthenelse{\equal{#1}{s}}%
    {\par\smallskip\par}{}%
}


%-------------------------------------------------------------------------------
% Configuration for personal information in title area
%-------------------------------------------------------------------------------
% Define photo ID
% Usage: \photo[circle|rectangle,edge|noedge,left|right]{<path-to-image>}
\newcommand{\photo}[2][circle,edge,left]{%
  \def\@photo{#2}
  \@for\tmp:=#1\do{%
    \ifthenelse{\equal{\tmp}{circle} \or \equal{\tmp}{rectangle}}%
      {\let\@photoshape\tmp}{}%
    \ifthenelse{\equal{\tmp}{edge} \or \equal{\tmp}{noedge}}%
      {\let\@photoedge\tmp}{}%
    \ifthenelse{\equal{\tmp}{left} \or \equal{\tmp}{right}}%
      {\let\@photoalign\tmp}{}%
  }%
}
\def\@photoshape{circle}
\def\@photoedge{edge}
\def\@photoalign{left}

% Define writer's name
% Usage: \name{<name>}
\newcommand*{\name}[1]{\def\@name{\par{\huge\bfseries\color{black}#1}\smallskip\par}}

% Define writer's position
% Usage: \name{<position>}
\newcommand*{\position}[1]{\def\@position{\par{\normalsize\bfseries\color{black} #1}\smallskip\par}}

% Define writer's address
% Usage: \address{<address>}
\newcommand*{\address}[1]{\def\@address{\par{\footnotesize\color{black}#1}\smallskip\par}}

% Defines writer's mobile (optional)
% Usage: \mobile{<mobile number>}
\newcommand*{\shortaddress}[1]{\def\@shortaddress{#1}}

% Defines writer's mobile (optional)
% Usage: \mobile{<mobile number>}
\newcommand*{\mobile}[1]{\def\@mobile{#1}}

% Defines writer's email (optional)
% Usage: \email{<email adress>}
\newcommand*{\email}[1]{\def\@email{#1}}

% Defines writer's homepage (optional)
% Usage: \homepage{<url>}
\newcommand*{\homepage}[1]{\def\@homepage{#1}}

% Defines writer's github (optional)
% Usage: \github{<github-nick>}
\newcommand*{\github}[2]{%
  \def\@github{#1}%
  \def\@githublink{#2}%
}

% Defines writer's gitlab (optional)
% Usage: \gitlab{<gitlab-nick>}
\newcommand*{\gitlab}[2]{%
  \def\@gitlab{#1}%
  \def\@gitlablink{#2}%
}

% Defines writer's stackoverflow profile (optional)
% Usage: \stackoverflow{<so userid>}{<so username>}
%   e.g.https://stackoverflow.com/users/123456/sam-smith
%       would be \stackoverflow{123456}{sam-smith}
\newcommand*{\stackoverflow}[2]{%
  \def\@stackoverflow{#1}%
  \def\@stackoverflowlink{#2}%
}

% Defines writer's linked-in (optional)
% Usage: \linkedin{<linked-in-nick>}
\newcommand*{\linkedin}[2]{%
  \def\@linkedin{#1}%
  \def\@linkedinlink{#2}%
}

% Usage: \twitter{<twitter handle>}
\newcommand*{\twitter}[2]{%
  \def\@twitter{#1}%
  \def\@twitterlink{#2}%
}

% Defines writer's skype (optional)
% Usage: \skype{<skype account>}
\newcommand*{\skype}[1]{\def\@skype{#1}}

% Defines writer's reddit (optional)
% Usage: \reddit{<reddit account>}
\newcommand*{\reddit}[2]{%
  \def\@reddit{#1}%
  \def\@redditlink{#2}%
}

% Defines writer's xing (optional)
% Usage: \xing{<xing name>}
\newcommand*{\xing}[2]{%
  \def\@xing{#1}%
  \def\@xinglink{#2}%
}

% Defines writer's quote (optional)
% Usage: \quote{<quote>}
\renewcommand*{\quote}[1]{\def\@quote{\par\medskip\par{\normalsize\color{black}\textit{``#1"}}\medskip\par}}

% Define a header for CV
% Usage: \makecvtitle
\newbool{isstart}%
\setbool{isstart}{true}%
\newcommand*{\iconitem}[4]{%
  \ifbool{#1}{\setbool{isstart}{false}}{\titleSocialSep}%
  \ifthenelse{\equal{#2}{}}%
    {#3\titleIconSep#4}%
    {\href{#2}{#3\titleIconSep#4}}%
}
\newcommand*{\makecvtitle}[1][C]{%
  \newcommand*{\drawphoto}{%
    \ifthenelse{\isundefined{\@photo}}{}{%
      \newlength{\photodim}
      \ifthenelse{\equal{\@photoshape}{circle}}%
        {\setlength{\photodim}{1.3cm}}%
        {\setlength{\photodim}{1.8cm}}%
      \ifthenelse{\equal{\@photoedge}{edge}}%
        {\def\@photoborder{black}}%
        {\def\@photoborder{none}}%
      \begin{tikzpicture}%
        \node[\@photoshape, draw=\@photoborder, line width=0.3mm, inner sep=\photodim, fill overzoom image=\@photo] () {};
      \end{tikzpicture}
    }%
  }
  \newlength{\headertextwidth}
  \newlength{\headerphotowidth}
  \ifthenelse{\isundefined{\@photo}}{
    \setlength{\headertextwidth}{\textwidth}
    \setlength{\headerphotowidth}{0cm}
  }{%
    \setlength{\headertextwidth}{0.76\textwidth}
    \setlength{\headerphotowidth}{0.24\textwidth}
  }%
  \begin{minipage}[c]{\headerphotowidth}%
    \ifthenelse{\equal{\@photoalign}{left}}{\raggedright\drawphoto}{}
  \end{minipage}
  \begin{minipage}[c]{\headertextwidth}
    \ifthenelse{\equal{#1}{L}}{\raggedright}{\ifthenelse{\equal{#1}{R}}{\raggedleft}{\centering}}
    \@name%
    \ifthenelse{\isundefined{\@position}}{}{\@position}%
    \ifthenelse{\isundefined{\@address}}{}{\@address}%
    \titleSocialArea{%
      \hypersetup{urlcolor=black}
      \ifthenelse{\isundefined{\@mobile}}%
        {}%
        {%
          \iconitem{isstart}{}{\faMobile}{\@mobile}%
        }%
      \ifthenelse{\isundefined{\@email}}%
        {}%
        {%
          \iconitem{isstart}{mailto:\@email}{\faEnvelope}{\@email}%
        }%
      \ifthenelse{\isundefined{\@shortaddress}}%
        {}%
        {%
          \iconitem{isstart}{}{\faMapMarker}{\@shortaddress}%
        }%
      \ifthenelse{\isundefined{\@homepage}}%
        {}%
        {%
          \iconitem{isstart}{http://\@homepage}{\faHome}{\@homepage}%
        }%
      \ifthenelse{\isundefined{\@github}}%
        {}%
        {%
          \iconitem{isstart}{\@githublink}{\faGithubSquare}{\@github}%
        }%
      \ifthenelse{\isundefined{\@gitlab}}%
        {}%
        {%
          \iconitem{isstart}{\@gitlablink}{\faGitlab}{\@gitlab}%
        }%
      \ifthenelse{\isundefined{\@stackoverflow}}%
        {}%
        {%
          \iconitem{isstart}{\@stackoverflowlink}{\faStackOverflow}{\@stackoverflow}%
        }%
      \ifthenelse{\isundefined{\@linkedin}}%
        {}%
        {%
          \iconitem{isstart}{\@linkedinlink}{\faLinkedinSquare}{\@linkedin}%
        }%
      \ifthenelse{\isundefined{\@twitter}}%
        {}%
        {%
          \iconitem{isstart}{\@twitterlink}{\faTwitter}{\@twitter}%
        }%
      \ifthenelse{\isundefined{\@skype}}%
        {}%
        {%
          \iconitem{isstart}{}{\faSkype}{\@skype}%
        }%
      \ifthenelse{\isundefined{\@reddit}}%
        {}%
        {%
          \iconitem{isstart}{\@redditlink}{\faReddit}{\@reddit}%
        }%
      \ifthenelse{\isundefined{\@xing}}%
        {}%
        {%
          \iconitem{isstart}{\@xinglink}{\faXingSquare}{\@xing}%
        }%
    }%
    \ifthenelse{\isundefined{\@quote}}{}{\@quote}%
  \end{minipage}%
  \begin{minipage}[c]{\headerphotowidth}%
    \ifthenelse{\equal{\@photoalign}{right}}{\raggedleft\drawphoto}{}
  \end{minipage}
}

%-------------------------------------------------------------------------------
% Configuration for commands in body area
%-------------------------------------------------------------------------------
% Use to draw horizontal line with specific thickness
\def\vhrulefill#1{\leavevmode\leaders\hrule\@height#1\hfill \kern\z@}
\newcommand*{\sectionstyle}[1]{{\normalsize\bfseries\color{black} #1}}
\newcommand{\cvsection}[1]{%
  \par\bigskip\par%
  \sectionstyle{#1}%
  \color{black}\vhrulefill{0.5pt}%
  \par\smallskip\par%
}

\newcommand{\cvsubsection}[1]{
  \par{\small\bfseries\color{black} #1}\par
}

\newcommand*{\cvparagraph}[1]{\par{\small\color{black} #1}\par}%

\newcommand*{\link}[2]{{\color{blue}\href{#2}{#1}}}

\newenvironment{cvitems}{%
  \begin{justify}
  \begin{itemize}[leftmargin=*, nosep]
  \small\color{black}
}{%
  \end{itemize}
  \end{justify}
}%


%-------------------------------------------------------------------------------
% Configuration for footer
%-------------------------------------------------------------------------------
\newcommand*{\footerstyle}[1]{{\footnotesize\scshape\color{black} #1}}
\newcommand*{\makecvfooter}[3]{%
  \fancyfoot{}
  \fancyfoot[L]{\footerstyle{#1}}
  \fancyfoot[C]{\footerstyle{#2}}
  \fancyfoot[R]{\footerstyle{#3}}
}




