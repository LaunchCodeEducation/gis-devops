.. _project_zika_client_toggleable_wms_layers:

=====================
Toggleable WMS Layers
=====================

In the previous task you added three WMS layers to your map.

Viewing all three of these layers at the same time is overwhelming. Let's give a user the ability to toggle the individual layers as visible or not visible.

In the starter code of the Zika Client you will notice that three toggle buttons already exist.

Your goal for this task will be to wire these buttons so that when they are clicked their associated layer's visibility is changed.

You can find information on the available properties, and methods associated with a Layer object by checking the `OpenLayers Layer documentation <https://openlayers.org/en/latest/apidoc/module-ol_layer_Layer-Layer.html>`_

Take Inventory
==============

What do we need to do in order to make our layers toggleable?

- register event handler for each button
- within each event handler access the appropriate layer and changes it's visibility
