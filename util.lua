
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
  local content = FileUtils:readFromFile(filename);
  property = {};
  for line in content:gmatch("[^\r\n]+") do
    local key, value = string.match(line,"(.-)=(.-)$");
    if key ~= nil then
      property[key] = value;
    end
  end
  return property;
end
