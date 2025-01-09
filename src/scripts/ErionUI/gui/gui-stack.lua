GuiStack = GuiStack or {}

GuiStack.parentStyles = {
  title = Geyser.StyleSheet:new({
    ['border-width'] = "0 0 1px 0",
    ['border-style'] = "dotted",
    ['border-color'] = "white",
    ['margin'] = "0px",
    ['padding'] = "0 0 1px 0",
    ['qproperty-align'] = "AlignBottom",
    ['font-weight'] = "bold",
    ['font'] = '11px "Bitstream Vera Sans Mono"',
  }),

  label = Geyser.StyleSheet:new({
    ['margin'] = "0px",
    ['padding'] = "0px",
    ['background-color'] = "rgba(0,0,0,100%)",
    ['font'] = '11px "Bitstream Vera Sans Mono"',
  })
}

GuiStack.parentStyles.value = Geyser.StyleSheet:new({
  ['qproperty-alignment'] = "AlignRight",
}, GuiStack.parentStyles.label)

function GuiStack:new(name, title, container) 
  local stack = {
    data = {},
    box = Geyser.VBox:new({
      x = 0, y = 0,
      width = "100%", height = "100%",
      name = dash(container.name, name),
      scrollBar = false,
      wrap = false,
      padding = 0,
      stylesheet = Geyser.StyleSheet:new({
        padding = "0px",
        margin = "0px",
        border = "0",
      }):getCSS(),
    }, container),
    rowHeight = 10,
  }
  self.__index = self
  setmetatable(stack, self)

  local title = Geyser.Label:new({
    name = dash(stack.box.name, 'title'),
    message = title,
    width = "100%", height = px(stack.rowHeight),
    fontSize = px(stack.rowHeight),
    stylesheet = self.parentStyles.title:getCSS(),
  }, stack.box)

  return stack
end

function GuiStack:addRow(name, heading)
  self.data[name] = {
    heading = heading, value = nil
  }

  local prefix = dash(self.box.name, name)
  local height = px(self.rowHeight);

  local rowBox = Geyser.HBox:new({
    name = dash(prefix, 'row'),
    width = "100%", height = height,
    fontSize = height,
      padding = 0,
    stylesheet = Geyser.StyleSheet:new({
      padding = "0px",
      margin = "0px",
      border = "0",
    }):getCSS(),
  }, self.box)

  local gHeading = Geyser.Label:new({
    name = dash(prefix, 'heading'),
    message = heading,
    height = "100%", width = "40%",
      padding = 0,
    fontSize = height,
    stylesheet = self.parentStyles.label:getCSS(),
  }, rowBox)

  local gValue = Geyser.Label:new({
    name = dash(prefix, 'value'),
    message = heading,
      padding = 0,
    height = "100%", width = "60%",
    fontSize = height,
    stylesheet = self.parentStyles.value:getCSS(),
  }, rowBox)

end

