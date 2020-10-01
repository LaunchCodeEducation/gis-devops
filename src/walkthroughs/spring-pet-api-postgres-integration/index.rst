:orphan:

.. _spring-pet-api-postgres-integration:

===========================
Spring Postgres Integration
===========================

Our goal is to integrate Postgres with our Spring application.

To accomplish this goal we will need to:

#. create a postgres docker container for our Spring application
#. create and configure a project database inside of the docker container
#. add dependencies to ``build.gradle``
#. amend ``application.properties``
#. Add Annotations to Models
#. Add DataRepository
#. Run project
#. Check database
#. Working with the Data Repository

We will be going through these steps with the `spring-example API <https://gitlab.com/LaunchCodeTraining/spring-example>`_ we worked on early this week.

Setup
=====

If you don't have the code fork, and clone the `spring-example API <https://gitlab.com/LaunchCodeTraining/spring-example>`_ to your GitLab account.

Let's Explore the code, most notably the Dog.java, and DogController.java files:

.. sourcecode:: java

    public class Dog {

        // properties

        private String name;
        private String breed;
        private int age;

        // constructor

        public Dog(String name, String breed, int age) {
            this.name = name;
            this.breed = breed;
            this.age = age;
        }

        // getters() & setters()

        public String getName() {
            return this.name;
        }

        public String getBreed() {
            return this.breed;
        }

        public int getAge() {
            return this.age;
        }
        
    }

This is a straightforward Model, it has properties, a constructor, and getters for each property.

.. sourcecode:: java

    @RestController
    @RequestMapping(value = "/dog")
    public class DogController {

        Dog newDog = new Dog("Bernie", "Basset", 4);

        @GetMapping
        public Dog getDog() {
            return newDog;
        }

        @PostMapping
        public Dog postDog(@RequestBody Dog incomingDog) {
            newDog = incomingDog;
            return newDog;
        }

        @GetMapping(value = "/{id}")
        public Dog getDogById(@PathVariable int id) {
            System.out.println(id);
            return new Dog("Samson", "Terrier", 7);
        }
        
    }

This is a fairly simple API right now, it supports 3 endpoints:

- GET `/dog`: returns an in memory Dog object
- POST `/dog`: overwrites the in memory Dog object with incoming JSON and returns the new in memory Dog object
- GET `/dog/{id}`: returns an in memory Dog object and prints out a path variable

We will be making some changes to these files after configuring our Spring application to work with a PostgreSQL database.

Create a Postgres Database for this project
===========================================

Docker allows us to easily quickly and easily create new containers and as a best practice for this class we will use a new postgres container for each of our Spring applications.

Stopping Other Postgres Containers
----------------------------------

Before creating the postgres container for this spring example application let's make sure there aren't any postgres containers running on the port we will be using.

You can check the running containers with the following command:

.. sourcecode:: bash

    docker ps

If you have any containers (most likely postgres containers) running on port 5432 stop them with the following command:

.. sourcecode:: bash

    docker stop container-name

Creating the spring-example Postgres Container
----------------------------------------------

Our next step is to create the spring-example Postgres Container. To do so we will create a new docker env file to hold the environment variables we will need for this specific container.

Create a new file named ``spring-example-postgres.env``.

Add the following lines to the file:

.. sourcecode:: code

    POSTGRES_USER=spring-example-user
    POSTGRES_PASSWORD=springuserpass
    ALLOW_IP_RANGE=<0.0.0.0/0>

With our environment variable file in place we can now create our container:

.. sourcecode:: bash

    docker run --name "spring-example-postgres" -p 5432:5432 -d -t --env-file ./spring-example-postgres.env postgres:9.4

You can verify that your docker container is running by checking the output of the ``docker ps`` command.

Configure Database for project
------------------------------

Now that we have a database container, we need to access the psql client to create the database for this specific project.

You can access the psql client of your container with the following command:

.. sourcecode:: bash

    docker exec -it spring-example-postgres psql -U spring-example-user postgres

This command will drop you into a psql shell where you can enter SQL statements to interact with the Postgres server.

We want to create a database, and grant privileges to our database user for this new database from the psql shell:

.. sourcecode:: sql

    CREATE DATABASE example;
    GRANT ALL PRIVILEGES on DATABASE example TO "spring-example-user";

.. admonition:: note

    You may need to grant the user superuser access.

    .. sourcecode:: sql

        ALTER USER spring-example-user WITH SUPERUSER;

Now that our container, user, and database are setup we can start working with our code.

Add Dependencies to Spring Project
==================================

Gradle is our build and dependency management tool. We need to inform gradle that we have new dependencies in this project and it will take care of installing and preparing the libraries for us.

We will be making additions to the ``build.gradle`` file. We are adding to the dependencies section of the build.gradle file:

