state("SB-Win64-Shipping", "current")
{
    // patch 1.2.0
    bool isLoading : 0x7103D20;
    float posX : 0x6F83B1C;
    float posY : 0x703BFEC;
    float posZ : 0x6F83B18;
}

state("SB-Win64-Shipping", "1.1.0")
{
    bool isLoading : 0x6D83DEC;
    float posX : 0x6DFAF54;
    float posY : 0x6DFAF58;
    float posZ : 0x6DFAF5C;
}

init
{
    // 328835072 - current patch
    // 356278272 - ver 1.1.0
	if (modules.First().ModuleMemorySize == 356278272)
		version = "1.1.0";

    vars.triggerRadius = 10f;

    #region Position Splits
    vars.positionRegistery = new Dictionary<string,List<float>>();
    vars.positionRegistery.Add("Eidos 7 Start", new List<float>() {-87699, 15023, 44920});
    vars.positionRegistery.Add("Sitting at First Camp", new List<float>() {-69788, 14117, 46521});
    vars.positionRegistery.Add("First Fusion Cell", new List<float>() {-48476, 13864, 45210});
    vars.positionRegistery.Add("Cutscene after library", new List<float>() {-49986, 13863, 38298});
    vars.positionRegistery.Add("Cutscene Camp before Abaddon", new List<float>() {-47629, 14485, 35382});
    vars.positionRegistery.Add("Cutscene Getting out of the Parking", new List<float>() {-45964, 13853, 32957});
    vars.positionRegistery.Add("Cutscene Flooded Comercial Sector", new List<float>() {-17710, 20729, 32289});
    vars.positionRegistery.Add("Cutscene Clock Tower", new List<float>() {-11647, 22269, 25173});
    vars.positionRegistery.Add("Cutscene Memorial Tower", new List<float>() {-12710, 19771, 18203});
    vars.positionRegistery.Add("Initial Pos Inside Archives", new List<float>() {-99237, 1034, 42746});
    vars.positionRegistery.Add("Cutscene Construction Zone", new List<float>() {-8150, 20585, 11805});
    vars.positionRegistery.Add("Cutscene Construction View", new List<float>() {-20640, 21738, 9857});
    vars.positionRegistery.Add("Cutscene After City Underground", new List<float>() {-31267, 16947, -6153});
    vars.positionRegistery.Add("During Cutscene after Giga", new List<float>() {640, 352, -11});
    vars.positionRegistery.Add("Initial Pos Xion", new List<float>() {18273, 80, -13125});
    #endregion

    vars.usedPositions = new List<string>();
}

startup
{
    #region Settings
    settings.Add("Eidos 7");
    settings.Add("Eidos 7 Start", false, "Eidos 7 Start", "Eidos 7");
    settings.Add("Sitting at First Camp", false, "Sitting at First Camp", "Eidos 7");
    settings.Add("First Fusion Cell", false, "First Fusion Cell", "Eidos 7");
    settings.Add("Cutscene after library", false, "Cutscene after library", "Eidos 7");
    settings.Add("Cutscene Camp before Abaddon", false, "Cutscene Camp before Abaddon", "Eidos 7");
    settings.Add("Cutscene Getting out of the Parking", false, "Cutscene Getting out of the Parking", "Eidos 7");
    settings.Add("Cutscene Flooded Comercial Sector", false, "Cutscene Flooded Comercial Sector", "Eidos 7");
    settings.Add("Cutscene Clock Tower", false, "Cutscene Clock Tower", "Eidos 7");
    settings.Add("Cutscene Memorial Tower", false, "Cutscene Memorial Tower", "Eidos 7");
    settings.Add("Initial Pos Inside Archives", false, "Initial Pos Inside Archives", "Eidos 7");
    settings.Add("Cutscene Construction Zone", false, "Cutscene Construction Zone", "Eidos 7");
    settings.Add("Cutscene Construction View", false, "Cutscene Construction View", "Eidos 7");
    settings.Add("Cutscene After City Underground", false, "Cutscene After City Underground", "Eidos 7");
    settings.Add("During Cutscene after Giga", false, "During Cutscene after Giga", "Eidos 7");
    settings.Add("Xion");
    settings.Add("Initial Pos Xion", false, "Initial Pos Xion", "Xion");
    #endregion
}

isLoading
{
    return current.isLoading;
}

update
{
    if (timer.CurrentPhase == TimerPhase.NotRunning) {
        vars.usedPositions.Clear();
    }
}

split
{
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