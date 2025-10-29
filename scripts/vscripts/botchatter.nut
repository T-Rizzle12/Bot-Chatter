//------------------------------------------------------
//     Author : T-Rizzle
//------------------------------------------------------

	::BotChatter <-
	{
		Events = {}
	}
	::BotChatter.FileExists <- function (fileName)
	{
		local fileContents = FileToString(fileName);
		if (fileContents == null)
			return false;

		return true;
	}
	::BotChatter.StringReplace <- function (str, orig, replace)
	{
		local expr = regexp(orig);
		local ret = "";
		local pos = 0;
		local captures = null;

		while (captures = expr.capture(str, pos))
		{
			foreach (i, c in captures)
			{
				ret += str.slice(pos, c.begin);
				ret += replace;
				pos = c.end;
			}
		}

		if (pos < str.len())
			ret += str.slice(pos);

		return ret;
	}
	::BotChatter.Initialize <- function (modename, mapname)
	{
		printl(modename);
		printl(mapname);
		if(!BotChatter.FileExists("botchatter/cfg/kill_lines.txt"))
		{
			local Array =
			[
				"Are we there yet?",
				"I need more coffee!",
				"Pow! You are dead!",
				"Nope!",
				"Boink!",
				"Notice!",
				"I sniped the sniper!",
				"THIS IS SPARTA!",
				"I'm just that good at this game!",
				"Your a FAT! *insert maniacal laughter here*",
				"Kaboom!",
				"*insert funny joke here*",
				"Nope.avi moment!",
				"AMONGUS!",
				"This is my world, you are not welcome in my world!",
				"You are dead no big suprise!",
				"Rip!",
				"This thing ain't on autopilot son!",
				"You are like a car crash in slow motion, its like i'm watching you fly through a windshield!",
				"Can a charger charge my Iphone?",
				"Jockeys are so annoying!",
				"Why are we still here, just to suffer!",
				"Bonk!",
				"LMG PRO!",
				"That's what i'm talking about!",
				"Great team effort everyone!",
				"Epic!",
				"Nice shooting people!",
				"Watch out!",
				"Here they come!",
				"Go Go Go, keep shooting!",
				"Don't stop shooting!",
				"Open Fire!",
				"EAT LEAD!",
				"Whats worse, a tank or a teamkiller?",
				"The FitnessGram Pacer Test is a multistage aerobic capacity test that progressively gets more difficult as it continues.",
			]
			local fileContents2 = ""
			foreach(str in Array)
			{
				if (fileContents2 == "")
					fileContents2 = str;
				else
					fileContents2 += "\n" + str;
			}
			StringToFile("botchatter/cfg/kill_lines.txt", fileContents2);
		}
		local fileContents = FileToString("botchatter/cfg/kill_lines.txt");
		fileContents = BotChatter.StringReplace(fileContents, "\\r", "\n");
		fileContents = BotChatter.StringReplace(fileContents, "\\n\\n", "\n");   // Basically: any CRLF combination ("\n", "\r", "\r\n") becomes "\n"

		Array <- split(fileContents, "\n");

		if(!BotChatter.FileExists("botchatter/cfg/incap_lines.txt"))
		{
			local Array =
			[
				"I'm Down!",
				"I need some help!",
				"Help me!",
			]
			local fileContents2 = ""
			foreach(str in Array)
			{
				if (fileContents2 == "")
					fileContents2 = str;
				else
					fileContents2 += "\n" + str;
			}
			StringToFile("botchatter/cfg/incap_lines.txt", fileContents2);
		}
		local fileContents = FileToString("botchatter/cfg/incap_lines.txt");
		fileContents = BotChatter.StringReplace(fileContents, "\\r", "\n");
		fileContents = BotChatter.StringReplace(fileContents, "\\n\\n", "\n");   // Basically: any CRLF combination ("\n", "\r", "\r\n") becomes "\n"

		Incap_Array <- split(fileContents, "\n");

		if(!BotChatter.FileExists("botchatter/cfg/ledge_incap_lines.txt"))
		{
			local Array =
			[
				"I'm hanging off the side of this ledge!",
				"I need some help!",
				"I need a little help over here!",
				"I slipped!",
			]
			local fileContents2 = ""
			foreach(str in Array)
			{
				if (fileContents2 == "")
					fileContents2 = str;
				else
					fileContents2 += "\n" + str;
			}
			StringToFile("botchatter/cfg/ledge_incap_lines.txt", fileContents2);
		}
		local fileContents = FileToString("botchatter/cfg/ledge_incap_lines.txt");
		fileContents = BotChatter.StringReplace(fileContents, "\\r", "\n");
		fileContents = BotChatter.StringReplace(fileContents, "\\n\\n", "\n");   // Basically: any CRLF combination ("\n", "\r", "\r\n") becomes "\n"

		Ledge_Incap_Array <- split(fileContents, "\n");

		if(!BotChatter.FileExists("botchatter/cfg/charger_lines.txt"))
		{
			local Array =
			[
				"Help a charger is crushing me!",
				"I need some help!",
				"Charger got me!",
			]
			local fileContents2 = ""
			foreach(str in Array)
			{
				if (fileContents2 == "")
					fileContents2 = str;
				else
					fileContents2 += "\n" + str;
			}
			StringToFile("botchatter/cfg/charger_lines.txt", fileContents2);
		}
		local fileContents = FileToString("botchatter/cfg/charger_lines.txt");
		fileContents = BotChatter.StringReplace(fileContents, "\\r", "\n");
		fileContents = BotChatter.StringReplace(fileContents, "\\n\\n", "\n");   // Basically: any CRLF combination ("\n", "\r", "\r\n") becomes "\n"

		Charger_Array <- split(fileContents, "\n");

		if(!BotChatter.FileExists("botchatter/cfg/smoker_lines.txt"))
		{
			local Array =
			[
				"Help a smoker got me!",
				"I need some help!",
				"Someone rescue me!",
			]
			local fileContents2 = ""
			foreach(str in Array)
			{
				if (fileContents2 == "")
					fileContents2 = str;
				else
					fileContents2 += "\n" + str;
			}
			StringToFile("botchatter/cfg/smoker_lines.txt", fileContents2);
		}
		local fileContents = FileToString("botchatter/cfg/smoker_lines.txt");
		fileContents = BotChatter.StringReplace(fileContents, "\\r", "\n");
		fileContents = BotChatter.StringReplace(fileContents, "\\n\\n", "\n");   // Basically: any CRLF combination ("\n", "\r", "\r\n") becomes "\n"

		Smoker_Array <- split(fileContents, "\n");

		if(!BotChatter.FileExists("botchatter/cfg/jockey_lines.txt"))
		{
			local Array =
			[
				"Help a jockey is riding me!",
				"I need some help!",
				"Get this thing off of me!",
			]
			local fileContents2 = ""
			foreach(str in Array)
			{
				if (fileContents2 == "")
					fileContents2 = str;
				else
					fileContents2 += "\n" + str;
			}
			StringToFile("botchatter/cfg/jockey_lines.txt", fileContents2);
		}
		local fileContents = FileToString("botchatter/cfg/jockey_lines.txt");
		fileContents = BotChatter.StringReplace(fileContents, "\\r", "\n");
		fileContents = BotChatter.StringReplace(fileContents, "\\n\\n", "\n");   // Basically: any CRLF combination ("\n", "\r", "\r\n") becomes "\n"

		Jockey_Array <- split(fileContents, "\n");

		if(!BotChatter.FileExists("botchatter/cfg/hunter_lines.txt"))
		{
			local Array =
			[
				"Help a hunter pounced me!",
				"I need some help!",
				"Get this thing off of me!",
			]
			local fileContents2 = ""
			foreach(str in Array)
			{
				if (fileContents2 == "")
					fileContents2 = str;
				else
					fileContents2 += "\n" + str;
			}
			StringToFile("botchatter/cfg/hunter_lines.txt", fileContents2);
		}
		local fileContents = FileToString("botchatter/cfg/hunter_lines.txt");
		fileContents = BotChatter.StringReplace(fileContents, "\\r", "\n");
		fileContents = BotChatter.StringReplace(fileContents, "\\n\\n", "\n");   // Basically: any CRLF combination ("\n", "\r", "\r\n") becomes "\n"

		Hunter_Array <- split(fileContents, "\n");

		if(!BotChatter.FileExists("botchatter/cfg/enter_checkpoint_lines.txt"))
		{
			local Array =
			[
				"We made it!",
				"We have a saferoom ahead!",
				"Get in here right now!",
			]
			local fileContents2 = ""
			foreach(str in Array)
			{
				if (fileContents2 == "")
					fileContents2 = str;
				else
					fileContents2 += "\n" + str;
			}
			StringToFile("botchatter/cfg/enter_checkpoint_lines.txt", fileContents2);
		}
		local fileContents = FileToString("botchatter/cfg/enter_checkpoint_lines.txt");
		fileContents = BotChatter.StringReplace(fileContents, "\\r", "\n");
		fileContents = BotChatter.StringReplace(fileContents, "\\n\\n", "\n");   // Basically: any CRLF combination ("\n", "\r", "\r\n") becomes "\n"

		Enter_Checkpoint_Array <- split(fileContents, "\n");

		if(!BotChatter.FileExists("botchatter/cfg/exit_checkpoint_lines.txt"))
		{
			local Array =
			[
				"Lets do this!",
				"Ready for some fun!",
				"Time to go!",
				"Lets go!",
			]
			local fileContents2 = ""
			foreach(str in Array)
			{
				if (fileContents2 == "")
					fileContents2 = str;
				else
					fileContents2 += "\n" + str;
			}
			StringToFile("botchatter/cfg/exit_checkpoint_lines.txt", fileContents2);
		}
		local fileContents = FileToString("botchatter/cfg/exit_checkpoint_lines.txt");
		fileContents = BotChatter.StringReplace(fileContents, "\\r", "\n");
		fileContents = BotChatter.StringReplace(fileContents, "\\n\\n", "\n");   // Basically: any CRLF combination ("\n", "\r", "\r\n") becomes "\n"

		Exit_Checkpoint_Array <- split(fileContents, "\n");

		if(!BotChatter.FileExists("botchatter/cfg/black_and_white_lines.txt"))
		{
			local Array =
			[
				"Guys, if I go down again, i'm dead.",
				"I need some first aid or i'm gonna die.",
				"I'm not gonna make it much further without some first aid.",
			]
			local fileContents2 = ""
			foreach(str in Array)
			{
				if (fileContents2 == "")
					fileContents2 = str;
				else
					fileContents2 += "\n" + str;
			}
			StringToFile("botchatter/cfg/black_and_white_lines.txt", fileContents2);
		}
		local fileContents = FileToString("botchatter/cfg/black_and_white_lines.txt");
		fileContents = BotChatter.StringReplace(fileContents, "\\r", "\n");
		fileContents = BotChatter.StringReplace(fileContents, "\\n\\n", "\n");   // Basically: any CRLF combination ("\n", "\r", "\r\n") becomes "\n"

		Black_And_White_Array <- split(fileContents, "\n");

		if(!BotChatter.FileExists("botchatter/cfg/after_revive_lines.txt"))
		{
			local Array =
			[
				"Thank you!",
				"Thank's for the help.",
				"Thank you for saving me.",
			]
			local fileContents2 = ""
			foreach(str in Array)
			{
				if (fileContents2 == "")
					fileContents2 = str;
				else
					fileContents2 += "\n" + str;
			}
			StringToFile("botchatter/cfg/after_revive_lines.txt", fileContents2);
		}
		local fileContents = FileToString("botchatter/cfg/after_revive_lines.txt");
		fileContents = BotChatter.StringReplace(fileContents, "\\r", "\n");
		fileContents = BotChatter.StringReplace(fileContents, "\\n\\n", "\n");   // Basically: any CRLF combination ("\n", "\r", "\r\n") becomes "\n"

		After_Revive_Array <- split(fileContents, "\n");
	}
	::BotChatter.OnRoundStart <- function (params)
	{
		BotChatterTimers.AddTimer("RandomVocal", 1.0, BotChatter.RandomVocal, {}, true);
	}
	::BotChatter.AddonStop <- function ()
	{
		BotChatter.RemoveTimer("RandomVocal");
	}
	::BotChatter.OnRoundEnd <- function (params)
	{
		BotChatter.AddonStop();
	}
	::BotChatter.OnMapTransition <- function (params)
	{
		BotChatter.AddonStop();
	}
	::BotChatter.RandomVocal <- function (params)
	{
		local player = null;
		while(player = Entities.FindByClassname(player, "player"))
		{
			if(player.IsValid() && player.IsSurvivor() && !player.IsDead() && !player.IsDying())
			{
				local rand = RandomInt(0,100)
				if(rand == 0)
				{
					DoEntFire("!self", "SpeakResponseConcept", "Laugh", 0.0, null, player);
				}
			}
		}
	}
	::BotChatter.OnHealStart <- function (healer, healee, params)
	{
		if(IsPlayerABot(healer))
		{
			//local healer = healer.GetPlayerUserId();
			//local healee = healee.GetPlayerUserId();
			local heal_line = RandomInt(0,3);
			local being_healed = "";
			local being_healed = healee.GetPlayerName();

			if(healer.IsInCombat() && heal_line == 0 && healer != healee)
			{
				Say(healer, "Keep them off me while I heal you!", false);
			}
			else if(heal_line == 0 && healer != healee)
			{
				Say(healer, "Hold up let me heal you " + being_healed + "!", false);
			}
		}
	}
	::BotChatter.OnReviveBegin <- function (player, subject, params)
	{
		if(IsPlayerABot(player))
		{
			//local player = player.GetPlayerUserId();
			//local subject = subject.GetPlayerUserId();
			local revive_line = RandomInt(0,3);

			if(player.IsInCombat() && revive_line == 0)
			{
				Say(player, "Keep them off me while I revive you!", false);
			}
		}
	}
	::BotChatter.OnFriendlyFire <- function (player, player2, params)
	{
		if(player != null && player2 != null && player != player2)
		{
			if(IsPlayerABot(player2) && player.IsSurvivor() && player2.IsSurvivor())
			{
				local ff_line = RandomInt(0,22);
				local affected = "";
				local affected = player.GetPlayerName();
				if(ff_line == 0)
				{
					Say(player2, "Sorry about that, " + affected + "!", false);
				}
				else if(ff_line == 1)
				{
					Say(player2, "That was an accident!", false);
				}
				else if(ff_line == 2)
				{
					Say(player2, "That was me.... " + affected + " again!", false);
				}
			}
			if(IsPlayerABot(player) && player.IsSurvivor() && player2.IsSurvivor())
			{
				local ff_line = RandomInt(0,22);
				local attacker = "";
				local attacker = player2.GetPlayerName();
				if(ff_line == 0)
				{
					Say(player, "Stop shooting me " + attacker + "!", false);
				}
				else if(ff_line == 1)
				{
					Say(player, "That better be an accident!", false);
				}
				else if(ff_line == 2)
				{
					Say(player, "Seriously " + attacker + " stop!", false);
				}
			}
		}
	}
	::BotChatter.OnPlayerIncapacitated <- function (player, params)
	{
		if(IsPlayerABot(player) && player.IsSurvivor())
		{
			//local player = player.GetPlayerUserId();
			local down_line = RandomInt(0,(Incap_Array.len() - 1));
			Say(player, Incap_Array[down_line], false);
		}
	}
	::BotChatter.OnPlayerLedgeGrab <- function (player, params)
	{
		if(IsPlayerABot(player))
		{
			//local player = player.GetPlayerUserId();
			local down_line = RandomInt(0,(Ledge_Incap_Array.len() - 1));
			Say(player, Ledge_Incap_Array[down_line], false);
		}
	}
	::BotChatter.OnChargerPummelStart <- function (player, params)
	{
		if(IsPlayerABot(player))
		{
			//local player = player.GetPlayerUserId();
			local pummel_line = RandomInt(0,(Charger_Array.len() - 1));
			Say(player, Charger_Array[pummel_line], false);
		}
	}
	::BotChatter.OnSmokerTongueGrab <- function (player, params)
	{
		if(IsPlayerABot(player))
		{
			//local player = player.GetPlayerUserId();
			local smoker_line = RandomInt(0,(Smoker_Array.len() - 1));
			Say(player, Smoker_Array[smoker_line], false);
		}
	}
	::BotChatter.OnJockeyRide <- function (player, params)
	{
		if(IsPlayerABot(player))
		{
			//local player = player.GetPlayerUserId();
			local jockey_line = RandomInt(0,(Jockey_Array.len() - 1));
			Say(player, Jockey_Array[jockey_line], false);
		}
	}
	::BotChatter.OnHunterPounce <- function (player, params)
	{
		if(IsPlayerABot(player))
		{
			//local player = player.GetPlayerUserId();
			local hunter_line = RandomInt(0,(Hunter_Array.len() - 1));
			Say(player, Hunter_Array[hunter_line], false);
		}
	}
	::BotChatter.OnPlayerEnteredCheckpoint <- function (player, params)
	{
		if(IsPlayerABot(player) && player.IsSurvivor() && Director.IsAnySurvivorInExitCheckpoint() && NetProps.GetPropInt(player, "m_iTeamNum") == 2)
		{
			//local player = player.GetPlayerUserId();
			local saferoom_line = RandomInt(0,(Enter_Checkpoint_Array.len() - 1));
			Say(player, Enter_Checkpoint_Array[saferoom_line], false);
		}
	}
	::BotChatter.OnPlayerLeftCheckpoint <- function (player, params)
	{
		if(IsPlayerABot(player) && player.IsSurvivor() && Director.HasAnySurvivorLeftSafeArea() && NetProps.GetPropInt(player, "m_iTeamNum") == 2)
		{
			//local player = player.GetPlayerUserId();
			local saferoom_line = RandomInt(0,(Exit_Checkpoint_Array.len() - 1));
			Say(player, Exit_Checkpoint_Array[saferoom_line], false);
		}
	}
	::BotChatter.OnReviveEnd <- function (player, last_incap, params)
	{
		if(IsPlayerABot(player))
		{
			//local player = player.GetPlayerUserId();
			if(last_incap)
			{
				local last_line = RandomInt(0,(Black_And_White_Array.len() - 1));
				Say(player, Black_And_White_Array[last_line], true);
			}
			else
			{
				local revive_line = RandomInt(0,(After_Revive_Array.len() - 1));
				Say(player, After_Revive_Array[revive_line], false);
			}
		}
	}
	::BotChatter.OnInfectedDeath <- function (player, params)
	{
		if(IsPlayerABot(player) && player.IsSurvivor())
		{
			//local player = player.GetPlayerUserId();
			local num = RandomInt(0, (Array.len() - 1));
			local kill_line = RandomInt(0,(250 + num));
			if(kill_line <= (Array.len() - 1))
			{
				Say(player, Array[kill_line], false);
			}
		}
	}

IncludeScript("botchatter_events");
