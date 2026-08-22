state("SB-Win64-Shipping", "current")
{
    // patch 1.4.1a
    bool isLoading : 0x70BF018;
	float timeScale : 0x6FFB918, 0x30, 0x268, 0x201C;
	float TimeSeconds : 0x6FFB918, 0x748;
	float UnpausedTimeSeconds : 0x6FFB918, 0x74C;
	int cutsceneFrameNum : 0x07032700, 0x20, 0x0, 0x100;
	//void *AnimationPlayer : 0x07032700, 0x20, 0x0, 0x60;
	//int cutsceneStartFrame : 0x07032700, 0x20, 0x0, 0x60, 0x470;
	//int cutsceneDurationFrames : 0x07032700, 0x20, 0x0, 0x60, 0x474;
	float overrideSubtitleCoolTime : 0x07032700, 0x20, 0x0, 0x60, 0x648, 0x31C;
	string256 cutsceneSequence : 0x07032700, 0x20, 0x0, 0x60, 0x730, 0x0;
}

state("SB-Win64-Shipping", "1.4.1")
{
    // patch 1.4.1
    bool isLoading : 0x70BE018;
	float timeScale : 0x06FFA8F8, 0x30, 0x268, 0x201C;
	float TimeSeconds : 0x06FFA8F8, 0x748;
	float UnpausedTimeSeconds : 0x06FFA8F8, 0x74C;
	int cutsceneFrameNum : 0x07031700, 0x20, 0x0, 0x100;
	//void *AnimationPlayer : 0x07031700, 0x20, 0x0, 0x60;
	//int cutsceneStartFrame : 0x07031700, 0x20, 0x0, 0x60, 0x470;
	//int cutsceneDurationFrames : 0x07031700, 0x20, 0x0, 0x60, 0x474;
	float overrideSubtitleCoolTime : 0x07031700, 0x20, 0x0, 0x60, 0x648, 0x31C;
	string256 cutsceneSequence : 0x07031700, 0x20, 0x0, 0x60, 0x730, 0x0;
}

state("SB-Win64-Shipping", "1.4.0")
{
    // patch 1.4.0
    bool isLoading : 0x70BD3D0;
    int event_id : 0x70C4B68;
}

state("SB-Win64-Shipping", "1.3.2")
{
    // patch 1.3.2
    bool isLoading : 0x70BC050;
    int event_id : 0x70C3B1C;
}

state("SB-Win64-Shipping", "1.3.1")
{
    // patch 1.3.1
    bool isLoading : 0x71099A8;
    int event_id : 0x7110898;
}

state("SB-Win64-Shipping", "1.3.0")
{
    // patch 1.3.0
    bool isLoading : 0x71049C8;
    int event_id : 0x710B8B8;
}

state("SB-Win64-Shipping", "1.2.0")
{
    // patch 1.2.0
    bool isLoading : 0x7103D20;
    int event_id : 0x710B4E4;
}

state("SB-Win64-Shipping", "1.1.0")
{
    bool isLoading : 0x70FD960;
	float timeScale : 0x07038898, 0x30, 0x268, 0x201C;
	float TimeSeconds : 0x07038898, 0x748;
	float UnpausedTimeSeconds : 0x07038898, 0x74C;
	int cutsceneFrameNum : 0x07070FA8, 0x20, 0x0, 0x100;
	//void *AnimationPlayer : 0x07070FA8, 0x20, 0x0, 0x60; //this isn't a real thing im just putting it here for safe keeping
	//int cutsceneStartFrame : 0x07070FA8, 0x20, 0x0, 0x60, 0x470; //signed integer
	//int cutsceneDurationFrames : 0x07070FA8, 0x20, 0x0, 0x60, 0x474; //signed integer
	float overrideSubtitleCoolTime : 0x07070FA8, 0x20, 0x0, 0x60, 0x648, 0x31C;
	string256 cutsceneSequence : 0x07070FA8, 0x20, 0x0, 0x60, 0x730, 0x0;
}

