:orphan:

.. _walkthrough-elasticsearch:

==========================
Walkthrough: Elasticsearch
==========================

Elasticsearch is a non-relational database. It stores information as documents, a collection of key-value pairs that describe the object. A document's format is very similar to JSON.

Unlike a relational database, we will not use SQL to communicate with our data, instead we will be using HTTP Requests, and JSON to communicate with our data. It is a RESTful API and therefore we will predominately be using GET, POST, PUT, and DELETE HTTP methods, and will be receiving JSON as a response.

A non-relational database has certain advantages, and disadvantages in comparison to a relational database.

Advantages:
    - Fast search
    - Full text search
    - Real time search
    - Fuzzy search
    - Distributed workers
    
Disadvantages:
    - Data loss & data corruption
    - Reindex for every document creation, or update
    - Memory intensive

Getting Ready
=============

Clone the `elasticsearch-kibana-starter <https://gitlab.com/LaunchCodeTraining/elasticsearch-kibana-starter>`_ to your machine.

Invoke the ``docker-compose.yml`` script to start up the elasticsearch and kibana containers:

.. sourcecode:: console

    docker-compose up -d

After waiting a minute or two for elasticsearch to startup you can verify that it is running properly with the following curl command:

.. sourcecode:: console

    curl localhost:9200

You should see an output containing some meta data about this cluster that looks similar to:

.. sourcecode:: console

    {
        "name" : "e5f4faac973f",
        "cluster_name" : "elasticsearch",
        "cluster_uuid" : "E5RXB-RuT9eWreLKiDQ63g",
        "version" : {
            "number" : "7.9.3",
            "build_flavor" : "default",
            "build_type" : "docker",
            "build_hash" : "c4138e51121ef06a6404866cddc601906fe5c868",
            "build_date" : "2020-10-16T10:36:16.141335Z",
            "build_snapshot" : false,
            "lucene_version" : "8.6.2",
            "minimum_wire_compatibility_version" : "6.8.0",
            "minimum_index_compatibility_version" : "6.0.0-beta1"
        },
        "tagline" : "You Know, for Search"
    }

You can verify Kibana started correctly by navigating to ``http://localhost:5601`` in your browser.

You should be greeted with the Kibana starting screen:

.. image:: /_static/images/elasticsearch/kibana-start-page.png

Go ahead and click the ``Explore on my own`` button which will take you to the home page:

.. image:: /_static/images/elasticsearch/kibana-home-page.png

In this walkthrough we will only be working with the Kibana Dev Tools which you can find by clicking the hamburger icon in the top left corner and selecting ``Dev Tools``:

.. image:: /_static/images/elasticsearch/menu-dev-tools.png

This will take you to the console:

.. image:: /_static/images/elasticsearch/kibana-console.png

From the console we can easily write web requests that will interact with our elasticsearch cluster.

Elasticsearch Terms
===================

**Cluster** - A collection of Nodes, that holds all the data, and manages Requests, and Responses.

**Node** - A single server inside the cluster. It stores pieces of the data, and performs indexing, and searching. The Node is the worker that performs the actions in Elasticsearch.

**Index** - A collection of documents that have somewhat similar characteristics.

**Shard** - A single piece of an index. It stores some documents, but not necessarily all the documents for a specific Index. The data of an Index is spread out amongst many Shards.

**Replica** - A copy of a shard. If a shard is corrupted, or goes offline, the Replica can be used to re-create the Shard, or can be used in the Shards place. A replica cannot be housed on the same Node as the Shard it was created from.

**Document** - A record of data. A basic unit of information that can be indexed.

Read more about these specific terms from the Elasticsearch documentation `basic concepts <https://www.elastic.co/guide/en/elasticsearch/reference/6.5/getting-started-concepts.html>`_.

Interfacing with Elasticsearch
==============================

At it's heart Elasticsearch is a RESTful API. We can fire web requests to the elasticsearch cluster go Create, Read, Update, or Delete documents.

