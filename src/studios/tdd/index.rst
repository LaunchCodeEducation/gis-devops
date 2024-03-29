:orphan:

.. _tdd-studio:

===============================
Studio: Test-Driven Development
===============================

For this studio, you will create a class to represent `URLs <https://en.wikipedia.org/wiki/URL>`_ as Java objects. You will do this using a test-driven approach.

Getting Started
===============

Fork and clone the `tdd-studio repository <https://gitlab.com/LaunchCodeTraining/tdd-studio>`_. 

Review terminology for the following URL components at `Wikipedia <https://en.wikipedia.org/wiki/URL>`_ : protocol, domain, path.

Your Tasks
==========

Create two classes:

* Url.java
* UrlTest.java

You will follow a test-driven approach to implement the requirements below. This means that for each requirement, you should write a test **before** writing any code for that requirement.

Use the red-green-refactor workflow:

* Write a failing test
* Write code to get the test to pass
* Review your code to see if it can be improved, and rerun your tests after each refactor

Requirements
------------

* There should be only one ``Url`` constructor, and it should take a string (e.g. ``"https://launchcode.org/learn"``) and set ``domain``, ``protocol``, and ``path`` fields. Note that protocol and domain will not contain any ``/`` characters, but the path may.
* The three should be immutable. In other words, they should be ``final`` and have getters but not setters.
* The constructor should take mixed-case strings, but set fields as lowercase strings. For example, if passed ``"HTTPS://LAUNCHCODE.ORG"`` then calling ``getDomain()`` should return ``"launchcode.org"``.
* ``Url`` should override ``toString()``, which should return a properly-formatted version of the URL (e.g. ``"https://launchcode.org/learn"``)
* The string passed to the constructor should satisfy each of the following. If it doesn't, then the constructor should throw an ``IllegalArgumentException`` with an appropriate message.

  * The protocol is one of: ftp, http, https, and file
  * The path may be empty, but domain and protocol must both be non-empty
  * The domain may only contain letters, numbers, ``.``, ``-``, or ``_``

.. note::

    These requirements are not comprehensive of how a URL may be structured, but they encompass a large number of URLs you use on a daily basis.


Bonus Missions
--------------

If you implement the above requirements with time to spare, attempt to implement these as well:

* Add port, query string, and fragment fields with reasonable validation for each
* Add support for IP addresses in place of domains

Resources
=========

* `Java Regex Docs <https://docs.oracle.com/javase/7/docs/api/java/util/regex/Pattern.html>`_