init
{
	//assign version string
	switch (modules.First().ModuleMemorySize)
	{
		default:
			version = "unknown";
			vars.timeScalePtr = null;
			vars.subtitleCoolTimePtr = null;
			break;
		case 362287104: // 362287104 - ver 1.4.1a
			version = "1.4.1a";
			vars.timeScalePtr = new DeepPointer(0x6FFB918, 0x30, 0x268, 0x201C);
			vars.subtitleCoolTimePtr = new DeepPointer(0x07032700, 0x20, 0x0, 0x60, 0x648, 0x31C);
			break;
		case 337035264: // 337035264 - ver 1.4.1
			version = "1.4.1";
			vars.timeScalePtr = new DeepPointer(0x06FFA8F8, 0x30, 0x268, 0x201C);
			vars.subtitleCoolTimePtr = new DeepPointer(0x07031700, 0x20, 0x0, 0x60, 0x648, 0x31C);
			break;
		case 328835072: // 328835072 - ver 1.2.0
			version = "1.2.0";
			vars.timeScalePtr = null;
			vars.subtitleCoolTimePtr = null;
			break;
		case 356278272: // 356278272 - ver 1.1.0
			version = "1.1.0";
			vars.timeScalePtr = new DeepPointer(0x07038898, 0x30, 0x268, 0x201C);
			vars.subtitleCoolTimePtr = new DeepPointer(0x07070FA8, 0x20, 0x0, 0x60, 0x648, 0x31C);
			break;
	}

	vars.AddEventToRegistry = (Func<string, string, string, bool>)((name, eventString, category) => {
		if (settings[name] == false)
			return false;

		vars.eventRegistry.Add(name, new Tuple<string, string>(eventString, category));
		return true;
	});

	if (timer.CurrentPhase == TimerPhase.Running)
	{ //THIS IS JUST DEVELOPMENT QOL
		foreach (var evt in vars.Events) {
			bool alreadyAdded = false;
			// evt[0] = name, evt[1] = event string, evt[2] = section
			if (settings[evt[0]] == true) {
				foreach (var entry in vars.eventRegistry) {
					if (evt[1] == entry.Value.Item1) {
						alreadyAdded = true;
						break;
					}
				}
				if (!alreadyAdded) vars.AddEventToRegistry(evt[0], evt[1], evt[2]);
			}
		}
	}
}

