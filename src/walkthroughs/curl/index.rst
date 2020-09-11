:orphan:

.. _walkthrough-curl-local:

================================
Walkthrough: Intro to Curl Local
================================

- You can find a hosted sample API at 34.237.137.145
- You can find a hosted TODO API at 35.153.156.170

Sample API
==========

GET
---

.. sourcecode:: bash

   curl -X GET 34.237.137.145

POST
----

.. sourcecode:: bash

   curl -X POST 34.237.137.145

.. sourcecode:: bash

   curl -X POST 34.237.137.145 -H 'content-type: application/json' -d '{"body": "hello"}'

.. sourcecode:: bash

   curl -X POST 34.237.137.145 -H 'content-type: application/json' -d '{"firstName": "Paul", "lastName": "Matthews"}'

TODO API
========

GET
---

.. sourcecode:: bash

   curl -X GET 35.153.156.170

.. sourcecode:: bash

   curl -X GET 35.153.156.170/todos

POST
----

.. sourcecode:: bash

   curl -X POST 35.153.156.170/todos -H 'content-type: application/json' -d '{"text": "buy milk"}'

- now perform a GET to ``/todos``. What has changed?

Try to add a task for walking the dog?

.. sourcecode:: bash

   curl -X POST 35.153.156.170/todos -H 'content-type: application/json' -d '{"task": "walk dog"}'

What did we do wrong?

.. sourcecode:: bash

   curl -X POST 35.153.156.170/todos -H 'content-type: application/json' -d '{"text": "walk dog"}'

- now perform a GET to ``/todos`` to see what has changed

PATCH
-----

Say we completed one of our tasks. We can update it's completed field by sending a PATCH request:

.. sourcecode:: bash

   curl -X PATCH 35.153.156.170/todos/2

- now perform a GET to ``/todos``. What has changed?

DELETE
------

Say we want to remove the task we completed. We can remove it from the list by sending a DELETE request:

.. sourcecode:: bash

   curl -X DELETE 35.153.156.170/todos/2

- now perform a GET to ``/todos``. What has changed?

curl Options
============

- -v
- -h
- -d

Recap
=====

- ``curl`` allows us to make HTTP requests from our terminal
- ``curl`` allows us to set the HTTP method to: GET, POST, PATCH, DELETE and more
- when using ``curl`` the HTTP responses is printed to STDOUT
- there are various options that can be used with curl to further configure the request or to dig deeper into the response
- ``man curl`` and ``curl --help`` are two ways to learn more about curl from the terminal