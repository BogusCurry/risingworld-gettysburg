
-- Includes
include("util.lua");
include("log.lua");
include("db.lua");
include("gui.lua");
include("player.lua");
include("command.lua");
include("food.lua");

-- Global variables
database = getDatabase();
server = getServer();
world = getWorld();
serverConfig = readPropertiesFile("server.properties");

-- Setup plugin
function onEnable()
  serverLog("Supreme Management booting...");
  gbInitDb();
  serverLog("Supreme Management loaded!");
end

-- Destructor (When is this called at all?)
function onDisable()
  serverLog("Supreme Management stopped!");
end
