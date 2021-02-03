---
title: "Mapnotes Api"
date: 2021-02-02T20:31:55Z
summary: ""
# TODO: check if categories work for search

# TODO: add/remove tags before committing
categories: ["projects"]
tags: ["api", "gis"]
---

<!-- 
language specific implementation requirements / overview
 -->

# Overview

Currently our Client consumes a Map Notes service that was provided for us. This project week we will be building our own Map Notes API.

# Functional Requirements

This API project will require you to adhere to the RESTful specification below as well as general API requirements.

## API Specification

The Map Notes API endpoints:

<!-- TODO: convert to table -->

- `GET /notes -> (Note[]) 200`
- `POST /notes ({title, body}) -> (Note) 201`
- `GET /notes/{id} -> (Note) 200`
- `DELETE /notes/{id} -> 204`
- `GET /notes/{id}/features -> (GeoJSON feature collection) 200`
- `PUT /notes/{id}/features (GeoJSON feature collection) -> 201`

## API Requirements

- All endpoint conclusions must have passing integration tests
- Any request that contains a path variable that doesn't exist in the database must return a 404 status code
- Geospatial data must adhere to the GeoJSON specification
- DTOs must be used for incoming and outgoing JSON representations
- API data must be persisted to a database

# Implementations

Refer to the course schedule for which implementation to follow.

- [Java/Spring]({{< ref "java/" >}})