startup
{
	settings.Add("timer_ext", false, "[BETA] Timer options");
	settings.CurrentDefaultParent = "timer_ext";
		settings.Add("cutscene_speedup", false, "[BETA] Speedup unskippable cutscenes and keep LRT in-sync");
		settings.Add("masher_speedup", false, "[BETA] Speedup dialogue mashing sequences");
		settings.Add("time_igt", false, "[DEBUG] Time with just IGT delta, this will skew from realtime during regular gameplay");
		settings.Add("debug_spew", false, "[DEBUG] Spew current sequence ID and frame number to dbgView");
	settings.CurrentDefaultParent = null;

	#region EventSplits
	vars.eventRegistry = new Dictionary<string, Tuple<string, string>>(); // split name, (event string, split category)

	vars.Events = new object[] {
		// Format: { name, eventString, section }

		// Prologue / Star Descent
		new object[] { "Brute Start", "MV_SD20_BruteIntro_Master", "Prologue / Star Descent" },
		new object[] { "Brute Killed", "MV_SD20_AfterBruteBattle_QTE_Master", "Prologue / Star Descent" },

		// Eidos 7
		new object[] { "Eidos 7 Start", "MV_DED01_Intro_Master", "Eidos 7" },
		new object[] { "Find Fusion Cell Cutscene", "Dialogue_DED01_FindFusioncell_03", "Eidos 7" },
		new object[] { "Late Fusion Cell Grab", "Subtitle_DED01_GuideFusioncell", "Eidos 7" }, //this pops if we go back to get the fusion cell after the ambush, should really be an and for the other one
		new object[] { "Abaddon Fight Start", "MV_DED01_EliteNative_Entrance_Master", "Eidos 7" },
		new object[] { "Abaddon Finisher QTE", "MV_DED01_Parkinglot_AfterBattle_Master", "Eidos 7" },
		new object[] { "Left Parking Tower", "MV_DED_Area01_ParkingTower_Exit", "Eidos 7" },
		new object[] { "Flooded Commercial Sector Discovery", "MV_DED02_ShoppingMallEnter_Master", "Eidos 7" },
		new object[] { "Entered Hall of Records", "MV_DED02_WarpToArchive", "Eidos 7" },
		new object[] { "Corruptor Entrance", "MV_DED02_Elite_GrubShooter_Master", "Eidos 7" },
		new object[] { "Corruptor Finisher", "MV_DED02_Elite_GrubShooterFinish_Maste", "Eidos 7" },
		new object[] { "Construction Zone Discovery", "MV_DED02_EnterConstructionSite_Transit", "Eidos 7" },
		new object[] { "All Crane Keycards", "Subtitle_DED02_GetCraneAccess3", "Eidos 7" },
		new object[] { "Second Sewer Camp", "Subtitle_DED03_Find2ndCamp", "Eidos 7" },

		// Gigas
		new object[] { "Gigas Fight Start", "MV_DED03_BetaNative_Intro_01_QTE_Master", "Gigas" },
		new object[] { "Gigas Finisher", "MV_DED03_BetaNative_finish_01_main", "Gigas" },

		// Xion
		new object[] { "Orcal Chamber Cutscene", "MV_Xion06_ElderFirstMeeting", "Xion" },
		new object[] { "Ranged Tutorial Start", "Subtitle_Xion01_P2_RangeDroneTutorial_07", "Xion" },
		new object[] { "Ranged Tutorial End", "Dialogue_Xion01_Phase1_DroneUpgrade", "Xion" },

		// Wasteland
		new object[] { "Wasteland Discovery", "MV_WLA10_Intro", "Wasteland" },
		new object[] { "Quiel Cutscene", "Dialogue_WLA30_NearAltesLabor", "Wasteland" },
		new object[] { "Quiel Killed", "MV_WLA30_RoyalGuard_AfterBattle", "Wasteland" },

		// Altess Levoire
		new object[] { "Button Puzzle Success", "Subtitle_ATL01_Sectora07_02", "Altess Levoire" },
		new object[] { "Air Vent Start", "Subtitle_ATL03_HeatoutletStart_01", "Altess Levoire" },
		new object[] { "Maelstrom Start", "MV_ATL03_OuterwallMove", "Altess Levoire" },
		new object[] { "Maelstrom End", "Subtitle_ATL03_GainHypercell_Drone", "Altess Levoire" },

		// Xion #2
		new object[] { "Xion #2 Tetrapod Landing", "MV_Xion01_PODAfterATLLanding_Main", "Xion #2" },

		// Matrix XI
		new object[] { "Tetrapod Landing", "MV_WLB20_POD_WLB_To_Matrix", "Matrix XI" },
		new object[] { "Collapsed Rail Bridge Start", "Subtitle_ME_Area02_EP_12", "Matrix XI" },
		new object[] { "Stalker Intro Cutscene", "MV_ME03_EliteNative_Entrance", "Matrix XI" },
		new object[] { "Stalker Finisher", "MV_ME03_EliteNative_Finish_Master", "Matrix XI" },
		new object[] { "Underground Sewer End", "Subtitle_ME04_Part1_EP_07", "Matrix XI" },
		new object[] { "Juggernaut Fight Start", "MV_ME05_EliteNative_Entrance_Transit", "Matrix XI" },
		new object[] { "Juggernaut Finisher", "MV_ME05_EliteNative_Finish", "Matrix XI" },
		new object[] { "Left Train Graveyard", "Subtitle_Temp_ME05_EP_Barrack05B", "Matrix XI" },
		new object[] { "Tachy Start Cutscene", "MV_ME06_Tachy_Entrance_Master", "Matrix XI" },
		new object[] { "Tachy Finisher", "MV_ME06_Tachy_Die_Master", "Matrix XI" },

		// Xion #3
		new object[] { "Xion #3 Arrival", "MV_Xion01_AfterMatrix", "Xion #3" },

		// Wasteland/Abyss Levoire
		new object[] { "Crashlanding Cutscene", "MV_WLB10_TetrapodLanding", "Wasteland/Abyss Levoire" },
		new object[] { "Shael Fight Start", "Dialogue_WLB10_NearAbyssLabor_BeforeBattle", "Wasteland/Abyss Levoire" },
		new object[] { "Shael Fight End", "MV_WLB10_RoyalGuard_AfterBattle", "Wasteland/Abyss Levoire" },

		// Abyss Levoire
		new object[] { "Capsule Cluster Room Entered", "Subtitle_AYL03_ClusterRoom_Enter", "Abyss Levoire" },
		new object[] { "Laser Room Entered", "Subtitle_AYL04_LaserEscape_01", "Abyss Levoire" },
		new object[] { "Laser Room End", "Subtitle_AYL04_LaserEscape_05", "Abyss Levoire" },
		new object[] { "Maelstrom Fight Start", "MV_AYL06_Maelstrom", "Abyss Levoire" },
		new object[] { "Legacy 3 Cutscene", "MV_AYL06_Legacy3_GainHyperCell", "Abyss Levoire" },

		// Xion #4
		new object[] { "Landing Cutscene", "MV_Xion01_PODAfterATLLanding_Main", "Xion #4" }, //this has same ID as the one from Xion #2?

		// Spire 4
		new object[] { "Intro Cutscene", "MV_SE01_Intro_Master", "Spire 4" },
		new object[] { "Hypertube Opened", "MV_SE02_ContainerControlTransit", "Spire 4" },
		new object[] { "Belial #1 Start Cutscene", "MV_SE04_Chasing_Master", "Spire 4" },
		new object[] { "Belial #1 End Cutscene", "MV_SE04_WeaponMaster_RunAway", "Spire 4" },
		new object[] { "Space Logistics Complex discovery", "MV_SE05_EntranceView_Main", "Spire 4" },
		new object[] { "Turret Conveyor Exit", "MV_SE05_ElevatorView_Main", "Spire 4" },
		new object[] { "Raphael Space Center Discovery", "MV_SE06_LobbyEntrance_Main", "Spire 4" },
		new object[] { "Belial Fight Start", "MV_SE06_LobbyEliteSpawn_Main", "Spire 4" },
		new object[] { "Belial Finisher", "MV_SE06_LobbyEliteFinish_Main", "Spire 4" },
		new object[] { "Maintenance Sector Entered", "MV_SE07_01_CargoElevatorTeleport_TransitStreaming", "Spire 4" }, //this is a hidden loading screen judging by the name, actual cutscene is MV_SE07_01_CargoElevatorTeleport_Master
		new object[] { "Entering Passenger Lift 161", "MV_SE07_02_PassengerElevatorTeleport_TransitStreaming", "Spire 4" }, //another hidden loading screen, cutscene is MV_SE07_02_PassengerElevatorTeleport_Master
		new object[] { "Vermillion Garden Karakuri Started", "SE08_01_EliteNative_Entrance", "Spire 4" },
		new object[] { "Karakuri Finisher", "MV_SE08_01_EliteNative_QTE_Master", "Spire 4" },
		//orbit elevator has this hidden loading screen too MV_SE08_PassengerElevatorTeleport_Master_TransitStreaming
		new object[] { "Democrawler Start", "MV_SE10_AlphaNative_Entrance_Master", "Spire 4" },
		new object[] { "Democrawler Finisher", "MV_SE10_AlphaNative_QTE_Master", "Spire 4" },
		new object[] { "Spire 4 End", "MV_WLA10_ExoSuitLanding_01", "Spire 4" },

		// Burning Xion
		new object[] { "Unidentified Naytiba Start", "MV_Xion06_RavenAppearance", "Burning Xion" },
		new object[] { "Unidentified Naytiba Finisher", "MV_Xion06_RavenFinish_QTE_Master", "Burning Xion" },

		// Wasteland Endgame
		new object[] { "Approaching Wasteland to Start Boss Rush", "Dialogue_WLA10_POD_Landing", "Wasteland Endgame" },
		new object[] { "Raven Fight Start", "MV_Nest_Intro", "Wasteland Endgame" },
		new object[] { "Raven Finisher", "MV_Nest_RavenBattle_After_Master", "Wasteland Endgame" },

		// Nest
		new object[] { "Adam Cutscene", "MV_Nest_EncounterAdam_Master_En", "Nest" },
		new object[] { "Providence Finisher", "MV_Nest_FinalBattle_Lily_QTE_S01_Master", "Nest" },
		new object[] { "Adam Transitions Into Elder Naytiba", "MV_Nest_BattleAdam_Phase2_Master", "Nest" },
		new object[] { "Elder Naytiba Finisher", "MV_Nest_FinalBattle_Adam_QTE_S01_Master", "Nest" },
		new object[] { "Return to the Colony", "MV_Nest_BattleAdam_After_03", "Nest" } //this can probably go now
    };

    var lastSection = "";
    foreach (var evt in vars.Events) {
        var section = evt[2];
        var name = evt[0];
        if (section != lastSection) {
            settings.Add(section);
            lastSection = section;
        }
        settings.Add(name, false, name, section);
    }
    #endregion

	//reset tracked IGT
	vars.trackedTime = TimeSpan.Zero;
	vars.EventString = null;
	vars.inCutscene = false;
	vars.inDialogueMasher = false;
}

