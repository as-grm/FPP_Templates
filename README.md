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

Vaša delo je urejanje ```main.tex``` in ```literature.bib``` datoteke. Poleg morate vnesti slike v mapo ```figs``` in dodati še poskeniran sklep *Komisije za študijske zadeve*.

Veliko se o LaTeX naučite iz priročnika **The not so Short Introduction to LaTeX**, ki je dostopen v različnih formatih na naslovu [https://ctan.org/tex-archive/info/lshort/english](https://ctan.org/tex-archive/info/lshort/english),
ki je preveden tudi v slovenščino [https://users.fmf.uni-lj.si/plestenjak/vaje/latex/lshort.pdf](https://users.fmf.uni-lj.si/plestenjak/vaje/latex/lshort.pdf).

Poleg navedenega priročnika je zelo uporabna stran dokumentacije v OverLeaf okolju [https://www.overleaf.com/learn](https://www.overleaf.com/learn), kjer imate popolnoma vse, kar potrebujete za delo v LaTeX okolju.

<hr>

**Pomembno**

Vedno pričnete najprej z izbiro ```programa/smeri```, kjer imate šest možnosti. Nato pa nadaljujete z vpisaovanjem vaših podatkov v sekcijo ```METADATA```, ki je nad ```\begin{document}```.

Če želite imeti verzijo naloge za online objavo, morate izbrisati ključ ```tisk``` v določitvi ```\documentclass```!
