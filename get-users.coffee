#!/usr/bin/env coffee
fs = require 'fs'
utils = require './utils'

saveTopLogins = ->
  MAX_PAGES = 10
  urls = utils.range(1, MAX_PAGES + 1).map (page) -> [
      "https://api.github.com/orgs/NIFTYCloud/members?per_page=100"
      "&page=#{page}"
    ].join('')

  parse = (text) ->
    JSON.parse(text).map (_) -> _.login

  utils.batchGet urls, parse, (all) ->
    logins = [].concat.apply [], all
    utils.writeStats './temp-logins.json', logins

saveTopLogins()
