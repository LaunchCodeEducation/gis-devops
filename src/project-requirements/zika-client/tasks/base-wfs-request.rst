.. _project_zika_client_base_wfs_request:

================
Base WFS Request
================

We currently have three layers created by using WMS requests and geoserver. You have also been provided with a private geoserver that you can run locally on your machine that has data we want to include in this project by making a WFS request.

With the WFS request you will need to provide two dates, a start date and an end date.

For this first WFS task you should load a new layer using a WFS request and the start date of ``2015-01-01`` and an end date of ``2016-01-01``.

Take Inventory
==============

What do we need to do in order to add a new layer from a WFS request to our map?

- we need to define a new layer
    - the layer needs a source
    - the layer needs a style
- we need to create a new WFS().writeGetFeature object that contains the metadata needed by geoserver to handle our request
    - srsName
    - featureNS
    - featurePrefix
    - featureTypes
    - outputFormat
    - filter: IsBetween("property_name", start_date, end_date)
- after creating our WFS feature request we need to attach it to a network request to our local geoserver
    - it must be a POST request
    - we need to unpack the json
    - we need to add the GeoJSON to the source of the layer we created