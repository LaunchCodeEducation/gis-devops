.. _project_zika_client:

====================
Project: Zika Client
====================

Zika Mission Control
====================

Throughout this class we will build a Zika Mission Control Dashboard. We will focus on one aspect at a time to assemble this project over multiple weeks.

This project will consist of:

- Zika Client (HTML, CSS, JavaScript)
- Zika API (Java/Spring)
- Zika Geoserver
- Public Geoserver
- Postgres database

This project will ultimately be deployed to AWS services and will be accessible 

Each week we will have a list of requirements that we will need to build into our project.

Project Overview
================

The Zika Mission Control dashboard will be a Spring web application. It will display an interactive map from `Open Street Maps <https://www.openstreetmap.org/#map=5/38.007/-95.844>`_ (OSM). The map will present a layer of features that represent an outbreak of Zika. Each representation of a Zika report will be clickable, and upon a click event the user will see more information about that specific report.

Each week we will build on our currently existing project, so **it is crucial to finish the primary objectives** for each project week!

Here is a mockup of the application you will be building.

.. image:: /_static/images/project/cdc_zika_dashboard.png


Project Requirements
====================

Following are the requirements from our stakeholders, and our tech team.

Stakeholder Requirements
------------------------

- Zika Reports need to be geographically displayed on a map
- Related Zika reporting layers should be added using public geoserver WMS services
- Related Zika reporting layers should be toggleable
- Users should be able to update the date to see new report data on the map

Technical Requirements
----------------------

- Version Control: Code base is managed with Git, and a remote repository is hosted on GitLab.
- HTML, CSS, Javascript, and XHR should be used to work with the Zika report data in a provided geoserver.
- OpenLayers should be used to load an interactive map from OSM.
- Zika reports should be loaded onto the OpenLayers map as a new feature layer.
- A population layer should be included from the underlying data set found here: https://sedac.ciesin.columbia.edu/data/set/gpw-v4-population-density-rev11
- Additional layers should be included that may be useful when thinking about Zika report data

There are many ways we could go about building this project, but we must follow the provided requirements.

Primary Objectives
==================

You should **complete all primary objectives** before working on any secondary objectives.

For your primary objectives, articles have been provided to help you think about what needs to be completed to complete the objective.

1. :ref:`Add WMS Layers to the map <project_zika_client_add_wms_layers>` 
2. :ref:`Make WMS Layers toggleable on button click <project_zika_client_add_wms_layers>`
3. :ref:`Make a WFS request for a specific date range and display as a layer <project_zika_client_base_wfs_request>`
4. :ref:`Make a WFS request for a different date range and change source of layer <project_zika_client_wfs_request_on_button_click>`
5. :ref:`Add a date range selection tool that makes a WFS request based on user input <project_zika_client_wfs_request_via_date_range_selection>`

Secondary Objectives
====================

For your secondary objectives no guidance will be given to you. You will have to think about what needs to be completed to pass the objective.

- Zika reports change color based on the severity of the outbreak
- modularize your JavaScript
- View report data when features are clicked on the map (map.onclick(forEachFeatureAtPixel))

Bonus Missions
==============

If you finish all objectives above, here are some additional features to consider. These are roughly listed in order from easiest to hardest. Feel free to pick what seems interesting to you, rather than starting from the top of the list. These are all independent of one another. 

- Use jQuery to reduce the amount of JavaScript 
- "Animate" reports displayed by adding them to the map one-by-one on page load
- Add a select box to filter down to a specific country or region (search by country and fuzzy search)

Turning in Your Work
====================

Code Review
-----------

Let your instructor know When you complete the primary objectives. The instructor will need a link to your GitLab repo, and they will perform a code review, and leave you feedback.

Objective Checklist
-------------------

As you work through the objectives for this week, keep track of them on your Checklist, your instructor will also confirm which objectives you completed in their code review. If you don't pass an objective the instructor will give you feedback on what you need to do to complete that objective.

Presentation
------------

Friday afternoon everyone will present their project to the class. This presentation is meant to be a celebration of your hard work throughout the week, and as a chance for you to share, and learn from the other students in the class.

At the end of this course, during your graduation ceremony you will be expected to present your final project to the attendees. Every project week we will have a presentation as a way for you to practice for this final presentation.

Check Your Knowledge
====================

We covered a lot of ground this week. 

To reinforce your understanding of the concepts answer these questions to yourself:

- When did we have to make changes to a controller file?
- When did we have to make changes to a repository file?
- When did we have to make changes to the ``index.html`` file?
- When did we have to make changes to the script.js file?
- When did we have to make changes to our test files?
- How does our application communicate with the database?
- Our data starts as various CSV files. How is that data transformed throughout our project?
- How does our application convert a Java Object to GeoJSON?
- How do we create a new layer in OpenLayers?
- How do we add that layer to our map from OSM?

Bonus Resources
===============

* `CSS Selectors <https://www.w3schools.com/cssref/css_selectors.asp>`_
* `JSON Lint <https://jsonlint.com/>`_
* `geojson.io <http://geojson.io/#map=2/20.0/0.0>`_
* `Spring Data JPA DataRepostiry query documentation <https://docs.spring.io/spring-data/jpa/docs/1.5.0.RELEASE/reference/html/jpa.repositories.html>`_

.. note::

   Remember that both jQuery and OpenLayers will silently fail if they are not given valid JSON and valid GeoJSON (respectively).
