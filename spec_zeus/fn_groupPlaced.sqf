private ["_parameterCorrect","_localityChanged","_unitsPlaced","_unitsHaveAI"];
_parameterCorrect = params [ ["_curator",objNull,[objNull]],["_groupPlaced",grpNull,[grpNull]] ];

if(_parameterCorrect && isServer) then {
	_unitsPlaced = (units _groupPlaced);
	// check if unit has AI and change ownership (TODO check for headless clients)
	_unitsHaveAI = false;
	{
		if (_x isKindOf "Man") exitWith {_unitsHaveAI = true};
	} forEach _unitsPlaced;
	_localityChanged = false;
	if (_unitsHaveAI) then {
		if(!isNil "Spec_var_ownerList") then {
			_localityChanged = _groupPlaced setGroupOwner (Spec_var_ownerList select 0);
		};
	};
	// make group editable for allCurators
	if(_localityChanged) then {
		{
			_x addCuratorEditableObjects [_unitsPlaced,true];
		} forEach allCurators;
	} else {
		{
			_x addCuratorEditableObjects [_unitsPlaced,true];
		} forEach (allCurators - [_curator]);
	};
};
true
