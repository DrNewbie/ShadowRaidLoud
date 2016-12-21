local _f_init = LevelsTweakData.init

Hooks:PostHook(LevelsTweakData, "init", "ShadowRaidLoud_Set_Music", function(lvl, ...)
	lvl.kosugi.music = lvl.shoutout_raid.music
end)