onStart
{
    #region Event Splits
    vars.eventRegistry.Clear();
    foreach (var evt in vars.Events) {
		// evt[0] = name, evt[1] = event string, evt[2] = section
        if (settings[evt[0]] == true) {
            vars.AddEventToRegistry(evt[0], evt[1], evt[2]);
        }
    }
    #endregion

	//reset tracked IGT
	vars.trackedTime = TimeSpan.Zero;
}

isLoading
{
    return current.isLoading;
}

gameTime
{
	if (timer.IsGameTimePaused || current.isLoading) { //don't tick timer on the loading screen at all
		vars.trackedTime = timer.CurrentTime.GameTime;
		return vars.trackedTime;
	}

	//UnpausedTimeSeconds is from GWorld, but resets on checkpoint reload/map change, so we track time by adding the delta between updates in vars.trackedTime
	float delta = current.UnpausedTimeSeconds - old.UnpausedTimeSeconds;

	if (settings["time_igt"]) { //we just want the unfiltered IGT
		vars.trackedTime = TimeSpan.FromSeconds(vars.trackedTime.TotalSeconds + delta);
		return vars.trackedTime;
	}

	if (delta <= 0.0f)
	{ //reloaded checkpoint or UnpausedTimeSeconds rolled back, don't add delta
		//print("reloaded checkpoint or something");
		vars.trackedTime = timer.CurrentTime.GameTime;
		return vars.trackedTime;
	}

	if (current.timeScale <= 2.5f && !vars.inDialogueMasher && current.timeScale == old.timeScale)
	{
		//normal, act like LRT
		//Infinite Pierce speeds the game up by 2.5x very briefly, which is why we're comparing to that
		//This is necessary or else our new IGT tracking will deviate too much from LRT, as RealWorldSeconds doesn't tick when opening pause menu/loading
		vars.trackedTime = timer.CurrentTime.GameTime;
		return vars.trackedTime;
	}

	vars.trackedTime = TimeSpan.FromSeconds(vars.trackedTime.TotalSeconds + delta); //why does this work but not vars.trackedTime.Add LMFAO??
	//print(vars.trackedTime.ToString());
	return vars.trackedTime;
}