We could simply craft and execute curl requests to interface with this tool, or we can use the Kibana console which provides a better interface for creating and managing web requests to elasticsearch.

From the Kibana console let's try making the same request we made earlier:

.. sourcecode:: console

    GET /

Which should give you an output similar to:

.. sourcecode:: console

    {
        "name" : "e5f4faac973f",
        "cluster_name" : "elasticsearch",
        "cluster_uuid" : "E5RXB-RuT9eWreLKiDQ63g",
        "version" : {
            "number" : "7.9.3",
            "build_flavor" : "default",
            "build_type" : "docker",
            "build_hash" : "c4138e51121ef06a6404866cddc601906fe5c868",
            "build_date" : "2020-10-16T10:36:16.141335Z",
            "build_snapshot" : false,
            "lucene_version" : "8.6.2",
            "minimum_wire_compatibility_version" : "6.8.0",
            "minimum_index_compatibility_version" : "6.0.0-beta1"
        },
        "tagline" : "You Know, for Search"
    }

So in short you have two options to interface with elasticsearch:

- curl
- kibana

They both result in making a web request to the elasticsearch cluster.

Elasticsearch Basics
====================

Meta Data Requests
------------------

.. sourcecode:: console

    GET /

.. sourcecode:: console

    GET /_cat

.. sourcecode:: console
    :caption: output

    =^.^=
    /_cat/allocation
    /_cat/shards
    /_cat/shards/{index}
    /_cat/master
    /_cat/nodes
    /_cat/tasks
    /_cat/indices
    /_cat/indices/{index}
    /_cat/segments
    /_cat/segments/{index}
    /_cat/count
    /_cat/count/{index}

    ... trimmed ...

.. sourcecode:: console

    GET /_cat/nodes

.. sourcecode:: console
    :caption: output

    172.29.0.3 26 24 4 1.29 0.94 0.65 dilmrt * e5f4faac973f

.. sourcecode:: console

    GET /_cat/indices

.. sourcecode:: console
    :caption: output

    green open .kibana-event-log-7.9.3-000001 F3GgrQ8JSpylaZcybsMThQ 1 0  1   0   5.5kb   5.5kb
    green open .apm-custom-link               NsolNevvSCuZQfJz9owKYg 1 0  0   0    208b    208b
    green open .kibana_task_manager_1         movhn2pQROa5pbfvGCvr4w 1 0  6 132 107.3kb 107.3kb
    green open .apm-agent-configuration       MokgJm7kQJCH0hAk6zXdxA 1 0  0   0    208b    208b
    green open .kibana_1                      Zy0BoXDoSOyw8q7hYe0UAA 1 0 19   5  10.4mb  10.4mb

Create
------

Before we create documents, we will have to create an index for our documents. Let's create a new index called teams.

.. sourcecode:: console

    PUT /teams
    { 
      "settings": {
        "index": {
          "number_of_shards": 2,
          "number_of_replicas": 1
        }
      }
   }
   
.. sourcecode:: console
    :caption: output

    {
    "acknowledged" : true,
    "shards_acknowledged" : true,
    "index" : "teams"
    }

When you add a document to an index it's called indexing a document. Indexing is slightly different than creating a record in a relational database. Indexing creates the document, and makes it fully searchable, which is more memory intensive, and slower than simply creating a record in a database. This allows the document in Elasticsearch to be searched fully, and very quickly. Elasticsearch is Near Realtime which means when we index a new document, it is searchable almost immediately.

Now let's index some MLB teams as documents on the ``/teams`` index.

First the St. Louis Cardinals.

.. sourcecode:: console

    POST /teams/_doc/1
    {
      "city": "St. Louis",
      "name": "Cardinals",
      "league": "National"
    }

.. sourcecode:: console
    :caption: output

    {
    "_index" : "teams",
    "_type" : "_doc",
    "_id" : "1",
    "_version" : 1,
    "result" : "created",
    "_shards" : {
        "total" : 2,
        "successful" : 1,
        "failed" : 0
    },
    "_seq_no" : 0,
    "_primary_term" : 1
    }


