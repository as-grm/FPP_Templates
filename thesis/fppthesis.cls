% **********************************************************************
% Copyright 2025 ULFPP

% Author: Aleksander GRM @fpp.uni-lj.si
% Description: This is an official latex ULFPP thesis class template.
% Version: 1.0
% Date: 20/06/2025
% **********************************************************************

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fppthesis}[2025/07/10 Zakljucna dela na FPP]

% ******************************************************************
% !!! POMEMBNO: class je narejen za prevajanje z pdflatex ukazom !!!
% ******************************************************************

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

\newboolean{@magisterij}
\newboolean{@doktorat}
\newboolean{@anglescina}
\newboolean{@tisk}
\newcommand{\@sloeng}[2]{\ifthenelse{\boolean{@anglescina}}{#2}{#1}}

%
\DeclareOption{anglescina}{\setboolean{@anglescina}{true}}
%
% *************************
% *** Program POMORSTVO ***
% *************************
\DeclareOption{pomnav}{
	\def\@program{Dodiplomski visokošolski program prve stopnje}
	\def\@smer{Navtika}
	\def\@imenaloge{DIPLOMSKA NALOGA}
	\def\@programme{missing}
	\def\@thesisname{DIPLOMA THESIS}
}
\DeclareOption{pomstr}{
	\def\@program{Dodiplomski visokošolski program prve stopnje}
	\def\@smer{Pomorsko strojništvo}
	\def\@imenaloge{DIPLOMSKA NALOGA}
	\def\@programme{missing}
	\def\@thesisname{DIPLOMA THESIS}
}
\DeclareOption{pom2}{
	\def\@program{Drugostopenjski podiplomski študijski program}
	\def\@smer{Pomorstvo}
	\def\@imenaloge{MAGISTRSKA NALOGA}
	\def\@thesisname{MASTER'S THESIS}
	\setboolean{@magisterij}{true}
}
%
% *************************
% *** Program PROMET ***
% *************************
\DeclareOption{promuni}{
	\def\@program{Dodiplomski univerzitetni program prve stopnje}
	\def\@smer{Transport in prometna logistika}
	\def\@imenaloge{DIPLOMSKA NALOGA}
	\def\@programme{missing}
	\def\@thesisname{DIPLOMA THESIS}
}
\DeclareOption{prompttl}{
	\def\@program{Dodiplomski visokošolski program prve stopnje}
	\def\@smer{Prometna tehnologija in transportna logistika}
	\def\@imenaloge{DIPLOMSKA NALOGA}
	\def\@programme{missing}
	\def\@thesisname{DIPLOMA THESIS}
}
\DeclareOption{prom2}{
	\def\@program{Drugostopenjski podiplomski študijski program}
	\def\@smer{Promet}
	\def\@imenaloge{MAGISTRSKA NALOGA}
	\def\@thesisname{MASTER'S THESIS}
	\setboolean{@magisterij}{true}
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
\ifthenelse{\boolean{@doktorat}}{
  \def\@stopnja{3. stopnja}
  \def\@tipdela{Doktorska naloga}
  \def\@cycle{3rd cycle }
  \def\@thesistype{PhD thesis}
}
%
\ifthenelse{\boolean{@magisterij}}{
	\def\@stopnja{2. stopnja}
	\def\@tipdela{Magistrsko delo}
	\def\@cycle{2nd cycle}
	\def\@thesistype{Master's thesis}
}{
  \def\@stopnja{1. stopnja}
  \def\@tipdela{Diplomsko delo}
  \def\@cycle{1st cycle}
  \def\@thesistype{Diploma thesis}
}
%
\@sloeng{
  \RequirePackage[slovene]{babel}
}{
  \RequirePackage[slovene,english]{babel}
  \selectlanguage{english}
}


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
\renewcommand{\title}{\@definerequiredfield{@title}}
\newcommand{\mesec}{\@definerequiredfield{@mesec}}
\newcommand{\leto}{\@definerequiredfield{@leto}}
\newcommand{\stevilka}{\@definerequiredfield{@stevilka}}
\newcommand{\zahvala}{\@definefield{@zahvala}}
\newcommand{\povzetek}{\@definerequiredfield{@povzetek}}
\renewcommand{\abstract}{\@definerequiredfield{@abstract}}
\newcommand{\kljucnebesede}{\@definerequiredfield{@kljucnebesede}}
\newcommand{\keywords}{\@definerequiredfield{@keywords}}
\newcommand{\sklep}{\@definerequiredfield{@sklep}}

\@ifthen{\boolean{@anglescina}}{
  \newcommand{\razsirjenipovzetek}{\@definerequiredfield{@razsirjenipovzetek}}
}

\newcommand{\geslo}[2]{\noindent\textbf{#1}\hspace*{3mm}\hangindent=\parindent\hangafter=1 #2\par}

\newcommand{\mentor}{\@dodajmentorja{Mentor}{mentorja}}
\newcommand{\somentor}{\@dodajmentorja{Somentor}{somentorja}}
\newcommand{\mentorica}{\@dodajmentorja{Mentorica}{mentorice}}
\newcommand{\somentorica}{\@dodajmentorja{Somentorica}{somentorice}}
\newcommand{\mentorja}{\@dodajdvamentorja{Mentorja}{mentorjev}}
\newcommand{\somentorja}{\@dodajdvamentorja{Somentorja}{somentorjev}}
\newcommand{\mentorici}{\@dodajdvamentorja{Mentorici}{mentoric}}
\newcommand{\somentorici}{\@dodajdvamentorja{Somentorici}{somentoric}}
\newcommand{\lektor}{\@dodajmentorja{Jezikovni pregled}{mentorja}}
\newcommand{\supervisor}[1]{\@addsupervisor{Supervisor}{Supervisor's}{#1}}
\newcommand{\cosupervisor}[1]{\@addsupervisor{Co-supervisor}{Co-supervisor's}{#1}}
\newcommand{\supervisors}[2]{\@addsupervisors{Supervisors}{Supervisors'}{#1}{#2}}
\newcommand{\cosupervisors}[2]{\@addsupervisors{Co-supervisors}{Co-supervisors'}{#1}{#2}}


\newcommand{\vkljucibibliografijo}[1]{%
	\cleardoublepage
	\singlespacing
	\addcontentsline{toc}{section}{Literatura}
	\bibliographystyle{plainnat}
	\bibliography{#1}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IZPIS PDF/A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AtEndPreamble{%
\let\oldtexorpdfstring\texorpdfstring
\renewcommand{\texorpdfstring}[2]{#2}
\let\sep{\protect\sep}
\newoutputstream{xmpdatafile}
\openoutputfile{\jobname.xmpdata}{xmpdatafile}
\ifthenelse{\boolean{@anglescina}}{
  \addtostream{xmpdatafile}{%
  \protect\Title{\@title}
  \protect\Author{\@avtor}
  \protect\Keywords{\@keywords}
  \protect\Subject{\@thesistype, \@programme}
}}{
  \addtostream{xmpdatafile}{%
  \protect\Title{\@naslov}
  \protect\Author{\@avtor}
  \protect\Keywords{\@kljucnebesede}
  \protect\Subject{\@tipdela, \@program}
}}
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

% pokončno napisan tekst
\theoremstyle{definition}
\newtheorem{aksiom}{Aksiom}
\newtheorem{definicija}{Definicija}[section]
\newtheorem{opomba}[definicija]{Opomba}
\newtheorem{primer*}[definicija]{Primer}
\newenvironment{primer}[1][]{
  \begin{primer*}[#1]\renewcommand*{\qedsymbol}{$\diamondsuit$}\pushQED{\qed}
}{
  \popQED\end{primer*}
}
\newtheorem{zgled*}[definicija]{Zgled}
\newenvironment{zgled}[1][]{
  \begin{zgled*}[#1]\renewcommand*{\qedsymbol}{$\diamondsuit$}\pushQED{\qed}
}{
  \popQED\end{zgled*}
}
\@ifthen{\boolean{@anglescina}}{
\newtheorem{axiom}{Axiom}
\newtheorem{definition}{Definition}[section]
\newtheorem{remark}[definition]{Remark}
\newtheorem{example*}[definition]{Example}
\newenvironment{example}[1][]{
  \begin{example*}[#1]\renewcommand*{\qedsymbol}{$\diamondsuit$}\pushQED{\qed}
}{
  \popQED\end{example*}
}
}

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

\@sloeng{\def\@frontpages{\@frontpages@sl}}{\def\@frontpages{\@frontpages@en}}

%
% *** SLO naloga ***
%
\def\@frontpages@sl{
	\pagestyle{empty}
	%
	\@frontpages@sl@naslovnica
	\cleardoublepage
	\@frontpages@en@frontpage
	\cleardoublepage
	\@frontpages@sl@osebe
	\cleardoublepage
	\@frontpages@sl@sklep
	\cleardoublepage
	
	\pagestyle{plain}
	\@frontpages@sl@zahvala
	\cleardoublepage
	%
	\@frontpages@common@toc
	%
	\pdfbookmark[1]{Povzetek}{povzetek}
	\@frontpages@sl@povzetek
	\@frontpages@sl@kljucnebesede
	\cleardoublepage
	\@frontpages@en@abstract
	\@frontpages@en@keywords
	\cleardoublepage
	
	% *** formatiranje odstavka ***
	\setlength{\parskip}{16pt}  % razmak med odstavki
	\setlength{\parindent}{0pt} % poravnava v začetku odstavka
}
%
% *** ANG naloga ***
%
\def\@frontpages@en{
  \@frontpages@en@frontpage
  \@frontpages@sl@naslovnica
  \@frontpages@en@acknowledgements
  \@frontpages@common@toc

  \pdfbookmark[1]{Abstract}{abstract}
  \@frontpages@en@abstract
  \@frontpages@sl@povzetek
  \@frontpages@en@keywords
  \cleardoublepage
  
  % *** formatiranje odstavka ***
  \setlength{\parskip}{16pt}  % razmak med odstavki
  \setlength{\parindent}{0pt} % poravnava v začetku odstavka
}
%
% *** Kazalo ***
%
\def\@frontpages@common@toc{
  \pdfbookmark[1]{\contentsname}{kazalo-vsebine}
  \tableofcontents
  \vfill
  \cleardoublepage
}
%
% *** Naslovna stran - SLO ***
%
\def\@frontpages@sl@naslovnica{
	\noindent
	\begin{center}
		UNIVERZA V LJUBLJANI\\[1mm]
		FAKULTETA ZA POMORSTVO IN PROMET
		\\[5cm]
		
		{\Large
			\@imenaloge
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
	
	\begin{center}
		\noindent
		Portorož, \@mesec~\@leto
	\end{center}
}
%
% *** Naslovna stran - SLO - mentorji ***
%
\def\@frontpages@sl@osebe{
	\noindent
	\begin{center}
		UNIVERZA V LJUBLJANI\\[1mm]
		FAKULTETA ZA POMORSTVO IN PROMET
		\\[5cm]
		
		{\Large
			\@imenaloge
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
% *** Naslovna stran - ANG ***
%
\def\@frontpages@en@frontpage{
	\noindent
	\begin{center}
	 	{\normalsize
	 		UNIVERSITY OF LJUBLJANA\\[1mm]
	 		FACULTY FOR MARITIME STUDIES AND TRANSPORT
	 	}
	 	\\[5cm]
	 	
	 	{\Large
	 		\@thesisname
	 	}
	 	\\[2cm]
	 	% \@program\ -- \@stopnja}
	 	\doublespacing		
		{\Large
		 	\textbf{\MakeUppercase{\@title}}	
		}
		\\[2cm]
		\singlespacing
		{\normalsize
		 	\@avtor
		}
		
		%		\@tipdela\\[1cm]
		%		\begin{tabular}{rl} \@mentorji \end{tabular}
		%		}
		
		\vfill
		
		\noindent{\normalsize
		Portorož, \@mesec~\@leto}
	\end{center}
}
%
% *** Sklep KZŠZ ***
%
\def\@frontpages@sl@sklep{
	\noindent
	\begin{center}
		\textbf{Sklep komisije za študijske zadeve}
		\\[1cm]
		\fbox{\includegraphics[width=14cm]{\@sklep}}
	\end{center}
}
%
% *** zahvala ***
%
\def\@frontpages@sl@zahvala{
  \ifdefined\@zahvala
    \pdfbookmark[1]{Zahvala}{zahvala}
    \section*{Zahvala}
    \@zahvala
    \vfill
    \cleardoublepage
  \fi
}
\def\@frontpages@en@acknowledgements{
  \ifdefined\@zahvala
    \pdfbookmark[1]{Acknowledgements}{zahvala}
    \section*{Acknowledgements}
    \@zahvala
    \vfill
    \cleardoublepage
  \fi
}
%
% *** povzetek ***
%
\def\@frontpages@sl@povzetek{
  \begin{center}
    \textbf{\@naslov}\\[3mm]
    \textsc{Povzetek}
  \end{center}
  \@povzetek
  \vfill
}
\def\@frontpages@en@abstract{
  \begin{center}
    \textbf{\@title}\\[3mm]
    \textsc{Abstract}
  \end{center}
  \@abstract
  \vfill
}
%
% *** ključne besede ***
%
\def\@frontpages@sl@kljucnebesede{
  \noindent
  \def\sep{, } % Pri izpisu ključne besede ločimo z vejico.
  \textbf{Ključne besede:} \@kljucnebesede
}
\def\@frontpages@en@keywords{
  \noindent
  \def\sep{, } % Pri izpisu ključne besede ločimo z vejico.
  \textbf{Keywords:} \@keywords
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
}
%
% ** izjava študenta ***
%
\def\@izjava{
	\noindent
	\cleardoublepage
	\pagestyle{empty}
	\begin{center}
		\textbf{\textsf{\large Izjava o avtorstvu}}
	\end{center}

	\vskip 5mm

	\small
	Spodaj podpisani/-a študent/-ka \textit{\@avtor}, vpisna številka \textit{\@stevilka}, avtor/-ica pisnega zaključnega dela študija z naslovom:
	
	\textit{\@naslov},
	
	\textbf{Izjavljam},
	
	\begin{enumerate}[nosep]
		\item
		\begin{enumerate}
			\item da je pisno zaključno delo študija rezultat mojega samostojnega dela;
			\item da je pisno zaključno delo študija rezultat lastnega dela več kandidatov in izpolnjuje pogoje, ki jih Statut UL določa za skupna zaključna dela študija ter je v zahtevanem deležu rezultat mojega samostojnega dela; 
		\end{enumerate}
		\item da je tiskana oblika pisnega zaključnega dela študija istovetna elektronski obliki pisnega zaključnega dela študija;
		\item da sem pridobil/-a vsa potrebna dovoljenja za uporabo podatkov in avtorskih del v pisnem zaključnem delu študija in jih v pisnem zaključnem delu študija jasno označil/-a;
		\item da sem pri pripravi pisnega zaključnega dela študija ravnal/-a v skladu z etičnimi načeli in, kjer je to potrebno, za raziskavo pridobil/-a soglasje etične komisije; 
		\item da soglašam z uporabo elektronske oblike pisnega zaključnega dela študija za preverjanje podobnosti vsebine z drugimi deli s programsko opremo za preverjanje podobnosti vsebine, ki je povezana s študijskim informacijskim sistemom članice; 
		\item da na UL neodplačno, neizključno, prostorsko in časovno neomejeno prenašam pravico shranitve avtorskega dela v elektronski obliki, pravico reproduciranja ter pravico dajanja pisnega zaključnega dela študija na voljo javnosti na svetovnem spletu preko Repozitorija UL;
		\item (\textit{za zaključna dela na 3. stopnji študija, sestavljena iz člankov}) da sem od založnikov, na katere sem predhodno izključno prenesel/-la materialne avtorske pravice na člankih, pridobil/-a potrebna soglasja za vključitev člankov v tiskano in elektronsko obliko disertacije. Soglasja UL omogočajo neodplačno, neizključno, prostorsko in časovno neomejeno hranjenje avtorskega dela v elektronski obliki in reproduciranje ter dajanje disertacije na voljo javnosti na svetovnem spletu preko Repozitorija UL.
		\item da dovoljujem objavo svojih osebnih podatkov, ki so navedeni v pisnem zaključnem delu študija in tej izjavi, skupaj z objavo pisnega zaključnega dela študija.
		\item da dovoljujem uporabo svojega rojstnega datuma v zapisu COBISS.
	\end{enumerate}
	
	\vskip 1cm
	
	Kraj: Portorož\\
	Datum: \@mesec,~\@leto
	
	\vskip 1cm
	Podpis študenta/-ke: ~~~~\rule{8cm}{0.5pt}

}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RAZŠIRJENI POVZETEK
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
% *** razširjen povzetek ***
% *** samo za naloge pisane v angleškem jeziku 
%
\newcommand{\@make@razsirjenipovzetek}[3]{
  % Args: jezik, naslov razš. povzetka (v jeziku), ime datoteke povzetka
  % V razširjenem povzetku želimo, da razdelki pripadajo nekemu
  % nad-razdelku "Razširjeni povzetek", zato vse razdelke premaknemo
  % en nivo nižje in nastavimo številčenje na podrazdelek.

  % shrani stare definicije razdelkov
  \let\oldthesection\thesection
  \let\oldthesubsection\thesubsection
  \let\oldsection\section
  \let\oldsubsection\subsection

  % nastavi številčenje po podrazdelkih
  \def\thesection{}
  \def\thesubsection{\@arabic\c@subsection}
  \numberwithin{equation}{subsection}

  % premakne nivoje razdelkov en nivo nižje, da nivo `\section' spada pod razdelek razširjenega povzetka
  \let\section\subsection
  \let\subsection\subsubsection

  \cleardoublepage
  \begin{otherlanguage}{#1}
    \phantomsection % potrebno za pravilno številčenje strani v kazalih
    \addcontentsline{toc}{section}{#2} % doda razdelek v kazalo in metapodatke
    \begin{center}
      \textsc{#2}
    \end{center}
    \input{#3}
  \end{otherlanguage}

  % obnovi stare definicije razdelkov
  \let\thesection\oldthesection
  \let\thesubsection\oldthesubsection
  \let\section\oldsection
  \let\subsection\oldsubsection
}

\AtEndDocument{%
	\pdfbookmark[1]{Izjava o avtorstvu}{izjava}
	\@izjava
}
