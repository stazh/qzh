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

Diese Anleitung richtet sich an Personen und Projekte, die ihre Transkriptionen in Ab-sprache mit dem Staatsarchiv Zürich auf der Plattform «Quellen zur Zürcher Geschichte» publizieren (über QZH: https://qzh.sources-online.org/exist/apps/qzh/about.html). QZH basiert auf der Open Source-Software TEI Publisher: https://teipublisher.com/index.html

Im Sinne der Maschinenlesbarkeit und Langzeitarchivierung der Texte empfiehlt es sich, die Transkriptionen von Anfang gemäss den Richtlinien von XML/TEI anzufertigen. Die allgemeinen Guidelines von TEI (Text Encoding Initiative) sind hier dokumentiert: https://tei-c.org/release/doc/tei-p5-doc/en/html/index.html (für weitere Infos vgl. unten, Abschnitte 3 und 4). Eine allgemeine Einführung in XML/TEI findet sich hier: https://tei-c.org/release/doc/tei-p5-doc/es/html/SG.html

Für Projekte die mit MS Word (.docx) arbeiten, gibt es verschiedene Möglichkeiten der Konvertierung in XML/TEI. So ist es auf der Website des TEI Publishers möglich, Word-Files hochzuladen und anschliessend als xml-Dateien abzuspeichern: https://teipublisher.com/exist/apps/tei-publisher/index.html Eine alternative Konvertierungsmaschine ist die sogenannte TEI-Garage: https://teigarage.tei-c.org/



Quellenstücke werden auf QZH grundsätzlich als Transkription mit Digitalisat des Origi-nals publiziert. Die Digitalisate werden, sofern es sich um Bestände des Staatsarchivs handelt, durch das StAZH bereitgestellt im Format TIFF. 

Die nachfolgende Anleitung lehnt sich an Workflows an, die durch den Verein e-editiones (https://www.e-editiones.org/) entwickelt wurden, um ein effizientes Zusam-menspiel zwischen der Edition von Quellentexten und deren anschliessender Publikation im TEI Publisher zu garantieren. Ausführliche Erläuterungen finden sich in diesem Video: https://www.youtube.com/watch?v=dyY539HzN6Q (Ab 1:02:00: Editorial Workflows).


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

•	Name Transkriptor:in (<resp key="transcript"/>) (o)
•	Name Bearbeiter:in Tagging (<resp key="tagging"/>) (f)
•	Name des Projekts (<title>) (f) 
•	Name Herausgeber:in (<respStmt>) (f) (ohne andere Angabe Staatsarchiv Zü-rich)
•	QZH-ID (<idno>, wird durch StAZH vergeben) (o)
•	Signatur des Quellenstücks inkl. Kürzel Archiv- oder Bibliotheksstandort        (<idno@source>) (o)
•	Editorischer (moderner) Titel des Quellenstücks (<head>) (o)
•	Regest (<summary>) (f)
•	Sprache (<textLang>) (o)
•	Überlieferung (<filiation>) (o)
•	Entstehungszeitraum (<origDate>) (o)
•	Trägermaterial: <material> (o)
•	Schlagwörter: <term> (f)
•	Kommentar zu Quellenstück (in <back>) (f)

Legende:
(o) = Angabe obligatorisch
(f) = Angabe fakultativ


## 6. Anhang 1: Wichtigste Tags

p: Absatz 
p="35": Seitenumbruch unter Angabe der originalen Seitenzahl 
lb: Zeilenumbruch
head: Überschrift
del: Streichung
add: Hinzufügung (mit Attributen @place und ggf. @hand)
persName: Personenname
placeName: Ortsname
date: Datum (mit Attribut @when)
abbr: Abkürzung (ggf. mit Attribut @expan) 
origDate: Originaldatum des Quellenstücks (mit Attribut @when)



## 7. Anhang 2: Exemplarisches Quellenstück

<?xml version="1.0" encoding="UTF-8"?>
<?xml-model href="https://www.ssrq-sds-fds.ch/tei/TEI_Schema_SSRQ.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"?>
<?xml-model href="https://www.ssrq-sds-fds.ch/tei/TEI_Schema_SSRQ.rng" type="application/xml" schematy-pens="http://purl.oclc.org/dsdl/schematron"?>
<?xml-stylesheet type="text/css" href="https://www.ssrq-sds-fds.ch/tei/Textkritik_Version_tei-ssrq.css“?>
<!--<?xml-stylesheet type="text/css" href="https://www.ssrq-sds-fds.ch/tei/Inhalt_Version_tei-ssrq.css"?>-->
<TEI xmlns:xi="http://www.w3.org/2001/XInclude" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:ssrq="http://ssrq-sds-fds.ch/ns/nonTEI" n="1234" xml:lang="de">
    <teiHeader>
        <fileDesc>
            <titleStmt>
                <respStmt>
                    <persName><!-- Name Transkriptor:in--></persName>
                    <resp key="transcript"/>
                </respStmt>
                <respStmt>
                    <persName><!--Name Bearbeiter:in Tagging --></persName>
                    <resp key="tagging"/>
                </respStmt>
            </titleStmt>
            <publicationStmt>
                <date type="electronic" when="2021-05-01"/>
                <date type="print" when="2018-12-31"/>
            </publicationStmt>
            <seriesStmt xml:id="ssrq-sds-fds">
                <title><!-- Name Projekt--></title>
                <respStmt>
                    <persName><!-- Name Herausgeber:in--></persName>
                    <resp>Herausgeberschaft</resp>
                </respStmt>
                <idno><!-- QZH-ID nach Schema QZH_XXX--></idno>
            </seriesStmt>
            <sourceDesc>
                <msDesc>
                    <msIdentifier>
                        <idno source="<!-- Link zu Quelle in Archivkatalog-->"><!-- Signatur der Quelle--></idno>
                    </msIdentifier>
                    <head><!-- Editorischer Titel des Quellenstücks --></head>
                    <msContents>
                    <summary><!-- Regest--></summary>
                        <msItem>
                            <textLang><!-- Sprache--></textLang>
                            <filiation type="current"><!--Überlieferung --></filiation>
                            <filiation type="original"><origDate when="1706-07-21"/></filiation>
                        </msItem>
                    </msContents>
                    <physDesc>
                        <objectDesc>
                            <supportDesc>
                                <sup-port><material>Papier</material></support>
                                <extent/>
                            </supportDesc>
                        </objectDesc>
                    </physDesc>
                    <history>
                        <origin/>
                    </history>
                </msDesc>
            </sourceDesc>
        </fileDesc>
        <encodingDesc>
            <editorialDecl>
                <p>
                    <ref target="https://www.ssrq-sds-fds.ch/wiki/Transkriptionsrichtlinien"/>
                </p>
            </editorialDecl>
        </encodingDesc>
        <profileDesc> </profileDesc>
        <profileDesc>
            <textClass default="false">
                <keywords scheme="http://www.ssrq-sds-fds.ch/taxonomie">
                    <term ref="key000325"><!-- Schlagwort--></term>
                </keywords>
            </textClass>
            <particDesc default="false"/>
            <settingDesc default="false"/>
        </profileDesc>
    </teiHeader>
    <text>
        <group>
            <text><!-- Editionstext-->
        <body>
        <div>
            <pb n="35" facs="StAZH_B_II_695__S__35_.tif"/>
            <p>
                <lb/>Der im <placeName ref="LOC_47.374444_8.541111">Ötenbach</placeName> verwahrte betrieger, wel-cher
                <lb/>sich von namen <persName>Mustapha Caffa</persName> und von <placeName ref="LOC_36.73225_3.08746">Algiers</placeName>
            <lb/>gebürtig dargibt, auch allhier das christenthum an<lb break="no"/>nemmen wollen, und getaufft zuwerden verlangt,
                <lb/>soll in den <placeName ref="LOC_47.368744_8.542639">Wellenberg</placeName> gelegt, durch die her-ren
            <lb/>nachgänger alles ernsts wohar er komme? by was
            <lb/>gsellschafft er sich die zeitharo aufgehalten?
                <lb/>was für reisen er gemacht? ob und wann er zu <placeNa-me ref="LOC_46.94809_7.44744">Bern</placeName> ge<lb break="no"/>taufft worden, auch obe er zu <placeName ref="LOC_47.12693_8.75345">Einsidlen</placeName> nicht um
            <lb/>ein gleiches angehalten, und was ihme dorten
            <lb/>widerfahren, befraget, und seine verantwortung
            <lb/>widerum an <abbr>mghh.</abbr> gebracht werden.</p></div>
        </body>
                <back>
                <div>
                    <p><!-- Kommentar zum Quellenstück-->
                    </p>
                </div>
                </back>
            </text>
            </group>
    </text>
</TEI>



[1]:	https://teipublisher.com/exist/apps/tei-publisher/doc/documentation.xml?id=installation
[2]:	https://www.java.com/de/download/manual.jsp
[3]:	https://ant.apache.org/bindownload.cgi
[4]:	https://mkyong.com/ant/how-to-install-apache-ant-on-windows/
[5]:	https://www.youtube.com/watch?v=1AU8HqvgHXo
[6]:	https://docs.npmjs.com/downloading-and-installing-node-js-and-npm
[7]:	https://github.com
[8]:	https://www.youtube.com/watch?v=dyY539HzN6Q

[image-1]:	Aufbau-Git-Workflow.drawio.png
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