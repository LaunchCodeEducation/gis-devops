Ops topics and projects are different than Dev topics and projects.

We will need to create a recipes directory that gives starter recipes like creating a jumpbox (that's combining multiple instructions from various topics. VPC, EC2, SG)

For recipes they should all include:

- architecture diagram
- what services are involved (linkbacks to topics)
- what considerations of how the services integrate (GOTCHAs)

notes:

THE FOCUS SHOULD ALWAYS BE THE THREE PARTIES:

- instructor
- student
- company stakeholders (paycheck-cutters)

recipes/
    generic.md (_index.md) (you need a virtual network and a virtual machine)
    recipe-purpose.md
    aws/
        _index.md (you need a VPC, and a EC2)
    azure/
        _index.md (you need a VPC, and a VM)

## Topics

- learn in isolation
- walkthrough are instructions
  - implementations are the different mechanisms of reaching that state
    - web console
    - CLI
    - IaC
- exercises are isolated use within an implementation
  - using the CLI spin up these SGs

notes:

we will use IaC to setup base environments so they only need to explore the isolated topic. if they are doing SGs we give them IaC to setup the rest of the system and they are responsible for doing the SGs.

## Projects

### ACE

for all projects: requirements and diagram

Exposure: they should be able to id the recipe and order, but no capability
Competency: we provide a list of recipes they should use and tell them which implementation to use (web console, CLI, IaC, ANY, some subset)
Autonomy: take away the list of recipes. Students only have a diagram and requirements. Students must deliver the recipe and deliver the implementation.
