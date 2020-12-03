:orphan:

.. _walkthrough-elasticsearch2:

=================================
Walkthrough: Elasticsearch Part 2
=================================

In the previous :ref:`walkthrough-elasticsearch` we learned about Elasticsearch terminology, CRUD functionality, Matching, Pagination, boolQuery, and Fuzzy searching.

In this walkthrough we will be expanding on Elasticsearch by learning about: Filtering, Aggregations, Mapping, and GeoAggregations.

Getting Ready
=============

We will be working with the ``/teams`` index again, which is data about the various MLB baseball teams. You should have 30 documents in the ``/teams`` index. You can check the number of documents in this index by running: ``curl 127.0.0.1:9200/teams/_count``.

If you don't have 30 documents, or the ``/teams`` index doesn't exist you can get that data with the ``baseball-teams.sh`` script in the repository you cloned.

Filters
=======

A powerful tool within our Elasticsearch queries is to add a Filter context. The filter context allows us to filter our queries in new ways. What if we wanted to select all the baseball teams that have won one or more world series?

.. sourcecode:: console
   :caption: GET /teams/_search "filter: range world_series_champions >= 1"

   GET /teams/_search
   {
       "query": {
           "bool": {
               "must": { "match_all": {} },
               "filter": {
                   "range": {
                       "world_series_champions": { "gte": 1 }
                   }
               }
           }
       }
   }

We found 24 teams that have won at least one world series.

What if we wanted to find baseball teams that have won between 2 and 5 world series?

.. sourcecode:: console
   :caption: GET /teams/_search "filter: range 2 >= world_series_champions >= 5"

   GET /teams/_search
   {
       "query": {
           "bool": {
               "must": { "match_all": {} },
               "filter": {
                   "range": {
                       "world_series_champions": { 
                           "gte": 2,
                           "lte":  5
                        }
                   }
               }
           }
       }
   }

We found 14 teams that match our query.

What about teams that have won between 2 and 5 world series in the National League?

.. sourcecode:: console
   :caption: GET /teams/_search "filter range 2 >= world_series_champions >= 5 National league"

    GET /teams/_search
    {
        "query": {
            "bool": {
                "must": { "match": { "league": "National" } },
                "filter": {
                    "range": {
                        "world_series_champions": { 
                            "gte": 2,
                            "lte":  5
                            }
                    }
                }
            }
        }
    }

We found 7 teams that match our query.

What about the teams that have never won a world series?

.. sourcecode:: console
   :caption: GET /teams/_search "filter range world_series_champions <= 0"

    GET /teams/_search
    {
        "query": {
            "bool": {
                "must": { "match_all": {} },
                "filter": {
                    "range": {
                        "world_series_champions": { 
                            "lte":  0
                            }
                    }
                }
            }
        }
    }

The ``range`` query gives us a few options:
    - "gte" - greater than or equal to
    - "lte" - less than or equal to
    - "lt" - less than
    - "gt" - greater than

The ``range`` query also allows us to round, and perform math for dates, and timezones. Checkout the `range documentation <https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-range-query.html>`_.

Aggregations
============

Average
-------

Aggreations are a way to describe the data found in a query.

What if we wanted to see the average world series wins?

.. sourcecode:: console
   :caption: GET /teams/_search "aggregation average world_series_champions"

    GET /teams/_search
    {
        "aggs": {
            "avg_world_series_wins": { 
                "avg": { 
                    "field": "world_series_champions" 
                    } 
                }
        }
    }

This gives us an average of 3.8 world series championships. 

What about the world series average for the National league?

.. sourcecode:: console
   :caption: GET /teams/_search "aggregation National league average world_series_champions"

    GET /teams/_search
    {
        "query": {
            "match": {
                "league": "National"
            }
        },
        "aggs": {
            "avg_world_series_wins": { 
                "avg": { 
                    "field": "world_series_champions" 
                    } 
                }
        }
    }

We get an average of 3.33 for the National league. What about the American league?

.. sourcecode:: console
   :caption: GET /teams/_search "aggregation American league average world_series_champions"

    GET /teams/_search
    {
        "query": {
            "match": {
                "league": "American"
            }
        },
        "aggs": {
            "avg_world_series_wins": { 
                "avg": { 
                    "field": "world_series_champions" 
                    } 
                }
        }
    }

We get an average of 4.4 for the American league.

Max
---

We can also find the max value with aggregations.

