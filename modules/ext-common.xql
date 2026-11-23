xquery version "3.1";

(:~
 : Shared extension functions for SSRQ.
 :)
module namespace pmf="http://www.tei-c.org/tei-simple/xquery/functions/ssrq-common";

import module namespace config="http://www.tei-c.org/tei-simple/config" at "config.xqm";
import module namespace counters="http://www.tei-c.org/tei-simple/xquery/counters";
import module namespace functx="http://www.functx.com";

declare namespace tei="http://www.tei-c.org/ns/1.0";

declare variable $pmf:COUNTER_TEXTCRITICAL := "text-critical-" || util:uuid();
declare variable $pmf:COUNTER_NOTE := "note-" || util:uuid();

declare function pmf:prepare($config as map(*), $node as node()*) {
    (
        counters:destroy($pmf:COUNTER_TEXTCRITICAL),
        counters:destroy($pmf:COUNTER_NOTE),
        counters:create($pmf:COUNTER_TEXTCRITICAL),
        counters:create($pmf:COUNTER_NOTE)
    )[5]
};

declare function pmf:increment-counter($type as xs:string) {
    switch ($type)
        case "text-critical" case "text-critical-start" return
            counters:increment($pmf:COUNTER_TEXTCRITICAL)
        default return
            counters:increment($pmf:COUNTER_NOTE)
};

declare function pmf:scribe($scribe as attribute()?) {
    if ($scribe) then
        if (starts-with($scribe, 'per')) then
            <span class="scribe" data-ref="{$scribe}"/>
        else
            let $nr := number($scribe)
            return
                if ($nr = 1) then
                    pmf:label('mainScribe', false()) || ' (' || codepoints-to-string(string-to-codepoints("A") + $nr - 1) || ')'
                else
                    pmf:label('secondaryScribe', false()) || ' (' || codepoints-to-string(string-to-codepoints("A") + $nr - 1) || ')'
    else
        ()
};


declare function pmf:span($content) {
    <span class="description">{
        for $node in $content
        return
        typeswitch($node)
            case xs:string return
                text { $node }
            default return
                $node
    }</span>
};

declare function pmf:label($id as xs:string?) {
    pmf:label($id, true())
};

declare function pmf:label($id as xs:string?, $upper as xs:boolean) {
    pmf:label($id, $upper, 0)
};

declare function pmf:label($id as xs:string?, $upper as xs:boolean, $plural as xs:integer) {
    pmf:label($id, $upper, $plural, (session:get-attribute("ssrq.lang"), "de")[1])
};

(: Shorten the full title to display only the last part after "Band xy:" :)
declare function pmf:short-title($title as xs:string?) {
    let $normalized-title := normalize-space($title)
    let $short-title := functx:substring-after-last($normalized-title, ':')
    return
        $short-title
};

(: Preprocess href attribute for obsolete, static links in TEI ref/@target
    TODO: Retrieve and insert missing url part "collection-name" to $new-href (clear requirements)
:)
declare function pmf:ref-link($target as xs:string?, $collection as xs:string?) {
    let $log := util:log('debug', 'pmf:ref-link, TARGET=' || $target)
    let $href :=
        if (starts-with($target, '/startseite/literaturverzeichnis'))
        then (
            replace($target, '.+', '../literaturverzeichnis.html')
        )
        else if (starts-with($target, '/suche/detail'))
        then (
            let $volume-name := substring-after($target, 'detail')
            let $collection-name := substring-after($collection, $config:data-root)
            let $new-href := concat('..', $collection-name, $volume-name)
            let $log := util:log('debug', 'pmf:ref-link, $collection-name=' || $collection-name)
            return
                $new-href
        )
        else if (starts-with($target, 'http://permalink.snl.ch/bib/'))
        then
            '../literaturverzeichnis.html#' || substring-after($target,"http://permalink.snl.ch/bib/")
        else
            $target

    let $log := util:log('debug', 'pmf:ref-link, HREF=' || $href)
    return
        $href
};

