-- Reload Button
-- Registers the frame that renders the button in-game. --
function DwTools:ReloadButton()
    self.reloadBtn = CreateFrame("Button", "reloadBtn", UIParent)

    self.reloadBtn:SetMovable(true)
    self.reloadBtn:EnableMouse(true)
    self.reloadBtn:SetClampedToScreen(true)
    self.reloadBtn:RegisterForDrag("LeftButton")
    self.reloadBtn:SetScript("OnDragStart", function(frame)
        if not DwTools.db.profile.reloadButtonPosition.locked then
            frame:StartMoving()
        end
    end)

    self.reloadBtn:SetScript("OnDragStop", function(frame)
        frame:StopMovingOrSizing()
        DwTools.db.profile.reloadButtonPosition.anchor, _, _, DwTools.db.profile.reloadButtonPosition.x, DwTools.db
            .profile.reloadButtonPosition.y = frame:GetPoint()
    end)
    self.reloadBtn:SetPoint(DwTools.db.profile.reloadButtonPosition.anchor, DwTools.db.profile.reloadButtonPosition.x,
        DwTools.db.profile.reloadButtonPosition.y)

    self.reloadBtn:SetSize(60, 60)
    self.reloadBtn:SetScale(DwTools.db.profile.reloadButtonPosition.scale)

    local reloadIcon = self.reloadBtn:CreateTexture("Texture", "Background")
    reloadIcon:SetTexture("Interface\\PaperDollInfoFrame\\UI-GearManager-Undo")

    -- Makes the area behind the background invisible. --
    reloadIcon:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMask")
    reloadIcon:SetAllPoints(self.reloadBtn)

    local reloadRing = self.reloadBtn:CreateTexture("Texture", "Overlay")
    reloadRing:SetAtlas("adventureguide-ring")
    reloadRing:SetPoint("Center", self.reloadBtn)
    reloadRing:SetSize(100, 100)

    -- The texture that appears when the button is highlighted. --
    local reloadHighlightTexture = self.reloadBtn:CreateTexture("Texture", "Overlay")
    reloadHighlightTexture:SetAtlas("adventureguide-rewardring")
    reloadHighlightTexture:SetPoint("Center", self.reloadBtn)
    reloadHighlightTexture:SetSize(100, 100)
    reloadHighlightTexture:SetBlendMode("Add")
    reloadHighlightTexture:SetVertexColor(1, 1, 1, 0.25)

    -- When the user mouses over the button the highlight texture shows. --
    self.reloadBtn:SetScript("OnEnter", function(self)
        reloadHighlightTexture:Show()
    end)

    -- When the user mouses out of the button the highlight texture is hidden. --
    self.reloadBtn:SetScript("OnLeave", function(self)
        reloadHighlightTexture:Hide()
    end)

    -- When the button is clicked.
    self.reloadBtn:SetScript('OnClick', function(self)
        ReloadUI()
    end)
end

-- Scale Update based on slider value
function DwTools:UpdateReloadBtnScale(value)
    self.reloadBtn:SetScale(value)
end
