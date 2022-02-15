global g_ShandieDashWaitUserSettings := g_SF.LoadObjectFromJSON( A_LineFile . "\..\DashWaitSettings.json" )

class IC_ShandieDashWait_SharedFunctions_Class extends IC_BrivSharedFunctions_Class
{
    ; Waits for the game to be in a ready state
    ShouldDashWait()
    {
        ;MsgBox "ShandieDashWait"
        ShandieIsInFormation := this.IsChampInFormation( 47, this.Memory.GetCurrentFormation() )
        CurrentZone := this.Memory.ReadCurrentZone()
        Stacks := this.Memory.ReadSBStacks()
        

        ; If no Shandie, just exit with false
        if (!ShandieIsInFormation) {
            ;MsgBox "Shandie not detected"
            return false
        }
            

        ; If DashWait is disabled, exit with false
        if (g_BrivUserSettings[ "DisableDashWait" ]) {
            ;MsgBox "Dash wait is disabled"
            return false
        }
            

        ;MsgBox % "CurrentZone: " . CurrentZone . ", g_ShandieDashWaitUserSettings[""ShandieDashWaitAtStart""]:" . g_ShandieDashWaitUserSettings["ShandieDashWaitAtStart"] . ", Expression result: " . ((CurrentZone < 10) AND g_ShandieDashWaitUserSettings["ShandieDashWaitAtStart"])
        ; Next we check for Dash Wait at start of run
        if ((CurrentZone < 10) AND g_ShandieDashWaitUserSettings["ShandieDashWaitAtStart"]) {
            ;MsgBox "Start run Dash Wait"
            return true
        }
            

        ;MsgBox % "Stacks: " . Stacks . ", g_BrivUserSettings[ ""TargetStacks"" ]:" . g_BrivUserSettings[ "TargetStacks" ] . ", CurrentZone: " . CurrentZone . ", g_BrivUserSettings[ ""StackZone"" ]: " . g_BrivUserSettings[ "StackZone" ] . ", DashWaitPostStack: " . g_ShandieDashWaitUserSettings["ShandieDashWaitPostStack"]
        ; Then we check for Dash Wait post stack
        if ( stacks > g_BrivUserSettings[ "TargetStacks" ] AND CurrentZone >= g_BrivUserSettings[ "StackZone" ] AND g_ShandieDashWaitUserSettings["ShandieDashWaitPostStack"]) {
            ;MsgBox "Post Stack Dash Wait"
            return true
        }

        return false
    }
}

class IC_ShandieDashWait_GemFarm_Class extends IC_BrivGemFarm_Class
{    
}


; tried with and without the extends
class IC_ShandieDashWait_SharedData_Class ;extends IC_SharedData_Class
{
    ReloadShandieDashWaitSettings() {
        MsgBox, , , Shandie settings saved, 1
        g_ShandieDashWaitUserSettings := g_SF.LoadObjectFromJSON( A_LineFile . "\..\DashWaitSettings.json" )
        If !IsObject( g_ShandieDashWaitUserSettings )
        {
            g_ShandieDashWaitUserSettings := {}        
            g_ShandieDashWaitUserSettings["WriteSettings"] := true
        }
        if ( g_ShandieDashWaitUserSettings["ShandieDashWaitAtStart"] == "" )
            g_ShandieDashWaitUserSettings["ShandieDashWaitAtStart"] := 1

        if ( g_ShandieDashWaitUserSettings["ShandieDashWaitPostStack"] == "" )
            g_ShandieDashWaitUserSettings["ShandieDashWaitPostStack"] := 1
        
        if(g_ShandieDashWaitUserSettings["WriteSettings"] := true)
        {
            g_ShandieDashWaitUserSettings.Delete("WriteSettings")
            g_SF.WriteObjectToJSON( A_LineFile . "\..\DashWaitSettings.json" , g_ShandieDashWaitUserSettings )   
        }
    }
}