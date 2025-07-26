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

    vars.positionRegistery = new Dictionary<string,List<float>>();

    vars.AddPositionToRegistery = (Func<String,float,float,float,bool>)((name, x, y, z) => {
        if (settings[name] == false) 
            return false;
        vars.positionRegistery.Add(name,new List<float>() {x,y,z});
        return true;
    });
}

startup
{
    #region Settings

    settings.Add("Eidos 7");
    settings.Add("Prologue", false,"Prologue","Eidos 7");
    settings.Add("Activate Camp : Silent Street", false,"Activate Camp : Silent Street","Eidos 7");
    settings.Add("Enter Area : Parking Tower 2nd Floor", false,"Enter Area : Parking Tower 2nd Floor","Eidos 7");
    settings.Add("Begin Fight : Abbadon", false,"Begin Fight : Abbadon","Eidos 7");
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

    settings.Add("Spire 4");   
    settings.Add("Enter Area : Orca Space Complex", false,"Enter Area : Orca Space Complex","Spire 4");
    settings.Add("Activate Camp : Hypertube Entrance", false,"Activate Camp : Hypertube Entrance","Spire 4");
    settings.Add("Activate 1st Generator", false,"Activate 1st Generator","Spire 4");
    settings.Add("Activate 2nd Generator", false,"Activate 2nd Generator","Spire 4");
    settings.Add("Activate 3rd Generator", false,"Activate 3rd Generator","Spire 4");
    settings.Add("Activate 4th Generator", false,"Activate 4th Generator","Spire 4");
    settings.Add("Activate Door : Hypertube", false,"Activate Door : Hypertube","Spire 4");
    settings.Add("Begin Fight : Belial First Encounter", false,"Begin Fight : Belial First Encounter","Spire 4");
    settings.Add("Enter Area : Space Logistic Complex", false,"Enter Area : Space Logistic Complex","Spire 4");
    settings.Add("End Escape Sequence : Space Logistic Complex", false,"End Escape Sequence : Space Logistic Complex","Spire 4");
    settings.Add("Enter Area : Raphael Space Center Parking Area", false,"Enter Area : Raphael Space Center Parking Area","Spire 4");
    settings.Add("Enter Area : Raphael Space Center", false,"Enter Area : Raphael Space Center","Spire 4");
    settings.Add("Begin Fight : Belial", false,"Begin Fight : Belial","Spire 4");
    settings.Add("Enter Area : Cargo Lift 121", false,"Enter Area : Cargo Lift 121","Spire 4");
    settings.Add("Enter Area : Maintenance Sector", false,"Enter Area : Maintenance Sector","Spire 4");
    settings.Add("End Escape Sequence : Maintenance Sector", false,"End Escape Sequence : Maintenance Sector","Spire 4");
    settings.Add("Enter Area : Passenger Lift P161", false,"Enter Area : Passenger Lift P161","Spire 4");
    settings.Add("Activate Camp : Prestige Lounge", false,"Activate Camp : Prestige Lounge","Spire 4");
    settings.Add("Begin Fight : Karakuri", false,"Begin Fight : Karakuri","Spire 4");
    settings.Add("Enter Area : Lift", false,"Enter Area : Lift","Spire 4");
    settings.Add("Begin Fight : Democrawler", false,"Begin Fight : Democrawler","Spire 4");
    settings.Add("End Fight : Democrawler", false,"End Fight : Democrawler","Spire 4");

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
    #region Position Splits
    vars.positionRegistery.Clear();
    vars.AddPositionToRegistery("Prologue",-26261,4402,-17109);
    vars.AddPositionToRegistery("Activate Camp : Silent Street",-69788,14117,46521);
    vars.AddPositionToRegistery("Enter Area : Parking Tower 2nd Floor",-47629,14485,35382);
    vars.AddPositionToRegistery("Begin Fight : Abbadon",-49502,15480,34752);
    vars.AddPositionToRegistery("Activate Camp : Parking Tower Roof",-50801,15486,29975);
    vars.AddPositionToRegistery("Exit Area : Parking",-45964,13853,32957);
    vars.AddPositionToRegistery("Activate Camp : Abandonned Station",-35562,16302,30489);
    vars.AddPositionToRegistery("Enter Area : Flooded Commercial Sector",-17710,20729,32289);
    vars.AddPositionToRegistery("Enter Area : Clock Tower",-11647,22269,25173);
    vars.AddPositionToRegistery("Enter Area : Memorial Tower",-12710,19771,18203);
    vars.AddPositionToRegistery("Begin Fight : Corrupter",-11488,19310,12357);
    vars.AddPositionToRegistery("Enter Area : Construction Zone",-8150,20585,11805);
    vars.AddPositionToRegistery("Enter Area : Construction Zone Panoramic View",-20640,21738,9857);
    vars.AddPositionToRegistery("Enter Area : Crater",-31267,16947,-6153);
    vars.AddPositionToRegistery("Enter Area : Xion",18273,80,-13125);
    vars.AddPositionToRegistery("Enter Area : Wastelands",-18157,3146,14879);
    vars.AddPositionToRegistery("Activate Elevator : Altess Levoire Entrance",34968,-5945,-32377);
    vars.AddPositionToRegistery("Enter Area : Altess Levoire",936,-8518,25037);
    vars.AddPositionToRegistery("Enter Area : Capsule Cluster Room",886,-9458,5178);
    vars.AddPositionToRegistery("Enter Area : Specimen Preservation Lab",14193,-8601,-12681);
    vars.AddPositionToRegistery("Activate Elevator : Deteriorated Lobby",12897,-30819,-12749);
    vars.AddPositionToRegistery("Begin Fight : Maelstrom Altess Levoire",-4816,-30819,-11912);
    vars.AddPositionToRegistery("End Fight : Maelstrom Alstess Levoire",-6648,-30805,-10848);
    vars.AddPositionToRegistery("Enter Area : Matrix 11",33517,-19134,11713);
    vars.AddPositionToRegistery("Activate Elevator : Landfill",7641,-2312,33456);
    vars.AddPositionToRegistery("End QTE Sequence : Collapsed Rail Bridge",-11483,2615,27238);
    vars.AddPositionToRegistery("Begin Fight : Stalker",-61080,4393,31998);
    vars.AddPositionToRegistery("Get Item : Burst Skill",-63740,4394,33250);
    vars.AddPositionToRegistery("Activate Camp : Rail Yard",-67882,4841,38273);
    vars.AddPositionToRegistery("Enter Area : Underground Sewer",-75486,2419,41333);
    vars.AddPositionToRegistery("Enter Area : Rotten Labyrinth",-77697,1763,48990);
    vars.AddPositionToRegistery("Activate Camp : Temporary Armoury Entrance",-84397,-4481,79083);
    vars.AddPositionToRegistery("Begin Fight : Juggernaut",-85097,-4516,76149);
    vars.AddPositionToRegistery("End Escape Sequence : Train Graveyard",-106871,-26344,104694);
    vars.AddPositionToRegistery("Activate Camp : Contaminated Water Purification Plant Entrance",-109520,-23900,114033);
    vars.AddPositionToRegistery("Begin Fight : Tachy",-105915,-23287,122190);
    vars.AddPositionToRegistery("End Fight : Tachy",-106235,-29300,123264);
    vars.AddPositionToRegistery("Enter Area : Central Desert",-19046,-19939,41594);
    vars.AddPositionToRegistery("Enter Area : Abyss Levoire",-20788,-8464,-34315);
    vars.AddPositionToRegistery("Activate Door : Underground Passage",-12307,-8928,-1814);
    vars.AddPositionToRegistery("Activate Button : Turning off Lasers",-20868,-9608,-4369);
    vars.AddPositionToRegistery("Begin Fight : Maelstrom Abyss Levoire",-26510,-9590,12143);
    vars.AddPositionToRegistery("End Fight : Maelstrom Abyss Levoire",-25477,-9575,14144);
    vars.AddPositionToRegistery("Enter Area : Orca Space Complex",-25467,4861,13683);
    vars.AddPositionToRegistery("Activate Camp : Hypertube Entrance",-511,1354,12405);
    vars.AddPositionToRegistery("Activate 1st Generator",4652,-68,10229);
    vars.AddPositionToRegistery("Activate 2nd Generator",1511,95,6892);
    vars.AddPositionToRegistery("Activate 3rd Generator",5494,-62,3646);
    vars.AddPositionToRegistery("Activate 4th Generator",1759,1329,4662);
    vars.AddPositionToRegistery("Activate Door : Hypertube",4781,1260,8165);
    vars.AddPositionToRegistery("Begin Fight : Belial First Encounter",-221707,-1200,206951);
    vars.AddPositionToRegistery("Enter Area : Space Logistic Complex",-224041,174,212273);
    vars.AddPositionToRegistery("End Escape Sequence : Space Logistic Complex",-220641,169,224277);
    vars.AddPositionToRegistery("Enter Area : Raphael Space Center Parking Area",-204175,1651,229143);
    vars.AddPositionToRegistery("Enter Area : Raphael Space Center",-216613,134,246033);
    vars.AddPositionToRegistery("Begin Fight : Belial",-204844,118,260984);
    vars.AddPositionToRegistery("Enter Area : Cargo Lift 121",-204332,2358,257163);
    vars.AddPositionToRegistery("Enter Area : Maintenance Sector",-222752,71968,261050);
    vars.AddPositionToRegistery("End Escape Sequence : Maintenance Sector",-218598,76111,264653);
    vars.AddPositionToRegistery("Enter Area : Passenger Lift P161",-135047,143327,270060);
    vars.AddPositionToRegistery("Activate Camp : Prestige Lounge",-138417,145876,275586);
    vars.AddPositionToRegistery("Begin Fight : Karakuri",-144280,145833,283950);
    vars.AddPositionToRegistery("Enter Area : Lift",-207885,134770,2748);
    vars.AddPositionToRegistery("Begin Fight : Democrawler",-224314,139505,-439);
    vars.AddPositionToRegistery("End Fight : Democrawler",-281390,1497,-23);
    vars.AddPositionToRegistery("Begin Fight : Unidentified Naytiba",606,-34660,32670);
    vars.AddPositionToRegistery("Enter Area : Outside Nest",-14770,-2695,-42149);
    vars.AddPositionToRegistery("Begin Fight : Raven",-38064,-2474,-51333);
    vars.AddPositionToRegistery("Enter Area : Nest",75431,-563,-39156);
    vars.AddPositionToRegistery("Begin Fight : Final Boss",43553,-2537,-39068);
    #endregion
}

