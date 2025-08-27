state("SB-Win64-Shipping", "current")
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
}

isLoading
{
    return current.isLoading;
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