split
{
	if (settings["debug_spew"]) {
		return (current.cutsceneSequence != old.cutsceneSequence && old.cutsceneSequence == "Dialogue_POD_ToXion1st");
	}

	if (current.cutsceneSequence != old.cutsceneSequence) {
		foreach (var entry in vars.eventRegistry) {
			// entry.Value.Item1 is the event string
			if (current.cutsceneSequence == entry.Value.Item1) {
				vars.eventRegistry.Remove(entry.Key);
				return true;
			}
		}
	}

	if (timer.CurrentSplitIndex == (timer.Run.Count - 1))
	{ //only do this on final split
		switch ((string)current.cutsceneSequence)
		{ //auto end, split on credits
			case "MV_Nest_LilyEnding_Credits_Save": //"true" ending
				return (current.cutsceneFrameNum >= 370);
			case "MV_Nest_BattleAdam_After_03": //"bad" ending
				return (current.cutsceneFrameNum >= 3520);
			case "MV_Nest_LilyEnding_Credits_Die": //"worst" ending
				return (current.cutsceneFrameNum >= 175);
		}
	}
}

reset
{
	return (current.cutsceneSequence != old.cutsceneSequence && current.cutsceneSequence == "MV_Prologue_Main");
}

start
{
	if (settings["debug_spew"]) {
		return (current.cutsceneSequence != old.cutsceneSequence && current.cutsceneSequence == "Dialogue_POD_ToXion1st");
	}

	// 47 to 48 -- press continue
	// 53 to 54 -- new game or new game plus
	// 49 to 50 -- ng or ng+ on some systems, unsure what the difference is
	//return ((current.event_id == 54 || current.event_id == 50 || current.event_id == 53 || current.event_id== 47) && (old.event_id + 1) == current.event_id);

	return (current.cutsceneSequence != old.cutsceneSequence && current.cutsceneSequence == "MV_Prologue_Main");
}

