state("SB-Win64-Shipping", "current")
{
    // patch 1.2.0
    bool isLoading : 0x7103D20;
}

state("SB-Win64-Shipping", "1.1.0")
{
    bool isLoading : 0x6D83DEC;
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