.. sourcecode:: console
   :caption: GET /teams/_search "aggregation: max world_series_champions"

    GET /teams/_search
    {
        "aggs": {
            "max_world_series_wins": { 
                "max": { 
                    "field": "world_series_champions" 
                    } 
                }
        }
    }

We find that the max number of wins is 27.

Min
---

We can also find the minimum number of world series wins.

.. sourcecode:: console
   :caption: GET /teams/_search "aggregation: min world_series_champions"

    GET /teams/_search
    {
        "aggs": {
            "min_world_series_wins": { 
                "min": { 
                    "field": "world_series_champions" 
                    } 
                }
        }
    }

Which we find is 0, a stat we knew about when we filtered by teams that had zero or less world series championships.

Stats
-----

We also have a handy ``stats aggregation`` that compiles various stats.

.. sourcecode:: console
   :caption: GET /teams/_search "aggregation: stats world_series_champions"

   GET /teams/_search
   {
       "aggs": {
           "world_series_champions_stats": {
               "stats": {
                   "field": "world_series_champions"
               }
           }
       }
   }

This gives us a decent collection of stats.

You can learn more by reading the `aggregation documentation <https://www.elastic.co/guide/en/elasticsearch/reference/current/search-aggregations-metrics.html>`_.

Mapping
=======

From the `mapping documentation <https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping.html>`_: Mapping is the process of defining how a document, and the fields it contains, are stored and indexed. 

We haven't learned about mapping yet because Elasticsearch dynamically maps indices, however when you need more control over the data types of the fields within a mapping, or when you are working with GEOINT you need to explicitly create an index's mapping.

Let's look at the current mapping of the ``/teams`` index.

.. sourcecode:: console
   :caption: GET /teams

   GET /teams

We currently have these properties:
    - city with type text
    - country with type text
    - division with type text
    - league with type text
    - name with type text
    - state with type text
    - world_series_champions with type long

Pretty straightforward so far, but what if we wanted to add the property "stadium_location" a Geopoint that contains the Latitude and Longitude of the stadium?

Since a Geopoint is a type of GEOINT we will have to explicitly add this property to the mapping.

.. sourcecode:: console
   :caption: PUT /teams ERROR

   PUT /teams
   {
       "mappings": {
           "_doc": {
               "properties": {
                   "stadium_location": {
                       "type": "geo_point"
                   }
               }
           }
       }
   }

When we run this cURL command we get an error. The resource already exists. This is one of the issues with Elasticsearch since documents are indexed immediately, you cannot update the mapping of an exising index. There are some exceptions, but in our case we need to re-create our index.

Let's clear out our current ``/teams`` index.

.. sourcecode:: console
   :caption: DELETE /teams

   DELETE /teams

Now we can re-create our index with an explicit mapping.

.. sourcecode:: console
   :caption: PUT /teams

   PUT /teams
    {
    "mappings": {
        "properties": {
        "city": {
            "type": "text"
        },
        "country": {
            "type": "text"
        },
        "division": {
            "type": "text"
        },
        "league": {
            "type": "text"
        },
        "name": {
            "type": "text"
        },
        "state": {
            "type": "text"
        },
        "world_series_champions": {
            "type": "long"
        },
        "stadium_location": {
            "type": "geo_point"
        }
        }
    }
    }

And now we will need to re-index our teams. Let's see one as an example.

.. sourcecode:: console
    :caption: POST /teams/_doc

    POST /teams/_doc
    {
        "city": "St. Louis",
        "country": "United States",
        "state": "Missouri",
        "name": "Cardinals",
        "league": "National",
        "division": "Central",
        "world_series_champions": 11,
        "stadium_location": {
            "lat": 38.622641, 
            "lon": -90.192819
        }
    }

Let's look at this new addition to our new ``/teams`` index.

.. sourcecode:: console
   :caption: GET /teams/_search

   GET /teams/_search

We have successfully added a new team with a geo_point for the property "stadium_location".

Let's re-create our ``/teams`` index with the ``baseball-teams-stadiums.sh`` script.

Now let's look at the new geo_points we added.

.. sourcecode:: console
   :caption: GET /teams/_search

   GET /teams/_search
   {
       "from": 0,
       "size": 30,
       "_source": ["name", "stadium_location"],
       "query": { "match_all": {} }
   }

It looks like it worked!

GeoAggregations
===============

Why did we go through all that work?

Elasticsearch supports all sorts of aggregations based around GEOINT.

Geo Distance
------------

