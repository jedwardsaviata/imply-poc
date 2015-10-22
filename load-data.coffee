#!/usr/bin/env coffee

_ = require 'lodash'
Q = require 'q'
moment = require 'moment'
request = require 'request'

# TODO:
# 1) Create datasource
# 2) Populate new datasource with randomly generated data

createDatasource = ->
  d = Q.defer()
  request.post '/druid/v2/datasouces/aviata', (error, result) ->
    if error
      console.log "Error creating datasource 'aviata': #{error}\n#{error.stack}"
      d.reject error
    else
      console.log "Datasource 'aviata' created successfully."
      d.resolve()
  d.promise

insertRecord = ->
  request.post '', JSON.stringify(record), (error, result) ->
    if error
      console.log "Error creating datasource 'aviata': #{error}\n#{error.stack}"
    else
      console.log "Datasource 'aviata' created successfully."
      insertRecord()

createRecord = ->
  record =
    timestamp: moment.utc().toISOString()
    iso_country: "US"
    country: "United States"
    state_short: "NM"
    state: "New Mexico"
    city: "Albuquerque"
    airport: "ABQ"
    sensor: Math.random() * 255 + 1
    channel_1: Math.random()
    channel_2: Math.random()
    channel_3: Math.random()

createDatasource()
.then ->
  insertRecord()
