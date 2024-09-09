# Edieren mit dem StAZH: TEI-Workflow

Verfasst von Michael Schaffner, Mai 2023

## Inhalt

1. [Allgemein](/documentation/Edieren_in_XML_TEI_Workflow/index.md#1-allgemeines)
2. [Verwendung eines Programms zur Bearbeitung von Dokumenten in XML/TEI](/documentation/Edieren_in_XML_TEI_Workflow/index.md#2-verwendung-eines-programms-zur-bearbeitung-von-dokumenten-in-xmltei)  	
3. [Transkription](/documentation/Edieren_in_XML_TEI_Workflow/index.md#3-transkription)
4. [Tagging und Named Entities](/documentation/Edieren_in_XML_TEI_Workflow/index.md#4-tagging-und-named-entities)
5. [Metadaten](/documentation/Edieren_in_XML_TEI_Workflow/index.md#5-metadaten)
6. [Anhang 1: Wichtigste Tags](/documentation/Edieren_in_XML_TEI_Workflow/index.md#6-anhang-1-wichtigste-tags)
7. [Anhang 2: Exemplarisches Quellenstück](/documentation/Edieren_in_XML_TEI_Workflow/index.md#7-anhang-2-exemplarisches-quellenstück)



## 1. Allgemeines	

Diese Anleitung richtet sich an Personen und Projekte, die ihre Transkriptionen in Absprache mit dem Staatsarchiv Zürich auf der Plattform «Quellen zur Zürcher Geschichte» publizieren (über QZH: https://qzh.sources-online.org/exist/apps/qzh/about.html). QZH basiert auf der Open Source-Software [TEI Publisher](https://teipublisher.com/index.html/ "TEI Publisher").

Im Sinne der Maschinenlesbarkeit und Langzeitarchivierung der Texte empfiehlt es sich, die Transkriptionen von Anfang gemäss den Richtlinien von XML/TEI anzufertigen. Die allgemeinen Guidelines von TEI (Text Encoding Initiative) sind hier dokumentiert: https://tei-c.org/release/doc/tei-p5-doc/en/html/index.html (für weitere Infos vgl. unten, Abschnitte 3 und 4). Eine allgemeine Einführung in XML/TEI findet sich hier: https://tei-c.org/release/doc/tei-p5-doc/es/html/SG.html

Für Projekte die mit MS Word (.docx) arbeiten, gibt es verschiedene Möglichkeiten der Konvertierung in XML/TEI. So ist es auf der Website des TEI Publishers möglich, Word-Files hochzuladen und anschliessend als xml-Dateien abzuspeichern: https://teipublisher.com/exist/apps/tei-publisher/index.html Eine alternative Konvertierungsmaschine ist die sogenannte [TEI Garage](https://teigarage.tei-c.org/ "TEI Garage").

Für Nutzer:innen, die mit Transkribus arbeiten, existiert eine eigene Anleitung zum Export in TEI: https://readcoop.eu/de/transkribus/howto/how-to-export-documents-from-transkribus/

Quellenstücke werden auf QZH grundsätzlich als Transkription mit Digitalisat des Originals publiziert. Die Digitalisate werden, sofern es sich um Bestände des Staatsarchivs handelt, durch das StAZH bereitgestellt im Format [TIFF](https://de.wikipedia.org/wiki/Tagged_Image_File_Format). 

Die nachfolgende Anleitung lehnt sich an Workflows an, die durch den Verein [e-editiones](https://www.e-editiones.org/ "e-editiones") entwickelt wurden, um ein effizientes Zusam-menspiel zwischen der Edition von Quellentexten und deren anschliessender Publikation im TEI Publisher zu garantieren. Ausführliche Erläuterungen finden sich in diesem Video: https://www.youtube.com/watch?v=dyY539HzN6Q (Ab 1:02:00: Editorial Workflows).


## 2. Verwendung eines Programms zur Bearbeitung von Dokumenten in XML/TEI	

Zur Erstellung und Bearbeitung der Transkriptionen wird das Programm Visual Studio Code empfohlen. Es können jedoch selbstverständlich nach eigenem Ermessen auch andere Programme wie Oxygen oder Notepad++ verwendet werden. Bei VS Code handelt es sich um eine kostenlose Applikation zur niederschwelligen Bearbeitung und Validierung von xml-Dateien. Sie kann hier heruntergeladen werden: https://code.visualstudio.com/download

Für VS Code sind – ebenfalls kostenlos – Erweiterungen, sogenannte Extensions, verfügbar, welche die Bearbeitung und Validierung der Texte in XML/TEI sowie spezifisch das Zusammenspiel mit dem TEI Publisher erleichtern. 
Folgende Extensions werden empfohlen: 

•	XML Language Support by Red Hat (vor allem zur Validierung)


•	tei-publisher-vscode (Vorschaufunktion in TEI Publisher und GND-Link, vgl. unten)

Folgende Tastaturkombinationen in VS Code erleichtern das Arbeiten:

•	xml formatieren für eine übersichtliche Darstellung: Ctr + Shift + F
    
•	 Vorschau generieren, welche die Umsetzung des XML/TEI im Webformat anzeigt: Ctr + Shift + A

•	 TEI Entity Explorer (vgl. unten): Ctr + Shift + E



Ein ODD (One document does it all) definiert die Umsetzung von XML/TEI in das gewünschte Publikationsformat. Mittels der Vorschaufunktion wird auf diese Weise bereits während des Transkribierens ersichtlich, wie sich der publizierte Text auf QZH präsentieren wird. Die Tastenkombination Shift + Alt + A öffnet eine Liste der verfügbaren ODDs. Das spezifische ODD von QZH kann hier heruntergeladen werden: https://github.com/stazh/qzh/blob/master/resources/odd/qzh.odd. Dass die Vorschau gemäss dem ODD von QZH generiert wird, kann folgendermassen konfiguriert werden: Einstellung File in VS Code --> Preferences --> Settings --> search settings --> teipublisher eingeben --> Feld «Teipublisher: Endpoint» wird sichtbar. Hier den Link zu QZH einfügen: https://qzh.sources-online.org/index.html. 
   
   
   •	Identifizieren einer markierten Person mittels [Gemeinsame Normdatei (GND)](https://www.dnb.de/DE/Professionell/Standardisierung/GND/gnd_node.html/ "GND"): 
    Shift + Alt + E
    Diese Tastenkombination öffnet eine Liste mit Vorschlägen von in der GND vorhandenen Einträgen (vgl. auch unten, Kap. 4: Tagging).
    
    
Untenstehend (Anhang 2) findet sich ein idealtypisches Quellenstück in XML/TEI, das als Vorlage zum Transkribieren mit VS Code verwendet werden kann.


## 3. Transkription

Die Transkriptionen in QZH orientieren sich an den Transkriptionsrichtlinien der Schweizerischen Rechtsquellenstiftung (SSRQ). Diese sind hier abrufbar: https://www.ssrq-sds-fds.ch/wiki/Transkriptionsrichtlinien

Eine Liste mit den wichtigsten Sonderzeichen und Symbolen findet sich [hier](/documentation/Edieren_in_XML_TEI_Workflow/Sonderzeichen.xml). Sie kann zum Kopieren und Einfügen beim Transkribieren verwendet werden.

## 4. Tagging und Named Entities 

Die xml-Dateien werden mittels des Schemas von TEI validiert. Dieses ist im Header des Dokuments verlinkt (vgl. [Anhang 2: Exemplarisches Quellenstück](/documentation/Edieren_in_XML_TEI_Workflow/index.md#7-anhang-2-exemplarisches-quellenstück)). In Rücksprache mit dem Staatsarchiv kann auch das detailliertere Schema der SSRQ verwendet werden.

Die Auszeichnung von Textphänomenen (Seiten- und Zeilenumbrüche, Absätze, Titel, Streichungen, Hinzufügungen, Dorsualnotizen etc.) erfolgt gemäss der Tag-Bibliothek des TEI-Konsortiums: https://tei-c.org/release/doc/tei-p5-doc/en/html/ (vgl. auch Anhang 1, Wichtigste Tags). Eine hilfreiche Liste einschlägiger Tags mit Beschreibung findet sich auch in der Tag-Bibliothek der SSRQ (https://www.ssrq-sds-fds.ch/wiki/Kategorie:Tag). Letztere Tag-Bibliothek ist nicht öffentlich, bei Interesse kann aber ein Zugang bei der Rechtsquellenstiftung angefragt werden.

Inhaltlich ausgezeichnet werden Personennamen (persName), Ortsnamen (placeName) und Daten (date/origDate). In den inhaltlichen Auszeichnungen werden folgende Referenzierungen zu Normdaten vorgenommen: 


•	Personennamen: [Gemeinsame Normdatei](https://explore.gnd.network). Format: persName ref="GND_1089527993"

Hinweis: In der GND kann mit der TEI Publisher-Erweiterung von VS Code mittels Tastenkombination eine Abfrage generiert werden (vgl. Tastaturkombination oben, Kap. 2). 


•	Ortsnamen: Referenzierung gemäss [GeoNames](https://www.geonames.org/). Format: placeName ref="LOC_43.29695_5.38107"

Hinweis: Das Programm Programm Visual Studio Code bietet für das Tagging von Named Entities in der Extension "TEI Publisher Tools" die praktische Funktion des TEI Entity Explorers: Dabei kann ein Personen- oder Ortsame manuell markiert und dann die Tastenkombination Ctr + Shift + E betätigt werden: In der linken Seitenleiste erscheint dann eine Liste mit Vorschlägen aus Normdatenbanken wie der Gemeinsamen Normdatenbank GND. Durch Betätigung des Plus-Symbols wird die Norm-ID direkt in das Attribut des Tags der Entität geschrieben. Welche Normdatenbanken abgefragt werden, lässt sich customizen. Für weitere Infos zur Extension vgl. [tei-publisher-vscode](https://marketplace.visualstudio.com/items?itemName=e-editiones.tei-publisher-vscode)

![][image-1]

Weitere Hinweise zur Verwendung der getagten Entitäten zur Erstellung von Personen- und Ortsregistern (wird durch das StAZH ausgeführt) finden sich im Read-Me des Repositories [QZH-data](https://github.com/stazh/qzh-data?tab=readme-ov-file#quellen-zur-z%C3%BCrcher-geschichte-daten).

## 5. Metadaten

Unten stehende Metadaten werden pro Quellenstück erhoben und die Informationen im TEI-Header mittels der untenstehenden Tags verzeichnet. Die korrekte Einordnung der Metadaten in den Header wird auch aus Anhang 2 (exemplarisches Quellenstück) ersichtlich.
Die Verzeichnung der Quellenstücke im der Archivdatenbank, sofern nicht bereits gegeben, erfolgt durch das StAZH unter Verwendung der gelieferten Metadaten. Informationen zur Verzeichnung der Metadaten finden sich im [Erschliessungshandbuch des Staatsarchivs Zürich](https://www.zh.ch/content/dam/zhweb/bilder-dokumente/organisation/direktion-der-justiz-und-des-innern/staatsarchiv/erschliessungshandbuch/ehb_stazh_version_2_8_2023.pdf).

•	Name Transkriptor:in (resp key="transcript") (o)


•	Name Bearbeiter:in Tagging (resp key="tagging") (f)

•	Name des Projekts (title) (f) 

•	Name Herausgeber:in (respStmt) (f) (ohne andere Angabe: Staatsarchiv Zürich)

•	QZH-ID (idno, wird durch StAZH vergeben) (o)

•	Signatur des Quellenstücks inkl. Kürzel Archiv- oder Bibliotheksstandort (idno@source) (o)

•	Editorischer (moderner) Titel des Quellenstücks (head) (o)

•	Regest (summary) (f)

•	Sprache (textLang) (o)

•	Überlieferung (filiation) (o)

•	Entstehungszeitraum (origDate) (o)

•	Trägermaterial (material) (o)

•	Schlagwörter (term) (f)

•	Kommentar zu Quellenstück (back) (f)

### Legende:
<p>(o) = Angabe obligatorisch</p>
<p>(f) = Angabe fakultativ</p>

<p>Hier ein Beispiel für einen Header mit befüllten Metadaten:</p>
<pre>
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;?xml-stylesheet type='text/xsl' href='../../Ressourcen/Stylesheet.xsl'?&gt;
&lt;TEI xmlns="http://www.tei-c.org/ns/1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"&gt;
    &lt;teiHeader&gt;
        &lt;fileDesc&gt;
            &lt;titleStmt&gt;
                &lt;title&gt;Quellen zur Zürcher Geschichte&lt;/title&gt;
                &lt;respStmt&gt;
                    &lt;persName&gt;Tessa Gerber. Mit einem Kommentar von Sarah Murer und Michael
                        Schaffner&lt;/persName&gt;
                    &lt;resp key="transcript"/&gt;
                &lt;/respStmt&gt;
                &lt;respStmt&gt;
                    &lt;persName&gt;Sarah Murer&lt;/persName&gt;
                    &lt;resp key="tagging"/&gt;
                &lt;/respStmt&gt;
            &lt;/titleStmt&gt;
            &lt;publicationStmt&gt;
                &lt;publisher&gt;Staatsarchiv des Kantons Zürich&lt;/publisher&gt;
                &lt;date type="electronic" when="2021-05-01"/&gt;
            &lt;/publicationStmt&gt;
            &lt;seriesStmt&gt;
                &lt;title&gt;Quellen zur Zürcher Geschichte&lt;/title&gt;
                &lt;respStmt&gt;
                    &lt;persName&gt;Staatsarchiv des Kantons Zürich&lt;/persName&gt;
                    &lt;resp&gt;Herausgeberschaft&lt;/resp&gt;
                &lt;/respStmt&gt;
                &lt;idno&gt;QZH_056&lt;/idno&gt;
            &lt;/seriesStmt&gt;
            &lt;sourceDesc&gt;
                &lt;msDesc&gt;
                    &lt;msIdentifier&gt;
                        &lt;idno source="https://suche.staatsarchiv.djiktzh.ch/detail.aspx?ID=5115294"
                            &gt;STAZH F III 4 (1542, Beilage)&lt;/idno&gt;
                    &lt;/msIdentifier&gt;
                    &lt;head&gt;Rechnung des Bauamts der Stadt Zürich über den Wiederaufbau von Regensberg
                        nach dem dortigen Stadtbrand&lt;/head&gt;
                    &lt;msContents&gt;
                        &lt;summary&gt;Die Rechnung des Bauamtes der Stadt Zürich über den Wiederaufbau
                            von Regensberg nach dem dortigen Stadtbrand listet Ausgaben für
                            Zimmerleute, Maurer, Bauknechte, Fuhrleute, Dachdecker, Schmiede und
                            Schlosser sowie für Kalk, Ziegel, Sand und allerlei weitere Kosten auf.
                            Insgesamt belaufen sich die Ausgaben des Bauamtes für den Wiederaufbau
                            auf 1775 Pfund, zehn Schilling und einen Pfennig.&lt;/summary&gt;
                        &lt;msItem&gt;
                            &lt;textLang&gt;Deutsch&lt;/textLang&gt;
                            &lt;filiation type="current"&gt;Aufzeichnungen, Heft&lt;/filiation&gt;
                            &lt;filiation type="original"&gt;&lt;origDate when="1542-07-31"
                            /&gt;31.07.1542&lt;/filiation&gt;
                        &lt;/msItem&gt;
                    &lt;/msContents&gt;
                    &lt;physDesc&gt;
                        &lt;objectDesc&gt;
                            &lt;supportDesc&gt;
                                &lt;support&gt;&lt;material&gt;Papier&lt;/material&gt;&lt;/support&gt;
                                &lt;extent/&gt;
                            &lt;/supportDesc&gt;
                        &lt;/objectDesc&gt;
                    &lt;/physDesc&gt;
                    &lt;history&gt;
                        &lt;origin&gt;&lt;origDate when="1542-07-31"/&gt;&lt;/origin&gt;
                    &lt;/history&gt;
                &lt;/msDesc&gt;
            &lt;/sourceDesc&gt;
        &lt;/fileDesc&gt;
        &lt;encodingDesc&gt;
            &lt;editorialDecl&gt;
                &lt;p&gt;
                    &lt;ref target="https://www.ssrq-sds-fds.ch/wiki/Transkriptionsrichtlinien"/&gt;
                &lt;/p&gt;
            &lt;/editorialDecl&gt;
        &lt;/encodingDesc&gt;
        &lt;profileDesc&gt; &lt;/profileDesc&gt;
        &lt;profileDesc&gt;
            &lt;textClass default="false"&gt;
                &lt;keywords scheme="http://www.ssrq-sds-fds.ch/taxonomie"&gt;
                    &lt;term ref="key000207"&gt;Amt&lt;/term&gt;
                    &lt;term ref="key004175"&gt;Ausgaben&lt;/term&gt;
                    &lt;term ref="key000490"&gt;Bauwesen&lt;/term&gt;
                    &lt;term ref="key005369"&gt;Buchführung&lt;/term&gt;
                    &lt;term ref="key004536"&gt;Finanzen&lt;/term&gt;
                    &lt;term ref="key000212"&gt;Löhne&lt;/term&gt;
                    &lt;term ref="key000574"&gt;Rechnungswesen&lt;/term&gt;
                    &lt;term ref="key000187"&gt;Unterhalt&lt;/term&gt;
                    &lt;term ref="key000204 "&gt;Verwaltung&lt;/term&gt;
                &lt;/keywords&gt;
            &lt;/textClass&gt;
        &lt;/profileDesc&gt;
    &lt;/teiHeader&gt;

  </pre>


## 6. Anhang 1: Wichtigste Tags

[p](https://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-p.html): Absatz 

[pb](https://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-pb.html): Seitenanfang

[lb](https://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-lb.html): Zeilenumbruch

[head](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-head.html): Überschrift

[del](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-del.html): Streichung

[add](https://www.tei-c.org/release/doc/tei-p5-doc/en/html/examples-add.html): Hinzufügung (mit Attributen @place und ggf. @hand)

[persName](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-persName.html): Personenname

[placesName](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-placeName.html): Ortsname

[date](https://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-date.html): Datum (mit Attribut @when)

[origDate](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-origDate.html): Originaldatum des Quellenstücks (mit Attribut @when)

[abbr](https://tei-c.org/release/doc/tei-p5-doc/en/html/ref-abbr.html): Abkürzung


## 7. Anhang 2: Exemplarisches Quellenstück

Ein exemplarisches Quellenstück kann gegen Anfrage beim Staatsarchiv bezogen werden. Es enthält den korrekten TEI-Header inklusive Angaben zum Einfügen der notwendigen Metadaten pro Quellenstück. Der edierte Originaltext wurde unter Verwendung der oben beschriebenen Tags ausgezeichnet. Es kann als Vorlage für das Anfertigen eigener Transkriptionen verwendet werden.

[image-1]:	Extension_TEI_Publisher.JPG



