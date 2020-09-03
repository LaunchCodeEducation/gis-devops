:orphan:

===================
Learning Objectives
===================

**Conceptual Objectives**: concepts or terminology you should be comfortable defining and discussing

**Practical Objectives**: methods, syntax, or commands you should be capable of using

Week 1 (Prep Weeks)
===================

.. _week-prep-shell-objectives:

Shell
-----

Conceptual
^^^^^^^^^^

- GUI vs CLI
- file system
- CRUD files/dirs
- path (relative and absolute)
- package managers (PATH)
- general command syntax (program <arg(s)> [-[-]option(s) [option arg(s)]]
- REPL
- scripts vs REPL commands
- users / groups and access control

Practical
^^^^^^^^^

- getting help w/ man & --help
- cd
- pwd
- ls
- mv
- cp
- touch
- curl
- man
- sudo
- vim (open, edit, save, exit)

.. _week-prep-http-objectives:

HTTP
----

Conceptual
^^^^^^^^^^

- req/res (client-server model)
- general: headers, bodies
- URLs: protocol, (sub)domains, path, qs, fragments
- HTTP methods and semantic meaning (GET, POST, rest in APIs lesson)
- DNS (phonebook analogy - human readable to machine identifiers)
- req: path, qs, method, headers (accept/content-type, authorization, cookies)
- res: status codes (2XX, 3XX, 4XX, 5XX), headers (content-type, set-cookie, location)
- clients: browser, CLI, GUI, another server
- http vs https

Practical
^^^^^^^^^

- dev tools network tab (GET, POST)
- making curl requests (GET, POST)
- postman (GET, POST)

.. _week-prep-networking-objectives:

Networking
----------

Conceptual
^^^^^^^^^^

- IP (unique to device + network)
- public/private
- Network processes (ports)
- Box model (host, LAN, WAN, internet)
- DNS (/etc/hosts -> ISP -> DNS authority)
- network interfaces (ethernet, wireless, loopback)
- host machine (local, remote host) machine running a process that is networked
- IP blocks
- later we will explore subnets and further dividing our networks
- firewalls (machine level and network machine; inbound and outbound rules) (will see more later in the class)

Practical
^^^^^^^^^

- DNS edit /etc/hosts to show arbitrary names (hit the public IP address of the node server)
- ifconfig (private)
- curl ipinfo.io/ip (public)
- curl -v (see handshake)
- telnet (connection refused)

.. _week-prep-git-local-objectives:

git local
---------

Conceptual
^^^^^^^^^^

- version control (VCS)
- local repository
- stage and tracking
- controlling tracking with .gitigonre
- commit
- branches
- merging strategies (standard & rebase)
- diffs (per line basis)
- history (message, diff, timestamp, author)
- commit strategies (commits should be small, messages should be descriptive, commits should be stable)

Practical
^^^^^^^^^

- git init (.git)
- git status
- git add
- git commit
- git branch
- git checkout
- git merge
- git rebase
- git log (--oneline)
- git revert
- git checkout commit-hash
- warning about destructive git commands (revert, reset, git rm)

.. _week-prep-git-remote-objectives:

git remote
----------

Conceptual
^^^^^^^^^^

- remote repository
- remote repo hosting providers (GitLab, GitHub)
- sync with upstream
- syncing local and remote
- .gitignore (derived code, sensitive, secrets)
- merge requests (process, use it to enforce code reviews, kicks off CI automation)
- branching strategies (collaboration; feature branches; patch branches; open MRs)
- merge conflict
- handling conflict strategies (standard merge, vs squash and rebase)
- CLASS EXPECTATIONS FOR GIT (small commits, descriptive messages, commits are stable, regular, feature branches)
- *git stash
- *git rebase

Practical
^^^^^^^^^

- git clone
- git push
- git pull
- git fetch
- git branch --all
- git config --global
- handling conflicts
- open MR (comments, push up new changes, approve changes, merge)

.. _week-prep-docker-consumer-objectives:

Docker
------

Conceptual
^^^^^^^^^^

- portability
- disposability
- isolation (to/from host machine)
- service management
- images (process + dependencies + fs configuration in a box)
- docker engine

Practical
^^^^^^^^^

- docker hub
- docker ps (-a, --filter)
- docker pull
- docker run (common flags: -p, -d, -e/--env-file, --rm, -it, --name, -v)
- docker start
- docker stop
- *docker exec

.. _week-prep-client-side-dev-objectives:

Client-Side Web Dev
-------------------

Conceptual
^^^^^^^^^^

- bones (html), skin (css), brain (js)
- browser uses engines for parsing (html, css, js)
- semantic html
- static files (static vs dynamic, static http server)
- html: tags, elements, attributes, parents/children (block vs inline)
- css: selectors, specificity (location, selector), rules
- file protocol (opening vs serving)
- order of execution (top-bottom)

Practical
^^^^^^^^^

- serving locally (liveserver, python)
- html: usage of head and body, emmet expansion
- css: in-line, style, link (local, remote)
- css: id, class, tag selectors
- js: script (block, local, remote)

.. _week-prep-js-fundamentals-objectives:

JavaScript Fundamentals
-----------------------

.. admonition:: Note

  This is not a comprehensive JS course. We will cover practical usage relevant to this course and day-to-day work.

  Specifically, we will not be covering prototypal inheritance but you can use the links below:
  
  - `introductory [Tyler McGinnis] <https://ui.dev/javascript-inheritance-and-the-prototype-chain/>`_
  - `introductory [MDN] <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Inheritance_and_the_prototype_chain>`_
  - `intermediate/advanced <https://javascript.info/prototype-inheritance>`_

Conceptual
^^^^^^^^^^

- scripting language (dynamic typing, interpreted)
- functions as first-class citizens (declare anywhere, HOF)
- quirks (browser engines, backwards compatibility, equality and type coercion, does everything it can to not crash which causes silent failures)
- client-side/browser usages (vanilla, libs and front-end frameworks)
- server-side/external usages (servers, CLI tools and scripted automations)
- distinctions between usages (standard lib, global vs window)
- *multi-paradigm (OOP, functional, blended)

Practical
^^^^^^^^^

- documentation (MDN, js.info, ui.dev)
- local execution using node
- variables (const and let, block-scoping)
- data types (string, number, boolean, null, undefined) 
- loops (for, while)
- conditionals (if, elseif, else)
- equality (==, ===)
- functions (expression, declaration, arrow)
- data structures (array, object [hashmap], functions/custom classes)
- classes (fields, methods, constructor)
- printing (console.log)
- *template strings
- *ES6 modules (import/export)
- *commonJS (require/module.exports)
- *node assert for lightweight testing

.. _week-prep-js-callbacks-objectives:

JavaScript Callbacks
--------------------

Conceptual
^^^^^^^^^^

- function signatures
- JS single threaded language with event loop (link out)
- opinionated terms: procedure (defines the callback signature and is responsible for invoking the callback) and a consumer (defining how to use the arguments) consumer parameters should match the procedure callback signature
- higher order functions (HOF)
- where are callbacks used: DOM events, array methods, network requests
- callbacks can be used synchronously and asynchronously

Practical
^^^^^^^^^

- array methods (map, filter, *reduce)
- inline callbacks
- externally defined callbacks (receives arguments implicitly) (reusability)
- `exercises <https://gist.github.com/the-vampiire/5090080c3909c217d5ca361fd2e31777#practice-challenges>`_

.. _week-prep-js-dom-fundamentals-objectives:

Document Object Model Fundamentals
----------------------------------

Conceptual
^^^^^^^^^^

- virtual representation of HTML
- elements are represented as JavaScript objects (OOP elements called nodes)
- window.document (document) represents the document as a whole and is the entry point (typically work with document.body)
- parent and child nodes based on HTML structure
- traditional element nodes and you have text nodes (text inside an element like <p> is a child of the element)
- DOM nodes only exist in memory unless they are attached to the DOM
- distinction between what exists physically written into the HTML vs what exists after JS is run
- you cannot interact with the DOM until it has completely loaded (location of <script> tags and event listeners

Practical
^^^^^^^^^

- Create node: document.createElement()
- Read node: document.querySelector() or document.querySelectorAll()
- Read node: use CSS selector syntax (#id, .classname)
- the return of querySelectorAll() is array like, it's a nodelist (converting nodelist to array)
- Update node: modifying in place (changing the text of a <p>, or a class)
- Update DOM: appendChild(), insert(), putting an element into the DOM
- Delete node: removeElement()
- common node properties: .classlist, .children, .innerText

.. _week-prep-js-dom-events-objectives:

DOM Events
----------

Conceptual
^^^^^^^^^^

- asynchronous (driven by user interaction, not executed linearly)
- listener and handler model (to any given node you attach an event listener, and must register it's callback handler [the function])
- always an event object the properties of which are dependent on the context
- a way to custom the behavior of a UI (can control or extend browser default behavior)
- events based on mouse, keyboard and browser interactions (event names as strings)
- *event bubbling

Practical
^^^^^^^^^

- best practice: .addEventListener() not onclick=
- event() -> void (callback is invoked but the return isn't necessary)
- document.addEventListener('DOMContentLoaded') (for executing JS after all HTML is parsed/loaded)
- common event methods: .preventDefault() (for overriding default browser behavior)
- *bubbling event properties: .target (element the event occurred on), .currentTarget (target that had the event handler on it)

.. _week-prep-js-async-objectives:

AJAX and JavaScript Promises
----------------------------

.. TODO: complete just add the Tyler McGinnis link and then add some points of the major topics

Conceptual
^^^^^^^^^^

- event loop to prevent blocking (single threaded)
- synchronous (executed linearly) vs asynchronous (executed on demand)
- Promises 

Practical
^^^^^^^^^

- .then(callback): processed when the Promise resolves
- .catch(callback): processed when the Promise is rejected
- fetch

.. _week-prep-web-apis-objectives:

Web APIs
--------

.. TODO: complete

Conceptual
^^^^^^^^^^

- data transference across a network
- data represented in a universal format
- JSON as a data format
- HTTP methods and paths to define resources
- HTTP response status codes 
- HTTP response body as business data

Practical
^^^^^^^^^

- curl web API

.. _week-prep-java-fundamentals-objectives:

Java Fundamentals
-----------------

.. TODO: complete

Conceptual
^^^^^^^^^^

- OO (everything is an object)
- strictly typed compiled language
- compiles to Java bytecode
- JVM
- entrypoint

Practical
^^^^^^^^^

- documentation (javadocs)
- CLI compiling & execution
- IDE compiling & execution
- variables
- data types
- loops
- conditionals
- equality
- methods
- data structures (array, list, hashmap, objects)
- classes (properties, methods, constructor)
- printing (System.out.print())
- interfaces

.. _week-prep-spring-fundamentals-objectives:

Spring Fundamentals
-----------------

.. TODO: complete

Conceptual
^^^^^^^^^^

- spring & springboot
- web framework
- dependencies
- annotation driven (explain annotations)
- controllers
- models
- views? SSR?
- *extensions (spring REST, spring security, spring elasticsearch)

Practical
^^^^^^^^^

- `spring initializr <https://start.spring.io/>`_
- running a springboot web application
- accessing a locally running web application with curl, browser, and postman
- modifying an existing controller class
- creating a custom controller class
- adding custom GET methods to a controller class
- adding custom POST methods to a controller class

.. _week-prep-sql-objectives:

SQL
---

.. TODO: complete

Conceptual
^^^^^^^^^^

- relational databases
- SQL as the language for interacting with relational databases
- SQL server
- database
- schema
- table
- row
- primary key
- one to one relationships
- foreign key
- one to many relationships
- *many to many relationships
- *joins

Practical
^^^^^^^^^

- postgres walkthrough (.. _postgres-walkthrough:)
- Create a Database
- Create a Schema
- Create a Table
- Create Record - Insert Into
- Read Record - Select
- Alter Table
- Update Record(s)
- Delete Record(s)
- Foreign Key

.. _week-prep-orms-objectives:

Object Relational Mapping
-------------------------

.. TODO: complete

Conceptual
^^^^^^^^^^

- 

Practical
^^^^^^^^^

- 

.. _week-prep-spring-data-objectives:

Spring Data
-----------

.. TODO: complete

Conceptual
^^^^^^^^^^

- 

Practical
^^^^^^^^^

- 
















Week 1
======

.. _week01-day1-objectives:

Day 1
-----

* Use Git for version control
* Navigate and use GitLab
* Effectively use IntelliJ to streamline Java application development

  * Configure IntelliJ projects, including assigning the right JDK
  * Run console and web projects in IntelliJ
  * Understand Java project structure

* Improve applications by refactoring code
* Describe the purpose of unit testing, and the qualities of a good unit test
* Create unit tests in Java using JUnit

.. _week01-day2-objectives:

Day 2
-----

- Importancne of Security Culture in your organization
- Awareness of OWASP guidelines
- Introduction to security vulnerabilities
- Introduction to security tools
- Use TDD to write Java methods
- Follow the Red-Green-Refactor workflow to improve test-driven coding

.. _week01-day3-objectives:

Day 3
-----

- Understand what an integration test is compared to a unit test
- Write integration tests in Spring using the MockMvc class and associated utilities
- Exercise common MVC integration test patterns to verify return codes, response content, header content
- Understand how dependency injection works within Spring Boot
- Use @Autowired along with Spring component annotations (@Controller, @Repository, etc) to enable management and injection of components

.. _week01-day4-objectives:

Day 4
-----

- Install and use PostgreSQL via the `psql` CLI
- Write common SQL commands in PostgreSQL: select, insert, update, delete
- Understand relational database components: databases, schemas, tables, columns, constraints
- Understand the benefits of using schemas
- Use application.properties settings to configure a database connection in Spring Boot
- Understand how Spring Data, JPA, and Hibernate relate to each other
- Awareness of Injection attacks and how to prevent them

.. _week01-day5-objectives:

Day 5
-----

- Understand the structure of HTTP requests and responses, including differences based on request type (GET, PUT, POST, HEAD, DELETE)
- Understand common HTTP status codes
- Understand JSON syntax
- User cURL to make HTTP requests
- Understand what an API is, and how they are commonly used
- Understand the structure of GeoJSON
- Understand geometry types: Point, LineString, Polygon, MultiPolygon
- Understand the data provided by a WMS service using GetCapabilities and GetMap
- Create map and layer objects in OpenLayers
- Make AJAX HTTP requests using jQuery

.. _week02-objectives:

Week 2
======

Utilize the skills learned in week 1 to build a Spring Boot application that uses OpenLayers to display geospatial data on a map. Deliver an app with the the following features:

- Ingestion of geospatial data via CSV.
- Display Zika infection data on a map using OpenLayers.
- Display information about each indvidual feature.

Week 3
======

.. _week03-day1-objectives:

Day 1
-----

- Describe the main features of a RESTful web service
- Describe the usage of HTTP methods in a RESTful web service
- Describe the URL format for a RESTful web service
- Describe HTTP status code usage in REST
- Explain what a resource is
- Explain how resource formats are related to requests
- Explain how content negotiation works, and which HTTP headers are necessary for this
- Explain idempotence in REST
- Explain statelessness in REST
- Use and design RESTful URLs, including nested resources and query/filtering parameters
- Define the "sensitive data exposure" vulnerability
- Understand and describe the importance and purpose of salting and hashing passwords

.. _week03-day2-objectives:

Day 2
-----

- Identify the difference between Swagger toolset and the Open API Specification
- Compose Swagger YAML files to define the endpoints, responses, and schema of an API
- Use `$ref` to reference reuseable definitions
- Integrate SwaggerUI into a project
- Explain the difference between authentication and authorization
- At a high level, explain how authentication and authorization work for APIs
- Explain HATEOAS from the perspective of the data returned by a REST service
- Explain the four levels of the REST maturity model

.. _week03-day3-objectives:

Day 3
-----
- Describe the use cases for Elasticsearch (ES)
- Understand how NoSQL databases structure data, in contrast to relational databases
- Describe the representation of data in ES as indexes of documents with fields
- Describe the high-level architecture of ES as being based on a cluster with nodes and shards
- Describe how ES is fault-tolerant
- Know when ES should be used beyond the primary data store for an application
- Use curl to query the search API of an index
- Write filter queries
- Understand query and filter context, and how each affects a result set
- Describe how analyzers are used for full text queries
- Describe how boost and highlighting can customize result sets
- Use pagination of result sets
- Describe and use fuzzy queries, geo queries, and aggregations

.. _week03-day4-objectives:

Day 4
-----

- Understand how parent/child relationships are represented, and how this contrasts with such relationships in relational databases
- Describe and configure document mappings, and know the causes of and preventions for mapping explosion
- Describe the purpose and procedure for reindexing
- Integrate Elasticsearch into a Spring Boot application

.. _week03-day5-objectives:

Day 5
-----

- Understand the origins of JavaScript and the ECMAScript specification
- Understand both client and server JS runtime environments
- Understand what a transpiler is, and how it enables use of different versions of JS in different environments
- Understand the benefits of linting code
- Use ESLint to ensure JS code adheres to a set of standards
- Understand and use ES2015 additions: `let`, `const`, template strings, arrow functions, default parameter values
- Understand and use Webpack to build static client-side applications

Week 4
======

- Use the REST, Elasticsearch, and JavaScript skills obtained in week 3 within a student-built application.

.. _week05-day1-objectives:

Week 5
======

Day 1
-----

- Use and configure SSH to access remote machines
- Manage Unix file permissions for owners and groups
- Manage Unix processes
- Configure systemd daemon processes to run on startup
- Use logs to troubleshoot applications
- Awareness of Security Misconfigation vulnerability and how to prevent it

.. _week05-day2-objectives:

Day 2
-----

- Understand the role of the VPC in providing security for multiple instances
- Understand why AWS provides "High Availability" ELB and RDS instances
- Create ELB instances that distribute traffic across multiple EC2 servers
- Configure an EC2 instances to connect to an RDS database
- Use Telnet to troubleshoot TCP connections

.. _week05-day3-objectives:

Day 3
-----

- Understand why the 12 Factor App principles are important in building a Cloud Native app
- Explain why an ephemeral file system is required to scale apps on the cloud
- Understand how to handle log files on the cloud
- Understand the importance of parity between development, staging, and production environments
- Create an autoscaling app on AWS
- Describe why ELB and RDS databases are "high availability"

.. _week05-day4-objectives:

Day 4
-----

- Understand the purpose of Gradle, and the types of tasks it can carry out
- Describe the historical relationship between Gradle, Maven, Ivy, and Ant
- Understand the content of Gradle files as written in Groovy and the Gradle DSL
- Understand Gradle Java project structure
- Describe the three task lifecycle phases
- Recognize tasks as objects with associated behaviors
- Create basic tasks, including tasks with dependencies
- Understand that tasks can be built from provided task classes such as `DefaultTask`, `Copy`, `Jar`, and so on
- Describe the types of behavior that plugins can provide to a project
- Install and use plugins
- Understand how to configure project dependencies with proper scope
- Describe how Gradle resolves task and project dependencies using a directed acyclic graph representation
- Understand the concepts: Continuous Integration and Continuous Delivery
- Install Jenkins
- Create and configure Projects in Jenkins
- Make Projects that trigger other Projects
- Reuse the same workspace for multiple Projects
- Use Git polling to trigger a Jenkins Project to run
- Configure Jenkins to run and show results of tests
- Create a Jenkins Project to deliver the build artifact (.jar file)
- Awareness of Known Vulnerabilities security issue and how to prevent it

.. _week05-day5-objectives:

Day 5
-----

- Understand the concept of Continuous Inspection
- Install Sonarqube
- Configure `build.gradle` to use Sonarqube
- Configure project name for Sonarqube Gradle task
- How to create a project in Sonarqube
- How to read results in Sonarqube UI

.. _week06-objectives:

Week 6
======

- Use the AWS skills learned in the previous week to deploy a cloud-hosted, scalable application to AWS

.. _week07-objectives:

Week 7
======

<aside class="aside-note" markdown="1">
GeoServer training is delivered by Boundless.
</aside>

SU 101 Spatial Basics
---------------------

- Gain a basic understanding of spatial concepts, mapping, open source, open data, data formats, geospatial concepts, and cartography.

GS101 Data Publishing
---------------------

- Publish simple datasets in GeoServer
- Accessing published data via WMS and WFS.
- Understand basic spatial file formats
- Read and configure files in the GeoServer web interface.

SU102 Spatial Web Services
--------------------------

- Gain a basic understanding of web service concepts
- Demonstrate working knowledge of Web Map Service, Web Feature Service and OGC standards.

GS102 Administration
--------------------

- Demonstrate GeoServer management, specifically the web administration interface.
- Be able to configure individual web services, manage the security system.
- Apply basic troubleshooting techniques.

GS103 Data Management
---------------------

- Apply tools tools to manipulate data to resolve issues of performance or data security.
- Recognize more advanced store types which GeoServer supports and how and why a GeoServer administrator would select these to serve their spatial data.

GW101 GeoWebCache
-----------------

- Discuss and explain concepts behind GeoWebCache as a specialized type of web cache and understanding how it can be configured to function as a component of a GeoServer instance in production.
- Demonstrate basic configuration.

PG101 Introduction to Spatial Databases
---------------------------------------

- Gain a basic understanding of spatial databases, competing technologies, application and use.
- Explain value of PostGIS with capabilities, history and success stories.
- Demonstrate basis skills such as creating a PostGIS database, connecting to a database from QGIS and GeoServer.

PG102 PostGIS Explained
-----------------------

- Demonstrate knowledge of geometry use in a PostGIS.
- Apply skills to import and export data.
- Describe, explain and apply basic SQL knowledge.

PG103 PostGIS Explored
----------------------

- Demonstrate SQL knowledge in applied queries
- Apply spatial joins, spatial indexes.
- Demonstrate Knowledge of projects and apply knowledge to effectively work with data.
- Represent 3D data.
- Apply linear referencing.
- Load raster data into a database.
- Load a road network into PgRouting.
- Gain a basic understanding of point cloud data.

PG104 PostGIS Analysis
----------------------

- Demonstrate proficient knowledge of SQL for spatial analysis.
- Demonstrate proficient knowledge of spatial joins.
- Explain DIM-9 Spatial relationship optimization.
- Apply nearest neighbor analysis.
- Apply raster analysis.
- Apply topology relationships through SQL.

.. _week08-objectives:

Week 8
======

- Use the skills learned in the previous week to integrate GeoServer with a Spring Boot + OpenLayers application, both locally and on AWS

Week 9
======

.. _week09-day-1-2-objectives:

Days 1-2
--------

<aside class="aside-note" markdown="1">
Pivotal Cloud Foundry training is delivered by Boundless.
</aside>

- PCF architecture
- How to interact with PCF: Command Line Interface (CLI), Apps Manager UI
- Orgs, spaces, user roles
- Deploy a Simple Application
- Scaling an app (Ver / Hor)
- Buildpacks
- Application Manifests
- Domains and Routes
- Logging and Metrics
- Application Monitoring
- Blue/Green App Deployment
- Services Marketplace
- Create & Bind a Service
- Platform Security
- NGA’s PCF envs

.. _week09-day3-objectives:

Day 3
-----

- Understand how Docker differs from traditional VMs.
- Describe the underlying Docker technologies such as Linux Containers and UnionFS.
- Spin up containers from existing images locally mapped ports.
- Spin up containers with both volumes and write through mounts.
- Create a Dockerfile that is capable of running a SpringBoot server.
- Understand Docker Network and how Docker containers are interconnected.
- Ability to create, inspect, and delete both images and containers.
- Create a Docker Compose config to spin up a web app, database, and Elasticsearch instance.

.. _week09-day4-objectives:

Day 4
-----

- Understand the difference between authentication and authorization
- Understand OAuth roles: resource owner, client, resource server, authorization server
- Know how to register an application
- Understand the general OAuth2 flow
- Understand the roles of cliend ID and client secret
- Understand OAuth authorization parameters: endpoint, client ID, redirect URI, response type, scope
- Understand the role of an access token in the authorization flow
- Understand the four OAuth grant types: auth code, implicit, resource owner password credentials, client credentials
- Understand the refresh token flow

.. _week09-day5-objectives:

Day 5
-----

- Understand the role certificates play in validating the identity of a server.
- Understand the role that a certificate authority plays in determining trust.
- Configure the browser to add new trusted certificates.
- Configure the browser to add client-side access certificates.
