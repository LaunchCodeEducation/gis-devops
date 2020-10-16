.. _project_zika_client_wfs_request_on_button_click:

=========================
WFS Request by Date Range
=========================

In the previous task we let the user make a new WFS request based on entering in one date, and then we made a new filter that matched their date with a specific date in geoserver and then would render a layer based on the data for that specific date.

Let's expand on this idea further and give the user the ability to select a range of dates, by selecting a start date, and an end date. We will then create a WFS request that will check for report_dates in that range using an `IsBetween Filter <https://openlayers.org/en/latest/apidoc/module-ol_format_filter_IsBetween-IsBetween.html>`_

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

- we will need two select boxes that are filled with valid dates
- we will need a button to send the request
- register a new click event handler for the button
- make a new WFS().getFeatures() request with the dates selected by the user in the select elements
- fire a fetch() request to geoserver using the new WFS().getFeatures() request
- load the returned data into the source of the layer created for zika reports