if Network:is_client() then
	return
end

_G.ShadowRaidLoud = _G.ShadowRaidLoud or {}

ShadowRaidLoud.Level_ID = "kosugi"
ShadowRaidLoud.Message2OtherPlayers = "This lobby is running 'Shadow Raid Loud Mod'"
ShadowRaidLoud.Message2WarnYou = "You're activating Shadow Raid Loud MOD. \n You should only play with your friends."

ShadowRaidLoud.Time2FirstSpawn = {easy = 60,
	normal = 60,
	hard = 60,
	overkill = 40,
	overkill_145 = 40,
	overkill_290 = 30
}
ShadowRaidLoud.Time2RepeatSpawn = {easy = 3,
	normal = 20,
	hard = 20,
	overkill = 20,
	overkill_145 = 20,
	overkill_290 = 20
}
ShadowRaidLoud.Time2OpenVault = {easy = 360,
	normal = 360,
	hard = 480,
	overkill = 480,
	overkill_145 = 480,
	overkill_290 = 600
}
ShadowRaidLoud._Spawning = {easy = 1,
	normal = 2,
	hard = 2,
	overkill = 2,
	overkill_145 = 2,
	overkill_290 = 2
}
ShadowRaidLoud._Spawning_Total = {easy = 40,
	normal = 50,
	hard = 60,
	overkill = 60,
	overkill_145 = 70,
	overkill_290 = 70
}
ShadowRaidLoud._Spawning_Other_Total = {
	sniper = {
		easy = 5,
		normal = 5,
		hard = 5,
		overkill = 5,
		overkill_145 = 5,
		overkill_290 = 5
	},
	taser = {
		easy = 2,
		normal = 4,
		hard = 4,
		overkill = 4,
		overkill_145 = 6,
		overkill_290 = 6
	},
	shield = {
		easy = 10,
		normal = 20,
		hard = 20,
		overkill = 30,
		overkill_145 = 30,
		overkill_290 = 30
	},
	spooc = {
		easy = 2,
		normal = 2,
		hard = 2,
		overkill = 3,
		overkill_145 = 4,
		overkill_290 = 5
	},
	tank = {
		easy = 2,
		normal = 3,
		hard = 4,
		overkill = 5,
		overkill_145 = 6,
		overkill_290 = 8
	}
}

ShadowRaidLoud.Difficulty = Global.game_settings and Global.game_settings.difficulty or "easy"

local _D = ShadowRaidLoud.Difficulty

ShadowRaidLoud.Time4Use = {
	FirstSpawn = ShadowRaidLoud.Time2FirstSpawn[_D],
	RepeatSpawn = ShadowRaidLoud.Time2RepeatSpawn[_D],
	OpenVault = ShadowRaidLoud.Time2OpenVault[_D],
}

