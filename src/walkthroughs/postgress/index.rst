:orphan:

.. _postgres-walkthrough:

=======================
Walkthrough: PostgreSQL
=======================

In this class we will be working with PostgreSQL as our relational database. We will cover some of the fundamentals of SQL and Postgres, but the majority of our database interactions will come from the ORM in our API.

This article will primarily focus on CRUD interactions within SQL for us to familiarize with what the ORM is doing behind the scenes.

Setup
=====

* Check that you have postgres installed by typing ``$ postgres --version`` into your terminal
* Check that you have docker installed by typing ``$ docker --version``
* Check that you have a running docker container for psql by typing ``$ docker ps -a``

If you are missing any of the three things above please fix them before we continue with the walkthrough.

* :ref:`postgres`
* :ref:`docker`
* :ref:`docker-psql`

Concepts
========

* Database
* Table
* Record
* CRUD -- Create, Read, Update, Delete
* Primary Key
* Foreign Key

Let's Run Some Postgres Commands
================================

* Connect to PSQL interactive terminal ``psql -h IP_ADDRESS -p PORT -U USER_NAME -d DATABASE_NAME``

Create a Database
-----------------

A database is a collection of schemas and tables. A database may have any number of schemas, and those schemas may have any number of tables. Tables may, or may not have various relationships with other tables. One database will not have any relationship with any other database. In essence databases are isolated. One database cannot communicate with any other databases.

.. admonition:: note

    We will not be working with schemas in this class, but you can learn more by looking over the `Postgres Schema Documentation <https://www.postgresql.org/docs/current/ddl-schemas.html>`_.

* ``CREATE DATABASE baseball;``
* ``\l`` -- command to list all databases
* ``\c baseball`` -- command to connect to the new baseball database

Create a Table
--------------

A table has columns that contain a column name, and a data type. Some columns have constraints which allow us to add some additional rules to our table. ``Not null``, ``Unique``, ``Primary Key``, and ``Foreign Key`` are examples of constraints. Using the ``Not null`` constraint requires that column must contain data when a record is being inserted into the table. 

Each individual piece of data added to a table is called a record. 

* ``CREATE TABLE teams (id SERIAL, name varchar(50), league varchar(25), PRIMARY KEY (id));`` -- create a new table with three columns: id, name, and league
* ``\dt`` -- command to list all tables in the current database

We are using the PRIMARY KEY constraint on the id column. A **primary key** is the unique identifier for a record. In this example our Primary Key is the SERIAL type. The SERIAL type is incrementing integers starting at 1. Every time a new record is added to this table, the next integer will be assigned as it's primary key.

Create Record - Insert Into
---------------------------

We can create records, by inserting them into a table.

* ``INSERT INTO teams(name, league) VALUES ('St. Louis Cardinals', 'National');``
* ``SELECT * FROM teams;``

We can insert as many records as we want with one INSERT INTO statement.

* ``INSERT INTO teams(name, league) VALUES ('Washington Nationals', 'National'), ('Chicago Cubs', 'National'), ('New York Mets', 'National'), ('New York Yankees', 'American');``

Read Record - Select
--------------------

* ``SELECT * FROM teams;`` -- SELECT all the columns from all the teams
* ``SELECT name FROM teams;`` -- SELECT only the name column from all the teams
* ``SELECT * FROM teams WHERE league='National';`` -- SELECT all the columns from all the teams in the 'National' league
* ``SELECT name FROM teams WHERE league='National';`` -- SELECT only the name column from teams in the 'National' league

Alter Table
-----------

A table can be changed. We can add, or drop columns, or change constraints.

* ``ALTER TABLE teams ADD COLUMN dvsn VARCHAR(10);`` -- Add the 'dvsn' column to teams
* ``SELECT * FROM teams;``
* ``ALTER TABLE teams DROP COLUMN IF EXISTS dvsn;`` -- Let's drop that change, and rename it division
* ``SELECT * FROM teams;``
* ``ALTER TABLE teams ADD COLUMN division VARCHAR(10);`` -- Add the 'division' column to teams
* ``SELECT * FROM teams;``

