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

## Recipe Types

> mental model: "list of ingredients"

- architecture diagram
- service list

> steps: "portions and order"

> complete: "step by step details"

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

- multi-instance deployment
- infra
  - EC2 mapnotes host
  - RDS
  - EC2 jumpbox
  - VPC
    - private/public subnet
    - SGs

> exposure

> competency: includes architecture diagram(s)

- what is given:
- what is expected:

implement the architecture from the following diagram

requirements: specific for each component of the architecture

MapNotes API host requirements:

- select the appropriate configuration parameters for the host EC2
- configure the host environment dependencies

-

RDS requirements:

Jumpbox requirements:

Network requirements:

> autonomy: only prompt and requirements

- what is given:
- what is expected:

deploy the API with an RDS and jumpbox

requirements:

- run the migration script in the jumpbox to migrate the RDS
- proper security best practices implemented

## Scenarios