Let's find the baseball stadiums within 20km of the LaunchCode Mentor Center (`"lat": 38.651522, "lon": -90.259495 <https://www.google.com/maps/place/38%C2%B039'05.5%22N+90%C2%B015'34.2%22W/@38.6515262,-90.2616837,17z/data=!3m1!4b1!4m5!3m4!1s0x0:0x0!8m2!3d38.651522!4d-90.259495>`_).

.. sourcecode:: console
   :caption: geo_distance 20km

   GET /teams/_search
   {
       "query": {
           "bool": {
               "filter": {
                   "geo_distance": {
                       "distance": "20km",
                       "stadium_location": {
                           "lat": 38.651522,
                           "lon": -90.259495
                       }
                   }
               }
           }
       }
   }

We got 1 hit! The St. Louis Cardinals play within 20km of the Mentor Center. Let's expand the search to 500km.

.. sourcecode:: console
   :caption: geo_distance 500km

   GET /teams/_search
   {
       "query": {
           "bool": {
               "filter": {
                   "geo_distance": {
                       "distance": "500km",
                       "stadium_location": {
                           "lat": 38.651522,
                           "lon": -90.259495
                       }
                   }
               }
           }
       }
   }

We got 4 hits this time: the Chicago Cubs, the Chicago White Sox, the Kansas City Royals, and the St. Louis Cardinals.

Geo Bounds
----------

.. sourcecode:: console
   :caption: geo bounds full MLB

   GET /teams/_search
   {
       "query": { "match_all": {} },
       "aggs": {
           "stadium_bounds": {
               "geo_bounds": {
                   "field": "stadium_location"
               }
           }
       }
   }

This gives us two points, we could use to draw a box around all of the stadiums. It's not very useful in this context because it's just a box covering the majority of the continental United States, and some of Canada. However, it could be more useful to visualize the area of each division.

.. sourcecode:: console
   :caption: geo bounds 

    GET /teams/_search
    {
        "query": {
            "bool": {
                "must": [
                    { "match": { "league": "American" } },
                    { "match": { "division": "Central" } }
                ]
            }
        },
        "aggs": {
            "al_central_stadium_bounds": {
                "geo_bounds": {
                    "field": "stadium_location"
                }
            }
        }
    }

In this case we get a better understanding of the area these teams draw fans, and could benefit from media deals.

Geo Centroid
------------

Instead of calculating the area of all of our stadiums, a more beneficial calculation could be the centroid. Or the geo point in the center of the polygon created by connecting all of the stadium locations.

.. sourcecode:: console
   :caption: geo centroid

   GET /teams/_search
   {
       "query": { "match_all": {} },
       "aggs": {
           "stadium_centroid": {
               "geo_centroid": {
                   "field": "stadium_location"
               }
           }
       }
   }

We have found the centroid of all the stadiums in the MLB. At "lat": 38.17771242745221 "lon" : -92.48515307530761. Pulling this `point <https://www.google.com/maps/place/38%C2%B010'39.8%22N+92%C2%B029'06.6%22W/@38.175995,-92.6250644,11z/data=!4m5!3m4!1s0x0:0x0!8m2!3d38.1777124!4d-92.4851531>`_ up on a map shows us south central Missouri, just east of the Lake of the Ozarks.

What about the centroid for just American League East Division?

.. sourcecode:: console
   :caption: geocentroid AL East

   GET /teams/_search
   {
       "query": { 
           "bool": {
               "must": [
                   { "match": { "league": "American" } },
                   { "match": { "division": "East" } }
               ]
           } 
        },
       "aggs": {
           "stadium_centroid": {
               "geo_centroid": {
                   "field": "stadium_location"
               }
           }
       }
   }

This time our centroid is in `southern Maryland <https://www.google.com/maps/place/38%C2%B046'26.6%22N+76%C2%B044'15.2%22W/@38.7741692,-77.017703,10z/data=!4m5!3m4!1s0x0:0x0!8m2!3d38.7740536!4d-76.7375409>`_, east and slightly south of Washington D.C.

Other Features
==============

We have covered a lot of ground with Elasticsearch, and still have barely touched on the features of this technology. You will get more experience with Elasticsearch throughout this class, but mainly through our Spring web apps, and how we interface with Elasticsearch will change. However, it is still crucial to understand how Elasticsearch works and what is going on under the hood.

If you are interested in learning more check out the following topics:
    - Boost
    - Highlight
    - Parent/Child Relationships
    - Joins
    - Analyzers

And of course you should always reference the `Elasticsearch documentation <https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html>`_ when you have questions.
