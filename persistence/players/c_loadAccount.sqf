private["_donation","_UID"];
sleep 3;
player globalchat "Loading player account...";

//Requests info from server in order to download stats
_UID = getPlayerUID player;

if ((call config_player_donations_enabled) == 1) then {
	// Get any donation info they might have made
	_donation = _UID + "_donation";
	[_donation, _donation, "DonationMoney", "NUMBER"] call sendToServer;
};

// Player location + health
[_UID, _UID, "Health", "NUMBER"] call sendToServer;
[_UID, _UID, "Position", "ARRAY"] call sendToServer;
[_UID, _UID, "Direction", "NUMBER"] call sendToServer;

// Survival + wasteland inventory
{
	[_UID, _UID, _x, "NUMBER"] call sendToServer;
} forEach mf_inventory_registered_item_ids;

// Player inventory
[_UID, _UID, "Uniform", "STRING"] call sendToServer;
[_UID, _UID, "Vest", "STRING"] call sendToServer;
[_UID, _UID, "Backpack", "STRING"] call sendToServer;

// Wait on these as we need them present to fit in everything they had on them
waitUntil {!isNil "uniformLoaded"};		
waitUntil {!isNil "vestLoaded"};
waitUntil {!isNil "backpackLoaded"};
	
//wait until everything has loaded in to add items

[_UID, _UID, "Items", "ARRAY"] call sendToServer;
waitUntil {!isNil "itemsLoaded"};

[_UID, _UID, "PrimaryWeapon", "STRING"] call sendToServer;
[_UID, _UID, "SecondaryWeapon", "STRING"] call sendToServer;
[_UID, _UID, "HandgunWeapon", "STRING"] call sendToServer;
waitUntil {!isNil "primaryLoaded"};
waitUntil {!isNil "secondaryLoaded"};
waitUntil {!isNil "handgunLoaded"};

[_UID, _UID, "PrimaryItems", "ARRAY"] call sendToServer;
[_UID, _UID, "SecondaryItems", "ARRAY"] call sendToServer;
[_UID, _UID, "HandgunItems", "ARRAY"] call sendToServer;

[_UID, _UID, "PrimaryMagazine", "ARRAY"] call sendToServer;
[_UID, _UID, "SecondaryMagazine", "ARRAY"] call sendToServer;
[_UID, _UID, "HandgunMagazine", "ARRAY"] call sendToServer;

[_UID, _UID, "HeadGear", "STRING"] call sendToServer;
[_UID, _UID, "Goggles", "STRING"] call sendToServer;

[_UID, _UID, "Magazines", "ARRAY"] call sendToServer;

//===========================================================================

//END
statsLoaded = 1;
titleText ["","BLACK IN",4];
player globalchat "Player account loaded!";