update
{
	//debug
	if (settings["debug_spew"]) {
		if ((current.cutsceneSequence != null && current.cutsceneSequence != old.cutsceneSequence)
			|| current.cutsceneFrameNum != old.cutsceneFrameNum) {
			print("framenumber: " + current.cutsceneFrameNum.ToString() + " cutscene: " + current.cutsceneSequence);
		}
	}

	#region Cutscenes Speedup
	//Need to test each sequence and make sure the timing hasn't deviated too much from the old LRT before adding more
	//How this works is we check the ID of the currently playing animationSequence and define a range of frames that
	//we speed up by, currently we're setting the global timeDilation property, but we can probably just speed up the actual sequenceplayer instead
	//I have plugged in a few dialogue mashing sections, these work the same way, but we also write to another field that overrides the
	//cooldown at which we can skip dialogue via the A button, we do this by a factor of the timescale.  These I am most worried about deviating.
	if (settings["cutscene_speedup"] && vars.timeScalePtr != null)
	{
		float timeScaleOverride = -1.0f;
		float timeScaleDesired = 67.67f; //override the speedup rate depending on the scene
		int speed_startFrame = -1;
		int speed_endFrame = -1;

		if (current.cutsceneSequence != null && //this is probably the only condition we need now
			current.cutsceneFrameNum > old.cutsceneFrameNum) //do this while the cutsceneFrameNum is being incremented
		{
			vars.inCutscene = true; //this is probably doing nothing RN
			vars.inDialogueMasher = false;

			switch ((string)current.cutsceneSequence)
			{
				default: break;
				case "MV_DED01_Intro_Master": //~29.30 seconds
					speed_startFrame = -1150;
					speed_endFrame = -367; //end about a second before skip prompt appears
					break;
				//the delay before you can mash isn't time dilated, we work around it by writing to a cooldown override variable,
				//but that isn't used reliably in every sequence.  need to test each dialogue masher and ensure the time doesn't deviate too heavily
				case "MV_DED03_DropPod": //~12.75 seconds
					speed_startFrame = 5100;
					speed_endFrame = 5700;
					timeScaleDesired = 20.0f;
					break;
				case "Dialogue_POD_ToXion1st": //~44.15 seconds
					speed_startFrame = -240;
					speed_endFrame = 5950;
					timeScaleDesired = 2.6f; //6.0f;
					//timeScaleDesired = 8.0f; //6.0f;
					vars.inDialogueMasher = true;
					break;
				/* //WEIRD DELAYS BREAK THESE
				case "TS_POD_ToXion_SelectionA":
					speed_startFrame = 60;
					speed_endFrame = 1620;
					timeScaleDesired = 6.0f;
					vars.inDialogueMasher = true;
					break;
				case "TS_POD_ToXion_SelectionB":
					speed_startFrame = 30;
					speed_endFrame = 1820;
					timeScaleDesired = 6.0f;
					vars.inDialogueMasher = true;
					break;
				case "TS_POD_ToXion_End": //fuck you adam
					speed_startFrame = 10;
					speed_endFrame = 600;
					timeScaleDesired = 6.0f;
					vars.inDialogueMasher = true;
					break;*/
				case "MV_Xion05_InsideLift_GoingDown_Enter_Main1":
					//going down xion elevator
					speed_startFrame = 10;
					speed_endFrame = 450;
					timeScaleDesired = 10.0f;
					break;
				case "MV_Xion05_InsideLift_GoingDown_Leave_Main2":
					//getting off xion elevator (alone)
					speed_startFrame = -225;
					speed_endFrame = 250;
					timeScaleDesired = 10.0f;
					break;
				case "MV_Xion05_InsideLift_GoingUp_Leave_WithAdamLily_Main2":
					//riding up lift in xion 1 (removeme?)
					speed_startFrame = -240;
					speed_endFrame = 140;
					timeScaleDesired = 10.0f;
					break;
				/*case "Subtitle_Xion06_P1_SmallTalk_Rael_02": //has a weird mash delay, fix this later?
					vars.inDialogueMasher = true;
					speed_startFrame = 10;
					speed_endFrame = 820;
					timeScaleDesired = 4.0f;
					break;*/
				case "Dialogue_Xion07_Phase1_HyperDriveRoomEnter":
					//first long unskippable bit into mashable hypercell cutscene
					speed_startFrame = -1030;
					speed_endFrame = -20;
					//runs as a dialogue masher up to frame 1529, could lower the speeduprate from -20 to 1450
					timeScaleDesired = 20.0f;
					break;
				case "Dialogue_Xion06_Phase2_ElderInteraction":
					speed_startFrame = -60;
					speed_endFrame = 5325;
					timeScaleDesired = 4.0f;
					vars.inDialogueMasher = true;
					break;
				case "MV_Xion01_SmallTalkAfterChamber_Trnasit": //outside xion after orcal chamber
					speed_startFrame = 6;
					speed_endFrame = 110;
					timeScaleDesired = 10.0f;
					break;
				case "Dialogue_Xion01_Phase1_SmallTalk_Street2":
					//left orcal's chamber, long establishing shot
					speed_startFrame = -680;
					speed_endFrame = -75;
					timeScaleDesired = 10.0f;
					//runs as dialogue masher to frame 3260, could speed it up by 4x until 3200
					break;
				case "Dialogue_Xion01_Phase2_SmallTalk_Street3": //sister's junk TEST & TIME THIS!!!!!!!!
					speed_startFrame = 10;
					speed_endFrame = 6967;
					timeScaleDesired = 4.0f;
					vars.inDialogueMasher = true;
					break;
				case "MV_Xion01_DroneUpgrade_Main":
					//IT'S AN EVOLUTION!!!
					speed_startFrame = 2472;
					speed_endFrame = 3072;
					timeScaleDesired = 10.0f;
					break;
				case "Dialogue_Xion01_Phase1_DroneUpgrade": //TIME THIS SHIT!!!!!!!!!!!!
					speed_startFrame = -50;
					speed_endFrame = 1150;
					timeScaleDesired = 4.0f;
					vars.inDialogueMasher = true;
					break;
				case "Dialogue_Xion01_Phase2_Agit_WithAdam": //dialogue mashing starts at around ~120
					//"the wasteland is that way.."
					speed_startFrame = 4200;
					speed_endFrame = 4950;
					timeScaleDesired = 10.0f;
					break;
				case "Subtitle_ATL02_ElevatorLilyDrone": //long elevator in altess levoire TEST & TIME ME!!!
					speed_startFrame = 0;
					speed_endFrame = 1050;
					timeScaleDesired = 20.0f;
					break;
				case "MV_ATL03_Legacy1_Hologram": //altess levoire legacy TIME TIME TIME
					speed_startFrame = -60;
					speed_endFrame = 7100;
					timeScaleDesired = 4.0f;
					vars.inDialogueMasher = true;
					break;
				case "Dialogue_ATL03_Legacy1End": //altess levoire legacy TIME TIME TIME
					speed_startFrame = -60;
					speed_endFrame = 2200;
					timeScaleDesired = 4.0f;
					vars.inDialogueMasher = true;
					break;
				case "Dialogue_Xion01_Phase3_SmallTalkAfterChamber":
					//xion 2 cutscene after orcal/hypercell chamber (we skip this in any%)
					speed_startFrame = -100;
					speed_endFrame = 1750;
					break;
				case "MV_ME06_Tachy_Die_Master":
					//tachy finisher
					speed_startFrame = 650; //start after KILLER animation
					speed_endFrame = 8500; //stop just before we fade out?
					break;
				case "MV_Xion01_AfterMatrix": //xion 3 fadein after tachy
					speed_startFrame = 10; //start after fadein?
					speed_endFrame = 500; //stop before fadeout?
					break;
				case "Dialogue_Xion06_Phase3_AfterMatrix_TalkAfterLanding": //orcal chamber cutscene after tachy (TIME THIS!!!!!!!!!)
					speed_startFrame = -750;
					speed_endFrame = 6500; //could stop at 6650 if this isn't long enough
					timeScaleDesired = 4.0f;
					vars.inDialogueMasher = true;
					break;
				case "Dialogue_Xion01_Phase3_AfterMatrix_AgitEnter": //xion 3 heading out
					speed_startFrame = 30;
					speed_endFrame = 1000;
					timeScaleDesired = 4.0f;
					vars.inDialogueMasher = true;
					break;
				case "MV_Xion01_Legacy2_Hologram": //raven legacy
					speed_startFrame = -450;
					speed_endFrame = 5900;
					break;
				case "TS_Xion01_Adam_P4_TalkAdam_Q":
					speed_startFrame = -50;
					speed_endFrame = 287;
					timeScaleDesired = 3.0f;
					break;
				case "MV_AYL03_Legacy3_Hologram": //this is when we actually start the legacy section
					speed_startFrame = -25;
					speed_endFrame = 5500;
					break;
				case "Dialogue_WLB10_FirstEnter": //great desert dialogue masher after crashlanding
					speed_startFrame = -10;
					speed_endFrame = 1080;
					timeScaleDesired = 3.0f;
					vars.inDialogueMasher = true;
					break;
				case "Subtitle_WLB_MapGuide": //great desert standstill dialogue masher after landing
					speed_startFrame = 0;
					speed_endFrame = 480;
					timeScaleDesired = 3.0f;
					vars.inDialogueMasher = true;
					break;
				case "MV_Xion01_PODAfterAYLLanding_Main": //xion 4 landing after abyss
					speed_startFrame = 630;
					speed_endFrame = 1050;
					break;
				/*	NOTES for arisa:
					MV_SE07_02_PassengerElevatorTeleport_Master is the cutscene we come in on, it skips to frame 2400
					don't want to speed up here because we have to actually interact with her and do our menuing etc.
					2nd floor cutscene is MV_SE08_ArisaToThe2ndFloor, skip jumps to frame 486, we could fast forward while she does the following:
					EnvObj_SE08_ArisaPlay2a_2ndFloor is when she stops and talks about the beds, runs from frame 0 to 381, then she walks across the room and does
					EnvObj_SE08_ArisaPlay2b_2ndFloor is the window cutscene, runs from frame 0 to 997, then she walks to the door and
					EnvObj_SE08_ArisaPlay3_2ndFloor is where she opens the door, use this to stop the fast forward
				*/
				/*	NOTES for Orbit Elevator
					MV_SE08_PassengerElevatorTeleport_Master frame 875 is when we enter the orbit elevator
					there is no event for arriving at the destination, so we will have to do an ugly hack where we fast forward for however long it takes to reach the destination
				*/
				case "MV_SE10_AlphaNative_QTE_Master": //democrawler into demogorgon
					speed_startFrame = 2400;
					speed_endFrame = 5250;
					break;
				case "Dialogue_WLA10_POD_Inside": //dialogue masher before burning xion
					speed_startFrame = 10;
					speed_endFrame = 1337;
					timeScaleDesired = 4.0f;
					vars.inDialogueMasher = true;
					break;
				case "Dialogue_Xion01_P5_PodAgitLanding": //burning xion arrival
					speed_startFrame = 20;
					speed_endFrame = 1750;
					break;
				case "Dialogue_Xion07_Phase5_DyingElder": //orcal deadge sadge
					speed_startFrame = -260;
					speed_endFrame = 6767;
					break;
				case "Dialogue_Xion01_P5_LilyTalk": //dialogue masher with lily before burning xion ends
					speed_startFrame = -10;
					speed_endFrame = 2750; //options appear at ~2830, ending a bit sooner
					timeScaleDesired = 3.0f;
					vars.inDialogueMasher = true;
					break;
				case "MV_Nest_RavenBattle_After_Master": //raven finisher
					speed_startFrame = 1000;
					speed_endFrame = 12400;
					break;
			}
		}
		else if (current.cutsceneSequence == null) {
			vars.inCutscene = false;
		}

		if (vars.inCutscene) {
				if (speed_endFrame != -1 && current.cutsceneFrameNum >= speed_endFrame) {
					timeScaleOverride = 1.0f;
					if (current.timeScale != timeScaleOverride)
						print("STOP!!!!!");
				}
				else if (speed_startFrame != -1 && current.cutsceneFrameNum >= speed_startFrame) {
					timeScaleOverride = timeScaleDesired;
					print("fast fwd");
				}
		}
		else if (current.timeScale > 2.5f) { //this is a fallback, need a better way to check if we *just* left the cutscene?
			//I don't like relying on the 2.5f magic number everywhere
			if (timer.CurrentPhase == TimerPhase.Running)
				timeScaleOverride = 1.0f; //shouldn't get here, but just incase don't leave us sped up if we aren't trying to speed up anything
		}

		if (!settings["masher_speedup"] && vars.inDialogueMasher) {
			timeScaleOverride = 1.0f;
		}

		if (timeScaleOverride != -1.0f)
		{
			IntPtr addr;
			float cooldownOverride = vars.inDialogueMasher ? Math.Abs(1.5f / timeScaleOverride) : 1.5f;
			//float cooldownOverride = 0.1f;
			if (timeScaleOverride != current.timeScale) {
				if (vars.timeScalePtr.DerefOffsets(game, out addr)) //have to nest this for some reason??
					game.WriteValue<float>(addr, timeScaleOverride);
			}

			if (cooldownOverride == 1.5f)
				cooldownOverride = 0.0f;

			//print("cooldownOverride " + cooldownOverride.ToString());
			if (vars.subtitleCoolTimePtr != null && vars.inDialogueMasher && cooldownOverride != current.overrideSubtitleCoolTime) {
				if (vars.subtitleCoolTimePtr.DerefOffsets(game, out addr))
					game.WriteValue<float>(addr, cooldownOverride);
			}
		}

		if (current.timeScale > 1.0f) print("current timeScale " + current.timeScale);
		//a kind of debug assertion popup, using this to make sure we don't go any faster than 2.5f during gameplay
		if (false && current.timeScale > 2.5f && current.timeScale != old.timeScale && timeScaleOverride == -1.0f && !vars.inCutscene) {
			MessageBox.Show(
				"Timescale went over 2.5f!!! (" + current.timeScale.ToString() + ")\n",
				"LiveSplit | STELLAR BLADE",
				MessageBoxButtons.OK, MessageBoxIcon.Question);
		}
	}
	#endregion
}

exit
{
	timer.IsGameTimePaused = true;
}
