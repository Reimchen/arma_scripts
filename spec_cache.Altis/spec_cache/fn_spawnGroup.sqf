_returnValue = false;
if(isServer) then {
_parameterCorrect = params [["_noGroupToSpawn",-1,[0]]];
_noCachedGroups = count specCachedGroups;

if(_parameterCorrect) then {
	_noGroupToSpawnRounded = round _noGroupToSpawn;
	if(_noGroupToSpawn == _noGroupToSpawnRounded) then {
		if(_noGroupToSpawn < _noCachedGroups && _noGroupToSpawn >= 0) then {
			_cachedGroupArray = specCachedGroups select _noGroupToSpawn;
			_sizeCachedGroupArray = count _cachedGroupArray;
			if(_sizeCachedGroupArray != 0) then {
				if( _sizeCachedGroupArray == 5) then {
					_returnValue = [(_cachedGroupArray select 0),( _cachedGroupArray select 1), (_cachedGroupArray select 2), (_cachedGroupArray select 3), (_cachedGroupArray select 4)] call Spec_fnc_spawnGroup_data;
					specCachedGroups set [_noGroupToSpawn,[]];
				} else {
					["Script Error: Group number (%1) should have been cached, but entry is wrong, size is (%2)", _noGroupToSpawn, count _cachedGroupArray] call BIS_fnc_error;
				}
			} else {
				["Wrong Index for cached group: Group with number (%1) has not been cached yet or was already spawned", _noGroupToSpawn] call BIS_fnc_error;
			};
		} else {
			["Wrong Index for cached group: We have cached group from 0 to (%1), got (%2)", (_noCachedGroups - 1), _noGroupToSpawn] call BIS_fnc_error;
		};
		} else {
			["Wrong parameter: expected Integer got (%1)",_noGroupToSpawn] call BIS_fnc_error;
		};
	} else {
		"Wrong parameter: expected Number" call BIS_fnc_error;
	};
};
_returnValue