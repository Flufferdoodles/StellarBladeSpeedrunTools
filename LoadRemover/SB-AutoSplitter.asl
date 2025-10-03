state("SB-Win64-Shipping", "current")
{
    // patch 1.4.1
    bool isLoading : 0x70BE018;
    string512 Event : 0x7031700, 0x18, 0xF8, 0x2C;
    int event_id : 0x70C5BC4;
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
}

init
{
    // 328835072 - ver 1.2.0
    if (modules.First().ModuleMemorySize == 328835072)
        version = "1.2.0";
    // 356278272 - ver 1.1.0
	if (modules.First().ModuleMemorySize == 356278272)
		version = "1.1.0";

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
}

isLoading
{
    return current.isLoading;
}

split
{

    foreach (var entry in vars.eventRegistry) {
        // entry.Value.Item1 is the event string
        if (current.Event == entry.Value.Item1) {
            vars.eventRegistry.Remove(entry.Key);
            return true;
        }
    }
}

start
{
    if (
        (current.event_id == 54 || current.event_id == 50 || current.event_id == 53 || current.event_id == 47)
        && (old.event_id + 1) == current.event_id
    ) {
        // 47 to 48 -- press continue
        // 53 to 54 -- new game or new game plus
        // 49 to 50 -- ng or ng+ on some systems, unsure what the difference is
        return true;
    }
}
