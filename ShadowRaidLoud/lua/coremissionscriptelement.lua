core:module("CoreMissionScriptElement")
core:import("CoreXml")
core:import("CoreCode")
core:import("CoreClass")

_G.ShadowRaidLoud = _G.ShadowRaidLoud or {}
ShadowRaidLoud = _G.ShadowRaidLoud
ShadowRaidLoud.Run_Script_Data = ShadowRaidLoud.Run_Script_Data or {}

local ShadowRaidLoud_OpenVault = MissionScriptElement.on_executed

function MissionScriptElement:on_executed(instigator, ...)
	local _id = "id_" .. tostring(self._id)
	if ShadowRaidLoud and ShadowRaidLoud.Enable and not Network:is_client() then
		if (_id == "id_100961" or _id == "id_100962") and not ShadowRaidLoud.Run_Script_Data[_id] then
			local element = self:get_mission_element(100964)
			if element then				
				local msg = "[System] Vault will open in ".. ShadowRaidLoud.Time4Use.OpenVault .." seconds"
				ShadowRaidLoud:Announce(msg)
				local _tmp = ShadowRaidLoud:Run_Script("id_100964", self, 100964, element, instigator, ShadowRaidLoud.Time4Use.OpenVault)
				ShadowRaidLoud.Run_Script_Data["id_100961"] = _tmp
				ShadowRaidLoud.Run_Script_Data["id_100962"] = _tmp
			end
		end
	end
	ShadowRaidLoud_OpenVault(self, instigator, ...)
end