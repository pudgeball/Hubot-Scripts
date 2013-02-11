userMaps =
    sayed: 'sayedk'
    nickmcguire: 'nickmcguire'

key = ""
token = ""

fs = require 'fs'
trello = require 'node-trello'

credData = new String(fs.readFileSync '/opt/hubotIRC/scripts/trelloCreds')
_ = credData.split ','
key = _[0]
token = _[1].substr 0, _[1].length - 1
trello_instance = new trello key, token

module.exports = (robot) ->

    # return all open bugs
    robot.respond /damage report$/, (msg) ->
        trello_instance.get "/1/organizations/easytag", boards: 'open', (err, data) ->
            if err == null
                bs = data.boards
                cards = [ ]
                boardMap = {}
                for b in bs
                    boardMap[b.id] = b.name
                for b, i in bs
                    trello_instance.get "/1/boards/#{b.id}/", cards: 'open', (err, data2) ->
                        if err == null
                            #msg.reply "#{Object.keys data2.cards[0]}"
                            for c in data2.cards
                                for l in c.labels
                                    msg.reply "#{l.name.toLowerCase()}"
                                    msg.reply "#{l.name.toLowerCase().indexOf "bug"}"
                                    if l.name.toLowerCase().indexOf("bug") != -1
                                        msg.reply "#{boardMap[c.idBoard]}: #{c.name}"

    # return all open cards assigned to me
    robot.respond /list orders$/, (msg) ->
        irc_user = msg.message.user.name
        if irc_user of userMaps
            target = "/1/members/#{userMaps[irc_user]}"
            trello_instance.get target, cards: 'open', (err, data) ->
                if err == null
                    cards = data.cards
                    for c in cards
                        msg.reply "#{c.name}"
       
    robot.respond /REPORT!$/, (msg) ->
        irc_user = msg.message.user.name
        msg.reply "Status report, #{irc_user}"

    robot.respond /list boards$/, (msg) ->
        trello_instance.get "/1/organizations/easytag/", boards: 'open', (err, data) ->
            if err == null
                boards = data.boards
                for b in boards
                    msg.reply b.name

    robot.respond /identify$/, (msg) ->
        irc_user = msg.message.user.name
        if irc_user of userMaps
            msg.reply "irc user: #{irc_user} identified as #{userMaps[irc_user]}"
        else
            msg.reply "could not identify"
