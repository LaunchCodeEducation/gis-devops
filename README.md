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