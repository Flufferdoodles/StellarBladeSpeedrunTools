state("SB-Win64-Shipping", "current")
{
    // patch 1.4.1a
    bool isLoading : 0x70BF018;
    string512 Event : 0x7031700, 0x18, 0xF8, 0x2C; // TODO
    int event_id : 0x70C5BC4; // TODO
}


state("SB-Win64-Shipping", "1.4.1")
{
    // patch 1.4.1
    bool isLoading : 0x70BE018;
    string512 Event : 0x7031700, 0x18, 0xF8, 0x2C;
    int event_id : 0x70C5BC4;
	float timeScale : 0x06FFA8F8, 0x30, 0x268, 0x201C;
	float TimeSeconds : 0x06FFA8F8, 0x748;
	float UnpausedTimeSeconds : 0x06FFA8F8, 0x74C;
	int cutsceneFrameNum : 0x07031700, 0x20, 0x0, 0x100;
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
    string512 Event : 0x7070FA8, 0x18, 0xF8, 0x2C;
    int event_id : 0x7105438;
	float timeScale : 0x07038898, 0x30, 0x268, 0x201C;
	float TimeSeconds : 0x07038898, 0x748;
	float UnpausedTimeSeconds : 0x07038898, 0x74C;
	int cutsceneFrameNum : 0x07070FA8, 0x20, 0x0, 0x100;
}

init
{
	//assign version string
	switch (modules.First().ModuleMemorySize)
	{
		default:
			version = "unknown";
			vars.timeScalePtr = null;
			break;
		case 337035264: // 337035264 - ver 1.4.1
			version = "1.4.1"; //FIXME: make sure this size is the same for EGS?
			vars.timeScalePtr = new DeepPointer(0x06FFA8F8, 0x30, 0x268, 0x201C);
			break;
		case 328835072: // 328835072 - ver 1.2.0
			version = "1.2.0";
			vars.timeScalePtr = null;
			break;
		case 356278272: // 356278272 - ver 1.1.0
			version = "1.1.0";
			vars.timeScalePtr = new DeepPointer(0x07038898, 0x30, 0x268, 0x201C);
			break;
	}

    vars.eventRegistry = new Dictionary<string, Tuple<string, string>>(); // split name, (event string, split category)

    vars.AddEventToRegistry = (Func<string, string, string, bool>)((name, eventString, category) => {
        if (settings[name] == false)
            return false;
        vars.eventRegistry.Add(name, new Tuple<string, string>(eventString, category));
        return true;
    });
}

