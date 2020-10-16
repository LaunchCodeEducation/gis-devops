.. _project_zika_client_wfs_by_date:

===============================
WFS Request for a Specific Date
===============================

Our previous task made a WFS request with a hard coded date of ``2015-11-28``, we want to expand on this idea by allowing our user to choose a date with valid data and to send a new WFS request.

We will have to give them the ability to choose a valid date, and we then we will need to give them the ability to request a new Zika layer from a new WFS request.

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

Taking Inventory
================

- create an HTML select element to hold valid dates
- populate the HTML select element with valid options representing dates
- create an event listener that will create a new WFS request, POST it to geoserver, and finally replace the source of zika layer with the new data

.. admonition:: tip

    Your project came with a CSV file of valid dates. You will need to figure out how to add these dates to an HTML select element.