The Washington Nationals.

.. sourcecode:: console
   :caption: POST /teams/_doc/2

   POST /teams/_doc/2
   {
      "city": "Washington",
      "name": "Nationals",
      "league": "National"
   }

.. sourcecode:: console
    :caption: output

    {
    "_index" : "teams",
    "_type" : "_doc",
    "_id" : "2",
    "_version" : 1,
    "result" : "created",
    "_shards" : {
        "total" : 2,
        "successful" : 1,
        "failed" : 0
    },
    "_seq_no" : 1,
    "_primary_term" : 1
    }


Finally, the Chicago Cubs.

.. sourcecode:: console
   :caption: POST /teams/_doc/3

   POST /teams/_doc/3 
   {
       "city": "Chicago",
       "name": "Cubs",
       "league": "National"
   }

.. sourcecode:: console
    :caption: output

    {
    "_index" : "teams",
    "_type" : "_doc",
    "_id" : "3",
    "_version" : 1,
    "result" : "created",
    "_shards" : {
        "total" : 2,
        "successful" : 1,
        "failed" : 0
    },
    "_seq_no" : 2,
    "_primary_term" : 1
    }

Read
----

Let's rerun that command from earlier to check on the indices associated with this cluster.

.. sourcecode:: console

    GET /_cat/indices

.. sourcecode:: console
    :caption: output

    green  open .kibana-event-log-7.9.3-000001 F3GgrQ8JSpylaZcybsMThQ 1 0  1   0  5.5kb  5.5kb
    yellow open teams                          3H0gwUatQaOC7rHfYXkjRQ 2 1  3   0  5.4kb  5.4kb
    green  open .apm-custom-link               NsolNevvSCuZQfJz9owKYg 1 0  0   0   208b   208b
    green  open .kibana_task_manager_1         movhn2pQROa5pbfvGCvr4w 1 0  6 168 79.1kb 79.1kb
    green  open .apm-agent-configuration       MokgJm7kQJCH0hAk6zXdxA 1 0  0   0   208b   208b
    green  open .kibana_1                      Zy0BoXDoSOyw8q7hYe0UAA 1 0 21   8 10.4mb 10.4mb

Let's read these documents from Elasticsearch.

.. sourcecode:: console
   :caption: GET /teams/_doc/1

   GET /teams/_doc/1

.. sourcecode:: console
    :caption: output

    {
    "_index" : "teams",
    "_type" : "_doc",
    "_id" : "1",
    "_version" : 1,
    "_seq_no" : 0,
    "_primary_term" : 1,
    "found" : true,
    "_source" : {
        "city" : "St. Louis",
        "name" : "Cardinals",
        "league" : "National"
    }
    }

.. sourcecode:: console
   :caption: GET /teams/_doc/2

   GET /teams/_doc/2

.. sourcecode:: console
    :caption: output

    {
    "_index" : "teams",
    "_type" : "_doc",
    "_id" : "2",
    "_version" : 1,
    "_seq_no" : 1,
    "_primary_term" : 1,
    "found" : true,
    "_source" : {
        "city" : "Washington",
        "name" : "Nationals",
        "league" : "National"
    }
    }


.. sourcecode:: console
   :caption: GET /teams/_doc/3

   GET /teams/_doc/3

.. sourcecode:: console
    :caption: output

    {
    "_index" : "teams",
    "_type" : "_doc",
    "_id" : "3",
    "_version" : 1,
    "_seq_no" : 2,
    "_primary_term" : 1,
    "found" : true,
    "_source" : {
        "city" : "Chicago",
        "name" : "Cubs",
        "league" : "National"
    }
    }

Update
------

Let's update one of these documents. The ``"city"`` key for our 2nd document currently is valued as ``"Washington"``. This can cause confusion for people that don't know the Washington Nationals are in Washington D.C. Let's update this record with a new ``"city"`` name.

