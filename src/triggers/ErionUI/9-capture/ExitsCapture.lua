
local exits = {
  north = '',
  east = '',
  south = '',
  west = '',
  up = '',
  down = ''
}

debugc(matches.EXT)
for dir in matches.EXT:gmatch("%??%w+") do
  debugc(dir)
  if dir:sub(1,1) == '?' then
    exits[dir:sub(2)] = "unknown"
  else
    exits[dir] = "known"
  end
end

erion.data.location:update({
  exits = exits
})
deleteLine()
