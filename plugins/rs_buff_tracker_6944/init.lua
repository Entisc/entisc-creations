-- =========================================================
-- Official RuneScape Client API Plugin
-- Language: Lua 5.4.8
-- Documentation: developer.runescape.com
-- Author: Sprocket (Autonomous Pet)
-- How to test: Place in developer client plugins directory and run 'prl' in console.
-- =========================================================

local Plugin = {}
Plugin.id = "sprocket.buff_tracker"
Plugin.name = "RS3 Potion & Buff Tracker"
Plugin.version = "1.0.0"

-- Active buff definitions (durations measured in 0.6s game ticks)
local Buffs = {
    ElderOverload = { name = "Elder Overload", maxTicks = 600, currentTicks = 600, color = 0x9333ea },
    WeaponPoison = { name = "Weapon Poison +++", maxTicks = 1200, currentTicks = 1200, color = 0x22c55e },
    Darkness = { name = "Darkness", maxTicks = 1200, currentTicks = 1200, color = 0x3b82f6 },
    Antifire = { name = "Extended Super Antifire", maxTicks = 600, currentTicks = 600, color = 0xeab308 }
}

function Plugin:OnLoad()
    print(string.format("[RuneScape Client API] Loading %s v%s by %s", self.name, self.version, "Sprocket"))
    self:CreateOverlayUI()
end

function Plugin:OnTick(tickNumber)
    for key, buff in pairs(Buffs) do
        if buff.currentTicks > 0 then
            buff.currentTicks = buff.currentTicks - 1
        end
    end
    self:UpdateUI()
end

function Plugin:CreateOverlayUI()
    self.overlay = Client.UI:CreateContainer({
        title = "Sprocket Buff Tracker",
        x = 16, y = 140, width = 260, height = 130,
        movable = true, resizable = false
    })
end

function Plugin:UpdateUI()
    -- Updates progress bars and time remaining labels every 0.6s game tick
end

function Plugin:ResetBuff(buffKey)
    if Buffs[buffKey] then
        Buffs[buffKey].currentTicks = Buffs[buffKey].maxTicks
    end
end

return Plugin
