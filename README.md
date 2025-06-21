# FPP LaTeX Templates

Repozitorij vsebuje LaTeX predloge za izdelavo zaključnega dela in poročila. Predloge se nahajajo v ločenih mapah

 - ```thesis```: predloga za izdelavo zaključnega dela (diplomska/magistrska naloga)
 - ```report```: predloga za izdelavo poročila

 Poleg je dodatna še mapa ```user_guide```, ki vsebuje osnovna navodila za pisanje v LaTeXu.

 Vsaka predloga vsebuje tri datoteke in eno mapo:

 - ```main.tex```: to datoteko urejeujete, kamor se vnašajo vsebine vašega zaključnega dela;
 - ```fppthesis.cls``` ali ```fppreport.cls```: tole je osnovi gradnik, ki izdela celotno formo vaše naloge ali poročila;
 - ```literatura.bib```: datoteka vsebuje literaturo, ki jo citirate v nalogi
 - mapa ```figs```: sem shranjujete slike, ki jih imate v nalogi. mapa je narejen zato, da se ne mešajo datoteke

Iz ```github``` repozitorija si povlečite dol trenutno kopijo, klikni na zelen gumbek ```<> Code```, ki je desno zgoraj in izberi ```Download ZIP```. Ustrezne datoteke in mapo si skopiraj v svoj ```OverLeaf``` projekt.

Vaša delo je urejanje ```main.tex``` in ```literature.bib``` datoteke. Poleg morate vnesti slike v mapo ```figs``` in dodati še poskeniran sklep *Komisije za študijske zadeve*.

Veliko se o LaTeX naučite iz priročnika **The not so Short Introduction to LaTeX**, ki je dostopen v različnih formatih na naslovu [https://ctan.org/tex-archive/info/lshort/english](https://ctan.org/tex-archive/info/lshort/english),
ki je preveden tudi v slovenščino [https://users.fmf.uni-lj.si/plestenjak/vaje/latex/lshort.pdf](https://users.fmf.uni-lj.si/plestenjak/vaje/latex/lshort.pdf).

Poleg navedenega priročnika je zelo uporabna stran dokumentacije v OverLeaf okolju [https://www.overleaf.com/learn](https://www.overleaf.com/learn), kjer imate popolnoma vse, kar potrebujete za delo v LaTeX okolju.

Pri prvih korakih v latex, si lahko pogledate z uporabo latex primera, kot so napisana navodila za latex ```navodila_latex.tex```, ki se nahajajo v mapi ```users_guide```. Tukaj se nahajajo osnovni koraki, ki jih potrebujete. Za naprednješo obdelavo teksta pa uporabite zgornjo dokumentacijo in pa ostale reference, ki se nahajajo v [navodilih za latex](https://github.com/as-grm/FPP_Templates/tree/main/user_guide]).

V primeru, če vam kaj ne dela prav in ne veste kje je napaka, vam bo zelo pomagal **ChatGPT**. Del kode, ki mislite da je napačen, preprosto skopirate v CGPT in ga vprašate, če vam pomaga poiskat napako. *Garantirano deluje 100\%*!


<hr>

**Prevajanje dokumenta**

LaTeX dokument ```main.tex``` vedno prevajamo z uporabo ```pdflatex``` ukaza, ker je predloga narejena samo za ta prevajalnik. Da si zgradite ustrezno bibliografijo je potrebno uporabiti še ukaz ```bibtex```, ki iz datoteke ```literatura.bib``` naredi datoteko ```main.bbl```, ki vsebuje izpis literature v predpisanem formatu.

V datoteki ```literatura.bib``` imate lahko bistveno več vpisane literature, kot jo pa potrebujete v nalogi. Prevajalni ```pdflatex``` sam nato izbere tisto kar potrebuje.

Postopek prevajanja LaTeX dokumenta je:
 1. ```pdflatex``` poženem vsaj 2x
 2. ```bibtex``` poženem prvič in nato, ko dodam kakšen nov vnos v ```literatura.bib```
 3. ```pdflatex``` poženem še na zadnje in dobim ```main.pdf``` dokument z vso izpisano literaturo in ustreznimi referencami v dokumentu.


<hr>

**Pomembno**

Vedno pričnete najprej z izbiro ```programa/smeri```, kjer imate šest možnosti. Nato pa nadaljujete z vpisaovanjem vaših podatkov v sekcijo ```METADATA```, ki je nad ```\begin{document}```.

Če želite imeti verzijo naloge za online objavo, morate izbrisati ključ ```tisk``` v določitvi ```\documentclass```!
