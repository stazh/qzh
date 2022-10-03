import module namespace m='http://www.tei-c.org/pm/models/qzh-norm/latex' at '/db/apps/qzh/transform/qzh-norm-latex.xql';

declare variable $xml external;

declare variable $parameters external;

let $options := map {
    "class": "article",
    "section-numbers": false(),
    "font-size": "12pt",
    "styles": ["transform/qzh-norm.css"],
    "collection": "/db/apps/qzh/transform",
    "parameters": if (exists($parameters)) then $parameters else map {}
}
return m:transform($options, $xml)