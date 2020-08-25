-- FrameStack Button
-- Registers the frame that renders the button in-game. --
function DwTools:FrameStackButton()

    self.frameStkBtn = CreateFrame("Button", "frameStkBtn", UIParent)

    self.frameStkBtn:SetMovable(true)
    self.frameStkBtn:EnableMouse(true)
    self.frameStkBtn:SetClampedToScreen(true)
    self.frameStkBtn:RegisterForDrag("LeftButton")
    self.frameStkBtn:SetScript("OnDragStart", function(frame)
        if not DwTools.db.profile.frameStackButtonPosition.locked then
            frame:StartMoving()
        end
    end)

    self.frameStkBtn:SetScript("OnDragStop", function(frame)
        frame:StopMovingOrSizing()
        DwTools.db.profile.frameStackButtonPosition.anchor, _, _, DwTools.db.profile.frameStackButtonPosition.x, DwTools.db
            .profile.frameStackButtonPosition.y = frame:GetPoint()
    end)
    self.frameStkBtn:SetPoint(DwTools.db.profile.frameStackButtonPosition.anchor,
    DwTools.db.profile.frameStackButtonPosition.x, DwTools.db.profile.frameStackButtonPosition.y)

    self.frameStkBtn:SetSize(60, 60)
    self.frameStkBtn:SetScale(DwTools.db.profile.frameStackButtonPosition.scale)

    local frameStkIcon = self.frameStkBtn:CreateTexture("Texture", "Background")
    frameStkIcon:SetTexture("Interface\\LFGFRAME\\Inspect")

    -- Makes the area behind the background invisible. --
    frameStkIcon:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMask")
    frameStkIcon:SetAllPoints(self.frameStkBtn)

    local frameStkRing = self.frameStkBtn:CreateTexture("Texture", "Overlay")
    frameStkRing:SetAtlas("adventureguide-ring")
    frameStkRing:SetPoint("Center", self.frameStkBtn)
    frameStkRing:SetSize(100, 100)

    -- The texture that appears when the button is highlighted. --
    local frameStkHighlightTexture = self.frameStkBtn:CreateTexture("Texture", "Overlay")
    frameStkHighlightTexture:SetAtlas("adventureguide-rewardring")
    frameStkHighlightTexture:SetPoint("Center", self.frameStkBtn)
    frameStkHighlightTexture:SetSize(100, 100)
    frameStkHighlightTexture:SetBlendMode("Add")
    frameStkHighlightTexture:SetVertexColor(1, 1, 1, 0.25)

    -- When the user mouses over the button the highlight texture shows. --
    self.frameStkBtn:SetScript("OnEnter", function(self)
        frameStkHighlightTexture:Show()
    end)

    -- When the user mouses out of the button the highlight texture is hidden. --
    self.frameStkBtn:SetScript("OnLeave", function(self)
        frameStkHighlightTexture:Hide()
    end)

    -- When the button is clicked.
    self.frameStkBtn:SetScript('OnClick', function(self)
        UIParentLoadAddOn("Blizzard_DebugTools");
        FrameStackTooltip_Toggle();
    end)
end

-- Scale Update based on slider value
function DwTools:UpdateFrameStkBtnScale(value)
    self.frameStkBtn:SetScale(value)
end