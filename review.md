## Content Review

do all reviews in the browser to see rendering

> process

1. perform a first pass of copyedit work
  - just focus on mispellings, syntax, formatting etc
  - light rewording of phrasing is okay
  - **avoid rewriting whole paragraphs / sections**
  - **avoid adding any new content or sections**
  - **do not edit anything for clarity or alignment at this time**
2. while doing the pass capture any thoughts for greater change (areas avoided) 
  - use the todo tree tags in comments to capture thoughts without making edits
  - you can put any **quick** general thoughts or phrasing but don't waste time perfecting the wording

```md
<!-- `CLARITY: thoughts on clarity`-->
<!-- `ALIGNMENT: thoughts on alignment with LOs` -->
<!-- `IDEA: thoughts on adding or expanding the content`-->
<!-- `DISCUSS: thoughts that need a verbal discussion`  -->
```

1. push up changes and notify the author of suggested notes
  - any comments with `DISCUSS` or `ALIGNMENT` should meet with reviewer
4. author reviews notes
  - if they agree and understand the changes they implement and push for final review
  - if they disagree or do not understand they meet with reviewer for clarification

In the event that a consensus can't be reached. If the content meets the learning objectives and has been copyedited then it should be merged. Leave the notes and add a card to the backlog to revisit the situation in the next appropriate sprint.

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

### General

> preferences

- shorter titles / headers

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

### Walkthroughs

- title: `Project: Purpose`
  - ex: `Car Model: Range & Trip Meter`
    - project is Cars repo
    - purpose is what is accomplished

> code

Any references to code (classes, functions, CLI programs etc) should be syntax highlighted:

- inline: [code](https://www.markdownguide.org/basic-syntax/#code) backticks
- block: use the [fenced code block](https://www.markdownguide.org/extended-syntax/#fenced-code-blocks) with the appropriate language
  - for pseudocode prefer python
  - for JSON shapes prefer JS