Update Record(s)
----------------

We can update the individual records in our table with the UPDATE statement. Each UPDATE statement must contain a SET statement which defines which column(s) will be updated, and a WHERE clause which defines which records will be updated.

* ``UPDATE teams SET division='Central' WHERE name='St. Louis Cardinals';`` -- Update the record that matches the WHERE clause
* ``SELECT * FROM teams;``
* ``UPDATE teams SET division='East' WHERE name='Washington Nationals' OR name='New York Mets' OR name='New York Yankees';``
* ``SELECT * FROM teams;``
* ``UPDATE teams SET division='Central' WHERE name='Chicago Cubs';``
* ``SELECT * FROM teams;``

.. warning::

  Any record that matches the WHERE clause will be updated!

Delete Record(s)
----------------

We can also delete individual records. Before we do let's add a team that no longer plays in the MLB, so we can delete them.

* ``INSERT INTO teams(name, league) VALUES ('St. Louis Brown Stockings', 'National');`` -- Adding a team we are about to delete
* ``SELECT * FROM teams;``
* ``DELETE FROM teams WHERE id=6;`` 
* ``SELECT * FROM teams;``

.. warning::

    Any record that matches the WHERE clause will be deleted! Since we deleted by the id, which is a primary key we are ensuring that only 1 record is affected.

Foreign Key
-----------

We recently learned that a Primary Key is the unique identifier for one record in a table. A Foreign Key is a reference to another record on another table.

What if we were to create a new table called players and filled it with various MLB players. It would be nice to include data about the team the player currently plays for. However in the MLB players are traded, retire, enter Free Agency, etc, and their team affiliations change. Instead of changing all of that data for each player every time a team change happens we should use the data that already exists in the teams table.

We can do this by creating a reference to the teams table within our new table.

* ``CREATE TABLE players (id SERIAL PRIMARY KEY, team_id INTEGER REFERENCES teams(id), first_name VARCHAR(50), last_name VARCHAR(50));``
* ``\dt``
* ``SELECT * FROM players;``
* ``INSERT INTO players (team_id, first_name, last_name) VALUES (1, 'Albert', 'Pujols'), (1, 'Yadier', 'Molina'), (5, 'Alex', 'Rodriguez');``
* ``SELECT * FROM players;``

Now we can join these tables together, and view it all at the same time.

* ``SELECT * FROM teams, players WHERE teams.id=players.team_id;`` -- view team info first
* ``SELECT * FROM players, teams WHERE players.team_id=teams.id;`` -- view player info first
* ``SELECT * FROM players, teams WHERE players.team_id=teams.id AND players.team_id=1;`` -- only select players on the St. Louis Cardinals

Albert Pujols signed with the Los Angeles Angels after playing for the St. Louis Cardinals, so we need to change his ``team_id``.

* ``INSERT INTO teams(name, league, division) VALUES ('Los Angeles Angels', 'American', 'West');``
* ``SELECT id from teams WHERE name='Los Angeles Angels';``
* ``SELECT id from players WHERE first_name='Albert' AND last_name='Pujols';``
* ``UPDATE players SET team_id=7 WHERE id=1;``

Now when we select all the players on the Cardinals roster we don't see Albert Pujols, because his ``team_id`` changed.

* ``SELECT * FROM players, teams WHERE players.team_id=teams.id AND players.team_id=1;``

When we look at all players with team info we can see the data associated with Albert Pujols has changed. Albert Pujols is now refrencing the Los Angeles Angels.

* ``SELECT * FROM players, teams WHERE players.team_id=teams.id;``

When a column references another tables PRIMARY KEY we call it a FOREIGN KEY. In the example we have worked on so far ``team_id`` on the players table is a Foreign Key that references the Primary Key on the teams table.

Resources
=========

We have barely touched the surface of Postgres, or SQL. You can find more information by reading the `Postgres documentation <https://www.postgresql.org/docs/>`_

We have covered everything that you will need to know for this class, but if you are hungry for more you should research JOIN statements.
