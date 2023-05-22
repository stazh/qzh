# Quellen zur Zürcher Geschichte

## Vorlage

Dieses Projekt ist eine modifizierte Version der TEI Publisher Webapplikation "Zürcher Rechtsquellen": https://gitlab.existsolutions.com/rqzh

## Dokumentation

- [Arbeiten mit TEI Publisher: Theorie und Hinweise für die Wartung der Webapplikation](/documentation/Arbeiten_mit_TEI_Publisher_Theorie/index.md)
- [Arbeiten mit TEI Publisher: GIT Workflow](/documentation/Arbeiten_mit_TEI_Publisher_GIT_Workflow/index.md)
- [Edieren mit dem StAZH: TEI-Workflow](/documentation/Edieren_in_XML_TEI_Workflow/index.md)
- [Changelog](/documentation/Changelog/index.md)

  
## Daten

Das Projekt besteht aus zwei Repositories: Der Webapplikation (dieses Repository) und dem Daten-Repository mit den Quellenstücken. Das Daten-Repository befindet sich hier: https://github.com/stazh/qzh-data
Unter diesem Link befindet sich auch eine Anleitung zum Taggen von Quellenstücken.

## Hinweis für das Deployment auf dem Server

Manchmal werden bei Import eines neuen .xar-Files in die eXist-db einige Dateien nicht übernommen. Bei einem Test betraf dies das File `transform/qzh-web.xql` (=> In der eXist-db war anschliessend ein veralteter Stand der Datei vorhanden, obwohl sich innerhalb der .xar-Datei das neue File befindet). Ein solcher Fehler äussert sich zum Beispiel dadurch, dass Quellenstücke nicht angezeigt werden können und stattdessen eine Fehlermeldung auf dem Bildschirm erscheint. In diesem Fall kann das betroffene File (oder die betroffenen Files) in der eXide geöffnet werden und der aktualisierte Inhalt manuell in das File eingefügt werden. Anschliessend muss die Datei in der eXide gesichert werden, damit die Änderungen wirksam werden.
