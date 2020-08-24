-- FrameStack Button
-- Registers the frame that renders the button in-game. --
local frameStkBtn = CreateFrame("Button", "DragFrame", UIParent)

frameStkBtn:SetPoint("Center", 0, 0)
frameStkBtn:SetSize(90, 90)

local frameStkIcon = frameStkBtn:CreateTexture("Texture", "Background")
frameStkIcon:SetTexture("Interface\\ICONS\\Achievement_Garrison_blueprint_medium.blp")

-- Makes the area behind the background invisible. --
frameStkIcon:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMask")
frameStkIcon:SetAllPoints(frameStkBtn)

local frameStkRing = frameStkBtn:CreateTexture("Texture", "Overlay")
frameStkRing:SetAtlas("adventureguide-ring")
frameStkRing:SetPoint("Center", frameStkBtn)
frameStkRing:SetSize(120, 120)

-- The texture that appears when the button is highlighted. --
local frameStkHighlightTexture = frameStkBtn:CreateTexture("Texture", "Overlay")
frameStkHighlightTexture:SetAtlas("adventureguide-rewardring")
frameStkHighlightTexture:SetPoint("Center", frameStkBtn)
frameStkHighlightTexture:SetSize(120, 120)
frameStkHighlightTexture:SetBlendMode("Add")
frameStkHighlightTexture:SetVertexColor(1, 1, 1, 0.25)

-- When the user mouses over the button the highlight texture shows. --
frameStkBtn:SetScript("OnEnter", function(self)
    frameStkHighlightTexture:Show()
end)

-- When the user mouses out of the button the highlight texture is hidden. --
frameStkBtn:SetScript("OnLeave", function(self)
    frameStkHighlightTexture:Hide()
end)

-- When the button is clicked.
frameStkBtn:SetScript('OnClick', function(self)
  UIParentLoadAddOn("Blizzard_DebugTools");
  FrameStackTooltip_Toggle();
end)

frameStkBtn:SetMovable(true)
frameStkBtn:EnableMouse(true)
frameStkBtn:RegisterForDrag("LeftButton")
frameStkBtn:SetScript("OnDragStart", frameStkBtn.StartMoving)
frameStkBtn:SetScript("OnDragStop", frameStkBtn.StopMovingOrSizing)
-- End FrameStack Button