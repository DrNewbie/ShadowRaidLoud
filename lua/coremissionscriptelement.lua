core:module("CoreMissionScriptElement")
core:import("CoreXml")
core:import("CoreCode")
core:import("CoreClass")

local CloneClass = _G.CloneClass
_G.ShadowRaidLoud = _G.ShadowRaidLoud or {}
ShadowRaidLoud = _G.ShadowRaidLoud

CloneClass( MissionScriptElement )

function MissionScriptElement.on_executed(self, instigator, alternative, skip_execute_on_executed)
	local _id = "id_" .. tostring(self._id)
	if ShadowRaidLoud and ShadowRaidLoud.Enable and not Network:is_client() then
		if _id == "id_100961" or _id == "id_100962" then
			local element = self:get_mission_element(100964)
			if element then				
				local msg = "[System] Vault will open in ".. ShadowRaidLoud.Time4Use.OpenVault .." seconds"
				ShadowRaidLoud:Announce(msg)
				ShadowRaidLoud:Run_Script("id_100964", self, 100964, element, instigator, 10)
			end
		end
	end
	self.orig.on_executed(self, instigator, alternative, skip_execute_on_executed)
end