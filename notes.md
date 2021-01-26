# Hugo SSG PoC

> Purpose: evaluate Hugo/MD as an alternative to Sphinx/RST

## Evaluation

Port over content from the existing Sphinx/RST curriculum repo [azure 3.1 web APIs](https://github.com/LaunchCodeEducation/azure/tree/master/src/chapters/web-apis). Evaluate the ease of use for developing and customizing the required features. 

# Required Features

Any alternative must make it easier to develop the following features:

> Hugo 

- [ ] ToC generation
- [ ] Internal linking across documents
- [ ] Shortcodes (admonitions, code blocks)
- [ ] Tagging

> Theme

- [ ] Search
- [ ] Tables
- [ ] Styling changes
- [ ] Mobile responsive
- [ ] [bonus] JS integration
- [ ] External linking / embedding

> themes
1. [docport](https://themes.gohugo.io//theme/hugo-theme-docport/shortcodes/tabs/)
2. [learn](https://themes.gohugo.io//theme/hugo-theme-learn/en/shortcodes/siteparam/)

# Log

## Setup

> create site

```sh
hugo new site src/
```

- wtf that was so fast i thought it was an error message

> set theme

- [fuji install instructions](https://themes.gohugo.io/hugo-theme-fuji/) (simple, responsive, light/dark mode)

## Configuration

the `config.toml` (TOML, JSON, YAML) is the equivalent of `conf.py`

### first impressions

> [sphinx config ref](https://www.sphinx-doc.org/en/master/usage/configuration.html)

> [hugo config ref](https://gohugo.io/getting-started/configuration/)

- live reload built-in
- can be parameterized with supplementary config files (easy modularization)
- content templates (archetypes) for quick generation

> front matter (content metadata)

- for tags / organization etc
- [front matter ref](https://gohugo.io/content-management/front-matter/)

# Create

## Content

```sh
hugo new