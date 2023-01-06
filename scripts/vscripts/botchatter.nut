//------------------------------------------------------
//     Author : T-Rizzle
//------------------------------------------------------

	::BotChatter <-
	{
		Ready = 1
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
		Msg(modename);
		Msg(mapname);
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
			local down_line = RandomInt(0,2);
			if(down_line == 0)
			{
				Say(player, "I'm Down!", false);
			}
			else if(down_line == 1)
			{
				Say(player, "I need some help!", false);
			}
			else if(down_line == 2)
			{
				Say(player, "Help me!", false);
			}
		}
	}
	::BotChatter.OnPlayerLedgeGrab <- function (player, params)
	{
		if(IsPlayerABot(player))
		{	
			//local player = player.GetPlayerUserId();
			local down_line = RandomInt(0,3);
			if(down_line == 0)
			{
				Say(player, "I'm hanging off the side of this ledge!", false);
			}
			else if(down_line == 1)
			{
				Say(player, "I need some help!", false);
			}
			else if(down_line == 2)
			{
				Say(player, "I need a little help over here!", false);
			}
			else if(down_line == 3)
			{
				Say(player, "I slipped!", false);
			}
		}
	}
	::BotChatter.OnChargerPummelStart <- function (player, params)
	{
		if(IsPlayerABot(player))
		{	
			//local player = player.GetPlayerUserId();
			local pummel_line = RandomInt(0,2);
			if(pummel_line == 0)
			{
				Say(player, "Help a charger is crushing me!", false);
			}
			else if(pummel_line == 1)
			{
				Say(player, "I need some help!", false);
			}
			else if(pummel_line == 2)
			{
				Say(player, "Charger got me!", false);
			}
		}
	}
	::BotChatter.OnSmokerTongueGrab <- function (player, params)
	{
		if(IsPlayerABot(player))
		{	
			//local player = player.GetPlayerUserId();
			local smoker_line = RandomInt(0,2);
			if(smoker_line == 0)
			{
				Say(player, "Help a smoker got me!", false);
			}
			else if(smoker_line == 1)
			{
				Say(player, "I need some help!", false);
			}
			else if(smoker_line == 2)
			{
				Say(player, "Someone rescue me!", false);
			}
		}
	}
	::BotChatter.OnJockeyRide <- function (player, params)
	{
		if(IsPlayerABot(player))
		{	
			//local player = player.GetPlayerUserId();
			local jockey_line = RandomInt(0,2);
			if(jockey_line == 0)
			{
				Say(player, "Help a jockey is riding me!", false);
			}
			else if(jockey_line == 1)
			{
				Say(player, "I need some help!", false);
			}
			else if(jockey_line == 2)
			{
				Say(player, "Get this thing off of me!", false);
			}
		}
	}
	::BotChatter.OnHunterPounce <- function (player, params)
	{
		if(IsPlayerABot(player))
		{	
			//local player = player.GetPlayerUserId();
			local hunter_line = RandomInt(0,2);
			if(hunter_line == 0)
			{
				Say(player, "Help a hunter pounced me!", false);
			}
			else if(hunter_line == 1)
			{
				Say(player, "I need some help!", false);
			}
			else if(hunter_line == 2)
			{
				Say(player, "Get this thing off of me!", false);
			}
		}
	}
	::BotChatter.OnPlayerEnteredCheckpoint <- function (player, params)
	{
		if(IsPlayerABot(player) && player.IsSurvivor() && 10 < player.GetAliveDuration())
		{	
			//local player = player.GetPlayerUserId();
			local saferoom_line = RandomInt(0,2);
			if(saferoom_line == 0)
			{
				Say(player, "We made it!", false);
			}
			else if(saferoom_line == 1)
			{
				Say(player, "We have a saferoom ahead!", false);
			}
			else if(saferoom_line == 2)
			{
				Say(player, "Get in here right now!", false);
			}
		}
	}
	::BotChatter.OnPlayerLeftCheckpoint <- function (player, params)
	{
		if(IsPlayerABot(player) && player.IsSurvivor() &&  10 < player.GetAliveDuration())
		{	
			//local player = player.GetPlayerUserId();
			local saferoom_line = RandomInt(0,3);
			if(saferoom_line == 0)
			{
				Say(player, "Lets do this!", false);
			}
			else if(saferoom_line == 1)
			{
				Say(player, "Ready for some fun!", false);
			}
			else if(saferoom_line == 2)
			{
				Say(player, "Time to go!", false);
			}
			else if(saferoom_line == 3)
			{
				Say(player, "Lets go!", false);
			}
		}
	}
	::BotChatter.OnReviveEnd <- function (player, last_incap, params)
	{	
		if(IsPlayerABot(player))
		{
			//local player = player.GetPlayerUserId();
			if(last_incap)
			{
				local last_line = RandomInt(0,2);
				
				if(last_line == 0)
				{
					Say(player, "Guys, if I go down again, i'm dead.", true);
				}
				else if(last_line == 1)
				{
					Say(player, "I need some first aid or i'm gonna die.", true);
				}
				else if(last_line == 2)
				{
					Say(player, "I'm not gonna make it much further without some first aid.", true);
				}
			}
			else
			{
				local revive_line = RandomInt(0,2);
				
				if(revive_line == 0)
				{
					Say(player, "Thank you!", false);
				}
				else if(revive_line == 1)
				{
					Say(player, "Thank's for the help.", false);
				}
				else if(revive_line == 2)
				{
					Say(player, "Thank you for saving me.", false);
				}
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