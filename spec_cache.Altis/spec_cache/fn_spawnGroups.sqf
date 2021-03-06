/*
    Author: SpecOp0

    Description:
    Spawns multiple cached group in scheduled environment with sleep to avoid heavy load.
    The groups are spawned from a starting to an ending index (including this index).
    
    Function can be used in an addAction entry as well and will use the standard parameter
    of an addAction entry (_this select 3).

    Parameter(s):
    0: NUMBER - unique index of first cached group to spawn (must be positive or zero and unit has to beached with cacheGroup)
    1: NUMBER - unique index of last  cached group to spawn (must be positive or zero and unit has to beached with cacheGroup)
    2 (Optional): NUMBER - sleep time in seconds (default 0.5) 
    3: ARRAY - for use in addAction with same parameter as above

    Returns:
    BOOL - true if spawning is successful (otherwise errors are shown in addition)
*/
if(!isServer) then {
    // remoteExecute this on the server if called via addAction entry
    if(_this isEqualType [] && {count _this > 3}) then {
        _this remoteExec ["Spec_cache_fnc_spawnGroups", 2, false];
    };
} else {
    private _scriptHandle = _this spawn {
        private _parameter = _this;
        private _start = 0;
        private _end = -1;
        private _parameterCorrect = false;
        // test if addAction was used (_this select 3 is present)
        if(_parameter isEqualType [] && {count _parameter > 3}) then {
            _parameter = _this select 3;
            _parameterCorrect = _parameter params [ ["_startAddAction",0,[0]], ["_endAddAction",-1,[0]] ];
            _start = _startAddAction;
            _end = _endAddAction;
        } else {
            _parameterCorrect = _parameter params [ ["_startNormal",0,[0]], ["_endNormal",-1,[0]] ];
            _start = _startNormal;
            _end = _endNormal;
        };
        if(_parameterCorrect) then {
            if(_start >= 0) then {
                _parameter params [ "", "", ["_sleepTime",0.5,[0]] ];
                for "_i" from _start to _end do {
                    [_i] call Spec_cache_fnc_spawnGroup;
                    sleep _sleepTime;
                };
            } else {
                ["Wrong Parameter: Start value is negative (%1) - expected positive value.", _start] call BIS_fnc_error;
            };
        } else {
            ["Wrong Parameter: Expected start and end value to be (positive) numbers - optional parameter sleepTime."] call BIS_fnc_error;
        };
    };
};