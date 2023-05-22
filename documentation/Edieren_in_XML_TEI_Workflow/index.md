# Edieren mit dem StAZH: TEI-Workflow

Verfasst von Michael Schaffner, Mai 2023

## Übersicht

(Für eine vergrösserte Ansicht: siehe separate Datei)
![][image-1]

Auf die einzelnen Abschnitte in dieser Übersicht wird in diesem Dokument eingegangen.

Hinweis: Das Projekt „Rechtsquellen des Kantons Zürich“ besteht aus zwei Repositories: Ein Repository mit dem gesamten Quellcode und ein separates Repository, welches nur die Quelldateien enthält. Die Setup-Schritte müssen jeweils für beide Repositories einmalig ausgeführt werden.



## Schritt 1: Lokale Installation der eXist-DB und des TEI-Publishers (einmalig)

### Installationsanleitung

Hier befindet sich eine Installationsanleitung für die eXist-DB und den TEI-Publisher: [https://teipublisher.com/exist/apps/tei-publisher/doc/documentation.xml?id=installation][1]

Es gibt zwei Wege, die Applikation zu installieren: entweder über Docker oder als Standalone Java Applikation. 

Die Docker-Version hat einen eher instabilen Eindruck gemacht, deshalb ist die Installation als Standalone Java Applikation empfohlen.

**Hinweis**: da TEI-Publisher Root-Rechte erfordert, kann er nicht auf dem Arbeitsrechner installiert werden.

### Verwendete Java-Version

Es gibt verschiedene Versionen der Java Runtime. Falls auf dem System Java noch nicht installiert ist, kann zum Beispiel die folgende Runtime verwendet werden: [https://www.java.com/de/download/manual.jsp][2]

### Installation von benötigen Hilfs-Packages

Nach der Installation kann der eXist-Datenbank-Server gestartet werden und das Dashboard geöffnet werden:

![][image-2]

![][image-3]

Standartmässig ist bereits ein Benutzer angelegt, mit dem man sich einloggen kann:

- Username: `admin`
- Passwort: (leer)

Anschliessend können über den Package Manager weitere Applikationen für die eXist-DB nachinstalliert werden:

![][image-4]

Anscheinend gibt es momentan einen Bug, der verhindert, dass der TEI-Publisher seine Abhängigkeiten selbst lädt. Bei der Installation der Applikation „TEI Publisher“ kann es deshalb zu einem Fehler kommen. 

Um den Fehler zu beheben, sollten zuerst zwei benötigte Abhängigkeiten installiert werden:

![][image-5]

![][image-6]

Anschliessend kann auch der TEI Publisher installiert werden:

![][image-7]


### User-Management

Im Abschnitt User-Management kann man weitere User-Accounts und Passwörter anlegen:

![][image-8]

## Schritt 2: Installation von Hilfstools: Ant, Node, npm (einmalig)

### Ant

- ANT wird benötigt, um später aus dem Quellcode der Applikation eine `.xar`-Datei zu erzeugen
- Eine kurze Anleitung zur Installation von ANT befindet sich hier: [https://ant.apache.org/bindownload.cgi][3]
- Die Anleitung ist etwas kompliziert, da man von Hand die Umgebungsvariabeln anpassen muss. Unter den folgenden Links ist die Anleitung noch etwas detailierter beschrieben:
	- Windows: [https://mkyong.com/ant/how-to-install-apache-ant-on-windows/][4]
	- Mac: Unter MacOS ist es am einfachsten, ein Packagemanager wie Homebrew zu verwenden, um ANT zu installieren. Eine Anleitung zur Installation von ANT mit Hilfe von Homebrew befindet sich hier: [https://www.youtube.com/watch?v=1AU8HqvgHXo][5]

### Node und npm

- Node und Npm werden benötigt, um später mittels Visual Studio Code automatisch die Änderungen an den Codedateien zur Exist-Datenbank zu Synchronisieren.
- Je nach Betriebssystem funktioniert die Installation unterschiedlich. Eine Anleitung befindet sich hier: [https://docs.npmjs.com/downloading-and-installing-node-js-and-npm][6]. Am einfachsten ist es, den Installer herunterzuladen, der relativ einfach durch die Installation führt. 


## Schritt 3: Anlegen eines GitHub (bzw. GitLab) Accounts (einmalig)

### Anlegen eines Accounts (kostenlos)

[https://github.com][7]

### Beitritt zur Gruppe „Quellen zur Zürcher Geschichte“
Zur Gruppe „Quellen zur Zuercher Geschichte“ hinzugefügt werden. (Nur bestehende Mitglieder:innen in der Gruppe mit den Rollen „Maintainer“ oder „Owner“ können neue Mitglieder:innen hinzufügen)


## Schritt 4: GitHub Zugangsdaten zum Git-Client hinzufügen (einmalig)

Wenn ein grafischer Git-Client wie Sourcetree verwendet wird, können die Zugangsdaten zu GitHub in den Einstellungen hinterlegt werden:

![][image-14]
![][image-15]
![][image-16]


## Schritt 5: Beide Projekt-Repositories von GitHub (bzw. GitLab) klonen (einmalig)

### Variante 1: Über die Konsole klonen

```bash
git clone https://github.com/stazh/qzh.git
```

```bash
git clone https://github.com/stazh/qzh-data.git
```

### Variante 2: Über einen Git-Client klonen

Statt die Git-Konsole zu verwenden, kann auch ein grafischer Git-Client (zum Beispiel SourceTree) verwendet werden: 

![][image-17]
![][image-18]
![][image-19]

## Schritt 6: Applikation zur Exist-DB hinzufügen (einmalig)

Später wird der geklonte Quellcode automatisch mit der ExistDB synchronisiert. Damit dies funktioniert, muss jedoch bereits eine initiale Version des Codes zur Exist-DB hinzugefügt werden.

Dazu muss zuerst aus den geklonten Repositories jeweils eine `.xar`-Datei erzeugt werden. Dies geschieht über die Konsole, die lokalen Pfade müssen je nach Speicherort des Codes abgeändert werden:

```bash
cd /Users/jan/quellen-zur-zuercher-geschichte

ant
```

Dieser Befehl erzeugt die `.xar`-Datei. Der Speicherort der `.xar`-Datei wird auf der Konsole ausgegeben:

```bash
/Users/jan/quellen-zur-zuercher-geschichte/build/qzh-0.1.xar
```

Die gleichen Schritte sollten auch für das Daten-Repository durchgeführt werden:

```bash
cd /Users/jan/quellen-zur-zuercher-geschichte-daten

ant
```

auch hier wird wieder der Speicherort auf der Konsole ausgegeben:

```bash
/Users/jan/quellen-zur-zuercher-geschichte-daten/build/qzh-data-0.1.xar
```

Als nächstes sollen die beiden `.xar`-Files zur Exist-DB hinzugefügt werden. Dazu öffnet man das Dashboard der Exist-DB und meldet sich mit dem Nutzer `admin` an. Das Passwort kann leer gelassen werden:

![][image-20]

Als nächstes wechselt man zum Package Manager:

![][image-21]

Nun können die beiden `.xar`-Files per Drag-and-Drop zum Package Manager hinzugefügt werden:

![][image-22]

Wenn die Installation funktioniert hat, erscheinen nun beim Launcher der Exist-DB zwei neue Icons für „Quellen zur Zürcher Geschichte“ und „Quellen zur Zürcher Geschichte: Daten“. Wenn man auf das Icon „Quelle zur Zürcher Geschichte“ klickt, sollte die Applikation gestartet und angezeigt werden:

![][image-23]



## Schritt 7: Visual Studio Code und Erweiterungen installieren (einmalig)

Hinweis: Statt mit Visual Studio Code kann auch direkt mit dem eXide-Editor gearbeitet werden. Dies hat jedoch den Nachteil, dass jede Änderung im Code wieder auf das File-System exportiert und manuell in das Git-Repository kopiert werden muss, was umständlich und fehleranfällig ist. Deshalb wird hier nur auf die Variante mit Visual Studio Code eingegangen.

Für die Arbeit mit Visual Studio Code sollte die Erweiterung **existdb-vscode** installiert werden (im Menü unter `Code > Einstellungen > Erweiterungen`):

![][image-24]

Daneben soll auch die Erweiterung `tei-publisher-vscode` installiert werden:

![][image-25]

Diese beiden Erweiterungen vereinfachen das Bearbeiten der Dateien und kümmern sich darum, dass Änderungen an den Codedateien automatisch mit der eXist-DB synchronisiert werden. 

## Schritt 8: Automatische Synchronisation mit der eXist-DB einrichten (einmalig)

Das Synchronisieren muss zuerst konfiguriert werden. Dies muss nacheinander für beide Repositories gemacht werden.

Dazu öffnet man ein Repository über das Menü `Datei > Öffnen`

![][image-26]

Anschliessend drückt man in Visual Studio Code `Ctrl+Shift+P`, um alle Commands anzuzeigen (`CMD-Shift-P` auf dem Mac).

Im sich öffnenden Dialog wählt man die Option `eXist-db: Create or edit configuration for folder`. Anschliessend wählt man das angezeigte Verzeichnis mit dem Code aus:

![][image-27]
![][image-28]

Es öffnet sich eine Datei, in der die Synchronisation konfiguriert werden kann. In dieser Datei sollte man den Zielpfad anpassen, der angibt, in welches Verzeichnis innerhalb des TEI-Publishers der Sourcecode aus Visual Studio Code kopiert werden soll.

Hier heisst das Ziel-Verzeichnis: `/db/apps/qzh`:

```json
{
    "servers": {
        "localhost": {
            "server": "http://localhost:8080/exist",
            "user": "admin",
            "password": "",
            "root": "/db/apps/qzh" <- hier den pfad anpassen
        }
    },
    "sync": {
        "server": "localhost",
        "ignore": [
            ".existdb.json",
            ".git/**",
            "node_modules/**",
            "bower_components/**",
            "package*.json",
            ".vscode/**"
        ]
    }
}
```

Für das zweite Repository sollten die gleichen Schritte wiederholt werden. Allerdings sollte man hier einen anderen Zielpfad wählen (z.B. `/db/apps/qzh-data`)


## Schritt 9: Automatische Synchronisation mit eXist-DB starten (nach jedem Neustart von Visual Studio Code)

**Wichtig**: Dieser Schritt sollte immer als erstes gemacht werden, bevor man Änderungen am Code durchführt oder die neusten Änderungen des Codes von GitHub pullt.

Auch hier sollen die folgenden Schritte für beide Repositories wiederholt werden. Innerhalb von Visual Studio Code klickt man wieder auf  `Ctrl+Shift+P`, um alle Commands anzuzeigen (`CMD-Shift-P` auf dem Mac). Über das angezeigte Menü wählt man diesmal `eXist-db: Control folder synchronisation to database`

![][image-29]

Anschliessend wählt man `start synchronization`:

![][image-30]

Wenn alles Funktioniert hat, sieht man jeweils beim Speichern einer Datei, wie die Änderung an die Exist-DB übertragen wird:

![][image-31]

Hinweis: Nicht-gesicherte Dateien werden nicht automatisch übertragen. Deshalb sollte man immer daran denken, die Files nach dem Editieren zu Speichern. Bei ungültigen Änderungen wird jeweils eine Fehlermeldung angezeigt und die Änderungen nicht übertragen. In diesem Fall muss der Fehler in der Datei zuerst behoben werden und anschliessend die Datei neu gespeichert werden, damit diese übertragen wird:

![][image-32]

Wichtiger Hinweis 1: Grosse Dateien (zum Beispiel Bilddateien) können nicht auf diese Weise übertragen werden. Solche Dateien können jedoch über die eXide hochgeladen werden. Dazu klickt man in der eXide auf „File \> Manage“. Dort gibt es dann einen Button „Upload Files“ (symbolisiert mit einer Wolke).

Wichtiger Hinweis 2: Durch den automatischen Sync können zwar einzelne Dateien übertragen werden, neu angelegte oder umbenannte Ordner werden jedoch nicht übertragen! Das bedeutet, dass man beim Anlegen eines neuen Ordners oder beim Umbenennen eines Ordners diese Änderung manuell in der eXide wiederholen muss. Dies ist auch der Fall, wenn man Code-Änderungen von GitHub pullt, welche eine Änderung an der Ordnerstruktur zur Folge haben.

###  Was kann man tun, wenn der Code in eXide und die lokalen Codedateien voneinander abweichen?

Es kann verschiedene Gründe geben, dass der Code in eXide und nicht mehr mit den lokalen Codedateien übereinstimmt:
- Es wurde vor Codeänderungen vergessen, den Sync zu aktivieren
- Beim Pullen von neuem Code über GitHub konnten nicht alle Änderungen übertragen werden
- Grosse Dateien wie Bilder wurden nicht durch den Sync übertragen
- Änderungen an der Ordnerstruktur wurden nicht durch den Sync übertragen

Damit an beiden Orten der Code wieder aktuell ist, kann man folgendermassen vorgehen:

1. Das Projekt aus eXide löschen (je nachdem welches Repository betroffen ist, entweder der Ordner „apps/qzh“ oder der Ordner „apps/qzh-data“). Ordner und Dateien können in eXide über „File \> Manage“ gelöscht werden.
2. Eine neue `.xar`-Datei aus aus den lokalen Codedateien erzeugen und dieses `.xar` erneut in eXide importieren (Siehe Abschnitt 6 in dieser Anleitung)

## Schritt 10: Automatisches Browser-Update einrichten (nach jedem Neustart der Exist-DB)

Vorsicht: Der Sync funktioniert nur in eine Richtung. Änderungen innerhalb von eXide werden nicht an Visual Studio und das Filesystem zurückgespiegelt! Die Änderungen sollten deshalb nur in Visual Studio Code vorgenommen werden.


Über das eXist-db Dashboard kann die Applikation gestartet werden.

![][image-33]

Nach einer Änderung an den Dateien über Visual Studio Code kann einfach die Browser-Seite neu geladen werden, um die Änderungen live anzuzeigen.

![][image-34]

**Hinweis**: Es kann sein, dass gewisse Änderungen nicht sofort sichtbar sind, weil sie vom Browser ge-cached wurden. In diesem Fall sollte der Cache des Browsers gelöscht werden oder der „Inkognito-Modus“ des Browsers verwendet werden.

## Schritt 11: Änderungen in das GIT-Repository pushen (regelmässig)

Änderungen an den Codedateien können entweder über die Konsole oder über einen grafischen GIT-Client wie SourceTree auf GitHub gepusht werden.

Bei SourceTree wählt man über die Checkbox sämtliche Änderungen aus, die man „committen“ möchte und klickt anschliessend unten rechts auf „Commit“. Um die Änderungen schlussendlich auf BitHub zu laden, klickt man auf den Button „Push“.

![][image-35]


## Schritt 12: Änderungen vom GIT-Repository pullen (regelmässig)

**Wichtig**: Neue Änderungen sollten erst dann vom Repository gepullt werden, wenn die automatische Synchronisierung zwischen Filesystem und der Exist-DB läuft (Schritt 9)

Wenn gemeinsam am Code gearbeitet wird, kann es sein, dass es auf GitHub bereits Änderungen durch andere Personen gegeben hat. In diesem Fall sollte man den neuen Source Code „pullen“ bevor man seine Änderungen pusht. Dazu gibt es im SourceTree den Button „Pull“ (bei vorhandenen Änderungen ist dieser jeweils mit einer Zahl hervorgehoben). Falls zwei Personen die gleiche Datei bearbeitet haben, kann es zu GIT-Konflikten kommen, die anschliessend wieder aufgelöst werden müssen.

## Weitere Ressourcen

[https://www.youtube.com/watch?v=dyY539HzN6Q][8]

In diesem Video werden zwei mögliche Workflows vorgestellt: „Database as Master“ und „Git as Master“. In diesem Dokument ist nur die Version „Git as Master“ beschrieben.

Das Video enthält auch eine grundlegende Einführung zum Thema GIT.

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