-- Reload Button
-- Registers the frame that renders the button in-game. --
local reloadBtn = CreateFrame("Button", "DragFrame2", UIParent)

reloadBtn:SetPoint("Center", 0, 0)
reloadBtn:SetSize(90, 90)

local reloadIcon = reloadBtn:CreateTexture("Texture", "Background")
reloadIcon:SetTexture("Interface\\MacroFrame\\MacroFrame-Icon.blp")

-- Makes the area behind the background invisible. --
reloadIcon:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMask")
reloadIcon:SetAllPoints(reloadBtn)

local reloadRing = reloadBtn:CreateTexture("Texture", "Overlay")
reloadRing:SetAtlas("adventureguide-ring")
reloadRing:SetPoint("Center", reloadBtn)
reloadRing:SetSize(120, 120)

-- The texture that appears when the button is highlighted. --
local reloadHighlightTexture = reloadBtn:CreateTexture("Texture", "Overlay")
reloadHighlightTexture:SetAtlas("adventureguide-rewardring")
reloadHighlightTexture:SetPoint("Center", reloadBtn)
reloadHighlightTexture:SetSize(120, 120)
reloadHighlightTexture:SetBlendMode("Add")
reloadHighlightTexture:SetVertexColor(1, 1, 1, 0.25)

-- When the user mouses over the button the highlight texture shows. --
reloadBtn:SetScript("OnEnter", function(self)
    reloadHighlightTexture:Show()
end)

-- When the user mouses out of the button the highlight texture is hidden. --
reloadBtn:SetScript("OnLeave", function(self)
    reloadHighlightTexture:Hide()
end)

-- When the button is clicked.
reloadBtn:SetScript('OnClick', function(self)
    ReloadUI()
end)

reloadBtn:SetMovable(true)
reloadBtn:EnableMouse(true)
reloadBtn:RegisterForDrag("LeftButton")
reloadBtn:SetScript("OnDragStart", reloadBtn.StartMoving)
reloadBtn:SetScript("OnDragStop", reloadBtn.StopMovingOrSizing)
-- End Reload Button