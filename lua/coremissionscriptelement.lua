core:module("CoreMissionScriptElement")
core:import("CoreXml")
core:import("CoreCode")
core:import("CoreClass")

local CloneClass = _G.CloneClass
_G.ShadowRaidLoud = _G.ShadowRaidLoud or {}
ShadowRaidLoud = _G.ShadowRaidLoud

CloneClass( MissionScriptElement )

function MissionScriptElement.on_executed(self, instigator, alternative, skip_execute_on_executed)
	local _id = tostring(self._id)
	if ShadowRaidLoud and ShadowRaidLoud.Enable and not Network:is_client() then
		if _id == "100961" or _id == "100962" then
			local element = self:get_mission_element(100964)
			self._mission_script:add(callback(element, element, "on_executed", instigator), ShadowRaidLoud.Time4Use.OpenVault, 1)
			local msg = "[System] Vault will open in ".. ShadowRaidLoud.Time4Use.OpenVault .." seconds"
			ShadowRaidLoud:Announce(msg)
		end
	end
	self.orig.on_executed(self, instigator, alternative, skip_execute_on_executed)
end
