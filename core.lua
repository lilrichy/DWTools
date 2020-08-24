-- DwTools a small addon to help with the development of World of Warcraft Addons.
-- by LiLRichy 2020
DwTools = LibStub("AceAddon-3.0"):NewAddon("DwTools", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")

-- Addon Version
local dwtVersion = "@project-version@"

-- Addon Prefix
local PREFIX = "[DwTools]"

-- Setup database Defaults
DwTools.defaults = {
    profile = {
        version = dwtVersion,
        reloadButtonPosition = {
            x = 0,
            y = 0,
            anchor = "CENTER",
            hidden = false,
            locked = false,
            scale = 1
        },
        frameStackButtonPosition = {
            x = 0,
            y = 0,
            anchor = "CENTER",
            hidden = false,
            locked = false,
            scale = 1
        },
    }
}

-- Initialize addon, called directly after the addon is fully loaded
function DwTools:OnInitialize()
    -- Create database with default values
    self.db = LibStub("AceDB-3.0"):New("DWToolsDB", self.defaults);
 
    -- Register addon message prefix
    C_ChatInfo.RegisterAddonMessagePrefix(PREFIX)

    -- Register chat commands
    self:RegisterChatCommand("dwt", "HandleChatMessageCommands")
    self:RegisterChatCommand("dwtools", "HandleChatMessageCommands")
    self:RegisterChatCommand("rl", function(self)
        ReloadUI()
    end)
    self:RegisterChatCommand("fs", function(self)
        UIParentLoadAddOn("Blizzard_DebugTools");
        FrameStackTooltip_Toggle();
    end)
end

function DwTools:HandleChatMessageCommands(msg)
    local command, text = msg:match("(%S+)%s*(%S*)")
    if command == "show" then
        if text == "reload" then
            DwTools.db.profile.reloadButtonPosition.hidden = true
        else
            if text == "framestack" then
                DwTools.db.profile.frameStackButtonPosition.hidden = true
            else
                DwTools.db.profile.reloadButtonPosition.hidden = true
                DwTools.db.profile.frameStackButtonPosition.hidden = true

            end
        end
        DwTools:updateVisibility()
    elseif command == "hide" then
        if text == "reload" then
            DwTools.db.profile.reloadButtonPosition.hidden = false
        else
            if text == "framestack" then
                DwTools.db.profile.frameStackButtonPosition.hidden = false
            else
                DwTools.db.profile.reloadButtonPosition.hidden = false
                DwTools.db.profile.frameStackButtonPosition.hidden = false

            end
        end
        DwTools:updateVisibility()
    elseif command == "toggle" then
        if text == "reload" then
            DwTools.db.profile.reloadButtonPosition.hidden = not self.db.profile.reloadButtonPosition.hidden
        else
            if text == "framestack" then
                DwTools.db.profile.frameStackButtonPosition.hidden = not self.db.profile.frameStackButtonPosition.hidden
            else
                DwTools.db.profile.reloadButtonPosition.hidden = not self.db.profile.reloadButtonPosition.hidden
                DwTools.db.profile.frameStackButtonPosition.hidden = not self.db.profile.frameStackButtonPosition.hidden
            end
        end
        DwTools:updateVisibility()
    elseif command == "unlock" then
        if text == "reload" then
            DwTools.db.profile.reloadButtonPosition.locked = false
        else
            if text == "framestack" then
                DwTools.db.profile.frameStackButtonPosition.locked = false
            else
                DwTools.db.profile.reloadButtonPosition.locked = false
                DwTools.db.profile.frameStackButtonPosition.locked = false

            end
        end

    elseif command == "lock" then
        if text == "reload" then
            DwTools.db.profile.reloadButtonPosition.locked = true
        else
            if text == "framestack" then
                DwTools.db.profile.frameStackButtonPosition.locked = true
            else
                DwTools.db.profile.reloadButtonPosition.locked = true
                DwTools.db.profile.frameStackButtonPosition.locked = true

            end
        end

    elseif command == "options" then
        InterfaceOptionsFrame_OpenToCategory(self.OptionsFrame)
        InterfaceOptionsFrame_OpenToCategory(self.OptionsFrame)

    elseif command == "help" then
        self:Print("\"/rl\" : Reloads the Ui")
        self:Print("\"/fs\" : Opens the Frame Stack window")
        self:Print("")
        self:Print("\"/dwt toggle\" : toggles the buttons")
        self:Print("\"/dwt show\" : shows the buttons")
        self:Print("\"/dwt hide\" : hides the buttons")
        self:Print("\"/dwt toggle reload\" : toggles the reload button")
        self:Print("\"/dwt show reload\" : shows reload button")
        self:Print("\"/dwt hide reload\" : hides reload button")
        self:Print("\"/dwt toggle framestack\" : toggles framestack button")
        self:Print("\"/dwt show framestack\" : show framestack button")
        self:Print("\"/dwt hide framestack\" : hide framestack button")
        self:Print("\"/dwt lock\" : locks buttons position")
        self:Print("\"/dwt unlock\" : unlocks buttons position")
        self:Print("\"/dwt lock reload\" : locks the reload button position")
        self:Print("\"/dwt unlock reload\" : unlocks the reload button position")
        self:Print("\"/dwt lock framestack\" : locks the framestack button position")
        self:Print("\"/dwt unlock framestack\" : unlocks the framestack button position")
        self:Print("")
        self:Print("\"/dwt options\" : opens options dialog")
    else
        self:Print("Usage: \"/dwt <command>\"")
        self:Print("Usage: \"/dwtools <command>\"")
        self:Print("")
        self:Print("Type: \"/dwt help\" for a list of commands")
    end
end

-- Called when the addon is enabled
function DwTools:OnEnable()

    -- Notify user that ListTracker is enabled, give config command
    self:Print("DwTools: ", dwtVersion .. "", " enabled.")

    -- Create options frame
    self:CreateOptions()

    -- Create buttons
    DwTools:ReloadButton()
    DwTools:FrameStackButton()
    DwTools:updateVisibility()
end

-- Hide and Show things
function DwTools:updateVisibility()
    if self.db.profile.reloadButtonPosition.hidden then
        self.reloadBtn:Show()
    else
        self.reloadBtn:Hide()
    end
    if self.db.profile.frameStackButtonPosition.hidden then
        self.frameStkBtn:Show()
    else
        self.frameStkBtn:Hide()
    end

end