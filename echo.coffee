module.exports = (robot) ->
    robot.respond /echo/, (msg) ->
        msg.reply "I'm sorry #{msg.message.user.name}, I'm afraid I can't do that"