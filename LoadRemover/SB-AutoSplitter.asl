state("SB-Win64-Shipping", "current")
{
    // patch 1.2.0
    bool isLoading : 0x7103D20;
    float posX : 0x6F83B1C;
    float posY : 0x703BFEC;
    float posZ : 0x6F83B18;
    int event_id  : 0x710B4E4;
}

state("SB-Win64-Shipping", "1.1.0")
{
    bool isLoading : 0x6D83DEC;
    float posX : 0x6DFAF54;
    float posY : 0x6DFAF58;
    float posZ : 0x6DFAF5C;
    int event_id  : 0x7105438;
}

init
{
    // 328835072 - current patch
    // 356278272 - ver 1.1.0
	if (modules.First().ModuleMemorySize == 356278272)
		version = "1.1.0";

    vars.triggerRadius = 10f;

    #region Position Splits
    vars.positionRegistery.Add("Prologue",new List<float>() {-26261,4402,-17109});
    vars.positionRegistery.Add("Activate Camp : Silent Street",new List<float>() {-69788,14117,46521});
    vars.positionRegistery.Add("Enter Area : Parking Tower 2nd Floor",new List<float>() {-47629,14485,35382});
    vars.positionRegistery.Add("Begin Fight : Abbadon",new List<float>() {-49502,15480,34752});
    vars.positionRegistery.Add("Activate Camp : Parking Tower Roof",new List<float>() {-50801,15486,29975});
    vars.positionRegistery.Add("Exit Area : Parking",new List<float>() {-45964,13853,32957});
    vars.positionRegistery.Add("Activate Camp : Abandonned Station",new List<float>() {-35562,16302,30489});
    vars.positionRegistery.Add("Enter Area : Flooded Commercial Sector",new List<float>() {-17710,20729,32289});
    vars.positionRegistery.Add("Enter Area : Clock Tower",new List<float>() {-11647,22269,25173});
    vars.positionRegistery.Add("Enter Area : Memorial Tower",new List<float>() {-12710,19771,18203});
    vars.positionRegistery.Add("Begin Fight : Corrupter",new List<float>() {-11488,19310,12357});
    vars.positionRegistery.Add("Enter Area : Construction Zone",new List<float>() {-8150,20585,11805});
    vars.positionRegistery.Add("Enter Area : Construction Zone Panoramic View",new List<float>() {-20640,21738,9857});
    vars.positionRegistery.Add("Enter Area : Crater",new List<float>() {-31267,16947,-6153});
    vars.positionRegistery.Add("Enter Area : Xion",new List<float>() {18273,80,-13125});
    vars.positionRegistery.Add("Enter Area : Wastelands",new List<float>() {-18175,3146,14879});
    vars.positionRegistery.Add("Activate Elevator : Altess Levoire Entrance",new List<float>() {34968,-5945,-32377});
    vars.positionRegistery.Add("Enter Area : Altess Levoire",new List<float>() {936,-8518,25037});
    vars.positionRegistery.Add("Enter Area : Capsule Cluster Room",new List<float>() {886,-9458,5178});
    vars.positionRegistery.Add("Enter Area : Specimen Preservation Lab",new List<float>() {14193,-8601,-12681});
    vars.positionRegistery.Add("Activate Elevator : Deteriorated Lobby",new List<float>() {12897,-30819,-12749});
    vars.positionRegistery.Add("Begin Fight : Maelstrom Altess Levoire",new List<float>() {-4816,-30819,-11912});
    vars.positionRegistery.Add("End Fight : Maelstrom Alstess Levoire",new List<float>() {-6648,-30805,-10848});
    vars.positionRegistery.Add("Enter Area : Matrix 11",new List<float>() {33517,-19134,11713});
    vars.positionRegistery.Add("Activate Elevator : Landfill",new List<float>() {7641,-2312,33456});
    vars.positionRegistery.Add("End QTE Sequence : Collapsed Rail Bridge",new List<float>() {-11483,2615,27238});
    vars.positionRegistery.Add("Begin Fight : Stalker",new List<float>() {-61080,4393,31998});
    vars.positionRegistery.Add("Get Item : Burst Skill",new List<float>() {-63740,4394,33250});
    vars.positionRegistery.Add("Activate Camp : Rail Yard",new List<float>() {-67882,4841,38273});
    vars.positionRegistery.Add("Enter Area : Underground Sewer",new List<float>() {-75486,2419,41333});
    vars.positionRegistery.Add("Enter Area : Rotten Labyrinth",new List<float>() {-77697,1763,48990});
    vars.positionRegistery.Add("Activate Camp : Temporary Armoury Entrance",new List<float>() {-84397,-4481,79083});
    vars.positionRegistery.Add("Begin Fight : Juggernaut",new List<float>() {-85097,-4516,76149});
    vars.positionRegistery.Add("End Escape Sequence : Train Graveyard",new List<float>() {-106871,-26344,10494});
    vars.positionRegistery.Add("Activate Camp : Contaminated Water Purification Plant Entrance",new List<float>() {-109520,-23900,114033});
    vars.positionRegistery.Add("Begin Fight : Tachy",new List<float>() {-105915,-23287,122190});
    vars.positionRegistery.Add("End Fight : Tachy",new List<float>() {-106235,-29300,123264});
    vars.positionRegistery.Add("Enter Area : Central Desert",new List<float>() {-19046,-19939,41594});
    vars.positionRegistery.Add("Enter Area : Abyss Levoire",new List<float>() {-20788,-8464,-34315});
    vars.positionRegistery.Add("Activate Door : Underground Passage",new List<float>() {-12307,-8928,-1814});
    vars.positionRegistery.Add("Activate Button : Turning off Lasers",new List<float>() {-20868,-9608,-4369});
    vars.positionRegistery.Add("Begin Fight : Maelstrom Abyss Levoire",new List<float>() {-26510,-9590,12143});
    vars.positionRegistery.Add("End Fight : Maelstrom Abyss Levoire",new List<float>() {17808,1732,-24140});
    vars.positionRegistery.Add("Enter Area : Orca Space Complex",new List<float>() {-25467,4861,13683});
    vars.positionRegistery.Add("Activate Camp : Hypertube Entrance",new List<float>() {-511,1354,12405});
    vars.positionRegistery.Add("Activate 1st Generator",new List<float>() {4652,-68,10229});
    vars.positionRegistery.Add("Activate 2nd Generator",new List<float>() {1511,95,6892});
    vars.positionRegistery.Add("Activate 3rd Generator",new List<float>() {5494,-62,3646});
    vars.positionRegistery.Add("Activate 4th Generator",new List<float>() {1759,1329,4662});
    vars.positionRegistery.Add("Activate Door : Hypertube",new List<float>() {4781,1260,8165});
    vars.positionRegistery.Add("Begin Fight : Belial First Encounter",new List<float>() {-221707,-1200,206951});
    vars.positionRegistery.Add("Enter Area : Space Logistic Complex",new List<float>() {-224041,174,212273});
    vars.positionRegistery.Add("End Escape Sequence : Space Logistic Complex",new List<float>() {-220641,169,224277});
    vars.positionRegistery.Add("Enter Area : Raphael Space Center Parking Area",new List<float>() {-204175,1651,229143});
    vars.positionRegistery.Add("Enter Area : Raphael Space Center",new List<float>() {-216613,134,246033});
    vars.positionRegistery.Add("Begin Fight : Belial",new List<float>() {-204844,118,260984});
    vars.positionRegistery.Add("Enter Area : Cargo Lift 121",new List<float>() {-204332,2358,257163});
    vars.positionRegistery.Add("Enter Area : Maintenance Sector",new List<float>() {-222752,71968,261050});
    vars.positionRegistery.Add("End Escape Sequence : Maintenance Sector",new List<float>() {-218598,76111,264653});
    vars.positionRegistery.Add("Enter Area : Passenger Lift P161",new List<float>() {-135047,143327,270060});
    vars.positionRegistery.Add("Activate Camp : Prestige Lounge",new List<float>() {-138417,145876,275586});
    vars.positionRegistery.Add("Begin Fight : Karakuri",new List<float>() {-144280,145833,283950});
    vars.positionRegistery.Add("Enter Area : Lift",new List<float>() {-207885,134770,2748});
    vars.positionRegistery.Add("Begin Fight : Democrawler",new List<float>() {-224314,139505,-439});
    vars.positionRegistery.Add("End Fight : Democrawler",new List<float>() {-281390,1497,-23});
    vars.positionRegistery.Add("Begin Fight : Unidentified Naytiba",new List<float>() {606,-34660,32670});
    vars.positionRegistery.Add("Enter Area : Outside Nest",new List<float>() {-14770,-2695,-42149});
    vars.positionRegistery.Add("Begin Fight : Raven",new List<float>() {-38064,-2474,-51333});
    vars.positionRegistery.Add("Enter Area : Nest",new List<float>() {75431,-563,-39156});
    vars.positionRegistery.Add("Begin Fight : Final Boss",new List<float>() {43553,-2558,-39068});
    #endregion

    vars.usedPositions = new List<string>();
}

