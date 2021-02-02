# Content Organization

## Archetypes

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