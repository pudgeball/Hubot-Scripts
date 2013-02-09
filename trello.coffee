userMaps =
    sayed: 'sorter'
    nickmcguire: '@nickmcguire'

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

    # return all open cards assigned to me
    robot.respond /list orders$/, (msg) ->
        irc_user = msg.message.user.name
        if irc_user of userMaps
            trello_instance.get "/1/organizations/easytag", boards: 'open', (err, data) ->
                if err == null
                    boards = data.boards
                    board_ids = (b.id for b in boards)
                    msg.reply "#{board_ids}"
                    for bid in board_ids
                        trello_instance.get "/1/boards/#{b_id}", filter: open, (err, data) ->
                            if err == null
                                msg.reply "#{Object.keys(data)}"
                            else
                                msg.reply "#{err}"
        
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
