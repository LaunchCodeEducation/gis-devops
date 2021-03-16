# Ops Content

## Topics

### Organization

> 1: fundamentals are baked into the topic, difficult to separate if not needed

```sh
topics/
  aws-s3/
    cli/
    cloudformation/
```

> 2: nesting

```sh
topics/
  object-storage/
    s3/
      cli/
      cloudformation/
```

> 3: easy to separate fundamentals in the schedule (without having to say "do everything except X")

this approach gives the greatest flexibility

```sh
topics/
  object-storage-fundamentals/
  aws-s3/
    # back-link to fundamentals
    cli/
    cloudformation/
```

### Structure

- root
  - fundamentals slides
    - what is it
      - compute, storage, networking
    - when should you use it
      - use cases
    - what other services are required
    - configuration parameters
      - common only
      - **leave use-case specific configuration for demo slides**
    - ways to implement
      - ex: web console, CLI, IaC
      - suggestions on which to use
  - web console demo slides (per use case)
    - isolated to just this topic / use case
    - configuration params specific to use case
    - list assumptions (what is already existing in the system)
      - provided through IaC
    - individual steps
  - quiz
  - exercise: proof of implementing through web console
- implementations (ex: s3 CLI)
  - demo slides
    - list assumptions (what is already existing in the system)
      - provided through IaC
    - individual steps
  - quiz

> use in schedule

- select 1+ implementations
  - root is always included (back-linked from implementation)
  - allows courses to follow employer preference for usage (CLI/scripting, IaC...)
- exposure
  - fundamentals + web console use case
- competency / autonomy
  - 1+ implementations

## Recipes

```sh
recipes/
  ec2-rds-jumpbox/
  ec2-ssh-jumpbox/
  ec2-docker-host/
  ec2-java-host/
  nginx-reverse-proxy/
  nginx-tls/
  nginx-mutual-tls/
  s3-static-host/
  ec2-load-balanced/
  ecs-load-balanced
  alb-green-blue
  alb-canary
```

> project is a list of tasks (each with a recipe)

- exposure
- competency there is a given recipe for the scenario
- autonomy there will not be an explicit recipe

> recipes are specific to a task / use case **not a particular project**

- **do**: recipe for deploying a java API
- **dont**: recipe for deploying mapnotes API

> recipes vs instructions

- instructions are generic
  - these are in the topic itself
  - ex: how to provision an EC2
recipes are specific
  - back-link to the involved topic(s) instructions
  - include specifics / notes
    - considerations
    - dependencies
  - ex: configure a linux EC2
    - back-link to "provision an EC2"
    - notes
      - package manager
      - service management
      - connecting
    - implementations: java host, elasticsearch host, ...

### Structure

- when to use: scenario / context
- prerequisite: assumptions or back-link to recipes / instructions
- guide: steps to complete the recipe
- gotchas: common areas for mistakes
- confirmation: steps to confirm functionality
- related: link to any relevant next steps / related recipes

## Assessing Student Capabilities

### Exercises

> critical thinking to apply knowledge of the given topic

loosely isolated (minimum additional topics involved)

> what is available:

diagram and requirements always given

- **architecture diagram**
- **requirements**
- service list
- steps
- gotchas
- provided infrastructure (the assumed infra from demo slides)

> to reach exposure: usage in pure infrastructure isolation

- what is given:
  - **architecture diagram**
  - **requirements**
  - **fully provided** infrastructure
    - all infrastructure except the topic (the assumed infra from demo slides)
- what is expected:
  - provision the topic infrastructure
  - follow the steps in the fundamentals web console demo

> to reach competency: usage in relative infrastructure isolation

- what is given:
- what is expected:

> to reach autonomy: usage with no infrastructure isolation

- what is given
- what is expected

### Projects

> rating a project

- complexity: number of infra components / services / configurations involved
- average ACE: the average level of the ACE for each topic

> key thoughts

- variability between required and provided infrastructure
- separate projects
- extension of dev project

#### mapnotes API deployment

> exposure: given recipes and order

- what is given:
  - recipe list and order
  - architecture diagram
  - specific requirements
- what is expected:
  - deliverable: implementation (live link etc)
    - executing the recipes

> competency: given recipes list

- what is given:
  - recipe list, **no order**
  - architecture diagram
  - component specific requirements
- what is expected:
  - deliverable: recipe inventory
    - recipe list and order (**before implementing**)
  - deliverable: implementation (live link etc)
    - executing the recipes

requirements specific for each component of the architecture:

```md
MapNotes API host requirements:

- select the appropriate configuration parameters for the host EC2
- configure the host environment dependencies

RDS requirements:

Jumpbox requirements:

Network requirements:
```

> autonomy: given prompt

- what is given:
  - architecture diagram
  - general requirements
- what is expected:
  - deliverable: recipes inventory
    - take inventory recipes (existing and needed) and order
  - deliverable: new recipes
    - any recipes that were not given
  - deliverable: implementation (live link etc)
    - executing the recipes
