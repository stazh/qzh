# Edieren mit dem StAZH: TEI-Workflow

Verfasst von Michael Schaffner, Mai 2023

## Inhalt

1. Allgemeines	
2. Verwendung eines Programms zur Bearbeitung von Dokumenten in XML/TEI	
3. Transkription	
4. Tagging	
5. Metadaten	
6. Anhang 1: Wichtigste Tags	
7. Anhang 2: Exemplarisches Quellenstück	



## 1. Allgemeines	

Diese Anleitung richtet sich an Personen und Projekte, die ihre Transkriptionen in Absprache mit dem Staatsarchiv Zürich auf der Plattform «Quellen zur Zürcher Geschichte» publizieren (über QZH: https://qzh.sources-online.org/exist/apps/qzh/about.html). QZH basiert auf der Open Source-Software <ref target="https://teipublisher.com/index.html">TEI Publisher</ref>.

Im Sinne der Maschinenlesbarkeit und Langzeitarchivierung der Texte empfiehlt es sich, die Transkriptionen von Anfang gemäss den Richtlinien von XML/TEI anzufertigen. Die allgemeinen Guidelines von TEI (Text Encoding Initiative) sind hier dokumentiert: https://tei-c.org/release/doc/tei-p5-doc/en/html/index.html (für weitere Infos vgl. unten, Abschnitte 3 und 4). Eine allgemeine Einführung in XML/TEI findet sich hier: https://tei-c.org/release/doc/tei-p5-doc/es/html/SG.html

Für Projekte die mit MS Word (.docx) arbeiten, gibt es verschiedene Möglichkeiten der Konvertierung in XML/TEI. So ist es auf der Website des TEI Publishers möglich, Word-Files hochzuladen und anschliessend als xml-Dateien abzuspeichern: https://teipublisher.com/exist/apps/tei-publisher/index.html Eine alternative Konvertierungsmaschine ist die sogenannte <ref target="https://teigarage.tei-c.org/">TEI-Garage</ref>.



Quellenstücke werden auf QZH grundsätzlich als Transkription mit Digitalisat des Origi-nals publiziert. Die Digitalisate werden, sofern es sich um Bestände des Staatsarchivs handelt, durch das StAZH bereitgestellt im Format TIFF. 

Die nachfolgende Anleitung lehnt sich an Workflows an, die durch den Verein <ref target="https://www.e-editiones.org/">e-editiones</ref> entwickelt wurden, um ein effizientes Zusam-menspiel zwischen der Edition von Quellentexten und deren anschliessender Publikation im TEI Publisher zu garantieren. Ausführliche Erläuterungen finden sich in diesem Video: https://www.youtube.com/watch?v=dyY539HzN6Q (Ab 1:02:00: Editorial Workflows).


## 2. Verwendung eines Programms zur Bearbeitung von Dokumenten in XML/TEI	

Zur Erstellung und Bearbeitung der Transkriptionen wird das Programm Visual Studio Code empfohlen. Es können jedoch selbstverständlich nach eigenem Ermessen auch andere Programme wie Oxygen oder Notepad++ verwendet werden. Bei VS Code handelt es sich um eine kostenlose Applikation zur niederschwelligen Bearbeitung und Vali-dierung von xml-Dateien. Sie kann hier heruntergeladen werden: https://code.visualstudio.com/download

Für VS Code sind – ebenfalls kostenlos – Erweiterungen, sogenannte Extensions, verfügbar, welche die Bearbeitung und Validierung der Texte in XML/TEI sowie spezifisch das Zusammenspiel mit dem TEI Publisher erleichtern. 
Folgende Extensions werden empfohlen: 
•	XML Language Support by Red Hat (vor allem zur Validierung)
•	tei-publisher-vscode (Vorschaufunktion in TEI Publisher und GND-Link, vgl. un-ten)

Folgende Tastaturkombinationen in VS Code erleichtern das Arbeiten:
xml formatieren für eine übersichtliche Darstellung
•	Shift + Alt + F
    Vorschau generieren, welche die Umsetzung des XML/TEI im Webformat anzeigt:
•	Shift + Alt + A
    Ein ODD (One document does it all) definiert die Umsetzung von XML/TEI in das ge-wünschte Publikationsformat. Mittels der Vorschaufunktion wird auf diese Weise bereits während des Transkribierens ersichtlich, wie sich der publizierte Text auf QZH präsentieren wird. Die Tastenkombination Shift + Alt + A öffnet eine Liste der verfügbaren ODDs. Das spe-zifische ODD von QZH kann hier heruntergeladen werden: https://github.com/stazh/qzh/blob/master/resources/odd/qzh.odd
•	Identifizieren einer markierten Person mittels Gemeinsame Normdatei (GND):
    Shift + Alt + E
    Diese Tastenkombination öffnet eine Liste mit Vorschlägen von in der GND vorhande-nen Einträgen (vgl. auch unten, Kap. 4: Tagging).

Untenstehend (Anhang 2) findet sich ein idealtypisches Quellenstück in XML/TEI, das als Vorlage zum Transkribieren mit VS Code verwendet werden kann.


## 3. Transkription

Die Transkriptionen in QZH orientieren sich an den Transkriptionsrichtlinien der Schwei-zerischen Rechtsquellenstiftung (SSRQ). Diese sind hier abrufbar: https://www.ssrq-sds-fds.ch/wiki/Transkriptionsrichtlinien

## 4. Tagging 

Die xml-Dateien werden mittels des Stylesheets von SSRQ validiert. Das Stylesheet ist im TEI-Header verlinkt. 

Die Auszeichnung von Textphänomenen (Seiten- und Zeilenumbrüche, Absätze, Titel, Streichungen, Hinzufügungen, Dorsualnotizen etc.) erfolgt gemäss der Tag-Bibliothek des TEI-Konsortiums: https://tei-c.org/release/doc/tei-p5-doc/en/html/index.html (vgl. auch Anhang 1, Wichtigste Tags). Eine hilfreiche Liste einschlägiger Tags findet sich auch in der Tag-Bibliothek der SSRQ (https://www.ssrq-sds-fds.ch/wiki/Kategorie:Tag). Die Tag-Bibliothek ist nicht öffentlich, bei Interesse kann aber ein Zugang bei der Rechtsquellenstiftung angefragt werden.

Inhaltlich ausgezeichnet werden Personennamen (persName), Ortsnamen (placeName) und Daten (date/origDate). In den inhaltlichen Auszeichnungen werden folgende Referenzierungen zu Normdaten vorgenommen: 
•	Personennamen: Gemeinsame Normdatei GND (https://explore.gnd.network)
Format: <persName ref="GND_1089527993">Scheüchtzer</persName>. Hinweis: In der GND kann mit der TEI Publisher-Erweiterung von VS Code mittels Tastenkombination eine Abfrage generiert werden (vgl. Tastaturkombination oben, Kap. 2). 
•	Ortsnamen: Referenzierung gemäss https://www.geonames.org/. Format: <placeName ref="LOC_43.29695_5.38107">Marseille</placeName>


## 5. Metadaten

Unten stehende Metadaten werden pro Quellenstück erhoben und die Informationen im TEI-Header mittels der untenstehenden Tags verzeichnet. Die korrekte Einordnung der Metadaten in den Header wird auch aus Anhang 2 (exemplarisches Quellenstück) ersichtlich.
Die Verzeichnung der Quellenstücke im der Archivdatenbank, sofern nicht bereits gege-ben, erfolgt durch das StAZH unter Verwendung der gelieferten Metadaten. Informationen zur Verzeichnung der Metadaten finden sich im Erschliessungshandbuch des Staatsarchivs: https://www.zh.ch/content/dam/zhweb/bilder-dokumente/organisation/direktion-der-justiz-und-des-innern/staatsarchiv/erschliessungshandbuch/ehb_stazh_version_2_8_2023.pdf

<p>•	Name Transkriptor:in (resp key="transcript") (o)</p>
<p>•	Name Bearbeiter:in Tagging (resp key="tagging") (f)</p>
<p>•	Name des Projekts (title) (f) </p>
<p>•	Name Herausgeber:in (respStmt) (f) (ohne andere Angabe: Staatsarchiv Zürich</p>)
<p>•	QZH-ID (idno, wird durch StAZH vergeben) (o)</p>
<p>•	Signatur des Quellenstücks inkl. Kürzel Archiv- oder Bibliotheksstandort (idno@source) (o)</p>
<p>•	Editorischer (moderner) Titel des Quellenstücks (head) (o)</p>
<p>•	Regest (summary) (f)</p>
<p>•	Sprache (textLang) (o)</p>
<p>•	Überlieferung (filiation) (o)</p>
<p>•	Entstehungszeitraum (origDate) (o)</p>
<p>•	Trägermaterial (material) (o)</p>
<p>•	<ref target="https://www.zh.ch/content/dam/zhweb/bilder-dokumente/organisation/direktion-der-justiz-und-des-innern/staatsarchiv/erschliessungshandbuch/kap_3_4_2_11_schlagwoerter_Excel_V12_2022.pdf">Schlagwörter</ref> (term) (f)</p>
<p>•	Kommentar zu Quellenstück (back) (f)</p>

Legende:
<p>(o) = Angabe obligatorisch</p>
<p>(f) = Angabe fakultativ</p>


## 6. Anhang 1: Wichtigste Tags

<p>p: Absatz </p>
<p>p="35": Seitenumbruch unter Angabe der originalen Seitenzahl </p>
<p>lb: Zeilenumbruch</p>
<p>head: Überschrift</p>
<p>del: Streichung</p>
<p>add: Hinzufügung (mit Attributen @place und ggf. @hand)</p>
<p>persName: Personenname</p>
<p>placeName: Ortsname</p>
<p>date: Datum (mit Attribut @when)</p>
<p>abbr: Abkürzung (ggf. mit Attribut @expan) </p>
<p>origDate: Originaldatum des Quellenstücks (mit Attribut @when)</p>



## 7. Anhang 2: Exemplarisches Quellenstück

![][image-1]

[image-1]:	https://github.com/stazh/qzh/blob/master/documentation/Edieren_in_XML_TEI_Workflow/QZH_Beispielquelle.xml
[image-2]:	Bildschirmfoto%202022-10-04%20um%2009.31.02.png
[image-3]:	Bildschirmfoto%202022-09-27%20um%2013.14.06.png
[image-4]:	Bildschirmfoto%202022-09-27%20um%2013.16.33.png
[image-5]:	Bildschirmfoto%202022-09-16%20um%2014.01.02.png
[image-6]:	Bildschirmfoto%202022-09-16%20um%2014.01.25.png
[image-7]:	Bildschirmfoto%202022-09-27%20um%2013.18.33.png
[image-8]:	DraggedImage.jpg
[image-9]:	DraggedImage-1.jpg
[image-10]:	DraggedImage-2.jpg
[image-11]:	Bildschirmfoto%202022-10-03%20um%2014.02.05.png
[image-12]:	Bildschirmfoto%202022-10-03%20um%2014.03.08.png
[image-13]:	Bildschirmfoto%202022-10-03%20um%2015.02.30.png
[image-14]:	Bildschirmfoto%202022-10-03%20um%2013.58.10.png
[image-15]:	DraggedImage-3.jpg
[image-16]:	Bildschirmfoto%202022-10-03%20um%2013.58.35.png
[image-17]:	Bildschirmfoto%202022-09-27%20um%2011.25.11.png
[image-18]:	Bildschirmfoto%202022-10-04%20um%2008.53.21.png
[image-19]:	Bildschirmfoto%202022-10-04%20um%2008.53.43.png
[image-20]:	Bildschirmfoto%202022-10-04%20um%2009.33.37.png
[image-21]:	DraggedImage-4.jpg
[image-22]:	DraggedImage-5.jpg
[image-23]:	Bildschirmfoto%202022-10-04%20um%2009.39.39.png
[image-24]:	Bildschirmfoto%202022-09-20%20um%2011.25.30.png
[image-25]:	Bildschirmfoto%202022-09-20%20um%2012.32.04.png
[image-26]:	Bildschirmfoto%202022-09-27%20um%2011.37.39.png
[image-27]:	Bildschirmfoto%202022-09-27%20um%2011.40.41.png
[image-28]:	Bildschirmfoto%202022-09-27%20um%2011.43.06.png
[image-29]:	Bildschirmfoto%202022-09-27%20um%2011.50.13.png
[image-30]:	Bildschirmfoto%202022-09-27%20um%2011.52.04.png
[image-31]:	Bildschirmfoto%202022-09-27%20um%2011.53.41.png
[image-32]:	Bildschirmfoto%202022-09-27%20um%2011.55.37.png
[image-33]:	Bildschirmfoto%202022-10-04%20um%2009.42.26.png
[image-34]:	Bildschirmfoto%202022-09-27%20um%2012.03.19.png
[image-35]:	Bildschirmfoto%202022-10-04%20um%2009.43.31.png