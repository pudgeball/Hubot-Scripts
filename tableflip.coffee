module.exports = (robot) ->
        robot.respond /tableflip/i, (msg) ->
                tableflip = "(╯°□°）╯︵ ┻━┻"
                msg.send tableflip