startup
{
    #region Settings
    settings.Add("Eidos 7");
    settings.Add("Prologue", false,"Prologue","Eidos 7");
    settings.Add("Activate Camp : Silent Street", false,"Activate Camp : Silent Street","Eidos 7");
    settings.Add("Enter Area : Parking Tower 2nd Floor", false,"Enter Area : Parking Tower 2nd Floor","Eidos 7");
    settings.Add("Activate Camp : Parking Tower Roof", false,"Activate Camp : Parking Tower Roof","Eidos 7");
    settings.Add("Exit Area : Parking", false,"Exit Area : Parking","Eidos 7");
    settings.Add("Activate Camp : Abandonned Station", false,"Activate Camp : Abandonned Station","Eidos 7");
    settings.Add("Enter Area : Flooded Commercial Sector", false,"Enter Area : Flooded Commercial Sector","Eidos 7");
    settings.Add("Enter Area : Clock Tower", false,"Enter Area : Clock Tower","Eidos 7");
    settings.Add("Enter Area : Memorial Tower", false,"Enter Area : Memorial Tower","Eidos 7");
    settings.Add("Begin Fight : Corrupter", false,"Begin Fight : Corrupter","Eidos 7");
    settings.Add("Enter Area : Construction Zone", false,"Enter Area : Construction Zone","Eidos 7");
    settings.Add("Enter Area : Construction Zone Panoramic View", false,"Enter Area : Construction Zone Panoramic View","Eidos 7");
    settings.Add("Enter Area : Crater", false,"Enter Area : Crater","Eidos 7");

    settings.Add("Wasteland");
    settings.Add("Enter Area : Xion", false,"Enter Area : Xion","Wasteland");
    settings.Add("Enter Area : Wastelands", false,"Enter Area : Wastelands","Wasteland");
    settings.Add("Activate Elevator : Altess Levoire Entrance", false,"Activate Elevator : Altess Levoire Entrance","Wasteland");
    settings.Add("Enter Area : Altess Levoire", false,"Enter Area : Altess Levoire","Wasteland");
    settings.Add("Enter Area : Capsule Cluster Room", false,"Enter Area : Capsule Cluster Room","Wasteland");
    settings.Add("Enter Area : Specimen Preservation Lab", false,"Enter Area : Specimen Preservation Lab","Wasteland");
    settings.Add("Activate Elevator : Deteriorated Lobby", false,"Activate Elevator : Deteriorated Lobby","Wasteland");
    settings.Add("Begin Fight : Maelstrom Altess Levoire", false,"Begin Fight : Maelstrom Altess Levoire","Wasteland");
    settings.Add("End Fight : Maelstrom Alstess Levoire", false,"End Fight : Maelstrom Alstess Levoire","Wasteland");

    settings.Add("Matrix 11");
    settings.Add("Enter Area : Matrix 11", false,"Enter Area : Matrix 11","Matrix 11");
    settings.Add("Activate Elevator : Landfill", false,"Activate Elevator : Landfill","Matrix 11");
    settings.Add("End QTE Sequence : Collapsed Rail Bridge", false,"End QTE Sequence : Collapsed Rail Bridge","Matrix 11");
    settings.Add("Begin Fight : Stalker", false,"Begin Fight : Stalker","Matrix 11");
    settings.Add("Get Item : Burst Skill", false,"Get Item : Burst Skill","Matrix 11");
    settings.Add("Activate Camp : Rail Yard", false,"Activate Camp : Rail Yard","Matrix 11");
    settings.Add("Enter Area : Underground Sewer", false,"Enter Area : Underground Sewer","Matrix 11");
    settings.Add("Enter Area : Rotten Labyrinth", false,"Enter Area : Rotten Labyrinth","Matrix 11");
    settings.Add("Activate Camp : Temporary Armoury Entrance", false,"Activate Camp : Temporary Armoury Entrance","Matrix 11");
    settings.Add("Begin Fight : Juggernaut", false,"Begin Fight : Juggernaut","Matrix 11");
    settings.Add("End Escape Sequence : Train Graveyard", false,"End Escape Sequence : Train Graveyard","Matrix 11");
    settings.Add("Activate Camp : Contaminated Water Purification Plant Entrance", false,"Activate Camp : Contaminated Water Purification Plant Entrance","Matrix 11");
    settings.Add("Begin Fight : Tachy", false,"Begin Fight : Tachy","Matrix 11");
    settings.Add("End Fight : Tachy", false,"End Fight : Tachy","Matrix 11");

    settings.Add("Central Desert");
    settings.Add("Enter Area : Central Desert", false,"Enter Area : Central Desert","Central Desert");
    settings.Add("Enter Area : Abyss Levoire", false,"Enter Area : Abyss Levoire","Central Desert");
    settings.Add("Activate Door : Underground Passage", false,"Activate Door : Underground Passage","Central Desert");
    settings.Add("Activate Button : Turning off Lasers", false,"Activate Button : Turning off Lasers","Central Desert");
    settings.Add("Begin Fight : Maelstrom Abyss Levoire", false,"Begin Fight : Maelstrom Abyss Levoire","Central Desert");
    settings.Add("End Fight : Maelstrom Abyss Levoire", false,"End Fight : Maelstrom Abyss Levoire","Central Desert");

    settings.Add("Orbit Elevator");
    settings.Add("Enter Area : Orca Space Complex", false,"Enter Area : Orca Space Complex","Orbit Elevator");
    settings.Add("Activate Camp : Hypertube Entrance", false,"Activate Camp : Hypertube Entrance","Orbit Elevator");
    settings.Add("Activate 1st Generator", false,"Activate 1st Generator","Orbit Elevator");
    settings.Add("Activate 2nd Generator", false,"Activate 2nd Generator","Orbit Elevator");
    settings.Add("Activate 3rd Generator", false,"Activate 3rd Generator","Orbit Elevator");
    settings.Add("Activate 4th Generator", false,"Activate 4th Generator","Orbit Elevator");
    settings.Add("Activate Door : Hypertube", false,"Activate Door : Hypertube","Orbit Elevator");
    settings.Add("Begin Fight : Belial First Encounter", false,"Begin Fight : Belial First Encounter","Orbit Elevator");
    settings.Add("Enter Area : Space Logistic Complex", false,"Enter Area : Space Logistic Complex","Orbit Elevator");
    settings.Add("End Escape Sequence : Space Logistic Complex", false,"End Escape Sequence : Space Logistic Complex","Orbit Elevator");
    settings.Add("Enter Area : Raphael Space Center Parking Area", false,"Enter Area : Raphael Space Center Parking Area","Orbit Elevator");
    settings.Add("Enter Area : Raphael Space Center", false,"Enter Area : Raphael Space Center","Orbit Elevator");
    settings.Add("Begin Fight : Belial", false,"Begin Fight : Belial","Orbit Elevator");
    settings.Add("Enter Area : Cargo Lift 121", false,"Enter Area : Cargo Lift 121","Orbit Elevator");
    settings.Add("Enter Area : Maintenance Sector", false,"Enter Area : Maintenance Sector","Orbit Elevator");
    settings.Add("End Escape Sequence : Maintenance Sector", false,"End Escape Sequence : Maintenance Sector","Orbit Elevator");
    settings.Add("Enter Area : Passenger Lift P161", false,"Enter Area : Passenger Lift P161","Orbit Elevator");
    settings.Add("Activate Camp : Prestige Lounge", false,"Activate Camp : Prestige Lounge","Orbit Elevator");
    settings.Add("Begin Fight : Karakuri", false,"Begin Fight : Karakuri","Orbit Elevator");
    settings.Add("Enter Area : Lift", false,"Enter Area : Lift","Orbit Elevator");
    settings.Add("Begin Fight : Democrawler", false,"Begin Fight : Democrawler","Orbit Elevator");
    settings.Add("End Fight : Democrawler", false,"End Fight : Democrawler","Orbit Elevator");

    settings.Add("Nest");
    settings.Add("Begin Fight : Unidentified Naytiba", false,"Begin Fight : Unidentified Naytiba","Nest");
    settings.Add("Enter Area : Outside Nest", false,"Enter Area : Outside Nest","Nest");
    settings.Add("Begin Fight : Raven", false,"Begin Fight : Raven","Nest");
    settings.Add("Enter Area : Nest", false,"Enter Area : Nest","Nest");
    settings.Add("Begin Fight : Final Boss", false,"Begin Fight : Final Boss","Nest");
    settings.Add("Credits Roll", false,"Credits Roll","Nest");
    #endregion
}

onStart
{
    vars.usedPositions.Clear();
}

isLoading
{
    return current.isLoading;
}

split
{
    // Last Split
    if (old.titleScreen == 332 && current.titleScreen == 58) {
        return true;
    }

    // Position Spliting
    foreach(var splitPos in vars.positionRegistery) {
        if (settings[splitPos.Key] == false) continue;
        if (vars.usedPositions.Contains(splitPos.Key)) continue;
        if (current.posX < splitPos.Value[0] -vars.triggerRadius || current.posX > splitPos.Value[0] +vars.triggerRadius) continue;
        if (current.posY < splitPos.Value[1] -vars.triggerRadius || current.posY > splitPos.Value[1] +vars.triggerRadius) continue;
        if (current.posZ < splitPos.Value[2] -vars.triggerRadius || current.posZ > splitPos.Value[2] +vars.triggerRadius) continue;

        vars.usedPositions.Add(splitPos.Key);
        return true;
    }
}

start
{
    if (
        (current.event_id == 54)
        && (old.event_id + 1) == current.event_id
    ) {
        // 47 to 48 -- press continue
        // 53 to 54 -- new game or new game plus
        return true;
    }
}
