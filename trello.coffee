userMaps =
    sayed: 'sorter'
    nickmcguire: '@nickmcguire'

key = ""
token = ""

fs = require 'fs'
fs.readFile '/opt/hubotIRC/scripts/trelloCreds', 'utf-8', (err,data)->
    _ = data.split ','
    key = _[0]
    token = _[1]

trello = require 'node-trello'
trello_instance = new trello key, token

module.exports = (robot) ->
    robot.respond /REPORT!$/, (msg) ->
        irc_user = msg.message.user.name
        msg.reply "Status report, #{irc_user}"

    robot.respond /identify$/, (msg) ->
        irc_user = msg.message.user.name
        if irc_user of userMaps
            msg.reply "irc user: #{irc_user} identified as #{userMaps[irc_user]}"
        else
            msg.reply "could not identify"

    robot.respond /list boards$/, (msg) ->
        trello_instance.get "/1/organizations/easytag/", { boards: "open" }, (err, data) ->
            msg.reply "#{data}"
