//------------------------------------------------------
//     Author : T-Rizzle
//------------------------------------------------------

printl("Including botchatter_events...");
printl("Bot Chatter starting up!");

::BotChatter.Events.OnGameEvent_heal_begin <- function (params)
{
	local healer = g_MapScript.GetPlayerFromUserID(params["userid"]);
	local healee = g_MapScript.GetPlayerFromUserID(params["subject"]);

	BotChatter.OnHealStart(healer, healee, params);
}

::BotChatter.Events.OnGameEvent_revive_begin <- function (params)
{
	local player = g_MapScript.GetPlayerFromUserID(params["userid"]);
	local subject = g_MapScript.GetPlayerFromUserID(params["subject"]);

	BotChatter.OnReviveBegin(player, subject, params);
}

::BotChatter.Events.OnGameEvent_player_hurt <- function (params)
{	
	if ("userid" in params && "attacker" in params)
	{
		local player = g_MapScript.GetPlayerFromUserID(params["userid"]);
		local player2 = g_MapScript.GetPlayerFromUserID(params["attacker"]);
	
		BotChatter.OnFriendlyFire(player, player2, params);
	}
}

::BotChatter.Events.OnGameEvent_player_incapacitated <- function (params)
{
	local player = g_MapScript.GetPlayerFromUserID(params["userid"]);

	BotChatter.OnPlayerIncapacitated(player, params);
}

::BotChatter.Events.OnGameEvent_player_ledge_grab <- function (params)
{
	local player = g_MapScript.GetPlayerFromUserID(params["userid"]);
	
	BotChatter.OnPlayerLedgeGrab(player, params);
}

::BotChatter.Events.OnGameEvent_charger_pummel_start <- function (params)
{
	local player = g_MapScript.GetPlayerFromUserID(params["victim"]);
	
	BotChatter.OnChargerPummelStart(player, params);
}

::BotChatter.Events.OnGameEvent_tongue_grab <- function (params)
{
	local player = g_MapScript.GetPlayerFromUserID(params["victim"]);
	
	BotChatter.OnSmokerTongueGrab(player, params);
}

::BotChatter.Events.OnGameEvent_jockey_ride <- function (params)
{
	local player = g_MapScript.GetPlayerFromUserID(params["victim"]);
	
	BotChatter.OnJockeyRide(player, params);
}

::BotChatter.Events.OnGameEvent_lunge_pounce <- function (params)
{
	local player = g_MapScript.GetPlayerFromUserID(params["victim"]);
	
	BotChatter.OnHunterPounce(player, params);
}

::BotChatter.Events.OnGameEvent_player_entered_checkpoint <- function (params)
{
	if ("userid" in params)
	{
		local player = g_MapScript.GetPlayerFromUserID(params["userid"]);
	
		BotChatter.OnPlayerEnteredCheckpoint(player, params);
	}
}

::BotChatter.Events.OnGameEvent_player_left_checkpoint <- function (params)
{
	if ("userid" in params)
	{
		local player = g_MapScript.GetPlayerFromUserID(params["userid"]);
		BotChatter.OnPlayerLeftCheckpoint(player, params);
	}
}

::BotChatter.Events.OnGameEvent_revive_success <- function (params)
{
	local player = g_MapScript.GetPlayerFromUserID(params["subject"]);
	local last_incap = params["lastlife"];
	
	BotChatter.OnReviveEnd(player, last_incap, params);
}

::BotChatter.Events.OnGameEvent_player_death <- function (params)
{
	if ("attacker" in params)
	{
		local player = g_MapScript.GetPlayerFromUserID(params["attacker"]);
		
		BotChatter.OnInfectedDeath(player, params);
	}
}

::BotChatter.Events.OnGameEvent_round_end <- function (params)
{
	BotChatter.OnRoundEnd(params);
}
::BotChatter.Events.OnGameEvent_map_transition <- function (params)
{
	BotChatter.OnMapTransition(params);
}

__CollectEventCallbacks(::BotChatter.Events, "OnGameEvent_", "GameEventCallbacks", RegisterScriptGameEventListener);
