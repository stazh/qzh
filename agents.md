# AI Agent Context: QZH Repository

## Project Overview

**Quellen zur Zürcher Geschichte (QZH)** - A digital edition platform for publishing historical sources from Zurich history. Built as an eXist-db application using the TEI Publisher framework.

## Local Development

- **Application URL**: http://localhost:8080/exist/apps/qzh
- **eXist-db Dashboard**: http://localhost:8080/exist/apps/dashboard/
- **Package Manager**: http://localhost:8080/exist/apps/eXide/
- **Default credentials**: tim/pls (local development)

## Technology Stack

- **eXist-db** (v5.3.0+): Native XML database backend
- **TEI Publisher** (v4.0+): Framework for publishing TEI-encoded texts
- **XQuery 3.1**: Primary backend language
- **TEI XML**: Document encoding standard
- **Web Components** (@teipublisher/pb-components v1.42.0): Frontend UI
- **Apache Ant**: Build system
- **Node.js/npm**: Frontend package management
- **Cypress**: E2E testing

## Build & Deployment

### Build Process
```bash
npm install          # Install pb-components dependencies
ant xar             # Create .xar package in build/
```

### Deployment
1. Install `.xar` file via eXist-db Package Manager
2. `pre-install.xql` creates system config collections
3. `post-install.xql` generates ODD transformations and sets permissions
4. **Known issue**: Some files may not update; manual refresh via eXide may be needed

## Testing

```bash
npm run e2e         # Run Cypress tests against localhost:8080
```

Tests cover: abbreviations, bibliography, people, places, and general functionality.

## Verifying Changes

**Always verify your work visually:**
- Navigate to http://localhost:8080/exist/apps/qzh in a browser
- Take screenshots to confirm UI changes render correctly
- Test affected functionality manually before considering work complete

## Key Files & Directories

### Configuration
- [config.xqm](modules/config.xqm) - Central application configuration (paths, data collections, TEI Publisher options)
- [controller.xql](controller.xql) - URL routing controller
- [custom-api.json](modules/custom-api.json) - OpenAPI specification for custom endpoints
- [collection.xconf](collection.xconf) - eXist-db index configuration (Lucene, range indexes, facets)
- [expath-pkg.xml](expath-pkg.xml) - EXPath package descriptor with dependencies

### Code Structure
- `modules/` - XQuery business logic modules
- `templates/` - HTML templates using pb-components
- `resources/odd/` - ODD (One Document Does-it-all) transformation specifications
- `transform/` - Generated XQuery transformation modules **⚠️ DO NOT EDIT**
- `data/` - Static data files (taxonomy, bibliography)
- `cypress/` - E2E test suites

### Data Repository
Separate data repository at: https://github.com/stazh/qzh-data
- Contains actual source documents (referenced as `/db/apps/qzh-data`)

## ⚠️ DO NOT EDIT

These files are **auto-generated** - edit source ODDs instead:
- `transform/*-main.xql` and `transform/*-module.xql` (generated from ODD files)
- `repo.xml` (generated from `repo.xml.tmpl` with git version info)

## Code Conventions

### XQuery Modules
- Namespace declarations: `module namespace prefix="uri"`
- Import config module: `import module namespace config="http://www.existsolutions.com/apps/qzh/config"`
- Full parameter type declarations
- Use XQuery 3.1 features (maps, arrays, arrow operator)

### API Design
- OpenAPI 3.0 specification-driven
- RESTful endpoints under `/api/`
- Custom operations: `custom:people`, `custom:places`, `custom:organizations`, `custom:keywords`

### Frontend
- Web Components architecture (pb-components)
- Template-driven HTML with `data-template` attributes
- Progressive enhancement approach

### Transformations
- ODD-based processing model (edit files in `resources/odd/`)
- Multiple output formats: web, print, latex, epub
- Extensions in `ext-*.xql` for custom rendering behavior

**⚠️ ODD XQuery Params — No Raw HTML Construction:**
When writing XQuery in ODD `<param>` values, you **cannot** construct raw HTML elements (e.g. `<li>`, `<paper-checkbox>`, `<div>`) directly — the ODD processing engine will strip or transform them. Instead, construct **TEI elements** (e.g. `<person>`, `<place>`) with appropriate attributes, and define a matching `<elementSpec>` model with a `<pb:template>` that renders the desired HTML. This is how TEI Publisher works: TEI → ODD model → `<pb:template>` → HTML.

**⚠️ Register XPath — Exclude Header:**
When querying for elements to display in the register sidebar (teiHeader context model), use `root(.)//text//persName` (not `root(.)//persName`) to exclude persons mentioned in the teiHeader itself. Same pattern for placeName, orgName etc. — always scope to `//text//` for register entries.

**⚠️ CRITICAL: After editing ANY ODD files, upload and recompile ALL touched ODDs:**

For **every ODD file you modify**, you MUST:
1. Upload it to eXist-db
2. Trigger recompilation

Example (for qzh.odd and qzh-norm.odd):
```bash
# 1. Upload ALL modified ODD files to eXist-db
curl -X PUT -T "/Users/stazh/Documents/GithubRepos_stazh/qzh/resources/odd/qzh.odd" \
  "http://localhost:8080/exist/rest/db/apps/qzh/resources/odd/qzh.odd" \
  -u "tim:pls" \
  -H "Content-Type: application/xml"

curl -X PUT -T "/Users/stazh/Documents/GithubRepos_stazh/qzh/resources/odd/qzh-norm.odd" \
  "http://localhost:8080/exist/rest/db/apps/qzh/resources/odd/qzh-norm.odd" \
  -u "tim:pls" \
  -H "Content-Type: application/xml"

# 2. Trigger recompilation for ALL modified ODDs
curl -X POST "http://localhost:8080/exist/apps/qzh/api/odd?odd=qzh.odd" -u "tim:pls"
curl -X POST "http://localhost:8080/exist/apps/qzh/api/odd?odd=qzh-norm.odd" -u "tim:pls"

# 3. Clear browser cache and reload page
```

**Important Notes**: 
- `qzh-norm.odd` inherits from `qzh.odd` — always update both when either changes
- Every ODD file modified must be uploaded AND recompiled
- Transforms are auto-generated on server; do NOT commit local transform files after ODD changes

## Documentation

Comprehensive German-language documentation in `documentation/`:
- **Arbeiten_mit_TEI_Publisher_Theorie/** - Theory and maintenance
- **Arbeiten_mit_TEI_Publisher_GIT_Workflow/** - Git workflow
- **Edieren_in_XML_TEI_Workflow/** - XML/TEI editing workflow
- **Changelog/** - Changes from original RQZH project

## Quick Reference

| Task | Command/Location |
|------|------------------|
| Start eXist-db | System-specific (typically via startup script) |
| Build package | `ant xar` |
| Install deps | `npm install` |
| Run tests | `npm run e2e` |
| View app | http://localhost:8080/exist/apps/qzh |
| Edit ODDs | `resources/odd/` |
| Main config | `modules/config.xqm` |
