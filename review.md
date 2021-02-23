## Content Review

do all reviews in the browser to see rendering

> review notes

- point out and discuss any issues before making sweeping changes
- up to the original author to implement changes if agreed
  - prevents cyclical review-rewrite-review behavior

> review criteria

- copyedit
- clarity
- alignment with objectives

## Structure

### Checklist

- [ ] tags and categories: lowercase
  - separate with spaces
- [ ] no TODOs remaining
- [ ] unused dirs are deleted
  - leave `hidden` in frontmatter if there are IDEAs for future work

### Learning Objectives

- bullet points lowercase unless proper noun

### Quizzes

- title:
  - general: `<Topic> Quiz`
  - language: `<Language> <Topic> Quiz`
- use block quotes `>` for questions
- use sub-headers for grouping questions
- solution
  - in `<!-- --!>` comment
  - full answer with number as appropriate
- answers
  - single choice: ordered list
  - multiple choice: unordered list

### Slides

> **only include content that is covered in learning objectives**

- file name: numbered in order of delivery
- title: prefix with file number
- use `type: "slides"` in the frontmatter (full page slides vs. embedded)
- define terms
  - `**term**: definition text`
- bullet points
  - empty line between for readability

> slide organization

- horizontal: major points
  - scrolling through provide key takeaways
  - **every horizontal needs a header**
- vertical: expands on a horizontal
  - scrolling down provides greater detail
  - not every vertical needs a header
- suggested format per slide
  - header: `##` keep it short
  - quote `>` takeaway / definition
  - extra content
    - sentences and/or bullet points

> personalizing slides

allows slides to always be available and to track changes per instructor

- numbered slides are general (free for anyone to use)
- instructor can write their own variant
  - `#-<instructor>.md` file name
  - **make sure one or the other is hidden during live course**
    - add `hidden: true` to frontmatter

> when to split up slide decks?

- length
  - maximum time of 30 mins
- by topic?
- by purpose?
  - terms/concepts
  - in practice