.. sourcecode:: gradle

    implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
	implementation group: 'org.postgresql', name: 'postgresql', version: '42.1.4'

After adding these new dependencies our build gradle will contain:

.. sourcecode:: gradle

    dependencies {
        implementation 'org.springframework.boot:spring-boot-starter-web'
        developmentOnly 'org.springframework.boot:spring-boot-devtools'
        implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
        implementation group: 'org.postgresql', name: 'postgresql', version: '42.1.4'
        testImplementation('org.springframework.boot:spring-boot-starter-test') {
            exclude group: 'org.junit.vintage', module: 'junit-vintage-engine'
        }
    }

Add Database Configuration Information to Spring Project
========================================================

Earlier we setup a postgres container and created a new database. We need to give that information to our spring project so it knows how to communicate with the PostgreSQL server.

We will be adding to ``spring-example/src/main/resources/application.properties``:

.. sourcecode:: code

    spring.datasource.driver-class-name=org.postgresql.Driver
    spring.datasource.url=jdbc:postgresql://127.0.0.1:5432/example
    spring.datasource.username=spring-example-user
    spring.datasource.password=springuserpass
    spring.jpa.hibernate.ddl-auto=update
    # echos SQL statements as they are executed by Hibernate ORM
    # uncomment for debugging to view SQL
    # spring.jpa.show-sql=true
    # spring.jpa.properties.hibernate.format_sql=true

Take note of the information we are adding:

- the URL for our database is ``127.0.0.1:5432``
- the name of our database is ``example``
- the name of our user is ``spring-example-user``
- the password for our user is ``springuserpass``

Model Annotations
=================

Now that we have configured our spring application to communicate with our database, we can utilize the Spring Data and JPA annotations to map our Models to Tables in our database.

.. admonition:: note

    Look over the `Baeldung JPA Entity <https://www.baeldung.com/jpa-entities>`_ to see some examples of some of the annotations we will be using in this article.

We will be flagging all our Models with the ``@Entity`` annotation to tell Hibernate to create a Table that matches the properties of this Model. We will also need to use the ``@Id`` annotation with an id property so the database can index the records that match our POJOs.

In this case we will be altering the ``Pet.java`` class in this way:

.. sourcecode:: java

    @Entity
    public class Dog {

        // properties

        @Id
        private int id;
        private String name;

        ... code clipped for brevity ...

.. admonition:: note

    Will need a default empty constructor and getters and setters for our class.

DataRepository
==============

The ``@Entity`` annotation will link a model with a table in a database, but to interact with it we will need to define a new interface that extends a JpaRepository. This interface will inherit many different built in methods that will provide basic CRUD functionality out of the box.

Create a new directory ``src/main/java/org/launchcode/springexample/data`` and then we will be adding a ``DogRepository.java`` file to that directory.

Make sure the contents of this file contains the following code:

.. sourcecode:: java

    package org.launchcode.springexample.data;

    import org.launchcode.vetapi.models.springexample.Dog;
    import org.springframework.data.jpa.repository.JpaRepository;
    import org.springframework.stereotype.Repository;

    @Repository
    public interface DogRepository extends JpaRepository<Dog, Integer>{
        
    }

For today we will not be adding any additional methods to this interface and will be working with the built in methods that have been inherited. So we don't need to make any additional changes to this file.

Working with the Data Repository
================================

Now we can use the DogRepository interface anywhere in our project we need access to our database.

Let's refactor our ``DogController.java`` to utilize this new Data Repository.

.. sourcecode:: java

    @RestController
    @RequestMapping(value = "/dog")
    public class DogController {

        // Dog newDog = new Dog("Bernie", "Basset", 4);
        @Autowired
        private DogRepository dogRepository;

        @GetMapping
        public List<Dog> getDogs() {
            return dogRepository.findAll();
        }

        @PostMapping
        public Dog postDog(@RequestBody Dog incomingDog) {
            return dogRepository.save(incomingDog);
        }

        // http://localhost:8080/dog/15

        @GetMapping(value = "/{id}")
        public Dog getDogById(@PathVariable int id) {
            return dogRepository.findById(id);
        }
        
    }

We are using the built in methods that are inherited by the dogRepository interface notably: ``findAll()``, ``findById()`` and ``.save()``. These built in methods are providing basic creation, reading, and updating for our SQL records.

.. admontion:: note

    Play the *dot* game with your new dogRepository to learn about additional methods that are available to us with this repository. In a later class we will explore customizing this repository with our own custom SQL statements, but for now the built in methods will suffice.

Try it Out!
===========

Make some curl requests to this spring application and then make some SELECT statements from the PSQL shell to see data being written to our database.

Restart your server and notice how your data persists!