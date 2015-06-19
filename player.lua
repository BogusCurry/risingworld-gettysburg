
addEvent("PlayerConnect", function(event)
  gbInitPlayerGui(event.player)
end)

addEvent("PlayerSpawn", function(event)
  sendWelcomeMessage(event.player)
end)

addEvent("PlayerChangePosition", function(event)

  local player = event.player
  local chunkPos = Vector3i.new()
  local blockPos = Vector3i.new()

  ChunkUtils:getChunkAndBlockPosition(event.position, chunkPos, blockPos)

  player:setAttribute("chunkPos", chunkPos)
  player:setAttribute("blockPos", blockPos)
  player:getAttribute("posLabel"):setText(
    "[" .. chunkPos.x .. "/" .. chunkPos.y .. "/" .. chunkPos.z .. "] " ..
    "[" .. blockPos.x .. "/" .. blockPos.y .. "/" .. blockPos.z .. "]"
  );

end);

-- addEvent("PlayerEnterChunk", function(event)

--   local oldX = event.oldChunk.x;
--   local oldY = event.oldChunk.y;
--   local oldZ = event.oldChunk.z;

--   local newX = event.newChunk.x;
--   local newY = event.newChunk.y;
--   local newZ = event.newChunk.z;

--   local currentRealmId = event.player:getAttribute("currentRealmId");

--   if currentRealmId ~= nil then

--     database:queryupdate([[
--       INSERT INTO realmchunks ('creator_id','x','z')
--         VALUES (
--           ]] .. event.player:getDBID() .. [[,
--           ]] .. newX .. [[,
--           ]] .. newZ .. [[
--         );
--     ]]);

--   end

-- );
-- 