
noRealm = "No realm"
noSub = ""

-- Add gui to Player
function gbInitGui(player)

  local realmLabel = Gui:createLabel(noRealm, 0.05, 0.150);
  realmLabel:setFontColor(0x3399FFAA);
  realmLabel:setFontsize(25);
  realmLabel:setPivot(0);
  player:setAttribute("realmLabel", realmLabel);
  player:addGuiElement(realmLabel);

  local subLabel = Gui:createLabel(noSub, 0.05, 0.100);
  subLabel:setFontColor(0xFFCC00AA);
  subLabel:setFontsize(25);
  subLabel:setPivot(0);
  player:setAttribute("subLabel", subLabel);
  player:addGuiElement(subLabel);

end

function setRealmLabel(player, text)

  if text == nil then
    text = noRealm
  end
  local realmLabel = player:getAttribute("realmLabel");
  realmLabel:setText(text);

end

function setSubLabel(player, text)

  if text == nil then
    text = noSub
  end
  local subLabel = player:getAttribute("subLabel");
  subLabel:setText(text);

end

function sendInfoMessage(player, text)

  local infoLabel = Gui:createLabel("\n\n    " .. 
    text .. "    \n\n", 0.5, 0.5);
  infoLabel:setFontColor(0xFFCC0088);
  infoLabel:setBorderColor(0xCCCCCC88);
  infoLabel:setBackgroundColor(0x00336688);
  infoLabel:setBorderThickness(2);
  infoLabel:setFontsize(20);
  infoLabel:setPivot(4);
  player:addGuiElement(infoLabel);
  setTimer(function()
    player:removeGuiElement(infoLabel);
    Gui:destroyElement(infoLabel);
  end, 4, 1);

end

function sendWelcomeMessage(player)

  local infoLabel = Gui:createLabel(
    "\n\nThis server is managed by:\n" ..
    "   Gettysburg Supreme Management   \n" ..
    "Type /info in the Chat [t]\n\n", 0.5, 0.5
  );
  infoLabel:setFontColor(0xFFCC00CC);
  infoLabel:setBorderColor(0xCCCCCCCC);
  infoLabel:setBorderThickness(5);
  infoLabel:setBackgroundColor(0x003366CC);
  infoLabel:setFontsize(40);
  infoLabel:setPivot(4);
  player:addGuiElement(infoLabel);
  setTimer(function()
    player:removeGuiElement(infoLabel);
    Gui:destroyElement(infoLabel);
  end, 8, 1);

end