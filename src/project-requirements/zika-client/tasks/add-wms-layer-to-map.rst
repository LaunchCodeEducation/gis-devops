.. _project_zika_client_add_wms_layers:

=====================
Add WMS Layers to Map
=====================

For your first task you will need to add three layers to your base map by making WMS requests to publicly hosted geoservers.

Add Population Density Layer
============================

One of the three layers must be a population density layer from the columbia.edu hosted Gridded Population of the World (GPW), v4 found at this link: https://sedac.ciesin.columbia.edu/data/set/gpw-v4-population-density-rev11.

You will need to decide which layer to use, and to write the code to create this layer.

Take Inventory
--------------

What do we need to do in order to add a new WMS layer to our map?

- we need an Open Street Map object
- we need to define a new Layer which needs:
    - a map projection
    - a geoserver url
    - a list of layer names to load from geoserver
- the layer needs to be added to the map

Add Additional Layers
=====================

After adding the population density layer to your map you will need to add two additional layers using WMS and publicly available geoservers.

You can find additional geoserver map services at the following locations:

- https://sedac.ciesin.columbia.edu/data/sets/browse?facets=data-type:map%20service
- http://www.skylab-mobilesystems.com/en/wms_serverlist.html
- https://freegisdata.rtwilson.com/