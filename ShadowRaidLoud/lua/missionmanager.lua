if Network:is_client() then
	return
end

_G.ShadowRaidLoud = _G.ShadowRaidLoud or {}

Hooks:PostHook(MissionManager, "init", "ShadowRaidLoud_Is_OK_Enable", function(miss, ...)
	if Network:is_client() then
		return
	end
	if Global.game_settings and Global.game_settings.level_id == ShadowRaidLoud.Level_ID and ShadowRaidLoud then
		ShadowRaidLoud.Enable = true
	else
		ShadowRaidLoud.Enable = false
	end
end)