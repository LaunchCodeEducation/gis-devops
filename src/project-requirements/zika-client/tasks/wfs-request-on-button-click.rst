.. _project_zika_client_wfs_request_on_button_click:

===============================
New WFS Request on Button Click
===============================

You will need to add a new button adjacent to the provided toggle buttons.

You will need to register a new event listener on the button that will create a new WFS.getFeatures() request, and then make the request with fetch().

Take Inventory
==============

- create new button
- register new click event listener for the button
- make a new WFS().getFeatures() request with the start date '2016-01-01' and the end date '2017-01-01'
- fire a fetch() request to geoserver using the new WFS().getFeatures() request
- load the returned data into the source of the layer created for zika reports