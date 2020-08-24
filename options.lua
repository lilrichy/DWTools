-- Create the options frame under the WoW interface->addons menu
function DwTools:CreateOptions()
    -- Create addon options frame
    self.Options = CreateFrame("Frame", "Options", InterfaceOptionsFramePanelContainer)
    self.Options.name = "DwTools"
    self.Options:SetAllPoints(InterfaceOptionsFramePanelContainer)
    self.Options:Hide()
    InterfaceOptions_AddCategory(self.Options)

    -- Create addon profiles options frame
    self.ProfilesOptions = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
    LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("DwTools: " .. self.ProfilesOptions.name, self.ProfilesOptions)
    self.ProfilesFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("DwTools: " .. self.ProfilesOptions.name,
                             self.ProfilesOptions.name, "DwTools")

    local function getOpt(info)
        return DwTools.db.profile[info[#info]]
    end

    local function setOpt(info, value)
        DwTools.db.profile[info[#info]] = value
        return DwTools.db.profile[info[#info]]
    end

    -- Create options frame
    LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("DwTools", {
        type = "group",
        name = "Options",
        args = {
            general = {
                type = "group",
                inline = true,
                name = "",
                args = {
                    reload = {
                        type = "group",
                        inline = true,
                        name = "Reload Button",
                        order = 10,
                        args = {
                            showReloadBtnCheck = {
                                type = "toggle",
                                name = "Show Reload Button",
                                order = 10,
                                get = function(info)
                                    return DwTools.db.profile.reloadButtonPosition.hidden
                                end,
                                set = function(info, value)
                                    DwTools.db.profile.reloadButtonPosition.hidden = value
                                    DwTools:updateVisibility()
                                end
                            },
                            lockReloadBtnCheck = {
                                type = "toggle",
                                name = "Lock Reload Button",
                                order = 20,
                                get = function(info)
                                    return DwTools.db.profile.reloadButtonPosition.locked
                                end,
                                set = function(info, value)
                                    DwTools.db.profile.reloadButtonPosition.locked = value
                                end
                            },
                            setReloadBtnScale = {
                                type = "range",
                                name = "Set Reload Button Scale",
                                min = .5,
                                max = 2.5,
                                bigStep = .1,
                                order = 30,
                                get = function(info)
                                    return DwTools.db.profile.reloadButtonPosition.scale
                                end,
                                set = function(info, value)
                                    DwTools.db.profile.reloadButtonPosition.scale = value
                                    DwTools:UpdateReloadBtnScale(value)
                                end
                            }
                        }
                    },
                    frameStk = {
                        type = "group",
                        inline = true,
                        name = "Frame Stack Button",
                        order = 20,
                        args = {
                            showframeStkBtnCheck = {
                                type = "toggle",
                                name = "Show Frame Stack Button",
                                order = 10,
                                get = function(info)
                                    return DwTools.db.profile.frameStackButtonPosition.hidden
                                end,
                                set = function(info, value)
                                    DwTools.db.profile.frameStackButtonPosition.hidden = value
                                    DwTools:updateVisibility()
                                end
                            },
                            lockFrameStkBtnCheck = {
                                type = "toggle",
                                name = "Lock Frame Stack Button",
                                order = 20,
                                get = function(info)
                                    return DwTools.db.profile.frameStackButtonPosition.locked
                                end,
                                set = function(info, value)
                                    DwTools.db.profile.frameStackButtonPosition.locked = value
                                end
                            },
                            setFrameStkBtnScale = {
                                type = "range",
                                name = "Set Frame Stack Button Scale",
                                min = .5,
                                max = 2.5,
                                bigStep = .1,
                                order = 30,
                                get = function(info)
                                    return DwTools.db.profile.frameStackButtonPosition.scale
                                end,
                                set = function(info, value)
                                    DwTools.db.profile.frameStackButtonPosition.scale = value
                                    DwTools:UpdateFrameStkBtnScale(value)
                                end
                            }
                        }
                    }
                }
            }
        }
    })
    self.OptionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("DwTools", "Options", "DwTools")
end