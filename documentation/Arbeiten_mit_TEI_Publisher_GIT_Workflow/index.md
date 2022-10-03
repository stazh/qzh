# Arbeiten mit TEI Publisher: GIT Workflow (2)

## Übersicht

(Für eine vergrösserte Ansicht: siehe separate Datei)
![][image-1]

Auf die einzelnen Abschnitte in dieser Übersicht wird in diesem Dokument eingegangen.

Hinweis: ich habe aktuell noch keinen Zugriff auf GitLab um ein neues Repository anzulegen. Die Screenshots und Beschreibungen beziehen sich deshalb zu Demo-Zwecken noch auf das Projekt „Zürcher Rechtsquellen“. 

Hinweis: Das Projekt „Rechtsquellen des Kantons Zürich“ besteht aus zwei Repositories: Ein Repository mit dem gesamten Quellcode und ein separates Repository, welches nur die Quelldateien enthält. Die Setup-Schritte müssen jeweils für beide Repositories einmalig ausgeführt werden.

## Schritt 1: Lokale Installation der eXist-DB und des TEI-Publishers

### Installationsanleitung

Hier befindet sich eine Installationsanleitung für die eXist-DB und den TEI-Publisher:

[https://teipublisher.com/exist/apps/tei-publisher/doc/documentation.xml?id=installation][1]

Es gibt zwei Wege, die Applikation zu installieren: entweder über Docker oder als Standalone Java Applikation. 

Die Docker-Version hat einen eher instabilen Eindruck gemacht, deshalb ist die Installation als Standalone Java Applikation empfohlen.

Hinweis - da TEI-Publisher Root-Rechte erfordert, kann er nicht auf dem Arbeitsrechner installiert werden.

### Verwendete Java-Version

Es gibt verschiedene Versionen der Java Runtime. Falls auf dem System Java noch nicht installiert ist, kann zum Beispiel die folgende Runtime verwendet werden:

[https://www.java.com/de/download/manual.jsp][2]

### Installation von benötigen Hilfs-Packages

Nach der Installation kann der eXist-Datenbank-Server gestartet werden und das Dashboard geöffnet werden:

![][image-2]

Standartmässig ist bereits ein Benutzer angelegt, mit dem man sich einloggen kann:

- Username: `admin`
- Passwort: (leer)

Anschliessend können über den Package Manager weitere Applikationen für die eXist-DB nachinstalliert werden:

![][image-3]

Anscheinend gibt es momentan einen Bug, der verhindert, dass der TEI-Publisher seine Abhängigkeiten selbst lädt. Bei der Installation der Applikation „TEI Publisher“ kann es deshalb zu einem Fehler kommen. 

Um den Fehler zu beheben, sollten zuerst zwei benötigte Abhängigkeiten installiert werden:

![][image-4]

![][image-5]

Anschliessend kann auch der TEI Publisher installiert werden:

![][image-6]


### User-Management

Im Abschnitt User-Management kann man weitere User-Accounts und Passwörter anlegen:

![][image-7]



## Schritt 2: Projekt-Repository von GitLab klonen (einmalig)

### Variante 1: Über die Konsole klonen

```bash
git clone https://gitlab.existsolutions.com/rqzh/rqzh2.git
```

### Variante 2: Über einen Git-Client klonen

Statt die Git-Konsole zu verwenden, kann auch ein grafischer Git-Client (zum Beispiel SourceTree) verwendet werden: 

![][image-8]
![][image-9]

(Hinweis: Dies muss für beide Repositories gemacht werden)

## Schritt 3: Erweiterungen für Visual Studio Code installieren (einmalig)

Hinweis: Statt mit Visual Studio Code kann auch direkt mit dem eXide-Editor gearbeitet werden. Dies hat jedoch den Nachteil, dass jede Änderung im Code wieder auf das File-System exportiert und manuell in das Git-Repository kopiert werden muss, was umständlich und fehleranfällig ist. Deshalb wird hier nur auf die Variante mit Visual Studio Code eingegangen.

Für die Arbeit mit Visual Studio Code sollte die Erweiterung **existdb-vscode** installiert werden (im Menü unter `Code > Einstellungen > Erweiterungen`):

![][image-10]

Daneben soll auch die Erweiterung `tei-publisher-vscode` installiert werden:

![][image-11]

Diese beiden Erweiterungen vereinfachen das Bearbeiten der Dateien und kümmern sich darum, dass Änderungen an den Codedateien automatisch mit der eXist-DB synchronisiert werden. 

## Schritt 4: Automatische Synchronisation mit der eXist-DB einrichten (einmalig)

Das Synchronisieren muss zuerst konfiguriert werden. Dies muss nacheinander für beide Repositories gemacht werden.

Dazu öffnet man ein Repository über das Menü `Datei > Öffnen`

![][image-12]

Anschliessend drückt man in Visual Studio Code `Ctrl+Shift+P`, um alle Commands anzuzeigen (`CMD-Shift-P` auf dem Mac).

Im sich öffnenden Dialog wählt man die Option `eXist-db: Create or edit configuration for folder`. Anschliessend wählt man das angezeigte Verzeichnis mit dem Code aus:

![][image-13]
![][image-14]

Es öffnet sich eine Datei, in der die Synchronisation konfiguriert werden kann. In dieser Datei sollte man den Zielpfad anpassen, der angibt, in welches Verzeichnis innerhalb des TEI-Publishers der Sourcecode aus Visual Studio Code kopiert werden soll.

In diesem Beispiel heisst das Ziel-Verzeichnis: `/db/apps/rqzh2`:

```json
{
    "servers": {
        "localhost": {
            "server": "http://localhost:8080/exist",
            "user": "admin",
            "password": "",
            "root": "/db/apps/rqzh2" <- hier den pfad anpassen
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

Für das zweite Repository sollten die gleichen Schritte wiederholt werden. Allerdings sollte man hier einen anderen Zielpfad wählen (z.B. `/db/apps/rqzh-data`)

Hinweis: allenfalls muss man zuerst über die eXide das leere Verzeichnis „db/apps/meinAppName“ anlegen, damit das Synchronisieren funktioniert (nicht überprüft)


## Schritt 5: Automatische Synchronisation mit eXist-DB starten (nach jedem Neustart von Visual Studio Code)

Auch hier sollen die folgenden Schritte für beide Repositories wiederholt werden. Innerhalb von Visual Studio Code klickt man wieder auf  `Ctrl+Shift+P`, um alle Commands anzuzeigen (`CMD-Shift-P` auf dem Mac). Über das angezeigte Menü wählt man diesmal `eXist-db: Control folder synchronisation to database`

![][image-15]

Anschliessend wählt man `start synchronization`:

![][image-16]

Wenn alles Funktioniert hat, sieht man jeweils beim Speichern einer Datei, wie die Änderung an die Exist-DB übertragen wird:

![][image-17]

Hinweis: Nicht-gesicherte Dateien werden nicht automatisch übertragen. Bei ungültigen Änderungen wird jeweils eine Fehlermeldung angezeigt und die Änderungen nicht übertragen:

![][image-18]


## Schritt 6: Automatisches Browser-Update einrichten (nach jedem Neustart der Exist-DB)

Die in Visual Studio Code vorgenommenen Änderungen sollten direkt im Browser angezeigt werden.  Dazu öffnet man zuerst die Exist-DB:

![][image-19]

Anschliessend wechselt man in eXide. Wenn alles funktioniert hat, sieht man dort die synchronisierten Dateien:

![][image-20]

Vorsicht: Der Sync funktioniert nur in eine Richtung. Änderungen innerhalb von eXide werden nicht an Visual Studio und das Filesystem zurückgespiegelt! Die Änderungen sollten deshalb nur in Visual Studio Code vorgenommen werden.

Als nächstes aktiviert man im Menü von eXide die Option „Live Reload“:

![][image-21]

Die Applikation zeigt nun einen Link an, der mit einem Klick geöffnet werden kann:

![][image-22]

Im Browser öffnet sich nun die Applikation:

![][image-23]

Nach einer Änderung an den Dateien über Visual Studio Code kann einfach die Browser-Seite neu geladen werden, um die Änderungen live anzuzeigen.

![][image-24]

Hinweis: Es kann sein, dass gewisse Änderungen nicht sofort sichtbar sind, weil sie vom Browser ge-cached wurden. In diesem Fall sollte der Cache des Browsers gelöscht werden oder der „Inkognito-Modus“ des Browsers verwendet werden.

## Schritt 7: Änderungen in das GIT-Repository pushen (regelmässig)

Änderungen an den Codedateien können entweder über die Konsole oder über einen grafischen GIT-Client wie SourceTree auf GitLab gepusht werden.

Bei SourceTree wählt man über die Checkbox sämtliche Änderungen aus, die man „committen“ möchte und klickt anschliessend unten rechts auf „Commit“. Um die Änderungen schlussendlich auf GitLab zu laden, klickt man auf den Button „Push“.

![][image-25]


## Schritt 8: Änderungen vom GIT-Repository pullen (regelmässig)

Wenn gemeinsam am Code gearbeitet wird, kann es sein, dass es auf GitLab bereits Änderungen durch andere Personen gegeben hat. In diesem Fall sollte man den neuen Source Code „pullen“ bevor man seine Änderungen pusht. Dazu gibt es im SourceTree den Button „Pull“ (bei vorhandenen Änderungen ist dieser jeweils mit einer Zahl hervorgehoben). Falls zwei Personen die gleiche Datei bearbeitet haben, kann es zu GIT-Konflikten kommen, die anschliessend wieder aufgelöst werden müssen.

## Weitere Ressourcen

[https://www.youtube.com/watch?v=dyY539HzN6Q][3]

In diesem Video werden zwei mögliche Workflows vorgestellt: „Database as Master“ und „Git as Master“. In diesem Dokument ist nur die Version „Git as Master“ beschrieben.

Das Video enthält auch eine grundlegende Einführung zum Thema GIT.

[1]:	https://teipublisher.com/exist/apps/tei-publisher/doc/documentation.xml?id=installation
[2]:	https://www.java.com/de/download/manual.jsp
[3]:	https://www.youtube.com/watch?v=dyY539HzN6Q

[image-1]:	Aufbau-Git-Workflow.drawio.png
[image-2]:	Bildschirmfoto%202022-09-27%20um%2013.14.06.png
[image-3]:	Bildschirmfoto%202022-09-27%20um%2013.16.33.png
[image-4]:	Bildschirmfoto%202022-09-16%20um%2014.01.02.png
[image-5]:	Bildschirmfoto%202022-09-16%20um%2014.01.25.png
[image-6]:	Bildschirmfoto%202022-09-27%20um%2013.18.33.png
[image-7]:	DraggedImage.jpg
[image-8]:	Bildschirmfoto%202022-09-27%20um%2011.25.11.png
[image-9]:	Bildschirmfoto%202022-09-27%20um%2011.25.23.png
[image-10]:	Bildschirmfoto%202022-09-20%20um%2011.25.30.png
[image-11]:	Bildschirmfoto%202022-09-20%20um%2012.32.04.png
[image-12]:	Bildschirmfoto%202022-09-27%20um%2011.37.39.png
[image-13]:	Bildschirmfoto%202022-09-27%20um%2011.40.41.png
[image-14]:	Bildschirmfoto%202022-09-27%20um%2011.43.06.png
[image-15]:	Bildschirmfoto%202022-09-27%20um%2011.50.13.png
[image-16]:	Bildschirmfoto%202022-09-27%20um%2011.52.04.png
[image-17]:	Bildschirmfoto%202022-09-27%20um%2011.53.41.png
[image-18]:	Bildschirmfoto%202022-09-27%20um%2011.55.37.png
[image-19]:	Bildschirmfoto%202022-09-27%20um%2011.57.06.png
[image-20]:	Bildschirmfoto%202022-09-27%20um%2011.57.35.png
[image-21]:	Bildschirmfoto%202022-09-27%20um%2012.00.15.png
[image-22]:	Bildschirmfoto%202022-09-27%20um%2012.00.37.png
[image-23]:	Bildschirmfoto%202022-09-27%20um%2012.01.17.png
[image-24]:	Bildschirmfoto%202022-09-27%20um%2012.03.19.png
[image-25]:	Bildschirmfoto%202022-09-27%20um%2012.06.11.png