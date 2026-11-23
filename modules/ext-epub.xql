xquery version "3.1";

(:~
 : Extension functions for EPUB: the behaviours defined in qzh.odd which the EPUB library does not know.
 : Without them text nodes, critical notes etc. would be missing from the output.
 :)
module namespace pmf="http://www.tei-c.org/tei-simple/xquery/functions/ssrq-epub";

declare namespace epub="http://www.idpf.org/2007/ops";

import module namespace html="http://www.tei-c.org/tei-simple/xquery/functions";
import module namespace counters="http://www.tei-c.org/tei-simple/xquery/counters";
import module namespace web="http://www.tei-c.org/tei-simple/xquery/functions/ssrq-web" at "ext-html.xql";

declare function pmf:content($config as map(*), $node as node(), $class as xs:string+, $content as item()*) {
    web:content($config, $node, $class, $content)
};

(:~ The library prints "[]" for line breaks within a word. :)
declare function pmf:break($config as map(*), $node as node(), $class as xs:string+, $content, $type, $label) {
    html:break($config, $node, $class, $content, $type, $label)
};

(:~ The table of contents links to the id. :)
declare function pmf:section($config as map(*), $node as node(), $class as xs:string+, $content) {
    <section class="{$class}" id="{translate(generate-id($node), ".", "_")}">
    { html:apply-children($config, $node, $content) }
    </section>
};

declare function pmf:caption($config as map(*), $node as element(), $class as xs:string+, $content) {
    web:caption($config, $node, $class, $content)
};

declare function pmf:copy($config as map(*), $node as element(), $class as xs:string+, $content) {
    web:copy($config, $node, $class, $content)
};

declare function pmf:output-date($config as map(*), $node as element(), $class as xs:string+, $content) {
    web:output-date($config, $node, $class, $content)
};

(:~ The end of a note spanning several words is only marked on the web. :)
declare function pmf:notespan-end($config as map(*), $node as element(), $class as xs:string+, $content) {
    ()
};

(:~ Text followed by a note. :)
declare function pmf:alternote($config as map(*), $node as element(), $class as xs:string+, $content,
    $label, $type, $alternate, $optional as map(*)) {
    <span class="{$class}">{ html:apply-children($config, $node, $content) }</span>,
    pmf:footnote($config, $node, $alternate, $optional?prefix)
};

declare function pmf:note($config as map(*), $node as element(), $class as xs:string+, $content, $place, $label, $type,
    $optional as map(*)) {
    pmf:footnote($config, $node, $content, $optional?prefix)
};

(:~ Text which itself refers to the note. If it contains references already, the note gets a number instead. :)
declare function pmf:alternate($config as map(*), $node as node(), $class as xs:string+, $content, $default, $alternate) {
    let $text := <span class="alternate {$class}">{ html:apply-children($config, $node, $default) }</span>
    return
        if ($text//a[@epub:type = "noteref"]) then (
            $text,
            pmf:footnote($config, $node, $alternate, ())
        ) else (
            <a epub:type="noteref" href="#{pmf:footnote-id($node)}">{ $text/@*, $text/node() }</a>,
            <aside epub:type="footnote" id="{pmf:footnote-id($node)}" class="altcontent">
            { $config?apply-children($config, $node, $alternate) }
            </aside>
        )
};

declare %private function pmf:footnote($config as map(*), $node as node(), $content, $prefix) {
    <a epub:type="noteref" href="#{pmf:footnote-id($node)}" class="noteref">{ counters:increment($html:NOTE_COUNTER_ID) }</a>,
    <aside epub:type="footnote" id="{pmf:footnote-id($node)}" class="note">
    {
        $config?apply-children($config, $node, $prefix),
        $config?apply-children($config, $node, $content)
    }
    </aside>
};

declare %private function pmf:footnote-id($node as node()) as xs:string {
    "fn" || translate(generate-id($node), ".", "_")
};
