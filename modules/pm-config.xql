
xquery version "3.1";

module namespace pm-config="http://www.tei-c.org/tei-simple/pm-config";

import module namespace pm-qzh-web="http://www.tei-c.org/pm/models/qzh/web/module" at "../transform/qzh-web-module.xql";
import module namespace pm-qzh-print="http://www.tei-c.org/pm/models/qzh/fo/module" at "../transform/qzh-print-module.xql";
import module namespace pm-qzh-latex="http://www.tei-c.org/pm/models/qzh/latex/module" at "../transform/qzh-latex-module.xql";
import module namespace pm-qzh-epub="http://www.tei-c.org/pm/models/qzh/epub/module" at "../transform/qzh-epub-module.xql";
import module namespace pm-docx-tei="http://www.tei-c.org/pm/models/docx/tei/module" at "../transform/docx-tei-module.xql";
import module namespace pm-qzh-norm-web="http://www.tei-c.org/pm/models/qzh-norm/web/module" at "../transform/qzh-norm-web-module.xql";
import module namespace pm-qzh-norm-print="http://www.tei-c.org/pm/models/qzh-norm/fo/module" at "../transform/qzh-norm-print-module.xql";
import module namespace pm-qzh-norm-latex="http://www.tei-c.org/pm/models/qzh-norm/latex/module" at "../transform/qzh-norm-latex-module.xql";
import module namespace pm-qzh-norm-epub="http://www.tei-c.org/pm/models/qzh-norm/epub/module" at "../transform/qzh-norm-epub-module.xql";

declare variable $pm-config:web-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "qzh.odd" return pm-qzh-web:transform($xml, $parameters)
case "qzh-norm.odd" return pm-qzh-norm-web:transform($xml, $parameters)
    default return pm-qzh-web:transform($xml, $parameters)
            
    
};
            


declare variable $pm-config:print-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "qzh.odd" return pm-qzh-print:transform($xml, $parameters)
case "qzh-norm.odd" return pm-qzh-norm-print:transform($xml, $parameters)
    default return pm-qzh-print:transform($xml, $parameters)
            
    
};
            


declare variable $pm-config:latex-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "qzh.odd" return pm-qzh-latex:transform($xml, $parameters)
case "qzh-norm.odd" return pm-qzh-norm-latex:transform($xml, $parameters)
    default return pm-qzh-latex:transform($xml, $parameters)
            
    
};
            


declare variable $pm-config:epub-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "qzh.odd" return pm-qzh-epub:transform($xml, $parameters)
case "qzh-norm.odd" return pm-qzh-norm-epub:transform($xml, $parameters)
    default return pm-qzh-epub:transform($xml, $parameters)
            
    
};
            


declare variable $pm-config:tei-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "docx.odd" return pm-docx-tei:transform($xml, $parameters)
    default return error(QName("http://www.tei-c.org/tei-simple/pm-config", "error"), "No default ODD found for output mode tei")
            
    
};
            
    