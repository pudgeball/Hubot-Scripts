module.exports = (robot) ->
    robot.respond /REPORT$/, (msg) ->
        irc_user = msg.message.user.name
        msg.reply "Status report, #{irc_user}"