startup
{
	settings.Add("timer_ext", false, "Extended timer options");
	settings.CurrentDefaultParent = "timer_ext";
		settings.Add("time_igt", false, "Time with just IGT delta, this will skew from realtime during regular gameplay");
		settings.Add("eventstring_start", false, "Start timer on first cutscene, please set your LiveSplit to start at 0.97");
		settings.Add("cutscene_speedup", false, "Speedup unskippable cutscenes and keep LRT in-sync");
	settings.CurrentDefaultParent = null;

    #region EventSplits
    vars.Events = new object[] {
        // Format: { name, eventString, section }

        // Prologue / Star Descent
        new object[] { "Brute Start", "/Theater/StarsDescent/SD20/Theater/MV_SD20_BruteIntro_Theater.MV_SD20_BruteIntro_Theater", "Prologue / Star Descent" },
        new object[] { "Brute Killed", "/Theater/StarsDescent/SD20/Theater/MV_SD20_AfterBruteBattle_Main.MV_SD20_AfterBruteBattle_Main", "Prologue / Star Descent" },

        // Eidos 7
        new object[] { "Eidos 7 Start", "/Theater/DrownedEidosDistrict/DED01/Theaters/MV_DED01_Intro_Master.MV_DED01_Intro_Master", "Eidos 7" },
        new object[] { "Find Fusion Cell Cutscene", "/Theater/DrownedEidosDistrict/DED01/Theaters/Dialogue/Dialogue_DED01_FindFusioncell_03.Dialogue_DED01_FindFusioncell_03", "Eidos 7" },
        new object[] { "Guide Fusion Cell Cutscene", "/Subtitle/DrownedEidosDistrict/DED01/Thearter/Subtitle_DED01_GuideFusioncell.Subtitle_DED01_GuideFusioncell", "Eidos 7" },
        new object[] { "Abaddon Fight Start", "/Theater/DrownedEidosDistrict/DED01/Theaters/MV_DED01_EliteNative_Entrance_Master.MV_DED01_EliteNative_Entrance_Master", "Eidos 7" },
        new object[] { "Abaddon Finisher QTE", "/Theater/DrownedEidosDistrict/DED01/Theaters/MV_DED01_Parkinglot_AfterBattle.MV_DED01_Parkinglot_AfterBattle", "Eidos 7" },
        new object[] { "Left Parking Tower", "/Theater/DrownedEidosDistrict/DED01/Theaters/MV_DED_Area01_ParkingTower_Exit.MV_DED_Area01_ParkingTower_Exit", "Eidos 7" },
        new object[] { "Flooded Commercial Sector Discovery", "/Theater/DrownedEidosDistrict/DED02/Theaters/MV_DED02_ShoppingMallEnter.MV_DED02_ShoppingMallEnter", "Eidos 7" },
        new object[] { "Warp to Archive", "/Theater/DrownedEidosDistrict/DED02/Theaters/MV_DED02_WarpToArchive.MV_DED02_WarpToArchive", "Eidos 7" },
        new object[] { "Corruptor Entrance", "/Theater/DrownedEidosDistrict/DED02/Theaters/DED_Area02_Elite_GrubShooter.DED_Area02_Elite_GrubShooter", "Eidos 7" },
        new object[] { "Corruptor Finisher", "/Theater/DrownedEidosDistrict/DED02/Theaters/MV_DED02_Elite_GrubShooterFinish.MV_DED02_Elite_GrubShooterFinish", "Eidos 7" },

        // Gigas
        new object[] { "Gigas Fight Start", "/Theater/DrownedEidosDistrict/DED03/Theaters/MV_DED03_BetaNative_Intro_01_QTE.MV_DED03_BetaNative_Intro_01_QTE", "Gigas" },
        new object[] { "Gigas Finisher", "meDesign/Level/Theater/DrownedEidosDistrict/DED03/Theaters/MV_DED03_BetaNative_finish_01_main.MV_DED03_BetaNative_finish_01_main'", "Gigas" },

        // Xion
        new object[] { "Orcal Chamber Cutscene", "/Theater/Xion/Xion06/Theater/MV_Xion06_ElderFirstMeeting.MV_Xion06_ElderFirstMeeting", "Xion" },
        new object[] { "Ranged Tutorial Start", "/Subtitle/Xion/Xion01/EP/Subtitle_Xion01_P2_RangeDroneTutorial_07.Subtitle_Xion01_P2_RangeDroneTutorial_07", "Xion" },
        new object[] { "Ranged Tutorial End", "/Theater/Xion/Xion01/Theater/Dialogue/Dialogue_Xion01_Phase1_DroneUpgrade_Theater.Dialogue_Xion01_Phase1_DroneUpgrade_Theater", "Xion" },

        // Wasteland
        new object[] { "Wasteland Discovery", "/Theater/WasteLandA/WLA10/Theater/MV_WLA10_Intro.MV_WLA10_Intro", "Wasteland" },
        new object[] { "Quiel Cutscene", "/Theater/WasteLandA/WLA30/Theater/Dialogue_WLA30_NearAltesLabor.Dialogue_WLA30_NearAltesLabor", "Wasteland" },
        new object[] { "Quiel Killed", "/Theater/WasteLandA/WLA30/Theater/MV_WLA30_RoyalGuard_AfterBattle.MV_WLA30_RoyalGuard_AfterBattle", "Wasteland" },

        // Altess Levoire
        new object[] { "Button Puzzle Success", "/Subtitle/AltesLabor/ATL01/Theater/Subtitle_ATL01_Sectora07_02.Subtitle_ATL01_Sectora07_02", "Altess Levoire" },
        new object[] { "Air Vent Start", "/Subtitle/AltesLabor/ATL03/Theater/Subtitle_ATL03_HeatoutletStart_01.Subtitle_ATL03_HeatoutletStart_01", "Altess Levoire" },
        new object[] { "Maelstrom Start", "/Theater/AltesLabor/ATL03/Theater/MV_ATL03_OuterwallMove.MV_ATL03_OuterwallMove", "Altess Levoire" },
        new object[] { "Maelstrom End", "/Subtitle/AltesLabor/ATL03/Theater/Subtitle_ATL03_GainHypercell_Drone.Subtitle_ATL03_GainHypercell_Drone", "Altess Levoire" },

        // Xion #2
        new object[] { "Xion #2 Tetrapod Landing", "/Theater/Xion/Xion01/Theater/MV_Xion01_PODAfterATLLanding_Theater.MV_Xion01_PODAfterATLLanding_Theater", "Xion #2" },

        // Matrix XI
        new object[] { "Tetrapod Landing", "/Theater/WasteLandB/WLB20/Theater/MV_WLB20_POD_WLB_To_Matrix.MV_WLB20_POD_WLB_To_Matrix", "Matrix XI" },
        new object[] { "Collapsed Rail Bridge Start", "/Theater/Matrix/MatrixXI/ME02/Theaters/ME_Area02_EP_12.ME_Area02_EP_12", "Matrix XI" },
        new object[] { "Stalker Intro Cutscene", "/Theater/Matrix/MatrixXI/ME03/Theater/MV_ME03_EliteNative_Entrance.MV_ME03_EliteNative_Entrance", "Matrix XI" },
        new object[] { "Stalker Finisher", "/Theater/Matrix/MatrixXI/ME03/Theater/MV_ME03_EliteNative_Finish.MV_ME03_EliteNative_Finish", "Matrix XI" },
        new object[] { "Underground Sewer End", "/Theater/Matrix/MatrixXI/ME04/Theaters/EP/ME04_Part1_EP_07.ME04_Part1_EP_07", "Matrix XI" },
        new object[] { "Juggernaut Fight Start", "/Theater/Matrix/MatrixXI/ME05/Theaters/MV_ME05_EliteNative_Theater.MV_ME05_EliteNative_Theater", "Matrix XI" },
        new object[] { "Juggernaut Finisher", "meDesign/Level/Theater/Matrix/MatrixXI/ME05/Theaters/MV_ME05_EliteNative_Finish_Theater.MV_ME05_EliteNative_Finish_Theater'", "Matrix XI" },
        new object[] { "Left Train Graveyard", "/Theater/Matrix/MatrixXI/ME05/Theaters/EP/Temp_ME05_EP_Barrack05B_Theater.Temp_ME05_EP_Barrack05B_Theater", "Matrix XI" },
        new object[] { "Tachy Start Cutscene", "/Theater/Matrix/MatrixXI/ME06/Theaters/MV_ME06_Tachy_Entrance_Theater.MV_ME06_Tachy_Entrance_Theater", "Matrix XI" },
        new object[] { "Tachy Finisher", "meDesign/Level/Theater/Matrix/MatrixXI/ME06/Theaters/MV_ME06_Tachy_Die_Theater.MV_ME06_Tachy_Die_Theater'", "Matrix XI" },

		// Xion #3
		new object[] { "Xion #3 Arrival", "/Theater/Xion/Xion01/Theater/MV_Xion01_AfterMatrix_Theater.MV_Xion01_AfterMatrix_Theater", "Xion #3" },

        // Wasteland/Abyss Levoire
        new object[] { "Crashlanding Cutscene", "/Theater/WasteLandB/WLB10/Theater/Dialogue_WLB10_FirstEnter.Dialogue_WLB10_FirstEnter", "Wasteland/Abyss Levoire" },
        new object[] { "Shael Fight Start", "/Theater/WasteLandB/WLB30/Theater/Dialogue_WLB10_NearAbyssLabor_BeforeBattle.Dialogue_WLB10_NearAbyssLabor_BeforeBattle", "Wasteland/Abyss Levoire" },
        new object[] { "Shael Fight End", "/Theater/WasteLandB/WLB10/Theater/MV_WLB10_RoyalGuard_AfterBattle.MV_WLB10_RoyalGuard_AfterBattle", "Wasteland/Abyss Levoire" },

        // Abyss Levoire
        new object[] { "Capsule Cluster Room Entered", "/Subtitle/AbyssLabor/AYL03/Theater/Subtitle_AYL03_ClusterRoom_Enter.Subtitle_AYL03_ClusterRoom_Enter", "Abyss Levoire" },
        new object[] { "Laser Room Entered", "/Subtitle/AbyssLabor/AYL04/Theater/Subtitle_AYL04_LaserEscape_01.Subtitle_AYL04_LaserEscape_01", "Abyss Levoire" },
        new object[] { "Laser Room End", "/Subtitle/AbyssLabor/AYL04/Theater/Subtitle_AYL04_LaserEscape_05.Subtitle_AYL04_LaserEscape_05", "Abyss Levoire" },
        new object[] { "Maelstrom Fight Start", "/Theater/AbyssLabor/AYL06/Theater/MV_AYL06_Maelstrom.MV_AYL06_Maelstrom", "Abyss Levoire" },
        new object[] { "Legacy 3 Cutscene", "/Theater/AbyssLabor/AYL03/Theater/MV_AYL03_Legacy3_Hologram_Theater.MV_AYL03_Legacy3_Hologram_Theater", "Abyss Levoire" },

        // Xion #4
        new object[] { "Landing Cutscene", "/Theater/Xion/Xion01/Theater/MV_Xion01_PODAfterAYLLanding_Theater.MV_Xion01_PODAfterAYLLanding_Theater", "Xion #4" },

        // Spire 4
        new object[] { "Intro Cutscene", "/Theater/SpaceElevator/SE01/Theater/MV_SE01_Intro.MV_SE01_Intro", "Spire 4" },
        new object[] { "Hypertube Opened", "/Theater/SpaceElevator/SE02/Theater/MV_SE02_ContainerControlTransit.MV_SE02_ContainerControlTransit", "Spire 4" },
        new object[] { "Belial #1 Start Cutscene", "/Theater/SpaceElevator/SE04/Theater/MV_SE04_Chasing_Theater.MV_SE04_Chasing_Theater", "Spire 4" },
        new object[] { "Belial #1 End Cutscene", "meDesign/Level/Theater/SpaceElevator/SE04/Theater/MV_SE04_WeaponMaster_RunAway.MV_SE04_WeaponMaster_RunAway'", "Spire 4" },
        new object[] { "Space Logistics Complex discovery", "/Theater/SpaceElevator/SE05/Theaters/MV_SE05_EntranceView_Theater.MV_SE05_EntranceView_Theater", "Spire 4" },
        new object[] { "Raphael Space Center Discovery", "/Theater/SpaceElevator/SE06/Theater/MV_SE06_LobbyEntrance_Theater.MV_SE06_LobbyEntrance_Theater", "Spire 4" },
        new object[] { "Belial Fight Start", "/Theater/SpaceElevator/SE06/Theater/MV_SE06_LobbyEliteSpawn_Theater.MV_SE06_LobbyEliteSpawn_Theater", "Spire 4" },
        new object[] { "Belial Finisher", "/Theater/SpaceElevator/SE06/Theater/MV_SE06_LobbyEliteFinish_Theater.MV_SE06_LobbyEliteFinish_Theater", "Spire 4" },
        new object[] { "Maintenance Sector Entered", "/Theater/SpaceElevator/SE07/Theater/MV_SE07_01_CargoElevatorTeleport_Start.MV_SE07_01_CargoElevatorTeleport_Start", "Spire 4" },
        new object[] { "Entering Passenger Lift 161", "/Theater/SpaceElevator/SE07/Theater/MV_SE07_02_PassengerElevatorTeleport_Start.MV_SE07_02_PassengerElevatorTeleport_Start", "Spire 4" },
        new object[] { "Vermillion Garden Karakuri Started", "/Theater/SpaceElevator/SE08/Theater/SE08_01_EliteNative_Entrance.SE08_01_EliteNative_Entrance", "Spire 4" },
        new object[] { "Karakuri Finisher", "/Theater/SpaceElevator/SE08/Theater/MV_SE08_01_EliteNative_QTE_Master.MV_SE08_01_EliteNative_QTE_Master", "Spire 4" },
        new object[] { "Democrawler Start", "/Theater/SpaceElevator/SE10/Theater/MV_SE10_AlphaNative_Entrance_Master.MV_SE10_AlphaNative_Entrance_Master", "Spire 4" },
        new object[] { "Democrawler Finisher", "/Theater/SpaceElevator/SE10/Theater/MV_SE10_AlphaNative_Ending_Master.MV_SE10_AlphaNative_Ending_Master", "Spire 4" },
        new object[] { "Spire 4 End", "/Theater/WasteLandA/WLA10/Theater/MV_WLA10_ExoSuitLanding_01.MV_WLA10_ExoSuitLanding_01", "Spire 4" },

		// Burning Xion
        new object[] { "Unidentified Naytiba Start", "/Theater/Xion/Xion06/Theater/MV_Xion06_RavenAppearance.MV_Xion06_RavenAppearance", "Burning Xion" },
        new object[] { "Unidentified Naytiba Finisher", "/Theater/Xion/Xion06/Theater/MV_Xion06_RavenFinish_QTE.MV_Xion06_RavenFinish_QTE", "Burning Xion" },

        // Wasteland Endgame
        new object[] { "Approaching Wasteland to Start Boss Rush", "/Theater/WasteLandA/WLA10/Theater/Dialogue_WLA10_POD_Landing_Theater.Dialogue_WLA10_POD_Landing_Theater", "Wasteland Endgame" },
        new object[] { "Raven Fight Start", "/Theater/WasteLandA/WLA10/Theater/Dialogue_Nest_Intro.Dialogue_Nest_Intro", "Wasteland Endgame" },
        new object[] { "Raven Finisher", "/Theater/WasteLandA/WLA10/Theater/MV_WLA_Nest_RavenBattle_QTE_Master.MV_WLA_Nest_RavenBattle_QTE_Master", "Wasteland Endgame" },

        // Nest
        new object[] { "Adam Cutscene", "/Theater/Nest/Nest20/Theater/MV_Nest_EncounterAdam.MV_Nest_EncounterAdam", "Nest" },
        new object[] { "Providence Finisher", "/Theater/Nest/Nest20/Theater/MV_Nest_FinalBattle_Lily_QTE_Die.MV_Nest_FinalBattle_Lily_QTE_Die", "Nest" },
        // new object[] { "End Credits", "/Theater/Nest/Nest40/Theater/MV_Nest_LilyEnding_Credits_Die.MV_Nest_LilyEnding_Credits_Die", "Nest" },
        new object[] { "Adam Transitions Into Elder Naytiba", "/Theater/Nest/Nest20/Theater/MV_Nest_BattleAdam_Phase2.MV_Nest_BattleAdam_Phase2", "Nest" },
        new object[] { "Elder Naytiba Finisher", "/Theater/Nest/Nest30/Theater/MV_Nest_FinalBattle_Adam_QTE.MV_Nest_FinalBattle_Adam_QTE", "Nest" },
        new object[] { "Return to the Colony", "/Theater/Nest/Nest40/Theater/MV_Nest_BattleAdam_After_03.MV_Nest_BattleAdam_After_03", "Nest" }
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

gameTime
{
	//UnpausedTimeSeconds is from GWorld, but resets on checkpoint reload/map change, so we track time by adding the delta between updates in vars.trackedTime
	float delta = current.UnpausedTimeSeconds - old.UnpausedTimeSeconds;

	if (settings["time_igt"]) { //we just want the unfiltered IGT
		vars.trackedTime = TimeSpan.FromSeconds(vars.trackedTime.TotalSeconds + delta);
		return vars.trackedTime;
	}

	if (current.isLoading || timer.IsGameTimePaused) { //don't tick timer on the loading screen at all
		vars.trackedTime = timer.CurrentTime.GameTime;
		return vars.trackedTime;
	}

	if (delta < 0.01f)
	{ //reloaded checkpoint or UnpausedTimeSeconds rolled back, don't add delta
		//print("reloaded checkpoint or something");
		vars.trackedTime = timer.CurrentTime.GameTime;
		return vars.trackedTime;
	}

	if (current.timeScale <= 2.5f) {
		//normal, act like LRT?
		//Infinite Pierce speeds the game up by 2.5x very briefly, which is why we're comparing to that
		//This is necessary or else our new IGT tracking will deviate too much from LRT, as RealWorldSeconds doesn't tick when opening pause menu/loading
		vars.trackedTime = timer.CurrentTime.GameTime;
		return vars.trackedTime;
	}

	//vars.trackedTime.Add(TimeSpan.FromSeconds(delta));
	//print(timer.CurrentTime.GameTime.ToString());
	//return TimeSpan.FromSeconds(vars.trackedTime);
	vars.trackedTime = TimeSpan.FromSeconds(vars.trackedTime.TotalSeconds + delta); //why does this work but not vars.trackedTime.Add LMFAO??
	print(vars.trackedTime.ToString());
	return vars.trackedTime;
}

isLoading
{
    return current.isLoading;
}

split
{
	if (current.Event != old.Event) {
		foreach (var entry in vars.eventRegistry) {
			// entry.Value.Item1 is the event string
			if (current.Event == entry.Value.Item1) {
				vars.eventRegistry.Remove(entry.Key);
				return true;
			}
		}
	}
	//auto end
	if (vars.EventString == "/Theater/Nest/Nest40/Theater/MV_Nest_BattleAdam_After_03.MV_Nest_BattleAdam_After_03") {
		if (current.cutsceneFrameNum >= 3520 && current.cutsceneFrameNum <= 8424) { //cutsceneFrameNum can be read off from the previous cutscene, so check that we're not that far ahead first
			vars.EventString = null;
			return true;
		}
	}
}

start
{
	if (current.Event != old.Event && current.Event == "meDesign/Level/Theater/Matrix/MatrixXI/ME06/Theaters/MV_ME06_Tachy_Die_Theater.MV_ME06_Tachy_Die_Theater'")
		return true; //for testing

	if (settings["eventstring_start"]) //since our event_id thing isn't working reliably on everyone's system
		return (current.Event != old.Event && current.Event == "/Theater/StarsDescent/Prologue/Theater/MV_Prologue_Main.MV_Prologue_Main");

	// 47 to 48 -- press continue
	// 53 to 54 -- new game or new game plus
	// 49 to 50 -- ng or ng+ on some systems, unsure what the difference is
	//return ((current.event_id == 54 || current.event_id == 50 || current.event_id == 53 || current.event_id== 47) && (old.event_id + 1) == current.event_id);
	return (current.event_id == (old.event_id + 1) && current.event_id < 60 && current.event_id > 30);
}

update
{
	//debug
 	if (current.Event != old.Event && current.Event != null)
	{
		print("dbgFilter: current.Event: \"" + current.Event + "\",");
		vars.EventString = current.Event; //track this here since it gets 0'd out on next update
	}

	if (current.event_id == (old.event_id + 1) && current.event_id < 60 && current.event_id > 30)
	{
		print("dbgFilter: current.event_id: " + current.event_id + " old.event_id: " + old.event_id);
	}

	//print("current TimeSeconds: " + current.TimeSeconds.ToString());
	if (current.cutsceneFrameNum != old.cutsceneFrameNum)
		print("current cutscene framenumber: " + current.cutsceneFrameNum.ToString());
	// Alright so here's where we're at, we have a consistent pointer to the frame number of the cutscene that is currently playing,
	// the problem is the frame numbers are relative to the individual "TheaterTrack" which is going to be camera cuts or many other things,
	// So a cutscene may start at frame 0 and when it reaches its next track the frameNumber will get set to -700 or something
	// LevelSequencePlayers seem to just run through an array of TheaterTracks
	// If we want to remove all of these conditional hacks below we need to locate a pointer to something representing the current TheaterTracs
	if (settings["cutscene_speedup"] && vars.timeScalePtr != null && vars.EventString != null)
	{
		float timeScaleOverride = -1.0f;
		float timeScaleDesired = 67.67f; //override the speedup rate depending on the scene
		int speed_startFrame = -1;
		int speed_endFrame = -1;

		//print("vars.EventString: " + vars.EventString);
		if (current.cutsceneFrameNum > old.cutsceneFrameNum) //do this while the cutsceneFrameNum is being incremented
		{
			int frameNum = current.cutsceneFrameNum; //saves some typing

			vars.inCutscene = true;			
			//can't put this in a switch? ok... lol
			if (vars.EventString == "/Theater/Xion/Xion05/Theater/MV_Xion05_InsideLift_GoingUp_Leave_WithAdamLily_Main2.MV_Xion05_InsideLift_GoingUp_Leave_WithAdamLily_Main2") {
				//riding up lift in xion 1 (removeme?)
				speed_startFrame = -240;
				speed_endFrame = 140;
				timeScaleDesired = 10.0f;
			}
			else if (vars.EventString == "/Theater/Xion/Xion07/Theater/Dialogue/Dialogue_Xion07_Phase1_HyperDriveRoomEnter_Theater.Dialogue_Xion07_Phase1_HyperDriveRoomEnter_Theater") {
				//first long unskippable bit into mashable hypercell cutscene
				speed_startFrame = -1030;
				speed_endFrame = -20;
				timeScaleDesired = 20.0f;
			}
			else if (vars.EventString == "/Theater/Xion/Xion01/Theater/Dialogue/Dialogue_Xion01_Phase1_SmallTalk_Street2_Theater.Dialogue_Xion01_Phase1_SmallTalk_Street2_Theater") {
				//left orcal's chamber, long establishing shot
				//it starts from 0 and increments to ~120 when first entering, then starts at -690 after fadeout
				//this one may need TLC hacks
				speed_startFrame = -680;
				//speed_endFrame = -150;
				if (frameNum < -50) speed_endFrame = -75;
				timeScaleDesired = 10.0f;
			}
			else if (vars.EventString == "/Theater/Xion/Xion01/Theater/MV_Xion01_DroneUpgrade_Theater.MV_Xion01_DroneUpgrade_Theater") {
				//IT'S AN EVOLUTION!!!
				speed_startFrame = 2472;
				speed_endFrame = 3072;
			}
			else if (vars.EventString == "/Theater/Xion/Xion01/Theater/Dialogue/Dialogue_Xion01_Phase2_Agit_WithAdam_Theater.Dialogue_Xion01_Phase2_Agit_WithAdam_Theater") {
				//"the wasteland is that way.."
				speed_startFrame = 4200;
				speed_endFrame = 4850;
				timeScaleDesired = 10.0f;
			}
			else if (vars.EventString == "/Theater/Xion/Xion01/Theater/Dialogue/Dialogue_Xion01_Phase3_SmallTalkAfterChamber_Theater.Dialogue_Xion01_Phase3_SmallTalkAfterChamber_Theater") {
				//xion 2 cutscene after orcal/hypercell chamber (we skip this in any%)
				speed_startFrame = 120; //would be nicer to start this earlier but it has the same issue where positive framecount for fade out and then the actual scene starts at -120
				speed_endFrame = 1750;
			}
			else if (vars.EventString == "meDesign/Level/Theater/Matrix/MatrixXI/ME06/Theaters/MV_ME06_Tachy_Die_Theater.MV_ME06_Tachy_Die_Theater'") {
				//tachy finisher
				speed_startFrame = 650; //start after KILLER animation
				speed_endFrame = 8500; //stop just before we fade out?
			}
			else if (vars.EventString == "/Theater/Xion/Xion01/Theater/MV_Xion01_AfterMatrix_Theater.MV_Xion01_AfterMatrix_Theater") { //xion fadein after tachy
				speed_startFrame = 10; //start after fadein?
				speed_endFrame = 500; //stop before fadeout?
			}
			else if (vars.EventString == "/Theater/Xion/Xion06/Theater/Dialogue/Dialogue_Xion06_Phase3_AfterMatrix_TalkAfterLanding_Theater.Dialogue_Xion06_Phase3_AfterMatrix_TalkAfterLanding_Theater") {
				//skip long establishing shot in orcal's chamber
				speed_startFrame = -750;
				speed_endFrame = -150;
				timeScaleDesired = 10.0f;
			}
			else if (vars.EventString == "/Theater/Xion/Xion01/Theater/MV_Xion01_Legacy2_Hologram.MV_Xion01_Legacy2_Hologram") {
				speed_startFrame = -450;
				speed_endFrame = 5900;
				if (current.cutsceneFrameNum >= 5900) {
					//hack, this is right before the black screen where we get the "skip" prompt, but it rewinds the frame number to -1290
					//we don't want to continue fast forwarding here so we'll change the EventString instead
					vars.EventString = null;
					speed_endFrame = 4750;
				}
			}
			else if (vars.EventString == "/Theater/AbyssLabor/AYL03/Theater/MV_AYL03_Legacy3_Hologram_Theater.MV_AYL03_Legacy3_Hologram_Theater") {
				//legacy after maelstrom kill in abyss levoire
				//speed_startFrame = 1100;
				//speed_endFrame = 5500;
				//ok we're gonna hack the fuck out of this
				if (frameNum >= 1370)
					vars.EventString = "MV_AYL03_Legacy3_Hologram_Theater.MV_AYL03_Legacy3_Hologram_Theater_HACK"; //we will check our frame range here
			}
			else if (vars.EventString == "MV_AYL03_Legacy3_Hologram_Theater.MV_AYL03_Legacy3_Hologram_Theater_HACK") {
				//hey it worked
				speed_startFrame = -25;
				speed_endFrame = 5500;
			}
			else if (vars.EventString == "/Theater/Xion/Xion01/Theater/MV_Xion01_PODAfterAYLLanding_Theater.MV_Xion01_PODAfterAYLLanding_Theater") {
				//landing after abyss
				speed_startFrame = 630;
				speed_endFrame = 1050;
			}
			else if (vars.EventString == "/Theater/SpaceElevator/SE10/Theater/MV_SE10_AlphaNative_Ending_Master.MV_SE10_AlphaNative_Ending_Master") {
				//democrawler into demogorgon
				speed_startFrame = 3200;
				speed_endFrame = 5250;
			}
			else if (vars.EventString == "/Theater/Xion/Xion01/Theater/Dialogue/Dialogue_Xion01_Phase5_PodAgitLanding_Theater.Dialogue_Xion01_Phase5_PodAgitLanding_Theater") {
				speed_startFrame = 20;
				speed_endFrame = 1750;
			}
			else if (vars.EventString == "/Theater/Xion/Xion07/Theater/Dialogue/Dialogue_Xion07_Phase5_DyingElder_Theater.Dialogue_Xion07_Phase5_DyingElder_Theater") {
				//orcal deadge sadge
				speed_startFrame = -260;
				speed_endFrame = 6767;
			}
			else if (vars.EventString == "/Theater/WasteLandA/WLA10/Theater/MV_WLA_Nest_RavenBattle_QTE_Master.MV_WLA_Nest_RavenBattle_QTE_Master") {
				//raven finisher
				speed_startFrame = 1000;
				speed_endFrame = 12300;
			}
			else {
				speed_startFrame = -1;
				speed_endFrame = -1;
			}

		}
		else if (current.cutsceneFrameNum == old.cutsceneFrameNum) { //idk idk idk
			vars.inCutscene = false;
			//vars.EventString = null;
		}

		if (vars.inCutscene)
		{
				if (speed_endFrame != -1 && current.cutsceneFrameNum >= speed_endFrame) {
					print("STOP!!!!!");
					timeScaleOverride = 1.0f;
					vars.EventString = null; //maybe we just want to do this here? testme..
					//nah this breaks ones that start with a positive framenumber FUCK!!!!!!
				}
				else if (speed_startFrame != -1 && current.cutsceneFrameNum >= speed_startFrame) {
					print("fast fwd");
					timeScaleOverride = timeScaleDesired;
				}
		}
		else if (current.timeScale > 2.5f) { //this is a fallback, need a better way to check if we *just* left the cutscene? 
			//I don't like relying on the 2.5f magic number everywhere
			if (timer.CurrentPhase == TimerPhase.Running)
				timeScaleOverride = 1.0f; //shouldn't get here, but just incase don't leave us sped up if we aren't trying to speed up anything
		}

		if (timeScaleOverride != -1.0f && timeScaleOverride != current.timeScale)
		{
			IntPtr addr;
			if (vars.timeScalePtr.DerefOffsets(game, out addr)) {
				game.WriteValue<float>(addr, timeScaleOverride);
			}
		}

		if (current.timeScale > 1.0f) print("current timeScale " + current.timeScale);
		//a kind of debug assertion popup, using this to make sure we don't go any faster than 2.5f during gameplay
		if (false && current.timeScale > 2.5f && current.timeScale != old.timeScale && timeScaleOverride != -1.0f && !vars.inCutscene) {
			MessageBox.Show(
				"Timescale went over 2.5f!!! (" + current.timeScale.ToString() + ")\n",
				"LiveSplit | STELLAR BLADE", 
				MessageBoxButtons.OK, MessageBoxIcon.Question);
		}
	}
}

exit
{
	timer.IsGameTimePaused = true;
}
