.. _project_zika_client_base_wfs_request:

================
Base WFS Request
================

We currently have three layers created by using WMS requests and geoserver. You have also been provided with a private geoserver that you can run locally on your machine that has data we want to include in this project by making a WFS request.

We must configure our WFS writeFeature requests. For this first WFS request we will make a request to the property ``report_date`` and we will need to match it's value to the string date ``2015-11-28``.

This will be our most involved task yet, to refresh yourself on WFS look over the `OpenLayers WFS - GetFeature Example <https://openlayers.org/en/latest/examples/vector-wfs-getfeature.html>`_.

Breaking down the example they had to create a new WFS().writeGetFeature() object starting on line 50. They then had to fire the WFS request to geoserver starting on line 63. You can see they are using the response back from geoserver to add the returning features of the WFS request into the source of existing VectorLayer.

.. admonition:: tip

    This task may seem confusing at first, reach out to an instructor, or fellow class mate to talk it through. Work together to answer the basic questions of how the request is being built, the information the request needs, how the request is sent, how the request is unpacked and loaded into a layer.

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
    - filter: `EqualTo <https://openlayers.org/en/latest/apidoc/module-ol_format_filter_EqualTo-EqualTo.html>`_ ("property_name", date_to_match)
- after creating our WFS feature request we need to attach it to a network request to our local geoserver
    - it must be a POST request
    - we need to unpack the json
    - we need to add the GeoJSON to the source of the layer we created

.. admonition:: tip

    We will want to fire this request after our Dom Content has been loaded