.. _project_zika_client_wfs_request_cases_by_operator:

======================================================
WFS Request via User Provided Operator and Case Number
======================================================

This final task is even more of a reach. So far we have provided the user with the ability to make a WFS request with a specific date, or a date range. What other information is available to us in geoserver?

Outside of ``report_date`` there are the following properties:

- ``id``
- ``country``
- ``state``
- ``cases``
- ``geometry``

``id`` and ``geometry`` are not very valuable as search parameters, however, ``cases``, ``state``, and ``country`` are viable search parameters.

For this task you will need to work with the ``cases`` property and allow the user to dictate if they want to see cases that are `GreaterThan <https://openlayers.org/en/latest/apidoc/module-ol_format_filter_GreaterThan-GreaterThan.html>`_, `LessThan <https://openlayers.org/en/latest/apidoc/module-ol_format_filter_LessThan-LessThan.html>`_ or `EqualTo <https://openlayers.org/en/latest/apidoc/module-ol_format_filter_EqualTo-EqualTo.html>`_ a number of cases entered by the user.

This is going to take some work on our part. We will have to provide the user with the ability to make a LessThan, GreaterThan, or EqualThan based on some input (like a select box) **AND** we will have to provide the user with the ability to provide us with a number of cases that will be used in the filter.

In essence it will be similar to what we did when implementing the date range picker, but now we will be working with ``cases`` instead of ``report_dates``, and we will have to provide them two means of input for the comparison operator, and cases number.

Geoserver Information
=====================

You will need some information about your geoserver container in order to make the WFS().writeFeature request object, and to make the network request.

- geoserver namespace: ``'https://zika.devops.launchcode.org'``
- geoserver prefix: ``'zika'``
- geoserver Types: ``['location_with_cases_by_date']``
- geoserver output format: ``'application/json'``
- geoserver srs name: Your map projection
- geoserver WFS URL: ``'http://localhost:8080/geoserver/zika/wfs'``

This information will be necessary for you to make the WFS write feature request and the network request that are necessary to receive a feature collection represented by geojson which can be loaded into the source of a layer.

Take Inventory
==============

- populate a select element of options that match GreaterThan, LessThan, and EqualTo
- create an input element for numbers where the user can enter positive integers
- create a button for these elements
- register an event listener for this button that will take the input from the HTML elements, craft a WFS request, fire the request, and load the returning data into the source of an existing layer

This task will be difficult, but in essence the steps are very similar to the previous tasks we have completed.