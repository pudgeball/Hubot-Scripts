userMaps =
    sayed: sorter
    nickmcguire: @nickmcguire

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