isLoading
{
    return current.isLoading;
}

split
{
    
    // Last Split
    if (
        old.event_id == 332 && current.event_id == 58
        && settings["Credits Roll"]
    ) {
        return true;
    }
    // Position Spliting
    foreach(var splitPos in vars.positionRegistery) {
        //if (splitPos.Key == "End Fight : Maelstrom Alstess Levoire") {
        //    print("x : " + (current.posX < splitPos.Value[0] -vars.triggerRadius || current.posX > splitPos.Value[0] +vars.triggerRadius));
        //    //print("y : " + (current.posY < splitPos.Value[1] -vars.triggerRadius || current.posY > splitPos.Value[1] +vars.triggerRadius));
        //    print("z : " + (current.posZ < splitPos.Value[2] -vars.triggerRadius || current.posZ > splitPos.Value[2] +vars.triggerRadius));
        //}
        if (current.posX < splitPos.Value[0] -vars.triggerRadius || current.posX > splitPos.Value[0] +vars.triggerRadius) continue;
        // if (current.posY < splitPos.Value[1] -vars.triggerRadius || current.posY > splitPos.Value[1] +vars.triggerRadius) continue;
        if (current.posZ < splitPos.Value[2] -vars.triggerRadius || current.posZ > splitPos.Value[2] +vars.triggerRadius) continue;

        vars.positionRegistery.Remove(splitPos.Key);
        return true;
    }
}

start
{
    if (
        (current.event_id == 54 || current.event_id == 50)
        && (old.event_id + 1) == current.event_id
    ) {
        // 47 to 48 -- press continue
        // 53 to 54 -- new game or new game plus
        // 49 to 50 -- ng or ng+ on some systems, unsure what the difference is
        return true;
    }

}
