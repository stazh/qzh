# Edieren mit dem StAZH: TEI-Workflow

Verfasst von Michael Schaffner, Mai 2023

## Inhalt

1. [Allgemein](/documentation/Edieren_in_XML_TEI_Workflow/index.md#1-allgemeines)
2. [Verwendung eines Programms zur Bearbeitung von Dokumenten in XML/TEI](/documentation/Edieren_in_XML_TEI_Workflow/index.md#2-verwendung-eines-programms-zur-bearbeitung-von-dokumenten-in-xmltei)  	
3. [Transkription](/documentation/Edieren_in_XML_TEI_Workflow/index.md#3-transkription)
4. [Tagging](/documentation/Edieren_in_XML_TEI_Workflow/index.md#4-tagging)
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

•	xml formatieren für eine übersichtliche Darstellung: Shift + Alt + F
    
•	 Vorschau generieren, welche die Umsetzung des XML/TEI im Webformat anzeigt: Shift + Alt + A


Ein ODD (One document does it all) definiert die Umsetzung von XML/TEI in das gewünschte Publikationsformat. Mittels der Vorschaufunktion wird auf diese Weise bereits während des Transkribierens ersichtlich, wie sich der publizierte Text auf QZH präsentieren wird. Die Tastenkombination Shift + Alt + A öffnet eine Liste der verfügbaren ODDs. Das spezifische ODD von QZH kann hier heruntergeladen werden: https://github.com/stazh/qzh/blob/master/resources/odd/qzh.odd. Dass die Vorschau gemäss dem ODD von QZH generiert wird, kann folgendermassen konfiguriert werden: Einstellung File in VS Code --> Preferences --> Settings --> search settings --> teipublisher eingeben --> Feld «Teipublisher: Endpoint» wird sichtbar. Hier den Link zu QZH einfügen: https://qzh.sources-online.org/index.html. 
   
   
   •	Identifizieren einer markierten Person mittels [Gemeinsame Normdatei (GND)](https://www.dnb.de/DE/Professionell/Standardisierung/GND/gnd_node.html/ "GND"): 
    Shift + Alt + E
    Diese Tastenkombination öffnet eine Liste mit Vorschlägen von in der GND vorhandenen Einträgen (vgl. auch unten, Kap. 4: Tagging).
    
    
Untenstehend (Anhang 2) findet sich ein idealtypisches Quellenstück in XML/TEI, das als Vorlage zum Transkribieren mit VS Code verwendet werden kann.


## 3. Transkription

Die Transkriptionen in QZH orientieren sich an den Transkriptionsrichtlinien der Schweizerischen Rechtsquellenstiftung (SSRQ). Diese sind hier abrufbar: https://www.ssrq-sds-fds.ch/wiki/Transkriptionsrichtlinien

Eine Liste mit den wichtigsten Sonderzeichen und Symbolen findet sich [hier](/documentation/Edieren_in_XML_TEI_Workflow/Sonderzeichen.xml). Sie kann zum Kopieren und Einfügen beim Transkribieren verwendet werden.

## 4. Tagging 

Die xml-Dateien werden mittels des Schemas von TEI validiert. Dieses ist im Header des Dokuments verlinkt (vgl. [Anhang 2: Exemplarisches Quellenstück](/documentation/Edieren_in_XML_TEI_Workflow/index.md#7-anhang-2-exemplarisches-quellenstück)). In Rücksprache mit dem Staatsarchiv kann auch das detailliertere Schema der SSRQ verwendet werden.

Die Auszeichnung von Textphänomenen (Seiten- und Zeilenumbrüche, Absätze, Titel, Streichungen, Hinzufügungen, Dorsualnotizen etc.) erfolgt gemäss der Tag-Bibliothek des TEI-Konsortiums: https://tei-c.org/release/doc/tei-p5-doc/en/html/ (vgl. auch Anhang 1, Wichtigste Tags). Eine hilfreiche Liste einschlägiger Tags mit Beschreibung findet sich auch in der Tag-Bibliothek der SSRQ (https://www.ssrq-sds-fds.ch/wiki/Kategorie:Tag). Letztere Tag-Bibliothek ist nicht öffentlich, bei Interesse kann aber ein Zugang bei der Rechtsquellenstiftung angefragt werden.

Inhaltlich ausgezeichnet werden Personennamen (persName), Ortsnamen (placeName) und Daten (date/origDate). In den inhaltlichen Auszeichnungen werden folgende Referenzierungen zu Normdaten vorgenommen: 


•	Personennamen: [Gemeinsame Normdatei](https://explore.gnd.network). Format: persName ref="GND_1089527993"

Hinweis: In der GND kann mit der TEI Publisher-Erweiterung von VS Code mittels Tastenkombination eine Abfrage generiert werden (vgl. Tastaturkombination oben, Kap. 2). 


•	Ortsnamen: Referenzierung gemäss [GeoNames](https://www.geonames.org/). Format: placeName ref="LOC_43.29695_5.38107"


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
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;
&lt;?xml-stylesheet type='text/xsl' href='../../Ressourcen/Stylesheet.xsl'?&gt;
&lt;?xml-model href=&quot;http://www.tei-c.org/ns/1.0&quot; type=&quot;application/xml&quot;?&gt;
&lt;TEI xmlns=&quot;http://www.tei-c.org/ns/1.0&quot; xmlns:xsi=&quot;http://www.w3.org/2001/XMLSchema-instance&quot;&gt;
    &lt;teiHeader&gt;
        &lt;fileDesc&gt;
            &lt;titleStmt&gt;
                &lt;title&gt;Quellen zur Zürcher Geschichte&lt;/title&gt;
                &lt;respStmt&gt;
                    &lt;persName&gt;Katja Lindenmann. Mit einem Kommentar von Michael Schaffner&lt;/persName&gt;
                    &lt;resp key=&quot;transcript&quot;/&gt;
                &lt;/respStmt&gt;
                &lt;respStmt&gt;
                    &lt;persName&gt;Michael Schaffner und Katja Lindenmann&lt;/persName&gt;
                    &lt;resp key=&quot;tagging&quot;/&gt;
                &lt;/respStmt&gt;
            &lt;/titleStmt&gt;
            &lt;publicationStmt&gt;
                &lt;publisher&gt;Staatsarchiv des Kantons Zürich&lt;/publisher&gt;
                &lt;date type=&quot;electronic&quot; when=&quot;2021-05-01&quot;/&gt;
            &lt;/publicationStmt&gt;
            &lt;seriesStmt&gt;
                &lt;title&gt;Quellen zur Zürcher Geschichte&lt;/title&gt;
                &lt;respStmt&gt;
                    &lt;persName&gt;Staatsarchiv des Kantons Zürich&lt;/persName&gt;
                    &lt;resp&gt;Herausgeberschaft&lt;/resp&gt;
                &lt;/respStmt&gt;
                &lt;idno&gt;QZH_027&lt;/idno&gt;
            &lt;/seriesStmt&gt;
            &lt;sourceDesc&gt;
                &lt;msDesc&gt;
                    &lt;msIdentifier&gt;
                        &lt;idno source=&quot;https://suche.staatsarchiv.djiktzh.ch/detail.aspx?ID=4980628&quot;&gt;A 27.24, Nr. 5&lt;/idno&gt;
                    &lt;/msIdentifier&gt;
                    &lt;head&gt;Nachgang zu &lt;persName&gt;Peter Hotz&lt;/persName&gt; und seiner Ehefrau wegen Schulden,
                        Bettel und weiterer Vergehen&lt;/head&gt;
                    &lt;msContents&gt;
                        &lt;summary&gt;Peter Hotz sagt aus, er könne wegen seiner gelähmten Arme nicht arbeiten,
                            weswegen er das städtische Almosen benötigt habe. Er bestätigt zudem, auch in
                            Affoltern und Mettmenstetten kleine Geldspenden von kirchlichen Amtleuten erhalten zu
                            haben. Des Weiteren beschreibt er, wie er und seine Ehefrau während der Kirchweihe in
                            Affoltern in einem Bauernhaus beherbergt worden seien. Dort hätten sie gemeinsam mit
                            dem Bauern und seinem Hausstand mehrere Mass Wein getrunken. Er gibt an, dass er die
                            dabei entstandenen Schulden mit erbettelter Butter begleichen könne, sobald er
                            freigelassen werde. In einem weiteren Absatz des Verhörs geht es um ausgestossene
                            Flüche, wobei Hotz diesen Vorwurf von sich weist. Es folgt eine Liste von Aussagen des
                            Beschuldigten bezüglich verschiedener Vergehen: Diese betreffen unter anderem
                            häusliche Gewalt und diverse Geldschulden. Er erwähnt dabei auch, dass er eine
                            angeborene Krankheit habe. Die Obrigkeit entlässt ihn und seine Ehefrau mit einer
                            Urfehde aus dem Gefängnis. Sie werden jedoch aus dem Herrschaftsgebiet verwiesen.&lt;/summary&gt;
                        &lt;msItem&gt;
                            &lt;textLang&gt;Deutsch&lt;/textLang&gt;
                            &lt;filiation type=&quot;current&quot;&gt;Aufzeichnungen (Doppelblatt)&lt;/filiation&gt;
                            &lt;filiation type=&quot;original&quot;&gt;
                                &lt;origDate from=&quot;1562-08-01&quot; to=&quot;1563-01-01&quot;&gt;&lt;/origDate&gt;
                            &lt;/filiation&gt;
                        &lt;/msItem&gt;
                    &lt;/msContents&gt;
                    &lt;physDesc&gt;
                        &lt;objectDesc&gt;
                            &lt;supportDesc&gt;
                                &lt;support&gt;
                                    &lt;material&gt;Papier&lt;/material&gt;
                                &lt;/support&gt;
                                &lt;extent&gt;&lt;/extent&gt;
                            &lt;/supportDesc&gt;
                        &lt;/objectDesc&gt;
                    &lt;/physDesc&gt;
                    &lt;history&gt;
                        &lt;origin&gt;&lt;/origin&gt;
                    &lt;/history&gt;
                &lt;/msDesc&gt;
            &lt;/sourceDesc&gt;
        &lt;/fileDesc&gt;
        &lt;encodingDesc&gt;
            &lt;editorialDecl&gt;
                &lt;p&gt;
                    &lt;ref target=&quot;https://www.ssrq-sds-fds.ch/wiki/Transkriptionsrichtlinien&quot; /&gt;
                &lt;/p&gt;
            &lt;/editorialDecl&gt;
        &lt;/encodingDesc&gt;
        &lt;profileDesc&gt;
            &lt;textClass default=&quot;false&quot;&gt;
                &lt;keywords scheme=&quot;http://www.ssrq-sds-fds.ch/taxonomie&quot;&gt;
                    &lt;term ref=&quot;key003396&quot;&gt;Alkohol&lt;/term&gt;
                    &lt;term ref=&quot;key005358&quot;&gt;Armenversorgung&lt;/term&gt;
                    &lt;term ref=&quot;key000598&quot;&gt;Ausweisung&lt;/term&gt;
                    &lt;term ref=&quot;key000581&quot;&gt;Bettel&lt;/term&gt;
                    &lt;term ref=&quot;key004380&quot;&gt;Fluchen&lt;/term&gt;
                    &lt;term ref=&quot;key111113&quot;&gt;Frauengut&lt;/term&gt;
                    &lt;term ref=&quot;key004489&quot;&gt;Geld&lt;/term&gt;
                    &lt;term ref=&quot;key111111&quot;&gt;Häusliche Gewalt&lt;/term&gt;
                    &lt;term ref=&quot;key000789&quot;&gt;Kirchweih&lt;/term&gt;
                    &lt;term ref=&quot;key003261&quot;&gt;Kundschaft&lt;/term&gt;
                    &lt;term ref=&quot;key005473&quot;&gt;Nachgang&lt;/term&gt;
                    &lt;term ref=&quot;key000882&quot;&gt;Nahrungsmittel&lt;/term&gt;
                    &lt;term ref=&quot;key111112&quot;&gt;Körperliche Behinderung&lt;/term&gt;
                    &lt;term ref=&quot;key003496&quot;&gt;Krankheiten&lt;/term&gt;
                    &lt;term ref=&quot;key000480&quot;&gt;Urfehde&lt;/term&gt;
                    &lt;term ref=&quot;key000058&quot;&gt;Schulden&lt;/term&gt;
                    &lt;term ref=&quot;key000480&quot;&gt;Urfehde&lt;/term&gt;
                    &lt;term ref=&quot;key000078&quot;&gt;Verhör&lt;/term&gt;
                    &lt;term ref=&quot;key000758&quot;&gt;Wirtshaus&lt;/term&gt;
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



