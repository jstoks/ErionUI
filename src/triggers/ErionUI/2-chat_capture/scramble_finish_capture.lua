selectCurrentLine()
local line = copy2decho()
deleteLine()

raiseEvent('erion.chat.line', 'SCRAMBLE', line)
