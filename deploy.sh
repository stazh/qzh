#!/usr/bin/env bash
set -e

EXIST_URL="http://localhost:8080"
USER="tim:pls"
XAR="build/qzh-0.1.xar"

echo "==> Build .xar"
ant xar

echo "==> Upload .xar nach eXist-db"
curl -sf -X PUT "$EXIST_URL/exist/rest/db/system/repo/qzh-0.1.xar" \
  -u "$USER" \
  -H "Content-Type: application/octet-stream" \
  --data-binary @"$XAR"

echo "==> Bestehende App entfernen (undeploy + Collection löschen)"
curl -sf -X POST "$EXIST_URL/exist/rest/db/system/repo" \
  -u "$USER" \
  -H "Content-Type: application/xml" \
  -d '<?xml version="1.0"?><query xmlns="http://exist.sourceforge.net/NS/exist"><text><![CDATA[
    try { repo:undeploy("http://existsolutions.com/qzh") } catch * { () },
    try { repo:remove("http://existsolutions.com/qzh") } catch * { () },
    if (xmldb:collection-available("/db/apps/qzh"))
    then xmldb:remove("/db/apps/qzh")
    else ()
  ]]></text></query>' > /dev/null

echo "==> Neu installieren"
RESULT=$(curl -sf -X POST "$EXIST_URL/exist/rest/db/system/repo" \
  -u "$USER" \
  -H "Content-Type: application/xml" \
  -d '<?xml version="1.0"?><query xmlns="http://exist.sourceforge.net/NS/exist"><text><![CDATA[
    repo:install-and-deploy-from-db("/db/system/repo/qzh-0.1.xar")
  ]]></text></query>')

if echo "$RESULT" | grep -q 'result="ok"'; then
  echo "==> Deployment erfolgreich"
else
  echo "==> FEHLER beim Deployment:"
  echo "$RESULT"
  exit 1
fi

echo "==> ODDs kompilieren"
curl -sf -X POST "$EXIST_URL/exist/apps/qzh/api/odd?odd=qzh.odd" -u "$USER" > /dev/null
curl -sf -X POST "$EXIST_URL/exist/apps/qzh/api/odd?odd=qzh-norm.odd" -u "$USER" > /dev/null

echo "==> pm-config.xql wiederherstellen (ODD-Kompilierung überschreibt diese Datei)"
curl -sf -X PUT "$EXIST_URL/exist/rest/db/apps/qzh/modules/pm-config.xql" \
  -u "$USER" \
  -H "Content-Type: application/xquery" \
  --data-binary @modules/pm-config.xql

echo "==> Permissions auf Transform-Dateien setzen"
curl -sf -X POST "$EXIST_URL/exist/rest/db" \
  -u "admin:" \
  -H "Content-Type: application/xml" \
  -d '<?xml version="1.0"?><query xmlns="http://exist.sourceforge.net/NS/exist"><text><![CDATA[
    import module namespace sm="http://exist-db.org/xquery/securitymanager";
    for $f in xmldb:get-child-resources("/db/apps/qzh/transform")
    let $path := xs:anyURI("/db/apps/qzh/transform/" || $f)
    return (sm:chown($path, "qzh"), sm:chgrp($path, "tei"), sm:chmod($path, "rwxr-xr-x"))
  ]]></text></query>' > /dev/null

echo "==> Fertig: $EXIST_URL/exist/apps/qzh"
