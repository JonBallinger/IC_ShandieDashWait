#include %A_LineFile%\..\IC_ShandieDashWait_Functions.ahk
class IC_ShandieDashWait_Component
{
    InjectAddon()
    {
        global g_ShandieDashWaitUserSettings := g_SF.LoadObjectFromJSON( A_LineFile . "\..\DashWaitSettings.json" )
        splitStr := StrSplit(A_LineFile, "\")
        addonDirLoc := splitStr[(splitStr.Count()-1)]
        addonLoc := "#include *i %A_LineFile%\..\..\" . addonDirLoc . "\IC_ShandieDashWait_Addon.ahk`n"
        FileAppend, %addonLoc%, %g_BrivFarmModLoc%
    }
}
IC_ShandieDashWait_Component.InjectAddon()