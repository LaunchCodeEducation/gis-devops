# Usage

Pulls the theme. If you don't do this you will get Warnings about not having layouts for HTML files.

```
git clone 
git submodule init
git submodule update
```

> theme submodule issue resolution 

```sh
rm -rf themes/learn
git submodule add --force https://github.com/matcornic/hugo-theme-learn.git themes/learn

# Reactivating local git directory for submodule 'src/themes/learn'.
```

# Organization

> prefer flat FS. grouping should be done in version controlled documents (course schedule, units, courses etc)


> example

```sh
topics/
  integration-testing/
  # tool-agnostic-content
    tool/
    # tool-specific-content
  test-driven-development/

vs

testing/
  integration/
    tool/

# testing is a grouping concept that should be done in a document not in the FS
```

> create any tool implementations using the topics archetype. delete anything not used at that level

```sh
hugo new topics/TOPIC <-- top-level topic / tool agnostic
hugo new topics/TOPIC/tools/TOOL <-- tool specific
```

- after creating the tools sub-topic change the `categories: ["tools"]`
- delete any sub-dirs that definitel wont be used for the topic / tool

be specific with topic naming but no tools as top levels 

> example

```sh
integration-testing/
  java/
    junit-stuff.md

# preferred over

junit/
  junit-stuff.md

# Workflow

## TODO Tree

> usage

```md
TODO: some todo
IDEA: some idea
TAG: content
...

> avaiilable tags

- TODO
- IDEA
- 

## Snippets

Refer to .vscodesnippets file, the names are prefixes.

To use them type the prefix and then hit `Ctrl+space` and then tab to move cursor.



# Content Organization

## Archetypes

TODO: how to pass variables (like language implementation to project) into hugo new

> archetypes are used as templates for new material

### creating

Each archetype should have its [frontmatter](https://gohugo.io/content-management/front-matter/) configured to set its:

- title
- date 
- lastmod
- summary** (establish convention)
- linkTitle** (establish convention)
- keywords (for searching)


### usage

```sh
hugo new 
```

## References

- top level index files: `_index.md` (ex: `projects/<project-name>/_index.md`)
- nested index files: `index.md` (ex: `projects/<project-name>/<language>/index.md`)

```md
[link text]({{< ref "" >}})
```

- [docs](https://gohugo.io/content-management/cross-references/)
- [relrefs](https://gohugo.io/functions/relref/)
- []

## Page Bundles

- the `_index.md` (branch) frontmatter title dictates the name listed in the sidebar
  - any nested items do not need to be prefixed with the title

## Adominitions

> referred to as short codes in hugo

- [hugo docs](https://gohugo.io/content-management/shortcodes/)
- [learn theme docs](https://learn.netlify.app/en/shortcodes/notice/)

# Markdown notes

- [Hugo Markdown Guide](https://www.markdownguide.org/tools/hugo/)

## Tables

just go here: https://www.tablesgenerator.com/markdown_tables

<!-- 
| Syntax      | Description | Test Text     |
| :---        |    :----:   |          ---: |
| Header      | Title       | Here's this   |
| Paragraph   | Text        | And more      |
-->
