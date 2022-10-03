import module namespace m='http://www.tei-c.org/pm/models/qzh/epub' at '/db/apps/qzh/transform/qzh-epub.xql';

declare variable $xml external;

declare variable $parameters external;

let $options := map {
    "styles": ["transform/qzh.css"],
    "collection": "/db/apps/qzh/transform",
    "parameters": if (exists($parameters)) then $parameters else map {}
}
return m:transform($options, $xml)