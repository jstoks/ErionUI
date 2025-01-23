selectCurrentLine()
local line = copy2decho()
deleteLine()

raiseEvent('erion.chat.line', line, 'Games')
