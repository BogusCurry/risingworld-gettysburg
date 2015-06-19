
-- Includes
include("util.lua")
include("log.lua")
include("db.lua")
include("gui.lua")
include("player.lua")
include("command.lua")
include("food.lua")

-- Global variables
database = getDatabase()
server = getServer()
world = getWorld()
serverConfig = readPropertiesFile("server.properties")
gbConfig = readPropertiesFile("gettysburg.properties")
supremeLeader = gbConfig.supreme_leader

-- Setup plugin
function onEnable()
  serverLog("Supreme Management booting...")
  gbLoadConfig()
  gbInitDb()
  gbInitGui()
  serverLog("Supreme Management loaded!")
end

-- Destructor (When is this called at all?)
function onDisable()
  serverLog("Supreme Management stopped!")
end

function gbLoadConfig()

  fontColor       = tonumber(gbConfig.color_font or gbConfig.colour_font) or 0xFFCC00CC
  secFontColor    = tonumber(gbConfig.color_secfont or gbConfig.colour_secfont) or 0x3399FFAA
  borderColor     = tonumber(gbConfig.color_border or gbConfig.colour_border) or 0xCCCCCCCC
  backgroundColor = tonumber(gbConfig.color_background or gbConfig.colour_background) or 0x003366CC

end