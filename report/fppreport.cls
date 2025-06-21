% **********************************************************************
% Copyright 2025 ULFPP

% Author: Aleksander GRM @fpp.uni-lj.si
% Description: This is an official latex ULFPP report class template.
% Version: 1.0
% Date: 20/06/2025
% **********************************************************************

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fppreport}[2025/07/10 Poročila na FPP]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NALAGANJE POTREBNIH PAKETOV
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{amsfonts,amsmath,amssymb,amsthm}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage{newfile}
\RequirePackage{etoolbox}
\RequirePackage{ifthen}
\RequirePackage{keyval}
\RequirePackage{makeidx}
\RequirePackage{setspace}
\RequirePackage{graphicx}

\newcommand{\@ifthen}[2]{\ifthenelse{#1}{#2}{\relax}}
\newcommand{\@unless}[2]{\ifthenelse{#1}{\relax}{#2}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OPCIJE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newboolean{@tisk}

%
% *************************
% *** Program POMORSTVO ***
% *************************
\DeclareOption{pomnav}{
	\def\@program{Dodiplomski visokošolski program prve stopnje}
	\def\@smer{Navtika}
}
\DeclareOption{pomstr}{
	\def\@program{Dodiplomski visokošolski program prve stopnje}
	\def\@smer{Pomorsko strojništvo}
}
\DeclareOption{pom2}{
	\def\@program{Drugostopenjski podiplomski študijski program}
	\def\@smer{Pomorstvo}
}
%
% *************************
% *** Program PROMET ***
% *************************
\DeclareOption{promuni}{
	\def\@program{Dodiplomski univerzitetni program prve stopnje}
	\def\@smer{Transport in prometna logistika}
}
\DeclareOption{prompttl}{
	\def\@program{Dodiplomski visokošolski program prve stopnje}
	\def\@smer{Prometna tehnologija in transportna logistika}
}
\DeclareOption{prom2}{
	\def\@program{Drugostopenjski podiplomski študijski program}
	\def\@smer{Promet}
}
%
% *** Druge nastavitve ***
%
\DeclareOption{tisk}{
  \setboolean{@tisk}{true}
  \PassOptionsToClass{twoside}{article}
}
%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
%
%
%
\ProcessOptions\relax
\LoadClass[12pt, a4paper]{article}
%
\RequirePackage[slovene]{babel}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VNOS METAPODATKOV
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\@definefield}[2]{
  % \definefield{@imepolja}{...} načeloma naredi \def\@imepolja{...},
  % le da pri tem iz ... pobriše presledke
  % Iz imena ukaza dobimo ukaz s pomočjo \csname kot
  %   \csname imeukaza\endcsname ~> \imeukaza
  % Če bi napisali \def\csname @imepolja\endcsname{...} bi to povozilo ukaz
  % \csname, zato moramo uporabiti \expandafter, da najprej izvedemo \csname,
  % šele nato \def.
  \expandafter\def\csname #1\endcsname{\ifblank{#2}{}{#2}}
}
\newcommand{\@definerequiredfield}[2]{
  \@definefield{#1}{#2}
  {
    % Ker ključne besede vsebujejo nedefinirano ločilo \sep, ga za potrebe
    % preverjanja lokalno definiramo (zato par zavitih oklepajev).
    \def\sep{\relax}
    \@ifthen{\equal{\csname #1\endcsname}{}}{
      \PackageError{fppthesis}{Polje je zahtevano.}{}
    }
  }
}
\def\@mentorji{}
\def\@supervisors{}
\newcommand{\@dodajmentorja}[3]{%
  \g@addto@macro\@mentorji{\textit{#1}: & #3 \\}%
}
\newcommand{\@dodajdvamentorja}[4]{%
  \g@addto@macro\@mentorji{\textit{#1}: & #3 \\ & #4 \\}%
}
\newcommand{\@addsupervisor}[3]{%
  \g@addto@macro\@supervisors{\textit{#1}: & #3 \\}%
}
\newcommand{\@addsupervisors}[4]{%
  \g@addto@macro\@supervisors{\textit{#1}: & #3 \\ & #4 \\}%
}
\newcommand{\@it@addsupervisor}[3]{%
  \g@addto@macro\@it@supervisors{\textit{#1}: & #3 \\}%
}
\newcommand{\@it@addsupervisors}[4]{%
  \g@addto@macro\@it@supervisors{\textit{#1}: & #3 \\ & #4 \\}%
}

\newcommand{\avtor}{\@definerequiredfield{@avtor}}
\newcommand{\naslov}{\@definerequiredfield{@naslov}}
\newcommand{\mesec}{\@definerequiredfield{@mesec}}
\newcommand{\leto}{\@definerequiredfield{@leto}}
\newcommand{\stevilka}{\@definerequiredfield{@stevilka}}
\newcommand{\zahvala}{\@definefield{@zahvala}}
\newcommand{\povzetek}{\@definerequiredfield{@povzetek}}
\newcommand{\kljucnebesede}{\@definerequiredfield{@kljucnebesede}}

\newcommand{\mentor}{\@dodajmentorja{Mentor}{mentorja}}
\newcommand{\somentor}{\@dodajmentorja{Somentor}{somentorja}}
\newcommand{\mentorica}{\@dodajmentorja{Mentorica}{mentorice}}
\newcommand{\somentorica}{\@dodajmentorja{Somentorica}{somentorice}}
\newcommand{\mentorja}{\@dodajdvamentorja{Mentorja}{mentorjev}}
\newcommand{\somentorja}{\@dodajdvamentorja{Somentorja}{somentorjev}}
\newcommand{\mentorici}{\@dodajdvamentorja{Mentorici}{mentoric}}
\newcommand{\somentorici}{\@dodajdvamentorja{Somentorici}{somentoric}}

\newcommand{\vkljucibibliografijo}[1]{%
	\cleardoublepage
	\singlespacing
	\addcontentsline{toc}{section}{Literatura}
	\bibliographystyle{plainnat}
	\bibliography{#1}
}

\newboolean{@anglescina}
\setboolean{@anglescina}{false} % or true, depending on your default

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IZPIS PDF/A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AtEndPreamble{%
\let\oldtexorpdfstring\texorpdfstring
\renewcommand{\texorpdfstring}[2]{#2}
\let\sep{\protect\sep}
\newoutputstream{xmpdatafile}
\openoutputfile{\jobname.xmpdata}{xmpdatafile}
\addtostream{xmpdatafile}{%
	\protect\Title{\@naslov}
	\protect\Author{\@avtor}
	\protect\Keywords{\@kljucnebesede}
}

\closeoutputstream{xmpdatafile}

\let\texorpdfstring\oldtexorpdfstring

% Nalozimo paket za zagotavljanje PDF/A-2B (ustrezni fonti, barvni profili, UTF-8 zapis simbolov, ...)
\RequirePackage[a-2b]{pdfx}
\ifthenelse{\boolean{@tisk}}{
  \definecolor{linkcolor}{RGB}{0,0,0}
}{
  \definecolor{linkcolor}{RGB}{0,84,147}
}
\hypersetup{bookmarksopen, bookmarksdepth=3, colorlinks=true,
  linkcolor=linkcolor, anchorcolor=linkcolor, citecolor=linkcolor, filecolor=linkcolor,
  menucolor=linkcolor, runcolor=linkcolor, urlcolor=linkcolor, pdfencoding=auto,
  breaklinks=true, psdextra}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DIMENZIJE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\textwidth 15cm
\textheight 24cm
\oddsidemargin.5cm
\evensidemargin.5cm
\topmargin-5mm
\addtolength{\footskip}{10pt}
\overfullrule=15pt


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RAZNO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% števec za enačbe zgleda kot (2.7) in se resetira v vsakem razdelku
\numberwithin{equation}{section}  

% bold matematika znotraj \textbf{ }, tudi v naslovih
\g@addto@macro\bfseries{\boldmath}

% Poimenuj kazalo slik kot ``Kazalo slik'' in ne ``Slike''
\addto\captionsslovene{
  \renewcommand{\listfigurename}{Kazalo slik}%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IZPIS ZAČETNIH STRANI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%\def\@frontpages{\@frontpages}

%
% *** Začetek dokumenta ***
%
\def\@frontpages{
	
	\pagestyle{empty}
	%
	\@naslovnica
	\cleardoublepage
	
	\pagestyle{plain}
	%\@frontpages@zahvala
	\cleardoublepage
	%
	\@toc
	%
	\pdfbookmark[1]{Povzetek}{povzetek}
	\@frontpage@povzetek
	\@frontpage@kljucnebesede
	\cleardoublepage	
}
%
% *** Kazalo ***
%
\def\@toc{
  \pdfbookmark[1]{\contentsname}{kazalo-vsebine}
  \tableofcontents
  \vfill
  \cleardoublepage
}
%
% *** Naslovna stran - SLO - mentorji ***
%
\def\@naslovnica{
	\noindent
	\begin{center}
		\textsc{Univerza v Ljubljani}\\[1mm]
		\textsc{Fakulteta za Pomorstvo in Promet}
		\\[5cm]
		
		{\Large
			\textsc{Projektna Naloga}
		}
		\\[2cm]
		
		{\Large
			\doublespacing
			\textbf{\MakeUppercase{\@naslov}}
			\singlespacing
		}
		\vskip 10mm
		\@avtor
	\end{center}

	\vfill
	
	\begin{tabular}{ll}
		\@mentorji
	\end{tabular}

	\vskip 5mm

	\begin{tabular}{ll}
		\textit{Študijski program}: & \@program \\
		\textit{Smer študija}:      & \@smer \\
		\textit{Vpisna številka}:   & \@stevilka
	\end{tabular}
	
	\vskip 2cm
	
	\begin{center}
		\noindent
		Portorož, \@mesec~\@leto
	\end{center}
}
%
% *** povzetek ***
%
\def\@frontpage@povzetek{
  \begin{center}
    \textbf{\@naslov}\\[3mm]
    \textsc{Povzetek}
  \end{center}
  \@povzetek
  \vfill
}
%
% *** ključne besede ***
%
\def\@frontpage@kljucnebesede{
  \noindent
  \def\sep{, } % Pri izpisu ključne besede ločimo z vejico.
  \textbf{Ključne besede:} \@kljucnebesede
}
%
% *** številčenje ***
%
\AfterEndPreamble{%
	% začetne strani številčimo z rimskimi številkami
	\pagenumbering{roman}
	\pagestyle{plain}
	\@frontpages
	
	% vsebino številčimo z arabskimi številkami od 1 naprej
	\setcounter{page}{1}
	\pagenumbering{arabic}
	
	% *** formatiranje odstavka ***
	\setlength{\parskip}{16pt}  % razmak med odstavki
	\setlength{\parindent}{0pt} % poravnava v začetku odstavka
}