declare function pmf:label($id as xs:string?, $upper as xs:boolean, $plural as xs:integer, $lang as xs:string) {
    if ($id) then
        let $spec := $config:schema-odd//tei:dataSpec[@ident='ssrq.labels']
        let $label :=
            if ($plural > 1) then
                if ($spec//tei:valItem[@ident = $id]/tei:desc[@xml:lang = $lang][@type="plural"]) then
                    $spec//tei:valItem[@ident = $id]/tei:desc[@xml:lang = $lang][@type="plural"]/text()
                else
                    $spec//tei:valItem[@ident = $id]/tei:desc[@xml:lang = $lang][1]/text()
            else
                $spec//tei:valItem[@ident = $id]/tei:desc[@xml:lang = $lang][1]   (: doesn't work for <hi rend="sup">e</hi>, just returns 'e' :)
        return
            if ($label) then
                if (count($label) > 1) then
                    ``[[Doppelte Übersetzung: `{$id}`, Sprache: `{$lang}`]]``
                else if ($upper) then
                    upper-case(substring($label, 1, 1)) || substring($label, 2)
                else
                    $label
            else
                ``[[Nicht übersetzt: `{$id}`, Sprache: `{$lang}`]]``
    else
        "[Missing label]"
};

declare function pmf:abbr($abbr as xs:string) {
    let $lang := (session:get-attribute("ssrq.lang"), "de")[1]
    let $val := $config:abbr//tei:valItem[@ident=$abbr]
    return (
        $val/tei:desc[@xml:lang = $lang]/string(),
        $val/tei:desc[1]/string()
    )[1]
};

(:~ Doppelpunkt einfügen unter Berücksichtigung frz. Typographie :)
declare function pmf:colon() {
    pmf:punct(':', true())
};

(:~ Strichpunkt einfügen unter Berücksichtigung frz. Typographie :)
declare function pmf:semicolon() {
    pmf:punct(';', true())
};

(:~ Französische Typographie erfordert Leerzeichen vor best. Interpunktionszeichen :)
declare function pmf:punct($char as xs:string, $spaceAfter as xs:boolean?) {
    let $lang := (session:get-attribute("ssrq.lang"), "de")[1]
    let $punct :=
        switch ($lang)
            case 'fr' return ' ' || $char
            default return $char
    return
        if ($spaceAfter) then
            $punct || ' '
        else
            $punct
};

declare function pmf:translate($attribute) {
    pmf:translate($attribute, 0, "uppercase")
};

declare function pmf:translate($attribute, $plural, $upper) {
    if ($attribute) then
        let $lang := (session:get-attribute("ssrq.lang"), "de")[1]
        let $element-name := local-name($attribute/..)
        let $attribute-name := local-name($attribute)
        let $value := $attribute/string()
        let $spec := $config:schema-odd//tei:elementSpec[@ident=$element-name]
        let $label:=
            if ($plural > 1) then
                let $plural := $spec//tei:attDef[@ident=$attribute-name]//tei:valItem[@ident=$value]/tei:desc[@xml:lang=$lang][@type="plural"]
                return
                    if ($plural) then
                        $plural/string()
                    else
                        $spec//tei:attDef[@ident=$attribute-name]//tei:valItem[@ident=$value]/tei:desc[@xml:lang=$lang][1]/string()
            else
                $spec//tei:attDef[@ident=$attribute-name]//tei:valItem[@ident=$value]/tei:desc[@xml:lang=$lang][1]/string()
        return
        switch ($upper)
            case "uppercase"
                return text{upper-case(substring($label,1,1)) || substring($label,2)}
            default
                return text{$label}
    else
        ()
};

declare function pmf:display-sigle($id as xs:string?) {
    let $components := tokenize($id, "_")
    return
        $components[1] || " " || $components[2] || "/" || $components[3]
};

declare function pmf:get-canton($id as xs:string?) {
    let $components := tokenize($id, "_")
    return
        $components[2]
};

declare function pmf:format-id($id as xs:string?) {
    let $temp := replace($id, "^QZH_", "")
    let $temp  := replace($temp, "^(.+?)_(\d{3}.*?)(?:_\d{1,2})?$", "$1 $2")
    return
        "QZH " || $temp
};

declare function pmf:get-article-nr($id as xs:string?) {
    let $temp  := replace($id, "^(.+?)_(\d{3}.*?)(?:_\d{1,2})?$", "$1 $2")
    let $parts := tokenize($temp)
    let $nr    :=
        if (matches($parts[2], '^\d{8}')) then
            ()
        else if (matches($parts[2], '^\d{4}_\d{3}')) then
            number(substring-after($parts[2], '_'))
        else
            number($parts[2])
    return $nr
};

declare function pmf:format-date($when as xs:string?) {
    pmf:format-date($when, (session:get-attribute("ssrq.lang"), "de")[1])
};

declare function pmf:format-date($when as xs:string?, $language as xs:string?) {
    if ($when) then
        text {
            try {
                if (matches($when, "^--\d+-\d+")) then
                    format-date(xs:date(replace($when, "^-(.*)$", "1900$1")), "[D1]. [MNn]", $language, (), ())
                else if (matches($when, "^--\d+")) then
                    format-date(xs:date(replace($when, "^-(.*)$", "1900$1-01")), "[MNn]", $language, (), ())
                else if (matches($when, "^\d{4}-\d{2}$")) then
                    format-date($when || '-01', "[MNn] [Y0001]", $language, (), ())
                else if (matches($when, "^\d+$")) then
                    $when
                else
                    if ($language = 'fr') then
                        format-date(xs:date($when), "[D01].[M01].[Y0001]", $language, (), ())
                    else
                        format-date(xs:date($when), "[D1].[M1].[Y0001]", $language, (), ())
            } catch * {
                $when
            }
        }
    else
        ()
};

(: Retrieve a number from the week
:  $duration as String in custom time format e.g. "P1W"
:  @return String e.g. "1"
:)
declare function pmf:weeks-from-duration($duration as xs:string) {
    let $week-number :=
        if (matches($duration, 'W$'))
        then
            replace($duration, '(\D)', '')
        else
            0
    return (
        $week-number,
        util:log('debug', 'pmf:weeks-from-duration, $duration=' || $duration),
        util:log('debug', 'pmf:weeks-from-duration, $week-number=' || $week-number)
    )
};

(: Construct the label, mapping a label text with the incoming number
:  $duration as string e.g. "1"
:  @return String containing a combined label text, or just the original value
:)
declare function pmf:format-week-duration($duration as xs:string) {
    try {
        let $components := map:merge((
            pmf:get-duration-label("week", pmf:weeks-from-duration($duration))
        ))
        return
            string-join(
                map:for-each($components, function($key, $value) {
                    if ($value > 0) then
                        $value || " " || $key
                    else
                        ()
                }),
                " "
            )
    } catch * {
        $duration
    }
};

declare function pmf:format-duration($duration as xs:string) {
    try {
        let $duration := xs:duration($duration)
        let $components := map:merge((
            pmf:get-duration-label("year", years-from-duration($duration)),
            pmf:get-duration-label("month", months-from-duration($duration)),
            pmf:get-duration-label("day", days-from-duration($duration)),
            pmf:get-duration-label("hour", hours-from-duration($duration))
        ))
        return
            string-join(
                map:for-each($components, function($key, $value) {
                    if ($value > 0) then
                        $value || " " || $key
                    else
                        ()
                }),
                " "
            )
    } catch * {
        $duration
    }
};

declare function pmf:get-duration-label($name as xs:string, $quantity as xs:int) {
    let $lang := (session:get-attribute("ssrq.lang"), "de")[1]
    let $val := $config:schema-odd//tei:dataSpec[@ident='ssrq.labels']//tei:valItem[@ident=$name]
    return
        if ($val) then
            let $label :=
                if ($quantity > 1) then
                    ($val/tei:desc[@xml:lang = $lang][@type="plural"]/string(), $val/tei:desc[@xml:lang = $lang]/string())[1]
                else
                    $val/tei:desc[@xml:lang = $lang][not(@type = "plural")]/string()
            return
                map {
                    $label : $quantity
                }
        else
            map { $name: $quantity }
};

declare function pmf:footnote-label($nr as xs:int) {
    string-join(reverse(pmf:footnote-label-recursive($nr)))
};

declare function pmf:existsAdditionalSource($idno as xs:string) {
    if (matches($idno, "_1$")) then
        true()
    else
        false()
};

declare function pmf:additionalSource($idno as xs:string) {
    let $base := replace($idno, "^(.*)_1$", '$1')
    for $header in
        collection($config:data-root)//tei:teiHeader[matches(.//tei:seriesStmt/tei:idno, "^" || $base || "_\d+$")]
            [not(.//tei:seriesStmt/tei:idno = $idno)]
        order by number(replace($header//tei:seriesStmt/tei:idno, "^.*_(\d+)$", "$1"))
        return
            $header//tei:msDesc
};

declare function pmf:url($url as xs:string) {
    (: fix URL for LaTeX :)
    let $url := tokenize(functx:replace-multi($url, ('#', '%'), ('\\#', '\\%')))[1]

    return '\url{' || $url || '}'
};

declare function pmf:format-author($author as node()*) {
    (: save typing in qzh.odd :)

    if ($author) then
        if (count($author) > 2) then
            string-join(($author[1], $author[2]), '; ') || ' et al.'
        else
            string-join($author, '; ')
    else
        ()
};

declare function pmf:switch-name($name as node()*) {

    substring-after($name, ', ') || ' ' || substring-before($name, ', ')
};

declare function pmf:format-editor($editor as node()*) {
    (: save typing in qzh.odd :)

    if ($editor) then
        if (count($editor) > 2) then
            pmf:switch-name($editor[1]) || ', ' || pmf:switch-name($editor[2]) || ' et al.'
        else if (count($editor) = 2) then
            pmf:switch-name($editor[1]) || ' und ' || pmf:switch-name($editor[2])
        else
            pmf:switch-name($editor)
    else
        ()
};

declare function pmf:print-date($date as node()*) {
    (: save typing in qzh.odd :)

    let $date-string :=
    	if ($date/@when) then
            if (matches($date/@when, "^\d{4}-\d{2}$")) then
                format-date(xs:date($date/@when || '-01'), "[MNn] [Y0001]", (session:get-attribute('ssrq.lang'), 'de')[1], (), ())
            else
        	    format-date(xs:date($date/@when), '[Y] [MNn] [D1]', (session:get-attribute('ssrq.lang'), 'de')[1], (), ())
    	else if (matches($date/@from, '-01-01$') and matches($date/@to, '-12-31$')) then (: precision is one year :)
    	    if (substring($date/@from, 1, 4) = substring($date/@to, 1, 4)) then
    	        substring($date/@from, 1, 4)
            else
                pmf:print-date-period(xs:int(substring($date/@from, 1, 4)), xs:int(substring($date/@to, 1, 4)))
    	else if (substring($date/@from, 1, 4) = substring($date/@to, 1, 4)) then (: within the same year :)
    	    if (substring($date/@from, 6, 2) = substring($date/@to, 6, 2)) then (: within the same month :)
    	        format-date(xs:date($date/@from), '[Y] [MNn] [D1]', (session:get-attribute('ssrq.lang'), 'de')[1], (), ()) || ' – ' || format-date(xs:date($date/@to), '[D1]')
    	    else
    	        format-date(xs:date($date/@from), '[Y] [MNn] [D1]', (session:get-attribute('ssrq.lang'), 'de')[1], (), ()) || ' – ' || format-date(xs:date($date/@to), '[MNn] [D1]', (session:get-attribute('ssrq.lang'), 'de')[1], (), ())
    	else if (format-date(xs:date($date/@from), '[Y] [MNn] [D1]') and format-date(xs:date($date/@to), '[Y] [MNn] [D1]')) then
        	string-join((format-date(xs:date($date/@from), '[Y] [MNn] [D1]', (session:get-attribute('ssrq.lang'), 'de')[1], (), ()),
        	' – ',
        	format-date(xs:date($date/@to), '[Y] [MNn] [D1]', (session:get-attribute('ssrq.lang'), 'de')[1], (), ())))
        else ()
    let $old-style :=
    	if ($date/@calendar='Julian') then
    		' ' || pmf:label('old-style-abbr', false())
    	else
    		()

    	return $date-string || $old-style
};

declare function pmf:print-date-period($from as xs:int, $to as xs:int) {

    let $century := $from idiv 100 + 1
    let $default := string-join(('ca. ', $from, ' – ', $to))
    return
        if (($to - $from = 99) and ($to mod 100 = 0)) then
            string-join(($century, pmf:label('century-ordinal', false()), ' ', pmf:label('century-abbr', false())))
        else if (($to - $from = 49) and ($to mod 50 = 0)) then
            switch ($to - $from idiv 100 * 100)
                case  50 return string-join((pmf:label('first-female', false()), ' ', pmf:label('half-cent-abbr', false()), ' ', $century, pmf:label('century-ordinal', false()), ' ', pmf:label('century-abbr', false())))
                case 100 return string-join((pmf:label('second-female', false()), ' ', pmf:label('half-cent-abbr', false()), ' ', $century, pmf:label('century-ordinal', false()), ' ', pmf:label('century-abbr', false())))
                default return $default
        else if (($to - $from = 24) and ($to mod 25 = 0)) then
            switch ($to - $from idiv 100 * 100)
                case  25 return string-join((pmf:label('first-male', false()), ' ', pmf:label('quarter-cent-abbr', false()), ' ', $century, pmf:label('century-ordinal', false()), ' ', pmf:label('century-abbr', false())))
                case  50 return string-join((pmf:label('second-male', false()), ' ', pmf:label('quarter-cent-abbr', false()), ' ', $century, pmf:label('century-ordinal', false()), ' ', pmf:label('century-abbr', false())))
                case  75 return string-join((pmf:label('third-male', false()), ' ', pmf:label('quarter-cent-abbr', false()), ' ', $century, pmf:label('century-ordinal', false()), ' ', pmf:label('century-abbr', false())))
                case 100 return string-join((pmf:label('fourth-male', false()), ' ', pmf:label('quarter-cent-abbr', false()), ' ', $century, pmf:label('century-ordinal', false()), ' ', pmf:label('century-abbr', false())))
                default return $default
        else if (($to - $from = 20) and ($from mod 100 = 40)) then
            string-join((pmf:label('mid-cent-abbr', false()), ' ', $century, '. ', pmf:label('century-abbr', false())))
        else
            $default
};

declare %private function pmf:footnote-label-recursive($nr as xs:int) {
    if ($nr > 0) then
        let $nr := $nr - 1
        return (
            codepoints-to-string(string-to-codepoints("a") + $nr mod 26),
            pmf:footnote-label-recursive($nr div 26)
        )
    else
        ()
};

declare function pmf:persName-list($namen as element(tei:persName)*) {
    if (count($namen) > 1) then (
        string-join(subsequence($namen, 1, count($namen) -1), ', '),
        <pb-i18n key="and"> und </pb-i18n>,
        $namen[last()]
    ) else
        $namen
};

(:
 : Personen- und Ortsregister
 :)

(:~ Höchstzahl der Namen, mit denen ein Ort angezeigt wird :)
declare variable $pmf:MAX_PLACE_NAMES := 5;

(:
 : Werte, die für den laufenden Request gemerkt werden, damit das Register nicht für jeden Namen neu gelesen wird.
 : Globale Variablen eignen sich dafür nicht: eXist wertet sie bei jedem Request aus, auch wenn sie niemand braucht.
 :)
declare %private function pmf:recall($name as xs:string) as item()* {
    if (request:exists()) then
        request:get-attribute("qzh.register." || $name)
    else
        ()
};

declare %private function pmf:remember($name as xs:string, $value as item()*) as item()* {
    let $stored :=
        if (request:exists()) then
            request:set-attribute("qzh.register." || $name, $value)
        else
            ()
    return
        $value
};

(:~
 : Registereinträge ("person" oder "place") nach dem Wert von @xml:id. fn:id() genügt hier nicht: Schlüssel wie
 : "Bucher, N." sind keine gültigen IDs und werden von fn:id() nie gefunden.
 :)
declare %private function pmf:register($register as xs:string) as map(*) {
    let $known := pmf:recall($register)
    return
        if (exists($known)) then
            $known
        else
            pmf:remember($register, map:merge(
                for $entry in doc($config:data-root || "/" || $register || "/" || $register || ".xml")//(tei:person|tei:place)
                return
                    map:entry(string($entry/@xml:id), $entry)
            ))
};

(:~ Normalisierte Ortsnamen nach Ortsschlüssel :)
declare %private function pmf:place-norms() as map(*) {
    let $known := pmf:recall("place-norms")
    return
        if (exists($known)) then
            $known
        else
            pmf:remember("place-norms", map:merge(
                for $name in doc($config:data-root || "/place/place-additions.xml")//tei:text/tei:placeName[@ref]
                group by $ref := string($name/@ref)
                return
                    map:entry($ref, normalize-space($name[1]))
            ))
};

(:~ Wert für data-ref: ohne Leerzeichen, da data-ref eine Liste von Schlüsseln enthalten kann :)
declare function pmf:register-key($ref as xs:string?) as xs:string {
    encode-for-uri(normalize-space($ref))
};

(:~ Wert für data-ref bei Personen ohne Registereintrag :)
declare function pmf:unidentified-key($name as xs:string?) as xs:string {
    "unid-" || pmf:register-key($name)
};

declare %private function pmf:register-link($register as xs:string, $name as xs:string?, $key as xs:string) as xs:string {
    "../" || $register || "/all/" || encode-for-uri(translate($name, "/", " ")) || "?key=" || encode-for-uri($key)
};

(:~ Link auf die Registerliste ("people" oder "places"), geöffnet beim Anfangsbuchstaben von $name :)
declare function pmf:register-search-link($register as xs:string, $name as xs:string?) as xs:string {
    let $sort-name := replace(normalize-space($name), "^von ", "")
    return
        "../" || $register || "/all/?category=" || encode-for-uri(upper-case(substring($sort-name, 1, 1)))
};

(:~ Lesetext, z. B. eines Namens: ohne Anmerkungen, aufgelöste statt abgekürzte und neue statt getilgte Formen :)
declare function pmf:reading-text($element as element()) as xs:string {
    normalize-space(string-join(pmf:reading($element/node())))
};

declare %private function pmf:reading($nodes as node()*) as xs:string* {
    for $node in $nodes
    return
        typeswitch ($node)
            case text() return
                string($node)
            case element(tei:note) | element(tei:del) return
                ()
            case element(tei:abbr) return
                if ($node/../self::tei:choice/tei:expan or $node/following-sibling::*[1][self::tei:expan]) then
                    ()
                else
                    pmf:reading($node/node())
            case element() return
                pmf:reading($node/node())
            default return
                ()
};

(:~
 : Besteht ein Name nur aus Text, Zeilenumbrüchen und Abkürzungen? Andere Auszeichnungen erzeugen selbst Links (z. B. auf
 : Anmerkungen oder Orte), ein solcher Name kann nicht als Ganzes verlinkt werden.
 :)
declare function pmf:is-plain-name($name as element()) as xs:boolean {
    every $element in $name//* satisfies local-name($element) = ("lb", "choice", "abbr", "expan")
};

declare function pmf:person($ref as xs:string?) as element(tei:person)? {
    if ($ref) then
        pmf:register("person")(normalize-space($ref))
    else
        ()
};

(:~
 : Anzeigename einer Person. Personen ohne GND sind in den Täuferquellen mit ihrem normalisierten Namen referenziert
 : (ref="Bucher, N."), dann ist dieser Schlüssel der Name.
 :)
declare function pmf:person-label($person as element(tei:person)) as xs:string {
    let $key := string($person/@xml:id)
    return
        if ($key = "" or matches($key, "^(GND|LOC|QZH)_")) then
            normalize-space($person/tei:persName[@type = "full"][1])
        else
            $key
};

(:~ Wie person-label, bei normalisierten Namen ergänzt um die Schreibweisen der Quellen :)
declare function pmf:person-title($person as element(tei:person)) as xs:string {
    let $label := pmf:person-label($person)
    let $spellings := normalize-space($person/tei:persName[@type = "full"][1])
    return
        if ($spellings = ("", $label)) then
            $label
        else
            $label || " (" || $spellings || ")"
};

declare function pmf:person-link($person as element(tei:person)) as xs:string {
    pmf:register-link("people", pmf:person-label($person), $person/@xml:id)
};

(:~
 : Personen eines Stücks für die Registerleiste: zuerst jene aus dem Register, danach die übrigen (ohne @ref oder
 : ohne Registereintrag). Registereinträge ohne Namen werden ausgelassen.
 :)
declare function pmf:register-persons($root as node()) as element(tei:person)* {
    let $names := $root//tei:text//tei:persName
    return (
        for $person in distinct-values($names/@ref ! normalize-space(.)) ! pmf:person(.)
        where $person/tei:persName[normalize-space(.)]
        order by pmf:person-label($person)
        return
            $person,
        for $name in $names[not(pmf:person(@ref))]
        group by $label := pmf:reading-text($name)
        where $label
        order by $label
        return
            <person xmlns="http://www.tei-c.org/ns/1.0" n="{pmf:unidentified-key($label)}" type="unidentified">
                <persName type="full">{$label}</persName>
            </person>
    )
};

declare function pmf:place($ref as xs:string?) as element(tei:place)? {
    if ($ref) then
        pmf:register("place")(normalize-space($ref))
    else
        ()
};

(:~ Normalisierter Name eines Ortes, falls in place-additions.xml hinterlegt :)
declare function pmf:place-norm($place as element(tei:place)) as xs:string? {
    pmf:place-norms()(string($place/@xml:id))
};

(:~ Hauptname eines Ortes: der normalisierte Name, sonst der erste Name in @n :)
declare function pmf:place-name($place as element(tei:place)) as xs:string? {
    let $norm := pmf:place-norm($place)
    return
        if ($norm) then
            $norm
        else
            let $n := normalize-space($place/@n)
            let $names := $place/tei:placeName ! normalize-space(.)
            return
                ($names[. = $n or starts-with($n, . || ", ")], $names)[. != ""][1]
};

(:~
 : Alle Namen eines Ortes, zuerst der Hauptname. Die übrigen folgen in der Reihenfolge des Registers (@n). Sind es mehr,
 : als angezeigt werden, kommen die am häufigsten genannten zuerst.
 :)
declare %private function pmf:place-names($place as element(tei:place)) as xs:string* {
    let $main := pmf:place-name($place)
    let $n := ", " || normalize-space($place/@n) || ", "
    let $others :=
        for $name in distinct-values($place/tei:placeName ! normalize-space(.))[not(. = ("", $main))]
        order by string-length(substring-before($n, ", " || $name || ", "))
        return
            $name
    return (
        $main,
        if (count($others) < $pmf:MAX_PLACE_NAMES) then
            $others
        else
            let $mentions := map:merge(
                for $mention in collection($config:data-root)//tei:text//tei:placeName[@ref = $place/@xml:id]
                group by $spelling := normalize-space($mention)
                return
                    map:entry($spelling, count($mention))
            )
            for $name at $pos in $others
            order by ($mentions($name), 0)[1] descending, $pos
            return
                $name
    )
};

(:~ Anzeigename eines Ortes: Hauptname und weitere Schreibweisen, höchstens $pmf:MAX_PLACE_NAMES :)
declare function pmf:place-label($place as element(tei:place)) as xs:string {
    let $known := pmf:recall("place-label." || $place/@xml:id)
    return
        if (exists($known)) then
            $known
        else
            let $names := pmf:place-names($place)
            return
                pmf:remember("place-label." || $place/@xml:id, string-join((
                    subsequence($names, 1, $pmf:MAX_PLACE_NAMES),
                    if (count($names) > $pmf:MAX_PLACE_NAMES) then "…" else ()
                ), ", "))
};

declare function pmf:place-link($place as element(tei:place)) as xs:string {
    pmf:register-link("places", pmf:place-name($place), $place/@xml:id)
};

(:~ Orte eines Stücks für die Registerleiste. Registereinträge ohne Namen werden ausgelassen. :)
declare function pmf:register-places($root as node()) as element(tei:place)* {
    for $place in distinct-values($root//tei:text//(tei:placeName|tei:origPlace)/@ref ! normalize-space(.)) ! pmf:place(.)
    let $name := pmf:place-name($place)
    where $name
    order by $name
    return
        $place
};