--Spawn_Settings
	local _default_enemy = {
		{ type = "units/payday2/characters/ene_murkywater_1/ene_murkywater_1", amount = 3}				
	}
	ShadowRaidLoud.Spawn_Settings = {}
	local Spawn_Settings = {}
	local Spawn_Settings_List = {}

	Spawn_Settings.front_right_side_group = {
		group_id = 1,
		position = {Vector3(3872, 2750, 978), Vector3(3872, 2850, 978), Vector3(3872, 2950, 978), Vector3(3872, 3050, 978), Vector3(3872, 3150, 978)},
		rotation = {Rotation(0, 0, 1)},
		enemy = {easy = _default_enemy,
				normal = _default_enemy,
				hard = _default_enemy,
				overkill = _default_enemy,
				overkill_145 = _default_enemy,
				overkill_290 = _default_enemy},
	}
	table.insert(Spawn_Settings_List, "front_right_side_group")

	Spawn_Settings.warehouse_top = deep_clone(Spawn_Settings.front_right_side_group)
	Spawn_Settings.warehouse_top.group_id = 2
	Spawn_Settings.warehouse_top.position = {Vector3(-2200, -4950, 1775), Vector3(-2100, -4950, 1775), Vector3(-2000, -4950, 1775), Vector3(-1900, -4950, 1775), Vector3(-1800, -4950, 1775)}
	table.insert(Spawn_Settings_List, "warehouse_top")
	
	Spawn_Settings.front_left_side_group = deep_clone(Spawn_Settings.front_right_side_group)
	Spawn_Settings.front_left_side_group.group_id = 3
	Spawn_Settings.front_left_side_group.position = {Vector3(2150, -3900, 975), Vector3(2000, -3900, 975), Vector3(1850, -3900, 975), Vector3(1700, -3900, 975)}
	table.insert(Spawn_Settings_List, "front_left_side_group")
	
	Spawn_Settings.warehouse_back = deep_clone(Spawn_Settings.front_right_side_group)
	Spawn_Settings.warehouse_back.group_id = 4
	Spawn_Settings.warehouse_back.position = {Vector3(-2844, -5328, 1377.29), Vector3(-2850, -5500, 1377.29), Vector3(-2850, -5414, 1377.29), Vector3(-2850, -5550, 1377.29)}
	table.insert(Spawn_Settings_List, "warehouse_back")
	
	Spawn_Settings.front_front_group = deep_clone(Spawn_Settings.front_right_side_group)
	Spawn_Settings.front_front_group.group_id = 5
	Spawn_Settings.front_front_group.position = {Vector3(4692, -3000, 975.941), Vector3(4692, -2900, 975.941), Vector3(4692, -2800, 975.941), Vector3(4692, -2700, 975.941), Vector3(4692, -2600, 975.941)}
	table.insert(Spawn_Settings_List, "front_front_group")
	
	Spawn_Settings.warehouse_roof_001 = deep_clone(Spawn_Settings.front_right_side_group)
	Spawn_Settings.warehouse_roof_001.group_id = 6
	Spawn_Settings.warehouse_roof_001.position = {Vector3(-2900, -1800, 1776), Vector3(-2825, -1800, 1776), Vector3(-2750, -1800, 1776), Vector3(-2675, -1800, 1776)}
	table.insert(Spawn_Settings_List, "warehouse_roof_001")
	
	Spawn_Settings.back_yard = deep_clone(Spawn_Settings.front_right_side_group)
	Spawn_Settings.back_yard.group_id = 7
	Spawn_Settings.back_yard.position = {Vector3(-4900, -1800, 975), Vector3(-4900, -1650, 975), Vector3(-4900, -1500, 975), Vector3(-4900, -1350, 975)}
	table.insert(Spawn_Settings_List, "back_yard")
	
	Spawn_Settings.warehouse_roof_002 = deep_clone(Spawn_Settings.front_right_side_group)
	Spawn_Settings.warehouse_roof_002.group_id = 8
	Spawn_Settings.warehouse_roof_002.position = {Vector3(-725, -2075, 1776), Vector3(-625, -2075, 1776), Vector3(-550, -2075, 1776), Vector3(-475, -2075, 1776)}
	table.insert(Spawn_Settings_List, "warehouse_roof_002")
	
	local _other_position = {Vector3(6080, 3402, 959), Vector3(-4940, 2365, 977), Vector3(-4941, -1474, 977), Vector3(-2756, -7415, 586.768), Vector3(-3693, -1303, 1391), Vector3(1453, 2365, 977), Vector3(-3745, -3499, 1791), Vector3(-1057, -4406, 1791), Vector3(-5328, -5730, 592)}

	Spawn_Settings.other_001 = deep_clone(Spawn_Settings.front_right_side_group)
	Spawn_Settings.other_001.group_id = 9
	Spawn_Settings.other_001.position = _other_position
	Spawn_Settings.other_001.POSNOADD = true
	table.insert(Spawn_Settings_List, "other_001")
	
	Spawn_Settings.other_002 = deep_clone(Spawn_Settings.front_right_side_group)
	Spawn_Settings.other_002.group_id = 10
	Spawn_Settings.other_002.position = _other_position
	Spawn_Settings.other_002.POSNOADD = true
	table.insert(Spawn_Settings_List, "other_002")
	
	Spawn_Settings.other_003 = deep_clone(Spawn_Settings.front_right_side_group)
	Spawn_Settings.other_003.group_id = 11
	Spawn_Settings.other_003.position = _other_position
	Spawn_Settings.other_003.POSNOADD = true
	table.insert(Spawn_Settings_List, "other_003")
	
	Spawn_Settings.other_004 = deep_clone(Spawn_Settings.front_right_side_group)
	Spawn_Settings.other_004.group_id = 12
	Spawn_Settings.other_004.position = _other_position
	Spawn_Settings.other_004.POSNOADD = true
	table.insert(Spawn_Settings_List, "other_004")
	
	Spawn_Settings.other_005 = deep_clone(Spawn_Settings.front_right_side_group)
	Spawn_Settings.other_005.group_id = 13
	Spawn_Settings.other_005.position = _other_position
	Spawn_Settings.other_005.POSNOADD = true
	table.insert(Spawn_Settings_List, "other_005")
	
	ShadowRaidLoud.Spawn_Settings = deep_clone(Spawn_Settings)
	ShadowRaidLoud.Spawn_Settings_List = Spawn_Settings_List
	
	Spawn_Settings = {}
	Spawn_Settings_List = {}
	_default_enemy = {}

