
addEvent("PlayerCommand", function(event)

  -- Split the command string
  local cmd = StringUtils:explode(event.command, " ");
  
  if #cmd >= 1 then
    cmd[1] = string.lower(cmd[1]);

    if cmd[1] == "/info" then



    end

--
--     ___       __          _
--    /   | ____/ /___ ___  (_)___
--   / /| |/ __  / __ `__ \/ / __ \
--  / ___ / /_/ / / / / / / / / / /
-- /_/  |_\__,_/_/ /_/ /_/_/_/ /_/
--

    if event.player:isAdmin() == false then
      return;
    end

    if cmd[1] == "/createrealm" then

      database:queryupdate([[
        INSERT INTO realms ('creator_id')
          VALUES (']] .. event.player:getDBID() .. [[');
      ]]);

      local newRealmId = database:getLastInsertID();
      event.player:setAttribute("creatingRealmID",newRealmId);

    elseif cmd[1] == "/expandrealm" then

      local currentRealmId = event.player:getAttribute("currentRealmId");
      event.player:setAttribute("creatingRealmID",currentRealmId);

    end

  end

end);
