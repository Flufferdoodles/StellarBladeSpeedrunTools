state("SB-Win64-Shipping", "current")
{
    // patch 1.2.0
    bool isLoading : 0x7103D20;
    int titleScreen : 0x710B4E4;
}

state("SB-Win64-Shipping", "1.1.0")
{
    bool isLoading : 0x6D83DEC;
    int titleScreen : 0x7105438;
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

start
{
    if (
        (current.titleScreen == 48 || current.titleScreen == 54)
        && (old.titleScreen + 1) == current.titleScreen
    ) {
        // 47 to 48 -- press continue
        // 53 to 54 -- new game or new game plus
        return true;
    }
}