--Spawning_Other
	ShadowRaidLoud.Spawning_Other = {
		sniper = {pos = {Vector3(-1650, -5375, 1775),
						Vector3(-1650, -5275, 1775),
						Vector3(-23175, 7200, 1100),
						Vector3(-6700, -300, 2196),
						Vector3(4250, -5775, 2001),
						Vector3(-2950, 5825, 1800),
						Vector3(-13550, 12200, 1125),
						Vector3(7222, 1491, 1803),
						Vector3(2550, 3725, 2100),
						Vector3(475, 3825, 2100)}
				},
		taser = {amount = 1, name = {Idstring("units/payday2/characters/ene_tazer_1/ene_tazer_1")}},
		shield = {amount = 3, name = {Idstring("units/payday2/characters/ene_shield_1/ene_shield_1")}},
		spooc = {amount = 1, name = {Idstring("units/payday2/characters/ene_spook_1/ene_spook_1")}},
		tank = {amount = 1, name = {Idstring("units/payday2/characters/ene_bulldozer_1/ene_bulldozer_1")}},
		
		pos_default = {},
	}
	if _D ~= "easy" and _D ~= "normal" then
		table.insert(ShadowRaidLoud.Spawning_Other.shield.name, Idstring("units/payday2/characters/ene_shield_2/ene_shield_2"))
		table.insert(ShadowRaidLoud.Spawning_Other.tank.name, Idstring("units/payday2/characters/ene_bulldozer_2/ene_bulldozer_2"))
	end
	if _D == "overkill_290" then
		table.insert(ShadowRaidLoud.Spawning_Other.tank.name, Idstring("units/payday2/characters/ene_bulldozer_3/ene_bulldozer_3"))
	end

	for _, v in pairs(ShadowRaidLoud.Spawn_Settings) do
		if not v.POSNOADD then
			table.insert(ShadowRaidLoud.Spawning_Other.pos_default, v.position[1])
		end
	end	
	
	for _, v in pairs(_other_position) do
		table.insert(ShadowRaidLoud.Spawning_Other.pos_default, v)
	end
	
	_other_position = {}
	
function ShadowRaidLoud:Announce(msg)
	managers.chat:send_message(ChatManager.GAME, "" , msg or "")
end

function set_team(unit)
	local team = unit:base():char_tweak().access == "gangster" and "gangster" or "combatant"
	local AIState = managers.groupai:state()
	local team_id = tweak_data.levels:get_default_team_ID(team)
	unit:movement():set_team(AIState:team_data(team_id))
end

function ShadowRaidLoud:_full_function_spawn(name, pos, rot, delay)
	delay = delay or 1
	local _nowslot = math.random(1, 100)
	DelayedCalls:Add("DelayedCalls_ShadowRaidLoud_full_function_spawn_" .. _nowslot, delay, function()
		local _player_unit = {}
		for _, data in pairs(managers.groupai:state():all_criminals() or {}) do
			table.insert(_player_unit, data.unit)
		end
		local _final_unit_to_use = _player_unit[math.random(table.size(_player_unit))] or {}
		local new_objective = {
				type = "follow",
				follow_unit = _final_unit_to_use,
				scan = true,
				is_default = true
			}
		pos = pos + Vector3(0, 0, 10)
		local _u = World:spawn_unit(name, pos, rot)
		set_team(_u)
		_u:brain():set_spawn_ai( { init_state = "idle", params = { scan = true }, objective = new_objective } )
		_u:brain():on_reload()
		_u:movement():set_character_anim_variables()
	end)
end