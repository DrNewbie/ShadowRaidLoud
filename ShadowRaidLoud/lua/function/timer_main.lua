if Network:is_client() then
	return
end

_G.ShadowRaidLoud = _G.ShadowRaidLoud or {}

local _D = ShadowRaidLoud.Difficulty

local _AFTER_GROUP_TOTAL_DELAY = 0

ShadowRaidLoud.Timer_Enable = false
ShadowRaidLoud.Delay_Timer = 0
ShadowRaidLoud.Go_Loud_Stage = 0
ShadowRaidLoud.ForcedAssault = false
ShadowRaidLoud.PhalanxBuff = false
ShadowRaidLoud.Timer_Main_Repeat_Dealy = 0

Hooks:Add("GameSetupUpdate", "ShadowRaidLoudGameSetupUpdate", function(t, dt)
	ShadowRaidLoud:Timer_Main(t)
end)

function ShadowRaidLoud:Timer_Main(t)
	if not Utils:IsInHeist() or ShadowRaidLoud.Timer_Main_Repeat_Dealy > t then
		return
	end
	ShadowRaidLoud.Timer_Main_Repeat_Dealy = math.floor(t) + 1
	local _nowtime = math.floor(t)
	local _start_time = ShadowRaidLoud.Start_Time or 0
	ShadowRaidLoud.Now_Time = _nowtime
	--Mission start
	if ShadowRaidLoud and ShadowRaidLoud.Enable then
		--Init
		if not ShadowRaidLoud.Timer_Enable and not managers.groupai:state():whisper_mode() then
			ShadowRaidLoud.Timer_Enable = true
			ShadowRaidLoud.Start_Time = _nowtime
			ShadowRaidLoud.Delay_Timer = _nowtime + ShadowRaidLoud.Time4Use.FirstSpawn
			ShadowRaidLoud.Go_Loud_Stage = 1
			for _, unit in pairs(World:find_units_quick("all", 1)) do
				if unit:interaction() then
					local interact_types = tostring(unit:interaction().tweak_data)
					if interact_types == "pick_lock_easy_no_skill" or
						interact_types == "open_from_inside" or
						interact_types == "pick_lock_hard_no_skill" then
						unit:interaction():interact(managers.player:player_unit())
					end
				end
				for k, v in pairs (ShadowRaidLoud.Unit_Remove_When_Loud or {}) do
					if v.key == unit:name():key() then
						for _, pos in pairs(v.position) do
							if unit:position() == pos then
								unit:set_slot(0)				
							end
						end
						if v.position and v.position[1] == Vector3(0, 0, 0) then
							unit:set_slot(0)
						end
					end
				end
			end
		end
		--Go loud
		if ShadowRaidLoud.Timer_Enable and ShadowRaidLoud.Delay_Timer < _nowtime and ShadowRaidLoud.Go_Loud_Stage == 1 then
			ShadowRaidLoud.Delay_Timer = ShadowRaidLoud.Time4Use.RepeatSpawn + _nowtime
			if not ShadowRaidLoud.ForcedAssault and _nowtime - ShadowRaidLoud.Start_Time > 10 then
				ShadowRaidLoud.ForcedAssault = true
				managers.groupai:state():on_police_called("alarm_pager_hang_up")
				DelayedCalls:Add("DelayedCalls_ShadowRaidLoud_ForcedAssault", 10, function()
					managers.groupai:state():special_assault_function()
				end)
			end
			if not ShadowRaidLoud.PhalanxBuff and _nowtime - ShadowRaidLoud.Start_Time > 300 then
				ShadowRaidLoud.PhalanxBuff = true
				managers.groupai:state():set_phalanx_damage_reduction_buff(0.5)
				managers.groupai:state():set_damage_reduction_buff_hud()
			end
			_AFTER_GROUP_TOTAL_DELAY = 0
			local _all_enemies = managers.enemy:all_enemies() or {}
			local _Spawning = ShadowRaidLoud._Spawning or {}
			local _Spawning_Total = ShadowRaidLoud._Spawning_Total or {}
			local _T = table.size(ShadowRaidLoud.Spawn_Settings_List)
			local _C = _Spawning[_D]
			local _total_enemies = table.size(_all_enemies)
			local _enemy_type_amount = {}
			local _Killed_by_System = 0
			for _, data in pairs(_all_enemies) do
				local enemyType = tostring(data.unit:base()._tweak_table)
				if not _enemy_type_amount[enemyType] then
					_enemy_type_amount[enemyType] = 1
				else
					_enemy_type_amount[enemyType] = _enemy_type_amount[enemyType] + 1
				end
			end
			if _total_enemies - _Killed_by_System < _Spawning_Total[_D] then
				local _Last_R
				for i = 1, _C do
					local _R = ShadowRaidLoud.Spawn_Settings_List[math.random(_T)]
					if _Last_R ~= _R then
						_Last_R = _R
						ShadowRaidLoud:Spawn_Group(_R)
					else
						_C = _C + 1
					end
				end
			end
			if not _enemy_type_amount["sniper"] then
				_enemy_type_amount["sniper"] = 0
			end
			if _enemy_type_amount["sniper"] < ShadowRaidLoud._Spawning_Other_Total["sniper"][_D] then
				local _pos_sniper = ShadowRaidLoud.Spawning_Other.sniper.pos
				ShadowRaidLoud:_full_function_spawn(Idstring("units/payday2/characters/ene_sniper_2/ene_sniper_2"), _pos_sniper[math.random(#_pos_sniper)], Rotation(0, 0, 1))
			end
			local _other = {
				taser = ShadowRaidLoud.Spawning_Other.taser,
				shield = ShadowRaidLoud.Spawning_Other.shield,
				spooc = ShadowRaidLoud.Spawning_Other.spooc,
				tank = ShadowRaidLoud.Spawning_Other.tank,
			}						
			local _list
			local _pos_other = ShadowRaidLoud.Spawning_Other.pos_default
			for _type, _data in pairs(_other) do
				_type = tostring(_type)
				_list = _data.name
				if not _enemy_type_amount[_type] then
					_enemy_type_amount[_type] = 0
				end
				if _enemy_type_amount[_type] < ShadowRaidLoud._Spawning_Other_Total[_type][_D] then
					for i = 1, _data.amount do
						ShadowRaidLoud:_full_function_spawn(_list[math.random(#_list)], _pos_other[math.random(#_pos_other)], Rotation(0, 0, 1), _AFTER_GROUP_TOTAL_DELAY + i)
					end
				end
			end
			math.randomseed(os.time())
		end
	end
	if ShadowRaidLoud.Run_Script_Data then
		for k, v in pairs(ShadowRaidLoud.Run_Script_Data or {}) do
			if v and type(v.delay) == "number" and _nowtime > v.delay then
				local them = v.them
				local id = v.id
				local element = v.element
				local instigator = v.instigator
				managers.network:session():send_to_peers_synched("run_mission_element_no_instigator", id, 0.1)
				them._mission_script:add(callback(element, element, "on_executed", instigator), 0.1, 1)
				ShadowRaidLoud.Run_Script_Data[k] = {}
			end
		end
	end
	ShadowRaidLoud.Timer_Main_Repeat_Dealy = ShadowRaidLoud.Timer_Main_Repeat_Dealy + math.max(_AFTER_GROUP_TOTAL_DELAY, 1)
end

function ShadowRaidLoud:Spawn_Group(_R)
	local _S = {}
	_S = ShadowRaidLoud.Spawn_Settings[_R] or {}
	if _S and _S.enemy then
		local _enemy = _S.enemy[_D] or {}
		if _enemy then
			local _pos = _S.position or nil
			local _rot = _S.rotation or nil
			local _id = _S.group_id or nil
			if _pos and _rot and _id then
				for _, v in pairs(_enemy) do
					local k = 1
					for j = 1, (v.amount or 0) do
						if k > #_pos then k = 1 end
						ShadowRaidLoud:_full_function_spawn(Idstring(v.type), _pos[k], rot, j*2)
						_AFTER_GROUP_TOTAL_DELAY = _AFTER_GROUP_TOTAL_DELAY + j*2
						k = k + 1
					end
				end
			end
		end
	end
end