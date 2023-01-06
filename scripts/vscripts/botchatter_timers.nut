//------------------------------------------------------
//     Author : smilzo
//     https://steamcommunity.com/id/smilz0
//------------------------------------------------------

if (!("BotChatterTimers" in getroottable()))
{
	::BotChatterTimers <-
	{
		DummyEnt = null
		Timers = {}
		Thinkers = {}
	}

	::BotChatterTimers.AddTimer <- function(name, delay, func, params = {}, repeat = false)
	{
		if (!name || name == "")
			name = UniqueString();
		else if (name in ::BotChatterTimers.Timers)
		{
			error("[BotChatterTimers][WARN] AddTimer - A timer with this name already exists: " + name + "\n");
			return false;
		}
		
		local si = getstackinfos(2);
		local f = "";
		local s = "";
		local l = "";
		if ("func" in si)
			f = si.func;
		if ("src" in si)
			s = si.src;
		if ("line" in si)
			l = si.line;
		local dbgInfo = "Func: " + f + " - Src: " + s + " - Line: " + l;
		
		local timer = { Delay = delay, Func = func, params = params, Repeat = repeat, LastTime = Time(), DbgInfo = dbgInfo };
		::BotChatterTimers.Timers[name] <- timer;
		
		return true;
	}

	::BotChatterTimers.RemoveTimer <- function(name)
	{
		if (!(name in ::BotChatterTimers.Timers))
		{
			//error("[BotChatterTimers][WARN] RemoveTimer - A timer with this name does not exist: " + name + "\n");
			return false;
		}
		
		delete ::BotChatterTimers.Timers[name];
		
		return true;
	}

	::BotChatterTimers.ThinkFunc <- function()
	{
		local curtime = Time();
		
		foreach (timerName, timer in ::BotChatterTimers.Timers)
		{
			if ((curtime - timer.LastTime) >= timer.Delay)
			{
				if (timer.Repeat)
					timer.LastTime = curtime;
				else
					delete ::BotChatterTimers.Timers[timerName];
				
				try
				{
					timer.Func(timer.params);
				}
				catch(exception)
				{
					error("[BotChatterTimers][ERROR] Exception in timer '" + timerName + "': " + exception + " (" + timer.DbgInfo + ")\n");
				}
			}
		}
		
		return 0.01;
	}
	
	::BotChatterTimers.AddThinker <- function(name, delay, func, params = {})
	{
		if (!name || name == "")
			name = UniqueString();
		else if (name in ::BotChatterTimers.Thinkers)
		{
			error("[BotChatterTimers][WARN] AddThinker - A thinker with this name already exists: " + name + "\n");
			return false;
		}
		
		local si = getstackinfos(2);
		local f = "";
		local s = "";
		local l = "";
		if ("func" in si)
			f = si.func;
		if ("src" in si)
			s = si.src;
		if ("line" in si)
			l = si.line;
		local dbgInfo = "Func: " + f + " - Src: " + s + " - Line: " + l;
		
		local thinkerEnt = SpawnEntityFromTable("info_target", { targetname = "botchattertimers_" + name });
		if (!thinkerEnt || !thinkerEnt.IsValid())
		{
			error("[BotChatterTimers][ERROR] Failed to spawn thinker entity for thinker '" + name + "'!\n");
			return false;
		}
		
		thinkerEnt.ValidateScriptScope();
		local scope = thinkerEnt.GetScriptScope();
		scope.ThinkerName <- name;
		scope.ThinkerDelay <- delay;
		scope.ThinkerFunc <- func;
		scope.ThinkerParams <- params;
		scope.ThinkerDbgInfo <- dbgInfo;
		scope["ThinkerThinkFunc"] <- ::BotChatterTimers.ThinkerThinkFunc;
		AddThinkToEnt(thinkerEnt, "ThinkerThinkFunc");
			
		local thinker = { Delay = delay, Func = func, params = params, Ent = thinkerEnt, DbgInfo = dbgInfo };
		::BotChatterTimers.Thinkers[name] <- thinker;
		
		return true;
	}
	
	::BotChatterTimers.RemoveThinker <- function(name)
	{
		if (!(name in ::BotAIFixTimers.Thinkers))
		{
			//error("[BotChatterTimers][WARN] RemoveThinker - A thinker with this name does not exist: " + name + "\n");
			return false;
		}
		
		local thinkerEnt = ::BotAIFixTimers.Thinkers[name].Ent;
		if (thinkerEnt && thinkerEnt.IsValid())
			thinkerEnt.Kill();
		else
			error("[BotChatterTimers][WARN] RemoveThinker - Thinker '" + name + "' had no valid entity\n");
		
		delete ::BotChatterTimers.Thinkers[name];
		
		return true;
	}
	
	::BotChatterTimers.ThinkerThinkFunc <- function()
	{
		try
		{
			ThinkerFunc(ThinkerParams);
		}
		catch(exception)
		{
			error("[BotChatterTimers][ERROR] Exception in thinker '" + ThinkerName + "': " + exception + " (" + ThinkerDbgInfo + ")\n");
		}
		
		return ThinkerDelay;
	}
}

if (!::BotChatterTimers.DummyEnt || !::BotChatterTimers.DummyEnt.IsValid())
{
	::BotChatterTimers.DummyEnt = SpawnEntityFromTable("info_target", { targetname = "botchattertimers" });
	if (::BotChatterTimers.DummyEnt)
	{
		::BotChatterTimers.DummyEnt.ValidateScriptScope();
		local scope = ::BotChatterTimers.DummyEnt.GetScriptScope();
		scope["L4TThinkFunc"] <- ::BotChatterTimers.ThinkFunc;
		AddThinkToEnt(::BotChatterTimers.DummyEnt, "L4TThinkFunc");
			
		printl("[BotChatterTimers][DEBUG] Spawned dummy entity");
	}
	else
		error("[BotChatterTimers][ERROR] Failed to spawn dummy entity!\n");
}
else
	printl("[BotChatterTimers][DEBUG] Dummy entity already spawned");
