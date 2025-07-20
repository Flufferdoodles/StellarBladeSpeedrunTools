state("SB-Win64-Shipping", "current")
{
    // patch 1.2.0
    bool isLoading : 0x7103D20;
    float posX : 0x6F89600;
    float posY : 0x6F89604;
    float posZ : 0x6F89608;
}

state("SB-Win64-Shipping", "1.1.0")
{
    bool isLoading : 0x6D83DEC;
    // TODO these are current patch addresses
    float posX : 0x6F89600;
    float posY : 0x6F89604;
    float posZ : 0x6F89608;
}

startup
{
    vars.hasSplit = new List<string>();
}

init
{
    // 328835072 - current patch
    // 356278272 - ver 1.1.0
	if (modules.First().ModuleMemorySize == 356278272)
		version = "1.1.0";
}

isLoading
{
    return current.isLoading;
}

split
{
    if (
        old.posX != current.posX 
        || old.posY != current.posY
        || old.posZ != current.posZ
    ) {
        if (
            !vars.hasSplit.Contains("eidos7")
            && current.posX - 44920.22266 < 1.0
            && current.posY + 87699.75 < 1.0
            && current.posZ - 15022.70898 < 1.0
        ) {

            vars.hasSplit.Add("eidos7");
            return true;
        }
    }
    
    return false;
}


