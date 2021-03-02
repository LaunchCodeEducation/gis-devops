## Topic Edges

Defined in the `content/edges` dir

<!-- IDEA: see ideas in edges/programming-fundamentals  -->

> topics which are not covered but are prerequisites to a course

Define detailed learning objectives. This is the opportunity to clearly communicate incoming expectations.

> linking

Edges should link out to all related entry points of topics that rely on them. Dependent topics should link back to express the prerequisite expectations.

## Projects

1. generate `hugo new projects/<project-name>`
2. rename the implementation
3. write ACE expectations
  - add any notes from discussion to the corresponding trello card

> prefer

- generalizing topics (leave tech details to each implementation)

### ACE Scoping

rationale for categorizing topics

#### Autonomy

> Topics in this category are inherent to the project and should be well known by the time of the project

> Expect to provide little to no support for these topics

- refer students to topic content for self-review if they are significantly behind (do not re-teach)
- note during assessment

> no starter code or commands provided, minimal instructions if any

#### Competency

> Topics in this category encompass the purpose of the project

> Expect to provide limited support for these topics

> minimal starter code (shell, interface), instructions

#### Exposure

> Topics in this category are tangentially related to the purpose of the project

> Expect to use these minimally and/or be prepared to provide support for these topics

> given starter code / commands, detailed instructions

### Structure

- follow ACE layout
- use block quotes (`>`) to separate super topics
  - ex: JavaScript sub-topics in projects/zika-client

## Topics

### Course Edges

> In the case of working on a course edge:

- **course edge**: a topic we aren't going to teach, but is a pre-req

#### Responsibilities for Curriculum Dev

- Only learning objectives

<!-- IDEA: quizzes or some form of assessment are a great way to control student admission to a specific course 

IDEA: look into codewars collections assembled by course staff as assements

-->

#### Responsibilities for Instructor

- When developing a course the schedule should define pre-reqs to learning objective roots.

### Scoping

These are to be completed as a team.

Use `high` and `low` for each category. This is an initial pass over the topic(s) to get an idea of scope.

> breadth: number of sub-topics under a topic

this is fixed

> depth: how deep within a specific topic

this is fixed

> ACE: informs the amount of practical work (types of content) needed to reach the chosen depth

this is variable

- Exposure: slides, quizzes
  - up to a walkthrough or demo slides
- Competency: Exposure + walkthrough and exercise
  - may use multiple walkthroughs for deeper topics
- Autonomy: Competency + additional less-guided exercises

> topic complexity: how complex is the mental model needed to absorb the topic?

this is variable

these are relative to the breadth, depth and ACE

- how many other topics (and their own complexity) are prerequisites for learning this topic
- more complex = more overall content
- less complex = less overall content

#### Overall

> multipliers

- familiarity with topic

> considerations

- incoming vs target ACE (based on learning objectives)
  - consider complexity of student target capabilities
    - prerequisite topics
    - number of prerequisites needed to learn/apply the topic
  - depth: how deep into the topic is needed to reach the target
  - breadth: how many sub-topics are needed to reach the target
  - amount of content: how much content is needed overall
    - higher ACE spread requires more content
      - dependent on the depth and breadth of the topic
- amount of content needed to generate
  - how much existing content aligns with the ACE target?

#### Slides

> multipliers

- familiarity with teaching the topic
- familiarity with writing slides

#### Quizzes

> multipliers

- familiarity with writing quizzes
- familiarity with teaching the topic

#### Walkthroughs

Walkthroughs should be written as a recipe not a guide. It should only be step by step while leaving additional context and teaching to the live presentation by the instructor.

> multipliers

- complexity of PoC
- familiarity with teaching the topic
- familiarity with writing walkthroughs

#### Exercises

Exercises are meant to require critical thinking and should be minimally guided.

> multipliers

- complexity of PoC
- familiarity with developing exercises
- familiarity with teaching the topic
