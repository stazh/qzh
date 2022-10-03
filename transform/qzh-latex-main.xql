import module namespace m='http://www.tei-c.org/pm/models/qzh/latex' at '/db/apps/qzh/transform/qzh-latex.xql';

declare variable $xml external;

declare variable $parameters external;

let $options := map {
    "class": "article",
    "section-numbers": false(),
    "font-size": "12pt",
    "styles": ["transform/qzh.css"],
    "collection": "/db/apps/qzh/transform",
    "parameters": if (exists($parameters)) then $parameters else map {}
}
return m:transform($options, $xml)