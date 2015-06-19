
noRealm = "Wasteland"
noSub = "Bla"
billboards = {}

-- Load gui
function gbInitGui()

end

-- Add gui to Player
function gbInitPlayerGui(player)

  local realmLabel = Gui:createLabel(noRealm, 0.05, 0.085);
  realmLabel:setFontColor(secFontColor);
  realmLabel:setFontsize(30);
  realmLabel:setPivot(0);
  player:setAttribute("realmLabel", realmLabel);
  player:addGuiElement(realmLabel);

  local subLabel = Gui:createLabel(noSub, 0.05, 0.065);
  subLabel:setFontColor(fontColor)
  subLabel:setFontsize(30)
  subLabel:setPivot(0)
  player:setAttribute("subLabel", subLabel)
  player:addGuiElement(subLabel)

  local posLabel = Gui:createLabel("", 0.05, 0.050);
  posLabel:setFontColor(borderColor)
  posLabel:setFontsize(20)
  posLabel:setPivot(0)
  player:setAttribute("posLabel", posLabel)
  player:addGuiElement(posLabel)

end

function setRealmLabel(player, text)

  if text == nil then
    text = noRealm
  end
  local realmLabel = player:getAttribute("realmLabel")
  realmLabel:setText(text)

end

function setSubLabel(player, text)

  if text == nil then
    text = noSub
  end
  local subLabel = player:getAttribute("subLabel")
  subLabel:setText(text)

end

function sendInfoMessage(player, text)

  local infoLabel = Gui:createLabel("\n\n   " .. 
    text .. "   \n\n", 0.5, 0.5)
  infoLabel:setFontColor(fontColor)
  infoLabel:setBorderColor(borderColor)
  infoLabel:setBackgroundColor(backgroundColor)
  infoLabel:setBorderThickness(2)
  infoLabel:setFontsize(20)
  infoLabel:setPivot(4)
  player:addGuiElement(infoLabel)
  setTimer(function()
    player:removeGuiElement(infoLabel)
    Gui:destroyElement(infoLabel)
  end, 4, 1)

end

function sendWelcomeMessage(player)

  local supremeLeaderText = "";
  if supremeLeader ~= nil then
    supremeLeaderText = "  Current Supreme Leader: " .. supremeLeader .. " Jong-un  \n"
  end

  local infoLabel = Gui:createLabel(
    "\nThis server is managed by:\n" ..
    "   =============================   \n" ..
    "   Gettysburg Supreme Management   \n" ..
    "   =============================   \n" ..
    supremeLeaderText ..
    "\nType /info in the Chat [t]\n", 0.5, 0.5
  )
  infoLabel:setFontColor(fontColor)
  infoLabel:setBorderColor(borderColor)
  infoLabel:setBackgroundColor(backgroundColor)
  infoLabel:setBorderThickness(5)
  infoLabel:setFontsize(40)
  infoLabel:setPivot(4)
  player:addGuiElement(infoLabel)
  setTimer(function()
    player:removeGuiElement(infoLabel)
    Gui:destroyElement(infoLabel)
  end, 8, 1)

end




  -- local bb = World:create3DText("\n  Billboard  \n\n",6.0,65.0,492.0,150,0x00336688,true,true)
  -- player:setAttribute("bb", bb)
  -- player:addWorldElement(bb)

  -- local fls = World:create3DText("false",6.0,85.0,492.0,200,0x00336688,true,false)
  -- player:setAttribute("fls", fls)
  -- player:addWorldElement(fls)

  -- local cp = World:createCheckpoint(6.0,85.0,492.0,50,10,0xFFCC0088)
  -- player:setAttribute("cp", cp)
  -- player:addWorldElement(cp)
