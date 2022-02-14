class IC_ShandieDashWait_SharedFunctions_Class extends IC_BrivSharedFunctions_Class
{
    ; Waits for the game to be in a ready state
    ShouldDashWait()
    {
        MsgBox "ShandieDashWait"
        ShandieIsInFormation := this.IsChampInFormation( 47, this.Memory.GetCurrentFormation() )
        CurrentZone := this.Memory.ReadCurrentZone()
        ;DashWaitAtStart := false
        ;DashWaitPostStack := true

        g_BrivUserSettingsFromAddons["ShandieDashWaitAtStart"] := false
        g_BrivUserSettingsFromAddons["ShandieDashWaitPostStack"] := true

        ; If no Shandie, just exit with false
        if (!ShandieIsInFormation) {
            MsgBox "Shandie not detected"
            return false
        }
            

        ; If DashWait is disabled, exit with false
        if (g_BrivUserSettings[ "DisableDashWait" ]) {
            MsgBox "Dash wait is disabled"
            return false
        }
            

        ; Next we check for Dash Wait at start of run
        if ((CurrentZone < 10) AND g_BrivUserSettingsFromAddons["ShandieDashWaitAtStart"]) {
            MsgBox "Start run Dash Wait"
            return true
        }
            

        MsgBox % "Stacks: " . stacks . ", g_BrivUserSettings[ ""TargetStacks"" ]:" . g_BrivUserSettings[ "TargetStacks" ] . ", CurrentZone: " . CurrentZone . ", g_BrivUserSettings[ ""StackZone"" ]: " . g_BrivUserSettings[ "StackZone" ] . ", DashWaitPostStack: " . DashWaitPostStack
        ; Then we check for Dash Wait post stack
        if ( stacks < g_BrivUserSettings[ "TargetStacks" ] AND CurrentZone >= g_BrivUserSettings[ "StackZone" ] AND g_BrivUserSettingsFromAddons["ShandieDashWaitPostStack"]) {
            MsgBox "Post Stack Dash Wait"
            return true
        }

        return false
    }
}

class IC_ShandieDashWait_GemFarm_Class extends IC_BrivGemFarm_Class
{
}