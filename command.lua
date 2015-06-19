
addEvent("PlayerCommand", function(event)

  local player = event.player
  local args = strsplit("\s+", event.command)
  local command_arg = table.remove(args)
  local cmd = string.lower(command_arg)

  if cmd == nil then
    serverLog("No command found on: [" .. event.command .. "]")
    return
  end

  if cmd == "info" or cmd == "i" then

    player:sendTextMessage("[#0000FF]" .. rest)
    player:sendTextMessage("[#0000FF]Long text Long text Long text")
    player:sendTextMessage("[#0000FF]Long text Long text Long text Long text Long text ")

  elseif cmd == "welcome" then

    sendWelcomeMessage(player)

  end

--
--     ___       __          _
--    /   | ____/ /___ ___  (_)___
--   / /| |/ __  / __ `__ \/ / __ \
--  / ___ / /_/ / / / / / / / / / /
-- /_/  |_\__,_/_/ /_/ /_/_/_/ /_/
--

  if player:isAdmin() == false then
    return
  end

  if cmd == "createrealm" or cmd == "cr" then

    player:setAttribute("creatingRealmID",database:insertRealm(player))

  elseif cmd == "expandrealm" or cmd == "er" then

    player:setAttribute("creatingRealmID",player:getAttribute("currentRealmId"))

  elseif cmd == "cancelcreaterealm" or cmd == "ccr" then

    player:setAttribute("creatingRealmID",nil)

  end

end)
