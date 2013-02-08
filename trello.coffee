userMaps =
    sayed: 'sorter'
    nickmcguire: '@nickmcguire'

key = ""
token = ""

fs = require 'fs'
fs.readFile '/opt/hubotIRC', 'utf-8', (err,data)->
    key = data

trello = require 'node-trello'
trello_instance = new trello

module.exports = (robot) ->
    robot.respond /REPORT!$/, (msg) ->
        irc_user = msg.message.user.name
        msg.reply "Status report, #{irc_user}"

    robot.respond /identify$/, (msg) ->
        irc_user = msg.message.user.name
        if userMaps[irc_user]
            msg.reply "irc user: #{irc_user} identified as #{userMaps[irc_user]}"
        else
            msg.reply "could not identify"

    robot.respond /_DEBUG$/, (msg) ->
        msg.reply "#{key}"