.. sourcecode:: console

    POST /teams/_update/2
    {
        "doc": {
            "city": "Washington D.C"
        }
    }

.. sourcecode:: console
    :caption: output

    {
    "_index" : "teams",
    "_type" : "_doc",
    "_id" : "2",
    "_version" : 4,
    "result" : "updated",
    "_shards" : {
        "total" : 2,
        "successful" : 1,
        "failed" : 0
    },
    "_seq_no" : 5,
    "_primary_term" : 1
    }

One of the differences between a relational database (PSQL) and a non-relational database (Elasticsearch) is how records/documents are updated. In a relational database the field is simply changed. In a non-relational database the entire document is deleted, and reindexed. This makes every update far more resource intensive than an update in a relational database.

Let's see this change.

.. sourcecode:: console

    GET /teams/_doc/2
    
.. sourcecode:: console
    :caption: output

    {
    "_index" : "teams",
    "_type" : "_doc",
    "_id" : "2",
    "_version" : 4,
    "_seq_no" : 5,
    "_primary_term" : 1,
    "found" : true,
    "_source" : {
        "city" : "Washington D.C",
        "name" : "Nationals",
        "league" : "National"
    }
    }
    
Delete
------

Let's delete a document.

.. sourcecode:: console

    DELETE /teams/_doc/3

.. sourcecode:: console
    :caption: output

    {
    "_index" : "teams",
    "_type" : "_doc",
    "_id" : "3",
    "_version" : 2,
    "result" : "deleted",
    "_shards" : {
        "total" : 2,
        "successful" : 1,
        "failed" : 0
    },
    "_seq_no" : 6,
    "_primary_term" : 1
    }    

Let's query that document again to make sure it's gone.

.. sourcecode:: console

    GET /teams/_doc/3

.. sourcecode:: console
    :caption: output

    {
    "_index" : "teams",
    "_type" : "_doc",
    "_id" : "3",
    "found" : false
    }

I think we all feel better now that the Cubs have been deleted!

Elasticsearch Search API
========================

Setup
-----

Before we can start exploring the Search API, we need more data. In the ``elasticsearch-kibana-starter`` folder you cloned earlier you should find a few scripts. We will be running ``baseball-teams.sh``:

.. sourcecode:: console

    bash baseball-teams.sh

You should see a bunch of output as each team is created.

Let's make sure the script ran succesfully by counting the number of teams in the index:

.. sourcecode:: console

    GET /teams/_count

.. sourcecode:: console

    {
    "count" : 30,
    "_shards" : {
        "total" : 2,
        "successful" : 2,
        "skipped" : 0,
        "failed" : 0
    }
    }

We should have a total of 30 documents stored within the ``/teams`` index.

So far Elasticsearch functions very similarly to PSQL. How do we leverage some the advantages of Elasticsearch?

We do this through the Elasticsearch Search API!

We will be writing our Elasticsearch queries by making GET requests: ``GET /teams/_search``

We can access the ``_search`` API by using query parameters, or by including JSON that describes the query to be made.

Match All Documents in Index
----------------------------

.. sourcecode:: console

    GET /teams/_search

