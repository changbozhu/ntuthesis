%---------------------------------------------------------------------------%
%-                    Nantong University Thesis Template                   -%
%-                           Document Class                                -%
%-                                                                         -%
%---------------------------------------------------------------------------%
%- Copyright (C) 2025-2025 Changbo Zhu <1207146285@qq.com> 
%- This is free software: you can redistribute it and/or modify it
%- under the terms of the GNU General Public License as published by
%- the Free Software Foundation, either version 3 of the License, or
%- (at your option) any later version.
%---------------------------------------------------------------------------%
%->> Identification
%---------------------------------------------------------------------------%
\NeedsTeXFormat{LaTeX2e}%
\newcommand*\@iflatexlater{\@ifl@t@r\fmtversion}%
%---------------------------------------------------------------------------%
%-
%--> report error warning
%-
% 报错
\def\texproject{ntuthesis}
\newcommand\ntuthesis@error[1]{%
  \ClassError{\texproject}{#1}{}%
}
\newcommand\ntuthesis@warning[1]{%
  \ClassWarning{\texproject}{#1}%
}
\newcommand\ntuthesis@debug[1]{%
  \typeout{Package \texproject Info: #1}%
}
\newcommand\ntuthesis@patch@error[1]{%
  \ntuthesis@error{Failed to patch command \protect#1}%
}
\newcommand\ntuthesis@deprecate[2]{%
  \def\ntuthesis@tmp{#2}%
  \ntuthesis@warning{%
    The #1 is deprecated%
    \ifx\ntuthesis@tmp\@empty\else
      . Use #2 instead%
    \fi
  }%
}
% 检查 \LaTeXe{} kernel 版本
\@iflatexlater{2017/04/15}{}{%
    \ntuthesis@error{TeX Live 2017 or later version is required to compile this document}
}
\ProvidesClass{style/ntuthesis}[2025/05/01 v1.0 Nantong University Thesis Template]%
\def\texproject@info{}
\def\texproject@info@cls@version{1.0}
\def\texproject@info@zhauthor{朱昌波}
\def\texproject@info@email{1207146285@qq.com}
\def\texproject@info@windows{Windows 11}
\def\texproject@info@linux{Deepin V23}
\def\texproject@info@macos{MacOS}
\def\projectname{\texproject}
\def\project{\texproject ~v\texproject@info@cls@version}
\def\projectversion{\texproject@info@cls@version}
\def\projectauthor{\texproject@info@zhauthor}
\def\projectemail{\texproject@info@email}
\def\projectwindows{\texproject@info@windows}
\def\projectlinux{\texproject@info@linux}
\def\projectmacos{\texproject@info@macos}

%---------------------------------------------------------------------------%
%->> Declare options
%---------------------------------------------------------------------------%
%-
%-> Layout
%-
\newif\ifntuthesis@print \ntuthesis@printfalse
\newif\ifntuthesis@oneside \ntuthesis@onesidefalse
\newif\ifntuthesis@twoside \ntuthesis@twosidetrue
\DeclareOption{oneside}{%
    \ntuthesis@printtrue%
    \ntuthesis@onesidetrue%
    \ntuthesis@twosidefalse%
}
\DeclareOption{twoside}{%
    \ntuthesis@printtrue%
    \ntuthesis@twosidetrue%
    \ntuthesis@onesidefalse%
}
\ifntuthesis@oneside
    \PassOptionsToClass{oneside}{ctexbook}%
\fi
\ifntuthesis@twoside
    \PassOptionsToClass{twoside}{ctexbook}%
\fi
%-
%-> degreetype
%-
\newif\ifntuthesis@professional \ntuthesis@professionalfalse
\newif\ifntuthesis@academic \ntuthesis@academicfalse
\DeclareOption{professional}{%
    \ntuthesis@professionaltrue%
    \ntuthesis@academicfalse%
}
\DeclareOption{academic}{%
    \ntuthesis@professionalfalse%
    \ntuthesis@academictrue%
}
%-
% -> stage or thesis type:   
%  bachelor --> graduate design; 
%  master --> master thesis; 
%  doctor --> doctoral dissertation
%  postdoctoral --> postdoctoral report
\newif\ifntuthesis@bachelor \ntuthesis@bachelorfalse
\newif\ifntuthesis@master \ntuthesis@masterfalse
\newif\ifntuthesis@doctor \ntuthesis@doctorfalse
\newif\ifntuthesis@postdoc \ntuthesis@postdocfalse
\DeclareOption{bachelor}{%
    \ntuthesis@bachelortrue%
    \ntuthesis@masterfalse%
    \ntuthesis@doctorfalse%
    \ntuthesis@postdocfalse%
    \ntuthesis@professionalfalse%
    \ntuthesis@academictrue%
}
\DeclareOption{master}{%
    \ntuthesis@bachelorfalse%
    \ntuthesis@mastertrue%
    \ntuthesis@doctorfalse%
    \ntuthesis@postdocfalse%
}
\DeclareOption{doctor}{%
    \ntuthesis@bachelorfalse%
    \ntuthesis@masterfalse%
    \ntuthesis@doctortrue%
    \ntuthesis@postdocfalse%
}
\DeclareOption{postdoctoral}{%
    \ntuthesis@bachelorfalse%
    \ntuthesis@masterfalse%
    \ntuthesis@doctorfalse%
    \ntuthesis@postdoctrue%
    \ntuthesis@professionalfalse%
    \ntuthesis@academictrue%
}
%-
%-> Language\ntuthesis@config@en
%-
\newif\ifntuthesis@plain \ntuthesis@plainfalse
\DeclareOption{scheme=plain}{% enable plain writing style
    \PassOptionsToClass{scheme=plain}{ctexbook}%
    \ntuthesis@plaintrue%
}
%-
%-> Draft version info
%-
\newif\ifntuthesis@draft \ntuthesis@draftfalse
\DeclareOption{draft}{%
    \ntuthesis@drafttrue%
}
%-
%-> Handle non-implemented options
%-
\DeclareOption*{%
    \PassOptionsToClass{\CurrentOption}{ctexbook}%
}
%-
%-> Terminates all options processing
%-
\ProcessOptions\relax%
%---------------------------------------------------------------------------%
%->> Load class information
%---------------------------------------------------------------------------%
\LoadClass[UTF8,a4paper]{ctexbook}%
\@ifclasslater{ctexbook}{2019/01/01}{}{%
    \ClassError{ntuthesis}{ctex >= 2019/01/01 is required ...}{}%
}
%---------------------------------------------------------------------------%
%->> Required packages
%---------------------------------------------------------------------------%
\RequirePackage{xstring}%
\RequirePackage{ifxetex}% LaTeX engine detection
\RequirePackage{etoolbox}% a toolbox of programming facilities
\newcommand{\ntuthesisifstreq}{\expandafter\ifstrequal\expandafter}% expansion control
\newcommand{\ntuthesisifstrbk}{\expandafter\ifblank\expandafter}% expansion control
\RequirePackage{expl3}% LaTeX3 programming environment
\ExplSyntaxOn
\newcommand{\ntuthesislntotab}[2][1pt]{% convert lines into table lines
    \seq_set_split:NnV \l_tmpa_seq {\\} {#2}
    \clist_set_from_seq:NN \l_tmpa_clist \l_tmpa_seq
    \clist_clear:N \l_tmpb_clist
    \clist_map_inline:Nn \l_tmpa_clist
      {%
        \clist_put_right:Nn \l_tmpb_clist 
          { \ulenhance[#1]{\ulextend{##1}} }
      }
    %\clist_show:N\l_tmpb_clist% show the content of comma list
    \clist_use:Nn \l_tmpb_clist { \\ & }
}
\ExplSyntaxOff
%---------------------------------------------------------------------------%
%->> Load class configuration
%---------------------------------------------------------------------------%
\AtEndOfPackage{% class cfg loaded after package to make preamble commands take effect
    \makeatletter
    \InputIfFileExists{style/ntuthesis.cfg}{}{}
    \makeatother
}

\RequirePackage{xcolor}
\definecolor{crimson}{RGB}{220, 20, 60}
\definecolor{light-green}{RGB}{175,238,238}
\RequirePackage{geometry}
\ifntuthesis@bachelor
    \geometry{paper=a4paper,top=20mm,bottom=20mm,headheight=12.5pt,headsep=3.7mm,footskip=5mm}%
\else
    \geometry{paper=a4paper,top=38mm,bottom=38mm,headheight=13pt,headsep=5.4mm,footskip=12mm}%
\fi
%---------------------------------------------------------------------------%
%->> Page layout
%---------------------------------------------------------------------------%
%- use \topmargin insead of \voffset to shift the complete text vertically
%- use \<odd|even>sidemargin insead of \hoffset to shift text horizontally
%- part one -- horizontal widths
%- left side width + textwidth + right side width = paperwidth
%- binding side width + textwidth + nonbinding side width = paperwidth
%- binding side width of [odd, even] page = [left, right] side width
%- left side width of [odd, even] page = 1.0in (fixed) + hoffset + [odd, even]sidemargin
%- assuming A4 paper (210mm x 297mm)
\ifntuthesis@print% if print layout enabled
    \ifntuthesis@oneside
        \ifntuthesis@bachelor
            \geometry{bindingoffset=5mm,left=20mm,right=20mm,twoside=false}%
        \else
            \geometry{bindingoffset=10mm,left=32mm,right=32mm,twoside=false}%
        \fi
    \fi
    \ifntuthesis@twoside
        \ifntuthesis@bachelor
            \geometry{bindingoffset=5mm,left=20mm,right=20mm,twoside=true}%
        \else
            \geometry{bindingoffset=10mm,left=32mm,right=32mm,twoside=true}%
        \fi
    \fi
\else
    \ifntuthesis@bachelor
        \geometry{bindingoffset=0mm,left=22.5mm,right=22.5mm,twoside=true}%
    \else
        \geometry{bindingoffset=0mm,left=37mm,right=37mm,twoside=true}%
    \fi
\fi
\setlength{\marginparwidth}{0pt}% width of margin notes
\setlength{\marginparsep}{0pt}% width of space between body text and margin notes
%- part two -- vertical heights
%- top height + textheight + bottom height = paperheight
%- top height = 1.0in (fixed) + voffset + topmargin + headheight + headsep 
%\setlength{\textheight}{221mm}% set required text height first
%\setlength{\voffset}{0mm}% set vertical offset
%\setlength{\topmargin}{2.6mm}% vertical margin above header
%\setlength{\headheight}{13pt}% header height
%\setlength{\headsep}{5.4mm}% vertical margin between header and body text
%\setlength{\footskip}{12mm}% vertical margin between footer and body text
%- specifies the amount of space between paragraphs.
\setlength{\parskip}{0.5ex plus 0.25ex minus 0.25ex}
%- line spacing
\linespread{1.6}% line space setting
\setlength{\parindent}{2em}
\raggedbottom% prevent adding vertical white space in strange places
%- default pagestyle is page number at bottom without headers and footers
\pagestyle{plain}
%---------------------------------------------------------------------------%
%->> Style control commands
%---------------------------------------------------------------------------%
%- redefine cleardoublepage to have page style argument
\renewcommand{\cleardoublepage}[1][plain]{%
    \clearpage\if@twoside\ifodd\c@page\else%
    \thispagestyle{#1}%
    \hbox{}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi%
}
%- underline
\ifxetex%
    \RequirePackage{ulem}%
\else%
    \RequirePackage{ulem}%
\fi
\newcommand{\ulunify}[1]{\uline{#1}}% unified name
\newcommand{\ulenhance}[2][1pt]{% enhanced underline
    \def\ULthickness{#1}% set thickness
    \setlength{\ULdepth}{0.5em}% set depth
    \expandafter\ulunify\expandafter{#2}% linebreak fix
}
\newcommand{\ulhshift}{-4em}% horizontal shift on underline
\newcommand{\ulextend}[2][350pt]{% extend underline length
    \hbox to #1{\hfill\hspace*{\ulhshift}#2\hfill}
}
\newif\if@autobibtex \@autobibtexfalse
%\ntuthesisifstreq{\ntuthesis@value@bibauto}{bibtex}{%
%    \@autobibtextrue%
%}{%
%    \@autobibtexfalse%
%}%

%\def\@setwindowsfontname{\ntuthesis@value@zhcn@mainfontfamily@windows}
\newcommand{\setwindowsfont}[1]{\def\@setwindowsfontname{#1}}
\setwindowsfont{\ntuthesis@value@zhcn@mainfontfamily@windows}
%\def\@setmacosfontname{\ntuthesis@value@zhcn@mainfontfamily@macos}
\newcommand{\setmacosfont}[1]{\def\@setmacosfontname{#1}}
\setmacosfont{\ntuthesis@value@zhcn@mainfontfamily@macos}
%\def\@setnonefontname{\ntuthesis@value@zhcn@mainfontfamily@none}
\newcommand{\setnonefont}[1]{\def\@setnonefontname{#1}}
\setnonefont{\ntuthesis@value@zhcn@mainfontfamily@none}
\newcommand{\setmathfontfamily}[1]{\def\@setmathfontname{#1}}
\setmathfontfamily{\ntuthesis@value@zhcn@mathfontfamily}
%---------------------------------------------------------------------------%
%->> Titlepage
%---------------------------------------------------------------------------%
%-
%-> common item commands
%-
% \confidential{#1}{#2}
\def\ntuthesis@value@confidential{}%
\def\ntuthesis@value@confidential@level{no}%
\def\ntuthesis@value@confidential@period{\phantom{0}}%
\newcommand{\confidential}[2]{%
    \def\ntuthesis@value@confidential@level{#1}%
    \def\ntuthesis@value@confidential@period{#2}%
}%
% \orderid{#1}
\def\ntuthesis@value@zhcn@orderid{}%
\newcommand{\orderid}[1]{\def\ntuthesis@value@zhcn@orderid{#1}}%
% \classid{#1}
\def\ntuthesis@value@zhcn@classid{}%
\newcommand{\classid}[1]{\def\ntuthesis@value@zhcn@classid{#1}}%
% \udc{#1}
\def\ntuthesis@value@zhcn@udc{}%
\newcommand{\udc}[1]{\def\ntuthesis@value@zhcn@udc{#1}}%
% \schoollogo<*>[]{#1}
\def\ntuthesis@value@zhcn@schoollogo{}%
\newcommand{\zhcnschoollogo}[2][]{\def\ntuthesis@value@zhcn@schoollogo{\ntuthesisifstrbk{#1}{\zihao{-2}\bfseries\sffamily #2}{\includegraphics[#1]{#2}}}}%
\def\ntuthesis@value@en@schoollogo{}%
\newcommand{\enschoollogo}[2][]{\def\ntuthesis@value@en@schoollogo{\ntuthesisifstrbk{#1}{\zihao{-2}\bfseries\sffamily #2}{\includegraphics[#1]{#2}}}%
}%
\newcommand{\schoollogo}{\@ifstar{\enschoollogo}{\zhcnschoollogo}}% swap starred and non-starred versions
% \schoolbadge<*>[]{#1}
\def\ntuthesis@value@zhcn@schoolbadge{}%
\newcommand{\zhcnschoolbadge}[2][]{%
    \def\ntuthesis@value@zhcn@schoolbadge{\ntuthesisifstrbk{#1}{\zihao{-2}\bfseries\sffamily #2}{\includegraphics[#1]{#2}}}%
}%
\def\ntuthesis@value@en@schoolbadge{}%
\newcommand{\enchoolbadge}[2][]{%
    \def\ntuthesis@value@en@schoolbadge{\ntuthesisifstrbk{#1}{\zihao{-2}\bfseries\sffamily #2}{\includegraphics[#1]{#2}}}%
}%
\newcommand{\schoolbadge}{\@ifstar{\enschoolbadge}{\zhcnschoolbadge}}% swap starred and non-starred versions
% \title{#1}
\def\ntuthesis@value@zhcn@title{}%
\newcommand\zhcntitle[1]{\def\ntuthesis@value@zhcn@title{#1}}%
\def\ntuthesis@value@en@title{}%
\newcommand\entitle[1]{\def\ntuthesis@value@en@title{#1}}%
\renewcommand{\title}{\@ifstar{\entitle}{\zhcntitle}}% swap starred and non-starred versions
% \title{#1}{#2}
%\renewcommand{\title}[2][\ntuthesis@value@zhcn@title]{%
%    \def\ntuthesis@value@zhcn@title{#2}
%    \def\ntuthesis@value@zhcn@titlemark{\MakeUppercase{#1}}}
%    \def\ntuthesis@value@zhcn@titlemark{#1}
%}

% \author<*>{#1}
\def\ntuthesis@value@zhcn@author{}%
\newcommand{\zhcnauthor}[1]{\def\ntuthesis@value@zhcn@author{#1}}%
\def\ntuthesis@value@en@author{}%
\newcommand{\enauthor}[1]{\def\ntuthesis@value@en@author{#1}}%
\renewcommand{\author}{\@ifstar{\enauthor}{\zhcnauthor}}% swap starred and non-starred versions
%studentid<*>{#1}
\def\ntuthesis@value@zhcn@studentid{}%
\def\ntuthesis@value@en@studentid{}%
\newcommand{\studentid}[1]{%
    \def\ntuthesis@value@zhcn@studentid{#1}%
    \def\ntuthesis@value@en@studentid{#1}%
}%
%\newcommand{\enstudentid}[1]{\def\ntuthesis@value@en@studentid{#1}}
%\newcommand{\studentid}{\@ifstar{\enstudentid}{\zhcnstudentid}}% swap starred and non-starred versions
% \researchfield<*>{#1}
\def\ntuthesis@value@zhcn@researchfield{}%
\newcommand{\zhcnresearchfield}[1]{\long\def\ntuthesis@value@zhcn@researchfield{#1}}%
\def\ntuthesis@value@en@researchfield{}%
\newcommand{\enresearchfield}[1]{\long\def\ntuthesis@value@en@researchfield{#1}}%
\newcommand{\researchfield}{\@ifstar{\enresearchfield}{\zhcnresearchfield}}% swap starred and non-starred versions
% \advisor<*>{#1}
\def\ntuthesis@value@zhcn@advisor{}%
\newcommand{\zhcnadvisor}[1]{\long\def\ntuthesis@value@zhcn@advisor{#1}}%
\def\ntuthesis@value@en@advisor{}%
\newcommand{\enadvisor}[1]{\long\def\ntuthesis@value@en@advisor{#1}}%
\newcommand{\advisor}{\@ifstar{\enadvisor}{\zhcnadvisor}}% swap starred and non-starred versions
% \coadvisor<*>{#1}
\def\ntuthesis@value@zhcn@coadvisor{}%
\newcommand{\zhcncoadvisor}[1]{\long\def\ntuthesis@value@zhcn@coadvisor{#1}}%
\def\ntuthesis@value@en@coadvisor{}%
\newcommand{\encoadvisor}[1]{\long\def\ntuthesis@value@en@coadvisor{#1}}%
\newcommand{\coadvisor}{\@ifstar{\encoadvisor}{\zhcncoadvisor}}% swap starred and non-starred versions
% \foundation<*>{#1}
\def\ntuthesis@value@zhcn@foundation{}%
\newcommand{\zhcnfoundation}[1]{\def\ntuthesis@value@zhcn@foundation{#1}}%
\def\ntuthesis@value@en@foundation{}%
\newcommand{\enfoundation}[1]{\def\ntuthesis@value@en@foundation{#1}}%
\newcommand{\foundation}{\@ifstar{\enfoundation}{\zhcnfoundation}}% swap starred and non-starred versions
% \degree<*>{#1}
\def\ntuthesis@value@zhcn@degree{}%
\newcommand{\zhcndegree}[1]{%
	\def\ntuthesis@value@zhcn@degree{#1}%
}%
\def\ntuthesis@value@en@degree{}%
\newcommand{\englishdegree}[1]{%
	\def\ntuthesis@value@en@degree{#1}%
}%
\newcommand{\degree}{\@ifstar{\englishdegree}{\zhcndegree}}% swap starred and non-starred versions
%
% \subject<*>{#1}
\def\ntuthesis@value@zhcn@subject{}%
\newcommand{\zhcnsubject}[1]{\def\ntuthesis@value@zhcn@subject{#1}}%
\def\ntuthesis@value@en@subject{}%
\newcommand{\ensubject}[1]{\def\ntuthesis@value@en@subject{#1}}%
\newcommand{\subject}{\@ifstar{\ensubject}{\zhcnsubject}}% swap starred and non-starred versions
% \major<*>{#1}
\def\ntuthesis@value@zhcn@major{}%
\newcommand{\zhcnmajor}[1]{\def\ntuthesis@value@zhcn@major{#1}}%
\def\ntuthesis@value@en@major{}%
\newcommand{\enmajor}[1]{\def\ntuthesis@value@en@major{#1}}%
\newcommand{\major}{\@ifstar{\enmajor}{\zhcnmajor}}% swap starred and non-starred versions
% \majorcode<*>{#1}
\def\ntuthesis@value@zhcn@majorcode{}%
\def\ntuthesis@value@en@majorcode{}%
\newcommand{\majorcode}[1]{%
    \def\ntuthesis@value@zhcn@majorcode{#1}%
    \def\ntuthesis@value@en@majorcode{#1}%
}%
%\newcommand{\enmajorcode}[1]{\def\ntuthesis@value@en@majorcode{#1}}
%\newcommand{\majorcode}{\@ifstar{\enmajorcode}{\zhcnmajorcode}}% swap starred and non-starred versions
% \department<*>{#1}
\def\ntuthesis@value@zhcn@department{}%
\newcommand{\zhcndepartment}[1]{\def\ntuthesis@value@zhcn@department{#1}}%
\def\ntuthesis@value@en@department{}%
\newcommand{\englishdepartment}[1]{\def\ntuthesis@value@en@department{#1}}%
\newcommand{\department}{\@ifstar{\englishdepartment}{\zhcndepartment}}% swap starred and non-starred versions
% \school<*>{#1}
\def\ntuthesis@value@zhcn@school{}%
\newcommand{\zhcnschool}[1]{\def\ntuthesis@value@zhcn@school{#1}}%
\def\ntuthesis@value@en@school{}%
\newcommand{\enschool}[1]{\def\ntuthesis@value@en@school{#1}}%
\newcommand{\school}{\@ifstar{\enschool}{\zhcnschool}}% swap starred and non-starred versions
% \orginization<*>{#1}
\def\ntuthesis@value@zhcn@orginization{}%
\newcommand{\zhcnorginization}[1]{\def\ntuthesis@value@zhcn@orginization{#1}}%
\def\ntuthesis@value@en@orginization{}%
\newcommand{\enorginization}[1]{\def\ntuthesis@value@en@orginization{#1}}%
\newcommand{\orginization}{\@ifstar{\enorginization}{\zhcnorginization}}% swap starred and non-starred versions
% \completedate<*>{#1}{#2}{#3}
\def\ntuthesis@value@zhcn@completedate{}%
\newcommand{\zhcncompletedate}[3]{%
    \def\ntuthesis@value@zhcn@completedate@year{#1}%
    \def\ntuthesis@value@zhcn@completedate@month{#2}%
    \def\ntuthesis@value@zhcn@completedate@day{#3}%
}%
\def\ntuthesis@value@en@completedate{}%
\newcommand{\encompletedate}[3]{%
    \def\ntuthesis@value@en@completedate@year{#1}%
    \def\ntuthesis@value@en@completedate@month{#2}%
    \def\ntuthesis@value@en@completedate@day{#3}%
}%
\newcommand{\completedate}{\@ifstar{\encompletedate}{\zhcncompletedate}}% swap starred and non-starred versions

% \submitdate<*>{#1}
\def\ntuthesis@value@zhcn@submitdate{}%
\newcommand{\zhcnsubmitdate}[1]{%
    \def\ntuthesis@value@zhcn@submitdate{#1}%
}%
\def\ntuthesis@value@en@submitdate{}%
\newcommand{\ensubmitdate}[1]{\def\ntuthesis@value@en@submitdate{#1}}%
\newcommand{\submitdate}{\@ifstar{\ensubmitdate}{\zhcnsubmitdate}}% swap starred and non-starred versions
% \studydatefrom{#1}
\def\ntuthesis@value@zhcn@studydatefrom{}%
\newcommand{\studydatefrom}[1]{\def\ntuthesis@value@zhcn@studydatefrom{#1}}%
% \studydateto{#1}
\def\ntuthesis@value@zhcn@studydateto{}%
\newcommand{\studydateto}[1]{\def\ntuthesis@value@zhcn@studydateto{#1}}%
% \date<*>{#1}
\def\ntuthesis@value@zhcn@date{}%
\newcommand{\zhcndate}[1]{\def\ntuthesis@value@zhcn@date{#1}}%
\def\ntuthesis@value@en@date{}%
\newcommand{\englishdate}[1]{%
	\def\ntuthesis@value@en@date{#1}%
}%
\renewcommand{\date}{\@ifstar{\englishdate}{\zhcndate}}% swap starred and non-starred versions

%-
%-> Detect and adjust items
%-
\AtEndPreamble{%
    \ifntuthesis@academic
        \def\ntuthesis@value@zhcn@degreetype{\ntuthesis@value@zhcn@academic}
        \def\ntuthesis@value@en@degreetype{\ntuthesis@value@en@academic}
        \ifntuthesis@bachelor
            \def\ntuthesis@config@zhcn@cover@prefix{\ntuthesis@config@zhcn@cover@thesis@bachelor}%
            \def\ntuthesis@config@zhcn@cover@title{\ntuthesis@config@zhcn@cover@title@bachelor}%
            \def\ntuthesis@config@zhcn@cover@author{\ntuthesis@config@zhcn@cover@author@bachelor}%
            \def\ntuthesis@config@zhcn@cover@major{\ntuthesis@config@zhcn@cover@majorname@bachelor}%
            \def\ntuthesis@config@zhcn@cover@majorcode{\ntuthesis@config@zhcn@cover@majorcode@bachelor}%
            \def\ntuthesis@config@zhcn@cover@researchfield{\ntuthesis@config@zhcn@cover@researchfield@bachelor}%
            \def\ntuthesis@config@zhcn@cover@department{\ntuthesis@config@zhcn@cover@department@bachelor}%
            \def\ntuthesis@config@zhcn@cover@completedate{\ntuthesis@config@zhcn@cover@completedate@bachelor}
            \def\ntuthesis@config@zhcn@titlepage@prefix{\ntuthesis@config@zhcn@titlepage@thesis@bachelor}%
            \def\ntuthesis@config@zhcn@titlepage@title{\ntuthesis@config@zhcn@titlepage@title@bbachelor}%
            \def\ntuthesis@config@zhcn@titlepage@author{\ntuthesis@config@zhcn@titlepage@author@bachelor}%
            \def\ntuthesis@config@zhcn@titlepage@major{\ntuthesis@config@zhcn@titlepage@majorname@bachelor}%
            \def\ntuthesis@config@zhcn@titlepage@majorcode{\ntuthesis@config@zhcn@titlepage@majorcode@bachelor}%
            \def\ntuthesis@config@zhcn@titlepage@researchfield{\ntuthesis@config@zhcn@titlepage@researchfield@bachelor}%
            \def\ntuthesis@config@zhcn@titlepage@department{\ntuthesis@config@zhcn@titlepage@department@bachelor}%
            \def\ntuthesis@config@zhcn@titlepage@completedate{\ntuthesis@config@zhcn@titlepage@completedate@bachelor}
			\def\ntuthesis@config@zhcn@titlepage@foundation{\ntuthesis@config@zhcn@titlepage@foundation@bachelor}
            \def\ntuthesis@value@zhcn@titlemark{\ntuthesis@value@zhcn@titlemark@bachelor}%
            \def\ntuthesis@value@en@titlemark{\ntuthesis@value@en@titlemark@bachelor}%
            \def\ntuthesis@value@en@thesistype{\ntuthesis@value@en@thesistype@bachelor}%
            \def\ntuthesis@config@zhcn@declare@author{\ntuthesis@config@zhcn@declare@author@bachelor}
            \def\ntuthesis@config@zhcn@declare@advisor{\ntuthesis@config@zhcn@declare@advisor@bachelor}
            \def\ntuthesis@config@zhcn@declare@date{\ntuthesis@config@zhcn@declare@date@bachelor}%
            \def\ntuthesis@config@zhcn@declare@creativity{\ntuthesis@config@zhcn@declare@creativity@bachelor}%
            \def\ntuthesis@value@zhcn@declare@creativity{\ntuthesis@value@zhcn@declare@creativity@bachelor}%
            \def\ntuthesis@config@zhcn@declare@rights{\ntuthesis@config@zhcn@declare@rights@bachelor}
            \def\ntuthesis@value@zhcn@declare@rights{\ntuthesis@value@zhcn@declare@rights@bachelor}
            \def\ntuthesis@value@zhcn@declare@rule{\ntuthesis@value@zhcn@declare@rule@bachelor}
            \def\maketitle{%
                \maketitle@cover@academic@bachelor%
                \maketitle@declare@academic@bachelor%
                %\maketitle@titlepage@academic@bachelor%
            }
        \else
            \ifntuthesis@master
                \def\achchaptername{在攻读硕士学位期间公开发表的论文与参加的项目}
                \def\ntuthesis@config@zhcn@cover@prefix{\ntuthesis@value@zhcn@degreetype\ntuthesis@config@zhcn@cover@thesis@master}%
                \def\ntuthesis@config@zhcn@cover@title{\ntuthesis@config@zhcn@cover@title@master}%
                \def\ntuthesis@config@zhcn@cover@author{\ntuthesis@config@zhcn@cover@author@master}%
                \def\ntuthesis@config@zhcn@cover@major{\ntuthesis@config@zhcn@cover@majorname@master}%
                \def\ntuthesis@config@zhcn@cover@majorcode{\ntuthesis@config@zhcn@cover@majorcode@master}%
                \def\ntuthesis@config@zhcn@cover@researchfield{\ntuthesis@config@zhcn@cover@researchfield@master}%
                \def\ntuthesis@config@zhcn@cover@department{\ntuthesis@config@zhcn@cover@department@master}%
                \def\ntuthesis@config@zhcn@cover@completedate{\ntuthesis@config@zhcn@cover@completedate@master}
                \def\ntuthesis@config@zhcn@titlepage@prefix{\ntuthesis@config@zhcn@titlepage@thesis@master}%
                \def\ntuthesis@config@zhcn@titlepage@title{\ntuthesis@config@zhcn@titlepage@title@master}%
                \def\ntuthesis@config@zhcn@titlepage@author{\ntuthesis@config@zhcn@titlepage@author@master}%
                \def\ntuthesis@config@zhcn@titlepage@major{\ntuthesis@config@zhcn@titlepage@majorname@master}%
                \def\ntuthesis@config@zhcn@titlepage@majorcode{\ntuthesis@config@zhcn@titlepage@majorcode@master}%
                \def\ntuthesis@config@zhcn@titlepage@researchfield{\ntuthesis@config@zhcn@titlepage@researchfield@master}%
                \def\ntuthesis@config@zhcn@titlepage@department{\ntuthesis@config@zhcn@titlepage@department@master}%\ntuthesis@config@en
                \def\ntuthesis@config@zhcn@titlepage@completedate{\ntuthesis@config@zhcn@titlepage@completedate@master}
			    \def\ntuthesis@config@zhcn@titlepage@foundation{\ntuthesis@config@zhcn@titlepage@foundation@master}
                \def\ntuthesis@value@zhcn@titlemark{\ntuthesis@value@zhcn@titlemark@master}%
                \def\ntuthesis@value@en@titlemark{\ntuthesis@value@en@titlemark@master}%
                \def\ntuthesis@value@en@thesistype{\ntuthesis@value@en@thesistype@master}%
                \def\ntuthesis@config@zhcn@declare@author{\ntuthesis@config@zhcn@declare@author@master}
                \def\ntuthesis@config@zhcn@declare@advisor{\ntuthesis@config@zhcn@declare@advisor@master}
                \def\ntuthesis@config@zhcn@declare@date{\ntuthesis@config@zhcn@declare@date@master}%
                \def\ntuthesis@config@zhcn@declare@creativity{\ntuthesis@config@zhcn@declare@creativity@master}%
                \def\ntuthesis@value@zhcn@declare@creativity{\ntuthesis@value@zhcn@declare@creativity@master}%
                \def\ntuthesis@config@zhcn@declare@rights{\ntuthesis@config@zhcn@declare@rights@master}
                \def\ntuthesis@value@zhcn@declare@rights{\ntuthesis@value@zhcn@declare@rights@master}
                \def\ntuthesis@value@zhcn@declare@rule{\ntuthesis@value@zhcn@declare@rule@master}
                \def\maketitle{%
                    \maketitle@cover@academic@master%
                    \maketitle@declare@academic@master%
                    \maketitle@titlepage@academic@master%
                }
            \else
                \ifntuthesis@doctor
                    \def\achchaptername{在攻读博士学位期间公开发表的论文与参加的项目}
                    \def\ntuthesis@config@zhcn@cover@prefix{\ntuthesis@value@zhcn@degreetype\ntuthesis@config@zhcn@cover@thesis@doctor}%
                    \def\ntuthesis@config@zhcn@cover@title{\ntuthesis@config@zhcn@cover@title@doctor}%
                    \def\ntuthesis@config@zhcn@cover@author{\ntuthesis@config@zhcn@cover@author@doctor}%
                    \def\ntuthesis@config@zhcn@cover@major{\ntuthesis@config@zhcn@cover@majorname@doctor}%
                    \def\ntuthesis@config@zhcn@cover@majorcode{\ntuthesis@config@zhcn@cover@majorcode@doctor}%
                    \def\ntuthesis@config@zhcn@cover@researchfield{\ntuthesis@config@zhcn@cover@researchfield@doctor}%
                    \def\ntuthesis@config@zhcn@cover@department{\ntuthesis@config@zhcn@cover@department@doctor}%
                    \def\ntuthesis@config@zhcn@cover@completedate{\ntuthesis@config@zhcn@cover@completedate@doctor}
                    \def\ntuthesis@config@zhcn@titlepage@prefix{\ntuthesis@config@zhcn@titlepage@thesis@doctor}%
                    \def\ntuthesis@config@zhcn@titlepage@title{\ntuthesis@config@zhcn@titlepage@title@doctor}%
                    \def\ntuthesis@config@zhcn@titlepage@author{\ntuthesis@config@zhcn@titlepage@author@doctor}%
                    \def\ntuthesis@config@zhcn@titlepage@major{\ntuthesis@config@zhcn@titlepage@majorname@doctor}%
                    \def\ntuthesis@config@zhcn@titlepage@majorcode{\ntuthesis@config@zhcn@titlepage@majorcode@doctor}%
                    \def\ntuthesis@config@zhcn@titlepage@researchfield{\ntuthesis@config@zhcn@titlepage@researchfield@doctor}%
                    \def\ntuthesis@config@zhcn@titlepage@department{\ntuthesis@config@zhcn@titlepage@department@doctor}%
                    \def\ntuthesis@config@zhcn@titlepage@completedate{\ntuthesis@config@zhcn@titlepage@completedate@doctor}
                    \def\ntuthesis@config@zhcn@titlepage@foundation{\ntuthesis@config@zhcn@titlepage@foundation@doctor}
                    \def\ntuthesis@value@zhcn@titlemark{\ntuthesis@value@zhcn@titlemark@doctor}%
                    \def\ntuthesis@value@en@titlemark{\ntuthesis@value@en@titlemark@doctor}%
                    \def\ntuthesis@value@en@thesistype{\ntuthesis@value@en@thesistype@doctor}%
                    \def\maketitle{\maketitle@cover@academic@doctor}
                    \def\ntuthesis@config@zhcn@declare@author{\ntuthesis@config@zhcn@declare@author@doctor}
                    \def\ntuthesis@config@zhcn@declare@advisor{\ntuthesis@config@zhcn@declare@advisor@doctor}
                    \def\ntuthesis@config@zhcn@declare@date{\ntuthesis@config@zhcn@declare@date@doctor}%
                    \def\ntuthesis@config@zhcn@declare@creativity{\ntuthesis@config@zhcn@declare@creativity@doctor}%
                    \def\ntuthesis@value@zhcn@declare@creativity{\ntuthesis@value@zhcn@declare@creativity@doctor}%
                    \def\ntuthesis@config@zhcn@declare@rights{\ntuthesis@config@zhcn@declare@rights@doctor}
                    \def\ntuthesis@value@zhcn@declare@rights{\ntuthesis@value@zhcn@declare@rights@doctor}
                    \def\ntuthesis@value@zhcn@declare@rule{\ntuthesis@value@zhcn@declare@rule@doctor}
                    \def\maketitle{%
                        \maketitle@cover@academic@doctor%
                        \maketitle@declare@academic@doctor%
                        \maketitle@titlepage@academic@doctor%
                    }
                \else
                    \ifntuthesis@postdoc
                        \def\achchaptername{在博士后研究期间公开发表的论文与参加的项目}
                        \def\ntuthesis@config@zhcn@cover@prefix{\ntuthesis@value@zhcn@degreetype\ntuthesis@config@zhcn@cover@thesis@postdoc}%
                        \def\ntuthesis@config@zhcn@cover@title{\ntuthesis@config@zhcn@cover@title@postdoc}%
                        \def\ntuthesis@config@zhcn@cover@author{\ntuthesis@config@zhcn@cover@author@postdoc}%
                        \def\ntuthesis@config@zhcn@cover@major{\ntuthesis@config@zhcn@cover@majorname@postdoc}%
                        \def\ntuthesis@config@zhcn@cover@majorcode{\ntuthesis@config@zhcn@cover@majorcode@postdoc}%
                        \def\ntuthesis@config@zhcn@cover@researchfield{\ntuthesis@config@zhcn@cover@researchfield@postdoc}%
                        \def\ntuthesis@config@zhcn@cover@department{\ntuthesis@config@zhcn@cover@department@postdoc}%
                        \def\ntuthesis@config@zhcn@cover@completedate{\ntuthesis@config@zhcn@cover@completedate@postdoc}
                        \def\ntuthesis@config@zhcn@titlepage@prefix{\ntuthesis@config@zhcn@titlepage@thesis@postdoc}%
                        \def\ntuthesis@config@zhcn@titlepage@title{\ntuthesis@config@zhcn@titlepage@title@postdoc}%
                        \def\ntuthesis@config@zhcn@titlepage@author{\ntuthesis@config@zhcn@titlepage@author@postdoc}%
                        \def\ntuthesis@config@zhcn@titlepage@major{\ntuthesis@config@zhcn@titlepage@majorname@postdoc}%
                        \def\ntuthesis@config@zhcn@titlepage@majorcode{\ntuthesis@config@zhcn@titlepage@majorcode@postdoc}%
                        \def\ntuthesis@config@zhcn@titlepage@researchfield{\ntuthesis@config@zhcn@titlepage@researchfield@postdoc}%
                        \def\ntuthesis@config@zhcn@titlepage@department{\ntuthesis@config@zhcn@titlepage@department@postdoc}%
                        \def\ntuthesis@config@zhcn@titlepage@completedate{\ntuthesis@config@zhcn@titlepage@completedate@postdoc}
                        \def\ntuthesis@config@zhcn@titlepage@foundation{\ntuthesis@config@zhcn@titlepage@foundation@postdoc}
                        \def\ntuthesis@value@zhcn@titlemark{\ntuthesis@value@zhcn@titlemark@postdoc}%
                        \def\ntuthesis@value@en@titlemark{\ntuthesis@value@en@titlemark@postdoc}%
                        \def\ntuthesis@value@en@thesistype{\ntuthesis@value@en@thesistype@postdoc}%
                        \def\maketitle{\maketitle@cover@academic@postdoc}
                        \def\ntuthesis@config@zhcn@declare@author{\ntuthesis@config@zhcn@declare@author@postdoc}
                        \def\ntuthesis@config@zhcn@declare@advisor{\ntuthesis@config@zhcn@declare@advisor@postdoc}
                        \def\ntuthesis@config@zhcn@declare@date{\ntuthesis@config@zhcn@declare@date@postdoc}%
                        \def\ntuthesis@config@zhcn@declare@creativity{\ntuthesis@config@zhcn@declare@creativity@postdoc}%
                        \def\ntuthesis@value@zhcn@declare@creativity{\ntuthesis@value@zhcn@declare@creativity@postdoc}%
                        \def\ntuthesis@config@zhcn@declare@rights{\ntuthesis@config@zhcn@declare@rights@postdoc}
                        \def\ntuthesis@value@zhcn@declare@rights{\ntuthesis@value@zhcn@declare@rights@postdoc}
                        \def\ntuthesis@value@zhcn@declare@rule{\ntuthesis@value@zhcn@declare@rule@postdoc}
                        \def\maketitle{%
                            \maketitle@cover@academic@postdoc%
                            \maketitle@declare@academic@postdoc%
                            \maketitle@titlepage@academic@postdoc%
                        }
                    \else
                        \ClassWarning{ntuthesis}{Invalid value of 'bachelor master doctor postdoctoral', please check the spelling}%
                    \fi
                \fi    
            \fi
        \fi
    \else% profeesinal
        \def\ntuthesis@value@zhcn@degreetype{\ntuthesis@value@zhcn@professional}
        \def\ntuthesis@value@en@degreetype{\ntuthesis@value@en@professional}
        \ifntuthesis@master
            \def\achchaptername{在攻读硕士学位期间公开发表的论文与参加的项目}
            \def\ntuthesis@config@zhcn@cover@prefix{\ntuthesis@value@zhcn@degreetype\ntuthesis@config@zhcn@cover@thesis@master}%
            \def\ntuthesis@config@zhcn@cover@title{\ntuthesis@config@zhcn@cover@title@master}%
            \def\ntuthesis@config@zhcn@cover@author{\ntuthesis@config@zhcn@cover@author@master}%
            \def\ntuthesis@config@zhcn@cover@major{\ntuthesis@config@zhcn@cover@majorname@master}%
            \def\ntuthesis@config@zhcn@cover@majorcode{\ntuthesis@config@zhcn@cover@majorcode@master}%
            \def\ntuthesis@config@zhcn@cover@researchfield{\ntuthesis@config@zhcn@cover@researchfield@master}%
            \def\ntuthesis@config@zhcn@cover@department{\ntuthesis@config@zhcn@cover@department@master}%
            \def\ntuthesis@config@zhcn@cover@completedate{\ntuthesis@config@zhcn@cover@completedate@master}
            \def\ntuthesis@config@zhcn@titlepage@prefix{\ntuthesis@config@zhcn@titlepage@thesis@master}%
            \def\ntuthesis@config@zhcn@titlepage@title{\ntuthesis@config@zhcn@titlepage@title@master}%
            \def\ntuthesis@config@zhcn@titlepage@author{\ntuthesis@config@zhcn@titlepage@author@master}%
            \def\ntuthesis@config@zhcn@titlepage@major{\ntuthesis@config@zhcn@titlepage@majorname@master}%
            \def\ntuthesis@config@zhcn@titlepage@majorcode{\ntuthesis@config@zhcn@titlepage@majorcode@master}%
            \def\ntuthesis@config@zhcn@titlepage@researchfield{\ntuthesis@config@zhcn@titlepage@researchfield@master}%
            \def\ntuthesis@config@zhcn@titlepage@department{\ntuthesis@config@zhcn@titlepage@department@master}%
            \def\ntuthesis@config@zhcn@titlepage@completedate{\ntuthesis@config@zhcn@titlepage@completedate@master}
            \def\ntuthesis@config@zhcn@titlepage@foundation{\ntuthesis@config@zhcn@titlepage@foundation@master}
            \def\ntuthesis@value@zhcn@titlemark{\ntuthesis@value@zhcn@titlemark@master}%
            \def\ntuthesis@value@en@titlemark{\ntuthesis@value@en@titlemark@master}%
            \def\ntuthesis@value@en@thesistype{\ntuthesis@value@en@thesistype@master}%
            \def\maketitle{\maketitle@cover@professional@master}
            \def\ntuthesis@config@zhcn@declare@author{\ntuthesis@config@zhcn@declare@author@master}
            \def\ntuthesis@config@zhcn@declare@advisor{\ntuthesis@config@zhcn@declare@advisor@master}
            \def\ntuthesis@config@zhcn@declare@date{\ntuthesis@config@zhcn@declare@date@master}%
            \def\ntuthesis@config@zhcn@declare@creativity{\ntuthesis@config@zhcn@declare@creativity@master}%
            \def\ntuthesis@value@zhcn@declare@creativity{\ntuthesis@value@zhcn@declare@creativity@master}%
            \def\ntuthesis@config@zhcn@declare@rights{\ntuthesis@config@zhcn@declare@rights@master}
            \def\ntuthesis@value@zhcn@declare@rights{\ntuthesis@value@zhcn@declare@rights@master}
            \def\ntuthesis@value@zhcn@declare@rule{\ntuthesis@value@zhcn@declare@rule@master}
            \def\maketitle{%
                \maketitle@cover@professional@master%
                \maketitle@declare@professional@master%
                \maketitle@titlepage@professional@master%
            }
        \else
            \ifntuthesis@doctor
                \def\achchaptername{在攻读博士学位期间公开发表的论文与参加的项目}
                \def\ntuthesis@config@zhcn@cover@prefix{\ntuthesis@value@zhcn@degreetype\ntuthesis@config@zhcn@cover@thesis@doctor}%
                \def\ntuthesis@config@zhcn@cover@title{\ntuthesis@config@zhcn@cover@title@doctor}%
                \def\ntuthesis@config@zhcn@cover@author{\ntuthesis@config@zhcn@cover@author@doctor}%
                \def\ntuthesis@config@zhcn@cover@major{\ntuthesis@config@zhcn@cover@majorname@doctor}%
                \def\ntuthesis@config@zhcn@cover@majorcode{\ntuthesis@config@zhcn@cover@majorcode@doctor}%
                \def\ntuthesis@config@zhcn@cover@researchfield{\ntuthesis@config@zhcn@cover@researchfield@doctor}%
                \def\ntuthesis@config@zhcn@cover@department{\ntuthesis@config@zhcn@cover@department@doctor}%
                \def\ntuthesis@config@zhcn@cover@completedate{\ntuthesis@config@zhcn@cover@completedate@doctor}
                \def\ntuthesis@config@zhcn@titlepage@prefix{\ntuthesis@config@zhcn@titlepage@thesis@doctor}%
                \def\ntuthesis@config@zhcn@titlepage@title{\ntuthesis@config@zhcn@titlepage@title@doctor}%
                \def\ntuthesis@config@zhcn@titlepage@author{\ntuthesis@config@zhcn@titlepage@author@doctor}%
                \def\ntuthesis@config@zhcn@titlepage@major{\ntuthesis@config@zhcn@titlepage@majorname@doctor}%
                \def\ntuthesis@config@zhcn@titlepage@majorcode{\ntuthesis@config@zhcn@titlepage@majorcode@doctor}%
                \def\ntuthesis@config@zhcn@titlepage@researchfield{\ntuthesis@config@zhcn@titlepage@researchfield@doctor}%
                \def\ntuthesis@config@zhcn@titlepage@department{\ntuthesis@config@zhcn@titlepage@department@doctor}%
                \def\ntuthesis@config@zhcn@titlepage@completedate{\ntuthesis@config@zhcn@titlepage@completedate@doctor}
                \def\ntuthesis@config@zhcn@titlepage@foundation{\ntuthesis@config@zhcn@titlepage@foundation@doctor}
                \def\ntuthesis@value@zhcn@titlemark{\ntuthesis@value@zhcn@titlemark@doctor}%
                \def\ntuthesis@value@en@titlemark{\ntuthesis@value@en@titlemark@doctor}%
                \def\ntuthesis@value@en@thesistype{\ntuthesis@value@en@thesistype@doctor}%
                \def\maketitle{\maketitle@cover@professional@doctor}
                \def\ntuthesis@config@zhcn@declare@author{\ntuthesis@config@zhcn@declare@author@doctor}
                \def\ntuthesis@config@zhcn@declare@advisor{\ntuthesis@config@zhcn@declare@advisor@doctor}
                \def\ntuthesis@config@zhcn@declare@date{\ntuthesis@config@zhcn@declare@date@doctor}%
                \def\ntuthesis@config@zhcn@declare@creativity{\ntuthesis@config@zhcn@declare@creativity@doctor}%
                \def\ntuthesis@value@zhcn@declare@creativity{\ntuthesis@value@zhcn@declare@creativity@doctor}%
                \def\ntuthesis@config@zhcn@declare@rights{\ntuthesis@config@zhcn@declare@rights@doctor}
                \def\ntuthesis@value@zhcn@declare@rights{\ntuthesis@value@zhcn@declare@rights@doctor}
                \def\ntuthesis@value@zhcn@declare@rule{\ntuthesis@value@zhcn@declare@rule@doctor}
                \def\maketitle{%
                    \maketitle@cover@professional@doctor%
                    \maketitle@declare@professional@doctor%
                    \maketitle@titlepage@professional@doctor%
                }
            \else
                \ClassWarning{ntuthesis}{Invalid value of '\string\DEGREE', please check the spelling}%
            \fi
        \fi    
    \fi
}

\newcommand\makecheckmarkbox[1]{
{\zihao{2}
    \makebox[0pt][l]{$\square$}\raisebox{0.25ex}{\hspace{0.1em}{#1}}
}%
}
%-
%-> Define Chinese style
%-
\newcommand{\maketitle@cover@academic@master}{%
    \cleardoublepage
    \newgeometry{left=24mm,right=22mm,top=28mm,bottom=22mm,headheight=13pt,headsep=11mm,footskip=4.3mm}%
    \thispagestyle{empty}
    \begin{center}
    {
        \linespread{1.6}
        \zihao{4}

        %\hfill{} \ntuthesisifstrbk{\ntuthesis@value@confidential}{}{\ntuthesis@config@confidential \ulenhance{\ulextend[50pt]{\hspace*{-\ulhshift}\zihao{5}\ntuthesis@value@confidential}}}
        {\zihao{-4}\bfseries %\hfill{} 
        \ntuthesis@config@zhcn@cover@classid \ulenhance[0.75pt]{\ulextend[140pt]{\hspace*{-\ulhshift}\zihao{5}\ntuthesis@value@zhcn@classid}}
        \hfill{}
        \ntuthesis@config@zhcn@cover@schoolcode \ulenhance[0.75pt]{\ulextend[55pt]{\hspace*{-\ulhshift}\zihao{5}\ntuthesis@value@zhcn@schoolcode}}
        }

        \vspace*{\stretch{2.6}}

        {\ntuthesis@value@zhcn@schoollogo}

        \vspace*{\stretch{1}}

        {\fontsize{30pt}{20pt}\selectfont \bfseries {\ntuthesis@config@zhcn@cover@prefix}}

        \vspace*{\stretch{0.64}}

        {\ntuthesis@value@zhcn@schoolbadge}

        \vspace*{\stretch{2.96}}

        {\zihao{-2}\bfseries\ttfamily \ulenhance[1.5pt]{\ulextend[356pt]{\hspace*{-\ulhshift}\ntuthesis@value@zhcn@title}}}

        \vspace*{\stretch{3.1}}

        \def\tabcolsep{1pt}
        \def\arraystretch{1.2}
        \begin{tabular}{p{1.2cm}p{3.5cm}p{5cm}p{1.3cm}p{5cm}}
            &\makebox[7em][s]{\bfseries\ntuthesis@config@zhcn@cover@author} &{\ttfamily \ulenhance[0.75pt]{\ulextend[136pt]{\hspace*{-\ulhshift}\ntuthesis@value@zhcn@author}} } 
                & {\bfseries \ntuthesis@config@zhcn@cover@studentid} &{\ttfamily \ulenhance[0.75pt]{\ulextend[138pt]{\hspace*{-\ulhshift}\ntuthesis@value@zhcn@studentid}}}\\
            &\makebox[7em][s]{\bfseries\ntuthesis@config@zhcn@cover@advisor} &\multicolumn{3}{c}{\ttfamily\ulenhance[0.75pt]{\ulextend[320pt]{\hspace*{-\ulhshift}\ntuthesis@value@zhcn@advisor}}}\\
            &\makebox[7em][s]{\bfseries\ntuthesis@config@zhcn@cover@majorcode} &\multicolumn{3}{c}{\ttfamily\ulenhance[0.75pt]{\ulextend[320pt]{\hspace*{-\ulhshift}\ntuthesis@value@zhcn@majorcode}}} \\
            &\makebox[7em][s]{\bfseries\ntuthesis@config@zhcn@cover@major} &\multicolumn{3}{c}{\ttfamily\ulenhance[0.75pt]{\ulextend[320pt]{\hspace*{-\ulhshift}\ntuthesis@value@zhcn@major}}} \\
            &\makebox[7em][s]{\bfseries\ntuthesis@config@zhcn@cover@researchfield} &\multicolumn{3}{c}{\ttfamily\ulenhance[0.75pt]{\ulextend[320pt]{\hspace*{-\ulhshift}\ntuthesis@value@zhcn@researchfield}}}  \\
        \end{tabular}

        \vspace*{\stretch{5.75}}

        {\zihao{-3}\bfseries \ntuthesis@config@zhcn@cover@completedate}
        {\ulenhance[0.75pt]{\ulextend[60pt]{\hspace*{-\ulhshift}\zihao{-3}\ntuthesis@value@zhcn@completedate@year}}}年
        {\ulenhance[0.75pt]{\ulextend[35pt]{\hspace*{-\ulhshift}\zihao{-3}\ntuthesis@value@zhcn@completedate@month}}}月
        {\ulenhance[0.75pt]{\ulextend[45pt]{\hspace*{-\ulhshift}\zihao{-3}\ntuthesis@value@zhcn@completedate@day}}}日

        \vspace*{\stretch{3.9}}
    }
    \end{center}
    \clearpage
    \if@twoside
        \thispagestyle{empty}
        \ifntuthesis@draft
            \vspace*{\stretch{1}}
            \begin{footnotesize}
                \noindent
                Draft Version (\today)
            \end{footnotesize}
        \fi
        \cleardoublepage[empty]
    \else
        \ifntuthesis@draft
            \thispagestyle{empty}
            \vspace*{\stretch{1}}
            \begin{footnotesize}
                \noindent
                Draft Version (\today)
            \end{footnotesize}
            \cleardoublepage[empty]
        \fi
    \fi
    \ifntuthesis@print%
        \hypersetup{% set hyperlinks
            hidelinks,% remove link color and border
        }
    \fi
    \restoregeometry
}



\newcommand{\maketitle@titlepage@academic@master}{%
    \intobmk*{\cleardoublepage}{扉页}
    \newgeometry{left=24mm,right=22mm,top=28mm,bottom=22mm,headheight=13pt,headsep=11mm,footskip=4.3mm}%
    \thispagestyle{empty}
    \begin{center}
    {
        \linespread{1}
        \zihao{4}

        {\zihao{1} \bfseries \sffamily \@title}

        \vspace*{\stretch{3}}

        {\zihao{2} \bfseries \sffamily \ntuthesis@value@zhcn@title}

        \vspace*{\stretch{1.8}}

       {\rmfamily\bfseries \fontsize{14pt}{20pt}\selectfont \ntuthesis@value@en@title}

        \vspace*{\stretch{3.5}}

        \def\tabcolsep{1pt}
        \def\arraystretch{1.85}
        \begin{tabular}{p{3.5cm}p{3.5cm}p{1.3cm}p{3.5cm}}
            \makebox[7em][s]{\sffamily\ntuthesis@config@zhcn@titlepage@department} &\multicolumn{3}{l}{\bfseries \ntuthesis@value@zhcn@department}\\
            \makebox[7em][s]{\sffamily\ntuthesis@config@zhcn@titlepage@degree} &\multicolumn{3}{l}{\bfseries \ntuthesis@value@zhcn@degree} \\
            \makebox[7em][s]{\sffamily\ntuthesis@config@zhcn@titlepage@major} &\multicolumn{3}{l}{\bfseries \ntuthesis@value@zhcn@major} \\
            \makebox[7em][s]{\sffamily\ntuthesis@config@zhcn@titlepage@author} &{\bfseries \ntuthesis@value@zhcn@author} 
                & {\sffamily \ntuthesis@config@zhcn@titlepage@studentid} &{\bfseries \ntuthesis@value@zhcn@studentid}\\
            \makebox[7em][s]{\sffamily\ntuthesis@config@zhcn@titlepage@advisor} &\multicolumn{3}{l}{\bfseries \ntuthesis@value@zhcn@advisor}\\
            \makebox[7em][s]{\sffamily\ntuthesis@config@zhcn@titlepage@coadvisor} &\multicolumn{3}{l}{\bfseries \ntuthesis@value@zhcn@coadvisor}\\
            \makebox[7em][s]{\sffamily\ntuthesis@config@zhcn@titlepage@completedate} &\multicolumn{3}{l}{\bfseries \ntuthesis@value@zhcn@completedate@year 年 \ntuthesis@value@zhcn@completedate@month 月 \ntuthesis@value@zhcn@completedate@day 日}  \\
            \makebox[7em][s]{\sffamily\ntuthesis@config@zhcn@titlepage@foundation} &\multicolumn{3}{l}{\bfseries \makecell[l]{\ntuthesis@value@zhcn@foundation}}\\
            %\makebox[7em][s]{\sffamily\ntuthesis@config@zhcn@titlepage@majorcode} &\multicolumn{3}{l}{\bfseries \ntuthesis@value@zhcn@majorcode} \\
            %\makebox[7em][s]{\sffamily\ntuthesis@config@zhcn@titlepage@researchfield} &\multicolumn{3}{l}{\bfseries \ntuthesis@value@zhcn@researchfield}  \\
        \end{tabular}
        \vspace*{\stretch{2.5}}
    }
    \end{center}
    \clearpage
    \if@twoside
        \thispagestyle{empty}
        \ifntuthesis@draft
            \vspace*{\stretch{1}}
            \begin{footnotesize}
                \noindent
                Draft Version (\today)
            \end{footnotesize}
        \fi
        \cleardoublepage[empty]
    \else
        \ifntuthesis@draft
            \thispagestyle{empty}
            \vspace*{\stretch{1}}
            \begin{footnotesize}
                \noindent
                Draft Version (\today)
            \end{footnotesize}
            \cleardoublepage[empty]
        \fi
    \fi
    \ifntuthesis@print%
        \hypersetup{% set hyperlinks
            hidelinks,% remove link color and border
        }
    \fi
    \restoregeometry
}
\newcommand{\maketitle@declare@academic@master}{%
    \cleardoublepage
     \newgeometry{left=32mm,right=32mm,top=38mm,bottom=38mm,headheight=13pt,headsep=5.4mm,footskip=12mm}%
    \thispagestyle{empty}
    {   \zihao{-4}
        \setlength{\baselineskip}{20pt}

        \vspace*{2ex}
        
        \begin{center}
            \intobmk*{{\zihao{3}\bfseries\sffamily \ntuthesis@config@zhcn@declare@creativity}}{\ntuthesis@config@zhcn@declare@creativity}
        \end{center}

        \vspace*{3ex}

        \ntuthesis@value@zhcn@declare@creativity

        \vspace*{3ex}

        {\hfill{} {\ntuthesis@config@zhcn@declare@author \hspace*{9em}}}

        \vspace*{2ex}

        {\hfill{} {\ntuthesis@config@zhcn@declare@date \hspace*{9em}}}

         \vspace*{2ex}

        {\hfill{}
        .................................................................................................................................}

        \begin{center}
           \intobmk*{ {\zihao{3}\bfseries\sffamily \ntuthesis@config@zhcn@declare@rights} }{\ntuthesis@config@zhcn@declare@rights}
        \end{center}

        \vspace*{3ex}
        
        \ntuthesis@value@zhcn@declare@rights

        %{\ntuthesis@value@zhcn@declare@rule}
        {\zihao{-4} \sffamily
         \def\tabcolsep{1pt}
        \def\arraystretch{1.2}
        \begin{tabular}{p{3.5cm}p{3cm}p{6.3cm}}
            本学位论文属于：&保密 \ntuthesisifstreq{\ntuthesis@value@confidential@level}{yes}{\makecheckmarkbox{$\checkmark$}}{\makecheckmarkbox{\quad}}  &在\makecheckmarkbox{\zihao{5}\ntuthesis@value@confidential@period\phantom{0}}年解密后，适应本授权书\\
                          &不保密 \ntuthesisifstreq{\ntuthesis@value@confidential@level}{no}{\makecheckmarkbox{$\checkmark$}}{\makecheckmarkbox{\quad}}  &
        \end{tabular}
        }
        
        \vspace*{5ex}

        {\hfill{} {\ntuthesis@config@zhcn@declare@author \hspace*{8em}  \ntuthesis@config@zhcn@declare@advisor \ulextend[8em]{\hspace*{-\ulhshift}}}}

        \vspace*{2ex}

        {\hfill{} {\ntuthesis@config@zhcn@declare@date \hspace*{8em} \ntuthesis@config@zhcn@declare@date \ulextend[8em]{ \hspace*{-\ulhshift} }}}

        \vspace*{3ex}
    }
    \clearpage
    \if@twoside
        \thispagestyle{empty}
        \cleardoublepage[empty]
    \fi
    \restoregeometry
}

\def\maketitle@cover@academic@doctor{\maketitle@cover@academic@master}
\def\maketitle@titlepage@academic@doctor{\maketitle@titlepage@academic@master}
\def\maketitle@declare@academic@doctor{\maketitle@declare@academic@master}
%
\def\maketitle@cover@professional@master{\maketitle@cover@academic@master}
\def\maketitle@titlepage@professional@master{\maketitle@titlepage@academic@master}
\def\maketitle@declare@professional@master{\maketitle@declare@academic@master}
%
\def\maketitle@cover@professional@doctor{\maketitle@cover@academic@master}
\def\maketitle@titlepage@professional@doctor{\maketitle@titlepage@academic@master}
\def\maketitle@declare@professional@doctor{\maketitle@declare@academic@master}





\newcommand{\maketitle@cover@academic@bachelor}{%
    \cleardoublepage
    \newgeometry{bindingoffset=5mm,left=20mm,right=20mm,top=20mm,bottom=20mm,headheight=13pt,headsep=4mm,footskip=4.3mm}%
    \thispagestyle{empty}
    \begin{center}
        \linespread{1.45}
        \zihao{-2}\sffamily

        %\hfill{} \ntuthesisifstrbk{\ntuthesis@value@confidential}{}{\ntuthesis@config@confidential \ulenhance{\ulextend[50pt]{\hspace*{-\ulhshift}\zihao{5}\ntuthesis@value@confidential}}}

        \vspace*{\stretch{4}}

        {\ntuthesis@value@zhcn@schoollogo}

        {\ntuthesis@value@zhcn@schoolbadge}

        \vskip 5mm
        
        {\fontsize{42pt}{42pt}\selectfont \bfseries \sffamily \ntuthesis@config@zhcn@cover@prefix}

        \vspace*{\stretch{1}}

        \def\tabcolsep{1pt}
        \def\arraystretch{1.4}
        \begin{tabular}{|p{1.11cm}|p{12.57cm}|}
        \hline
        \makecell{题\\目} & {\zihao{-2}\sffamily \ulextend[356pt]{\hspace*{-\ulhshift}\ntuthesis@value@zhcn@title}} \\
        \hline
        \end{tabular}

        \vskip 32.5mm

        \def\tabcolsep{2pt}
        \def\arraystretch{1}
        \begin{tabular}{p{3.1cm}p{6.29cm}}
            %\hline
            \makebox[5em][s]{\bfseries\ntuthesis@config@zhcn@cover@author} &{\rmfamily\zihao{3} \ulenhance[0.75pt]{\ulextend[175pt]{\hspace*{-\ulhshift}\ntuthesis@value@zhcn@author}} }\\
            \makebox[5em][s]{\bfseries\ntuthesis@config@zhcn@cover@major} &{\rmfamily\zihao{3} \ulenhance[0.75pt]{\ulextend[175pt]{\hspace*{-\ulhshift}\ntuthesis@value@zhcn@major}}}\\
            \makebox[5em][s]{\bfseries\ntuthesis@config@zhcn@cover@advisor} &{\rmfamily\zihao{3} \ulenhance[0.75pt]{\ulextend[175pt]{\hspace*{-\ulhshift}\ntuthesis@value@zhcn@advisor}}}\\
            \makebox[5em][s]{\bfseries\ntuthesis@config@zhcn@cover@completedate} &{\rmfamily\zihao{3}  \ulenhance[0.75pt]{\ulextend[175pt]{\hspace*{-\ulhshift}\ntuthesis@value@zhcn@completedate@year 年 \ntuthesis@value@zhcn@completedate@month 月 \ntuthesis@value@zhcn@completedate@day 日}} }  \\
            %\hline
        \end{tabular}

        \vspace*{\stretch{8}}
    \end{center}
    \clearpage
    \if@twoside
        \thispagestyle{empty}
        \ifntuthesis@draft
            \vspace*{\stretch{1}}
            \begin{footnotesize}
                \noindent
                Draft Version (\today)
            \end{footnotesize}
        \fi
        \cleardoublepage[empty]
    \else
        \ifntuthesis@draft
            \thispagestyle{empty}
            \vspace*{\stretch{1}}
            \begin{footnotesize}
                \noindent
                Draft Version (\today)
            \end{footnotesize}
            \cleardoublepage[empty]
        \fi
    \fi
    \ifntuthesis@print%
        \hypersetup{% set hyperlinks
            hidelinks,% remove link color and border
        }
    \fi
    \restoregeometry
}

\newcommand{\maketitle@declare@academic@bachelor}{%
    \cleardoublepage
    \newgeometry{bindingoffset=5mm,left=20mm,right=20mm,top=20mm,bottom=20mm,headheight=13pt,headsep=4mm,footskip=4.3mm}%
    \thispagestyle{empty}
    {   \linespread{1.9}\zihao{4}
        
        \vspace*{2ex}
        
        \begin{center}
            \intobmk*{{\zihao{2}\bfseries\rmfamily\ntuthesis@config@zhcn@declare@creativity}}{\ntuthesis@config@zhcn@declare@creativity}
        \end{center}

        \vspace*{1ex}

        \ntuthesis@value@zhcn@declare@creativity

        \vspace*{7ex}

        {\hfill{} 
        \ntuthesis@config@zhcn@declare@author\ulenhance[0.75pt]{\ulextend[6em]{\hspace*{-\ulhshift}}}
        \ntuthesis@config@zhcn@declare@date\ulenhance[0.75pt]{\ulextend[6em]{\hspace*{-\ulhshift}}}
        }

        \vspace*{10ex}

        \begin{center}
           \intobmk*{{\zihao{2}\bfseries\rmfamily\ntuthesis@config@zhcn@declare@rights}}{\ntuthesis@config@zhcn@declare@rights}
        \end{center}

        \vspace*{1ex}
        
        \ntuthesis@value@zhcn@declare@rights

        {\bfseries \ntuthesis@value@zhcn@declare@rule}
        
        \vspace*{7ex}

        {
        \ntuthesis@config@zhcn@declare@author\ulenhance[0.75pt]{\ulextend[5em]{\hspace*{-\ulhshift}}}
        \ntuthesis@config@zhcn@declare@advisor\ulenhance[0.75pt]{\ulextend[5em]{\hspace*{-\ulhshift}}}
        \ntuthesis@config@zhcn@declare@date\ulenhance[0.75pt]{\ulextend[5em]{\hspace*{-\ulhshift}}}
        \hfill{} 
        }

        \vspace*{3ex}
    }
    \clearpage
    \if@twoside
        \thispagestyle{empty}
        \cleardoublepage[empty]
    \fi
    \restoregeometry
}
%---------------------------------------------------------------------------%
%->> Structure elements
%---------------------------------------------------------------------------%
\ifntuthesis@plain%
    \def\contentsname{\ntuthesis@config@en@tocname}
    \def\listfigurename{\ntuthesis@config@en@lsfigname}
    \def\listtablename{\ntuthesis@config@en@lstabname}
    \def\bibname{\ntuthesis@config@en@bibname}
    \def\refname{\ntuthesis@config@en@bibname}
    \def\algname{\ntuthesis@config@en@algname}
    \def\bibetal{\ntuthesis@config@en@bibetal}
    \def\biband{\ntuthesis@config@en@biband}
    \def\axiomname{\ntuthesis@config@en@axiomname}
    \def\theoremname{\ntuthesis@config@en@theoremname}
    \def\lemmaname{\ntuthesis@config@en@lemmaname}
    \def\corollaryname{\ntuthesis@config@en@corollaryname}
    \def\assertionname{\ntuthesis@config@en@assertionname}
    \def\propositionname{\ntuthesis@config@en@propositionname}
    \def\conjecturename{\ntuthesis@config@en@conjecturename}
    \def\definitionname{\ntuthesis@config@en@definitionname}
    \def\examplename{\ntuthesis@config@en@examplename}
    \def\remarkname{\ntuthesis@config@en@remarkname}
    \def\proofname{\ntuthesis@config@en@proofname}
    \def\@title{\ntuthesis@value@en@titlemark}
    \def\@author{\ntuthesis@value@en@author}
\else
    \def\contentsname{\ntuthesis@config@zhcn@tocname}
    \def\listfigurename{\ntuthesis@config@zhcn@lsfigname}
    \def\listtablename{\ntuthesis@config@zhcn@lstabname}
    \def\algname{\ntuthesis@config@zhcn@algname}
    \def\bibname{\ntuthesis@config@zhcn@bibname}
    \def\refname{\ntuthesis@config@zhcn@bibname}
    \def\bibetal{\ntuthesis@config@zhcn@bibetal}
    \def\biband{\ntuthesis@config@zhcn@biband}
    \def\axiomname{\ntuthesis@config@zhcn@axiomname}
    \def\theoremname{\ntuthesis@config@zhcn@theoremname}
    \def\lemmaname{\ntuthesis@config@zhcn@lemmaname}
    \def\corollaryname{\ntuthesis@config@zhcn@corollaryname}
    \def\assertionname{\ntuthesis@config@zhcn@assertionname}
    \def\propositionname{\ntuthesis@config@zhcn@propositionname}
    \def\conjecturename{\ntuthesis@config@zhcn@conjecturename}
    \def\definitionname{\ntuthesis@config@zhcn@definitionname}
    \def\examplename{\ntuthesis@config@zhcn@examplename}
    \def\remarkname{\ntuthesis@config@zhcn@remarkname}
    \def\proofname{\ntuthesis@config@zhcn@proofname}
    \def\@title{\ntuthesis@value@zhcn@titlemark}
    \def\@author{\ntuthesis@value@zhcn@author}
\fi
%---------------------------------------------------------------------------%
%->> Structure layout
%---------------------------------------------------------------------------%
\ifntuthesis@bachelor
%- chapter
\ctexset {
    chapter = {
        format = \linespread{1.6}\zihao{-3}\bfseries\sffamily\centering,
        nameformat = {},
        titleformat = {},
        number = \zhnum{chapter},
        numberformat = \zihao{-3}\bfseries\sffamily,
        aftername = \quad,
        beforeskip = {0pt},
        afterskip = {20pt},
        pagestyle = plain,
    }
}
%- section
\ctexset {
    section = {
        format = \linespread{1.6}\zihao{4}\bfseries\rmfamily\raggedright,
        numberformat = \rmfamily,
        aftername = \quad,
        beforeskip = {13pt},
        afterskip = {13pt},
    }
}
%- subsection
\ctexset {
    subsection = {
        format = \linespread{1.6}\zihao{-4}\bfseries\rmfamily\raggedright,
        numberformat = \rmfamily,
        aftername = \quad,
        beforeskip = {13pt},
        afterskip = {13pt},
    }
}
%- subsubsection
\ctexset {
    subsubsection = {
        format = \linespread{1.6}\zihao{-4}\raggedright,
        numberformat = \rmfamily,
        aftername = \quad,
        beforeskip = {13pt},
        afterskip = {13pt},
    }
}
%- appendix
\ctexset {
    appendix = {
        numbering = true,
        number = \Alph{chapter},
    }
}
\else
%- chapter
\ctexset {
    chapter = {
        format = \linespread{1.0}\zihao{-3}\bfseries\sffamily\centering,
        nameformat = {},
        titleformat = {},
        number = \zhnum{chapter},
        numberformat = \zihao{-3}\bfseries\sffamily,
        aftername = \quad,
        beforeskip = {25pt},
        afterskip = {45pt},
        pagestyle = plain,
    }
}
%- section
\ctexset {
    section = {
        format = \linespread{1.0}\zihao{4}\sffamily\raggedright,
        numberformat = \rmfamily,
        aftername = \quad,
        beforeskip = {13pt},
        afterskip = {13pt},
    }
}
%- subsection
\ctexset {
    subsection = {
        format = \linespread{1.0}\zihao{-4}\raggedright,
        numberformat = \rmfamily,
        aftername = \quad,
        beforeskip = {13pt},
        afterskip = {13pt},
    }
}
%- subsubsection
\ctexset {
    subsubsection = {
        format = \linespread{1.0}\zihao{-4}\raggedright,
        numberformat = \rmfamily,
        aftername = \quad,
        beforeskip = {13pt},
        afterskip = {13pt},
    }
}
%- appendix
\ctexset {
    appendix = {
        numbering = true,
        number = \Alph{chapter},
    }
}
\fi
%---------------------------------------------------------------------------%
%->> Configure table of contents
%---------------------------------------------------------------------------%
%- the table of contents is specified by defining \l@chapter, \l@section, ...
%- most commands are then defined with the \@dottedtocline:
%- \@dottedtocline{⟨level⟩}{⟨indent⟩}{⟨numwidth⟩}{⟨title⟩}{⟨page⟩}
%- ⟨level⟩    an entry is produced only if ⟨level⟩ <= value of the tocdepth counter
%-            note, \chapter is level 0, \section is level 1, etc
%- ⟨indent⟩   indentation from the outer left margin of the start of the contents line
%- ⟨numwidth⟩ width of a box in which the section number is to go
%- <title>    title
%- <page>     page number

%- parameters for spacing and length in toc
\def\@dotsep{1.5mu}% separation between dots in mu units
\def\@pnumwidth{2em}% width of a box in which the page number is put
\def\@tocrmarg{2em}% right margin for multiple line entries, \@tocrmarg ≥ \@pnumwidth
\def\@chaptervspace{1ex}% vertical space between chapter titles

%- redefine dottedtocline from classes.dtx and latex.ltx
\renewcommand*{\@dottedtocline}[5]{% [<level>,<indent>,<numwidth>,<title>,<page>]
    \ifnum #1>\c@tocdepth \else
        \vskip \z@ \@plus.2\p@
        {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
        \parindent #2\relax\@afterindenttrue
        \interlinepenalty\@M
        \leavevmode \zihao{-4}\sffamily
        \@tempdima #3\relax
        \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
        {#4}\nobreak
        \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}\hfill
        \nobreak
        \hb@xt@\@pnumwidth{\hfil\normalfont \normalcolor #5}%
        \par\penalty\@highpenalty}%
    \fi
}
%- redefine l@part from book.cls to add dotted toc line
\renewcommand*{\l@part}[2]{% [<title>,<page>]
    \ifnum \c@tocdepth >-2\relax
        \addpenalty{-\@highpenalty}%
        \addvspace{2.25em \@plus\p@}%
        \setlength\@tempdima{3em}%
        \begingroup
            \parindent \z@ \rightskip \@pnumwidth
            \parfillskip -\@pnumwidth
            {\leavevmode
            \zihao{4}\sffamily #1
            \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}% add dotted toc line
            \hfil \hb@xt@\@pnumwidth{\hss #2}}\par
            \nobreak
            \global\@nobreaktrue
            \everypar{\global\@nobreakfalse\everypar{}}%
        \endgroup
    \fi
}
%- redefine l@chapter from book.cls to add dotted toc line
\renewcommand*{\l@chapter}[2]{% [<title>,<page>]
    \ifnum \c@tocdepth >\m@ne
        \addpenalty{-\@highpenalty}%
        \vskip \@chaptervspace \@plus\p@
        \setlength\@tempdima{1.5em}%
        \begingroup
            \parindent \z@ \rightskip \@pnumwidth
            \parfillskip -\@pnumwidth
            \leavevmode \zihao{4}\sffamily
            \advance\leftskip\@tempdima
            \hskip -\leftskip
            #1\nobreak
            \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}% add dotted toc line
            \hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
            \penalty\@highpenalty
        \endgroup
    \fi
}
%- redefine indentation for others
\renewcommand*\l@section{\@dottedtocline{1}{2em}{1.8em}}
\renewcommand*\l@subsection{\@dottedtocline{2}{4em}{2.8em}}
\renewcommand*\l@subsubsection{\@dottedtocline{3}{6em}{3.8em}}
\renewcommand*\l@paragraph{\@dottedtocline{4}{8em}{4.8em}}
\renewcommand*\l@subparagraph{\@dottedtocline{5}{10em}{5.8em}}
\renewcommand*\l@figure{\@dottedtocline{1}{1em}{1.8em}}
\renewcommand*\l@table{\@dottedtocline{1}{1em}{1.8em}}
%---------------------------------------------------------------------------%

% define Chinese Abstract environment
\newenvironment{abstract}
{%start part
    \cleardoublepage
    %\setcounter{page}{1}% 开始页码
    %\pagenumbering{roman}% 页码符号
    \linespread{1}\xiaosi
    \ifntuthesis@bachelor
        \abstracttitle{摘 \quad\quad 要}{12pt}{12pt}
    \else
        \frontabstract
        \abstracttitle{摘\quad 要}{25pt}{25pt}
    \fi
    \par
}{}


% define English Abstract environment
\newenvironment{abstract*}
{%start part
    \cleardoublepage
    \linespread{1}\fontsize{14pt}{20pt}\selectfont
    \ifntuthesis@bachelor
        \abstracttitle*{ABSTRACT}{12pt}{12pt}
    \else
        \frontabstract*
        \abstracttitle*{Absrtact}{25pt}{25pt}
    \fi
    \par
}{%endpart
}


% define Chinese review environment
\newenvironment{review}
{%start part
    %\begin{quotation}
    \begin{refsection}
    \intotoc\chapter*{综述}% add link to toc
    
}{%endpart
    {\linespread{1.25}
    \printbibliography[title=综述参考文献,heading=bibintoc]
    %\ntuthesisbibliography%{ref}
    }
    \end{refsection}
    %\end{quotation}
}

% define Chinese backitem environment
\newenvironment{backitem}
{%start part
    \setlist[enumerate]{}% restore default behavior
    \linespread{1.25}\zihao{5}
    \begin{enumerate}
    \renewcommand{\labelenumi}{[\theenumi]}
}{%endpart
    \end{enumerate}
}

% Define the chapter of Academmic Achievements
\newenvironment{achievement}{%
    \chapter{\achchaptername}
    }{}

% Define the chapter of Academmic Achievements
\newenvironment{acknowledgment}{%
    \intotoc\chapter*{致\quad 谢}
    %\chapter[致\quad 谢]{致\quad 谢}
    %\chaptermark{致\quad 谢}% syntax: \chapter[目录]{标题}\chaptermark{页眉}
    %\thispagestyle{noheaderstyle}% 如果需要移除当前页的页眉
    %\pagestyle{noheaderstyle}% 如果需要移除整章的页眉
    }{%
        \par \hfill{} \ntuthesis@value@zhcn@author
    }


% define Chinese abbrv environment
\newcommand{\addabbrvheader}[3]{
    {\zihao{4}\sffamily #1} & {\zihao{4}\sffamily #2} & {\zihao{4}\sffamily #3}\\ [10pt]
}%
\newcommand{\addabbrvitem}[3]{
    {\fontsize{12pt}{12pt}\selectfont #1} & {\fontsize{12pt}{12pt}\selectfont  #2} & {\fontsize{12pt}{12pt}\selectfont  #3}\\
}%
\newenvironment{abbreviation}
{%start part
    %\linespread{1}
    \def\tabcolsep{5pt}
    \def\arraystretch{0.9}
    \centering
    \begin{tabular}{p{1.5cm}p{7cm}p{5.5cm}}
        \addabbrvheader{缩写}{英文全称}{中文}
}{%endpart
    \end{tabular}
}
\endinput

