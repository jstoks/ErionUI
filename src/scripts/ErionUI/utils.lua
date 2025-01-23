--Just functions I may need to call

--Rounidng Function
  function round(x, n)
    n = math.pow(10, n or 0)
    x = x * n
    if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
    return x / n
  end
  
-- Suffix a number with px
function px(num)
  return num .. 'px'
end

-- join strings with hyphen
function dash(...)
  return table.concat(arg, '-')
end

function dot(...)
  return table.concat(arg, '.')
end

function undot(str)
  local result = nil;
  for part in string.gmatch(str, "[%w_-]+") do
    result = part
  end
  return result or str
end

function splitLine(str, limit)
  if str == nil then
    return ''
  end

  if str:len() < limit then
    return str
  end

  local words = str:split(' ')

  local line = ''
  local i = 1
  while line:len() < limit / 2 do
    line = line .. words[i] .. ' '
    i = i + 1
  end

  line = line:trim() .. "\n"
  while i <= #words do
    line = line .. words[i] .. ' '
    i = i + 1
  end

  return line:trim()
end