.. sourcecode:: console
    :caption: output

    {
    "took" : 1,
    "timed_out" : false,
    "_shards" : {
        "total" : 2,
        "successful" : 2,
        "skipped" : 0,
        "failed" : 0
    },
    "hits" : {
        "total" : {
        "value" : 30,
        "relation" : "eq"
        },
        "max_score" : 1.0,
        "hits" : [
        {
            "_index" : "teams",
            "_type" : "_doc",
            "_id" : "ks38JnYBsXlZ1fuSR5PV",
            "_score" : 1.0,
            "_source" : {
            "city" : "Toronto",
            "country" : "Canada",
            "state" : "Ontario",
            "name" : "Blue Jays",
            "league" : "American",
            "division" : "East",
            "world_series_champions" : 2
            }
        },

    ... trimmed ...

Another way of writing this would be:

.. sourcecode:: console

    GET /teams/_search
    {
        "query": { "match_all": {} }   
    }

.. sourcecode:: console
    :caption: output

    {
    "took" : 1,
    "timed_out" : false,
    "_shards" : {
        "total" : 2,
        "successful" : 2,
        "skipped" : 0,
        "failed" : 0
    },
    "hits" : {
        "total" : {
        "value" : 30,
        "relation" : "eq"
        },
        "max_score" : 1.0,
        "hits" : [
        {
            "_index" : "teams",
            "_type" : "_doc",
            "_id" : "ks38JnYBsXlZ1fuSR5PV",
            "_score" : 1.0,
            "_source" : {
            "city" : "Toronto",
            "country" : "Canada",
            "state" : "Ontario",
            "name" : "Blue Jays",
            "league" : "American",
            "division" : "East",
            "world_series_champions" : 2
            }
        },
    ... trimmed ...

These queries only return 10 results. Looking at the `documentation for From/Size <https://www.elastic.co/guide/en/elasticsearch/reference/6.5/search-request-from-size.html>`_ to learn about Pagination.

We can configure how many results are returned with the From, and Size request parameters.

.. sourcecode:: console

    GET /teams/_search
    {
        "from": 0,
        "size": 30,
        "query": { "match_all": {} }
    }

.. sourcecode:: console
    :caption: output

    {
    "took" : 0,
    "timed_out" : false,
    "_shards" : {
        "total" : 2,
        "successful" : 2,
        "skipped" : 0,
        "failed" : 0
    },
    "hits" : {
        "total" : {
        "value" : 30,
        "relation" : "eq"
        },
    ... trimmed ...

We can also control the results of the document source. For example if we only wanted the city, and name from each document:

.. sourcecode:: console
   :caption: GET /teams/_search

   GET /teams/_search
   {
       "from": 0,
       "size": 30,
       "_source": ["city", "name"],
       "query": { "match_all": {} }
   }

.. sourcecode:: console
    :caption: output

    {
    "took" : 1,
    "timed_out" : false,
    "_shards" : {
        "total" : 2,
        "successful" : 2,
        "skipped" : 0,
        "failed" : 0
    },
    "hits" : {
        "total" : {
        "value" : 30,
        "relation" : "eq"
        },
        "max_score" : 1.0,
        "hits" : [
        {
            "_index" : "teams",
            "_type" : "_doc",
            "_id" : "ks38JnYBsXlZ1fuSR5PV",
            "_score" : 1.0,
            "_source" : {
            "city" : "Toronto",
            "name" : "Blue Jays"
            }
        },
    ... trimmed ...

Match Documents by Field
------------------------

Elasticsearch gives us even more control of our searches with the ``"match"`` query.

Match String
^^^^^^^^^^^^

Let's match all the teams in the National league.

.. sourcecode:: console
   :caption: GET /teams/_search

   GET /teams/_search
   {
       "from": 0,
       "size": 15,
       "query": { "match": { "league": "National" } }
   }

.. sourcecode:: console
    :caption: output

    {
    "took" : 2,
    "timed_out" : false,
    "_shards" : {
        "total" : 2,
        "successful" : 2,
        "skipped" : 0,
        "failed" : 0
    },
    "hits" : {
        "total" : {
        "value" : 15,
        "relation" : "eq"
        },
    ... trimmed ...

Match Phrase
^^^^^^^^^^^^

Let's match all teams in the city "St. Louis"

.. sourcecode:: console
   :caption: GET /teams/_search

   GET /teams/_search
   {
       "query": { "match_phrase": { "city": "St. Louis" } }
   }

.. sourcecode:: console
    :caption: output

    {
    "took" : 1,
    "timed_out" : false,
    "_shards" : {
        "total" : 2,
        "successful" : 2,
        "skipped" : 0,
        "failed" : 0
    },
    "hits" : {
        "total" : {
        "value" : 1,
        "relation" : "eq"
        },
        "max_score" : 3.9303184,
        "hits" : [
        {
            "_index" : "teams",
            "_type" : "_doc",
            "_id" : "p838JnYBsXlZ1fuSSJPw",
            "_score" : 3.9303184,
            "_source" : {
            "city" : "St. Louis",
            "country" : "United States",
            "state" : "Missouri",
            "name" : "Cardinals",
            "league" : "National",
            "division" : "Central",
            "world_series_champions" : 11
            }
        }
        ]
    }
    }

Match Or
^^^^^^^^

Let's match all teams in state "Illinois" or "Missouri"

.. sourcecode:: console
   :caption: GET /teams/_search

   GET /teams/_search
   {
       "query": { "match": { "state": "Illinois Missouri" } }
   }

.. sourcecode:: console
    :caption: output

    {
    "took" : 0,
    "timed_out" : false,
    "_shards" : {
        "total" : 2,
        "successful" : 2,
        "skipped" : 0,
        "failed" : 0
    },
    "hits" : {
        "total" : {
        "value" : 4,
        "relation" : "eq"
    },    
    ... trimmed ...

When we use ``match`` instead of ``match_phrase`` Elasticsearch searches for both individual words and returns any document that matches either term.

This can be a little ambiguous, you can create a more explicit query by creating a ``boolQuery``.

.. sourcecode:: console
   :caption: GET /teams/_search

   GET /teams/_search
   {
       "query": {
           "bool": {
               "should": [
                   { "match": { "state": "Illinois" } },
                   { "match": { "state": "Missouri" } }
               ]
           }
       }
   }

.. sourcecode:: console
    :caption: output

    {
    "took" : 0,
    "timed_out" : false,
    "_shards" : {
        "total" : 2,
        "successful" : 2,
        "skipped" : 0,
        "failed" : 0
    },
    "hits" : {
        "total" : {
        "value" : 4,
        "relation" : "eq"
    },
    ... trimmed ...

Match And
^^^^^^^^^

Let's match all teams in "Florida" and in "Miami". We will do this by creating another ``boolQuery``.

.. sourcecode:: console
   :caption: GET /teams/_search

   GET /teams/_search
   {
       "query": {
           "bool": {
               "must": [
                   { "match": { "state": "Florida" } },
                   { "match": { "city": "Miami" } }
               ]
           }
       }
   }

.. sourcecode:: console
    :caption: output

    {
    "took" : 0,
    "timed_out" : false,
    "_shards" : {
        "total" : 2,
        "successful" : 2,
        "skipped" : 0,
        "failed" : 0
    },
    "hits" : {
        "total" : {
        "value" : 1,
        "relation" : "eq"
        },
        "max_score" : 5.177124,
        "hits" : [
        {
            "_index" : "teams",
            "_type" : "_doc",
            "_id" : "os38JnYBsXlZ1fuSSJO1",
            "_score" : 5.177124,
            "_source" : {
            "city" : "Miami",
            "country" : "United States",
            "state" : "Florida",
            "name" : "Marlins",
            "league" : "National",
            "division" : "East",
            "world_series_champions" : 2
            }
        }
        ]
    }
    }

In this case the ``boolQuery`` has a ``"must"`` statement which operates like an AND statement in SQL. The previous examples used a ``"should"`` statement which operates like an OR statement in SQL.

A  ``boolQuery`` can be include as many ``"must"``, ``"should"``, ``"match"``, ``"match_phrase"``, etc as is necessary for the query.

Elasticsearch Fuzzy Search
==========================

Elasticsearch also allows fuzzy searches. This gives us the ability to set the fuzziness factor, and Elasticsearch will match words, or phrases that are within the fuzziness factor of the query term.

.. sourcecode:: console
   :caption: GET /teams/_search

   GET /teams/_search
   {
       "query": {
           "fuzzy": { "name": "Damondbacks" }
       }
   }

.. sourcecode:: console
    :caption: output

    {
    "took" : 15,
    "timed_out" : false,
    "_shards" : {
        "total" : 2,
        "successful" : 2,
        "skipped" : 0,
        "failed" : 0
    },
    "hits" : {
        "total" : {
        "value" : 1,
        "relation" : "eq"
        },
        "max_score" : 2.07845,
        "hits" : [
        {
            "_index" : "teams",
            "_type" : "_doc",
            "_id" : "rs38JnYBsXlZ1fuSSZM9",
            "_score" : 2.07845,
            "_source" : {
            "city" : "Phoenix",
            "country" : "United States",
            "state" : "Arizona",
            "name" : "Diamondbacks",
            "league" : "National",
            "division" : "West",
            "world_series_champions" : 1
            }
        }
        ]
    }
    }

Despite omitting a letter from "Diamondbacks" fuzzy search was still able to make the match happen!

We can manually set the fuzziness factor in a fuzzy search, from 0 edits, to 2 edits.

.. sourcecode:: console
   :caption: GET /teams/_search

   GET /teams/_search
   {
       "query": {
           "fuzzy": {
               "name": {
                   "value": "Damondbacks",
                   "fuzziness": 0
               }
           }
       }
   }

.. sourcecode:: console
    :caption: output

    {
    "took" : 0,
    "timed_out" : false,
    "_shards" : {
        "total" : 2,
        "successful" : 2,
        "skipped" : 0,
        "failed" : 0
    },
    "hits" : {
        "total" : {
        "value" : 0,
        "relation" : "eq"
        },
        "max_score" : null,
        "hits" : [ ]
    }
    }

.. sourcecode:: console
   :caption: GET /teams/_search

   GET /teams/_search
   {
       "query": {
           "fuzzy": {
               "name": {
                   "value": "Diamandbacks",
                   "fuzziness": 1
               }
           }
       }
   }

.. sourcecode:: console
    :caption: output

    {
    "took" : 0,
    "timed_out" : false,
    "_shards" : {
        "total" : 2,
        "successful" : 2,
        "skipped" : 0,
        "failed" : 0
    },
    "hits" : {
        "total" : {
        "value" : 0,
        "relation" : "eq"
        },
        "max_score" : null,
        "hits" : [ ]
    }
    }

.. sourcecode:: console
   :caption: GET /teams/_search

   GET /teams/_search
   {
       "query": {
           "fuzzy": {
               "name": {
                   "value": "Damondbacks",
                   "fuzziness": 2
               }
           }
       }
   }

.. sourcecode:: console
    :caption: output

    {
    "took" : 4,
    "timed_out" : false,
    "_shards" : {
        "total" : 2,
        "successful" : 2,
        "skipped" : 0,
        "failed" : 0
    },
    "hits" : {
        "total" : {
        "value" : 1,
        "relation" : "eq"
        },
        "max_score" : 2.07845,
        "hits" : [
        {
            "_index" : "teams",
            "_type" : "_doc",
            "_id" : "rs38JnYBsXlZ1fuSSZM9",
            "_score" : 2.07845,
            "_source" : {
            "city" : "Phoenix",
            "country" : "United States",
            "state" : "Arizona",
            "name" : "Diamondbacks",
            "league" : "National",
            "division" : "West",
            "world_series_champions" : 1
            }
        }
        ]
    }
    }

Conclusion
==========

Elasticsearch is a powerful data storage system. Although Elasticsearch has some disadvantages that make it an unlikely candidate for a primary data storage solution, it's highly flexible, fast, and configurable searches make it an ideal choice as a secondary data storage solution.

We have only scratched the surface on what Elasticsearch can do. In our next class we will continue learning about Elasticsearch, and how to configure our Spring web applications to use Elasticsearch.

To learn more check out the `Elasticsearch documentation <https://www.elastic.co/guide/en/elasticsearch/reference/6.5/index.html>`_.
