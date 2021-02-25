# type

- defaults to the `content/<type>` directory the file exists in
- or specify in frontmatter with `type: type` if not in a matching `content/<type>` dir
- corresponds to the `layouts/<type>` that should be used
  - otherwise uses the `_default` for `single` or `section`
    - difference b/w single and section?

- the top-level dir (`content/<type>`) matches to the layout even if the file is under a nested `content/<type>/something-else/file.md`