local channel = matches.channel

selectCurrentLine()
local line = copy2decho()
deleteLine()
deleteLine()

raiseEvent('erion.chat.line', channel, line)
