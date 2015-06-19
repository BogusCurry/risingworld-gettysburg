
function addToSet(set, key)
  set[key] = true
end

function delFromSet(set, key)
  set[key] = nil
end

function setHas(set, key)
  return set[key] ~= nil
end

-- readPropertiesFile
function readPropertiesFile(filename)
  serverLog("Reading properties of " .. filename)
  local content = FileUtils:readFromFile(filename)
  property = {}
  for line in content:gmatch("[^\r\n]+") do
    local key, value = string.match(line,"(.-)=(.-)$")
    if key ~= nil then
      serverLog(" " .. key .. " = " .. value)
      property[key] = value
    end
  end
  return property
end

function strjoin(delimiter, list)
  local len = #list
  if len == 0 then 
    return "" 
  end
  local string = list[1]
  for i = 2, len do 
    string = string .. delimiter .. list[i] 
  end
  return string
end

function strsplit(sep, text)
  local t = {}
  for match in text:gmatch("([^" .. sep .. "]+)") do
    t[#t+1] = match
  end
  return t
end