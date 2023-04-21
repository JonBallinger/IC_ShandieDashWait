IC_ShandieDashWait_ReloadSettings()

g_ShandieDashWaitUserSettings := g_SF.LoadObjectFromJSON( A_LineFile . "\..\DashWaitSettings.json" )

GUIFunctions.AddTab("Shandie Dash Wait")

Gui, ICScriptHub:Tab, Shandie Dash Wait
GUIFunctions.UseThemeTextColor()

Gui, ICScriptHub:Font, w700
Gui, ICScriptHub:Add, Text, , Shandie Dash Wait Settings
Gui, ICScriptHub:Font, w400

Gui, ICScriptHub:Add, Checkbox, vOptionSettingCheck_ShandieDashWaitAtStart x15 y+5, ShandieDashWaitAtStart
Gui, ICScriptHub:Add, Checkbox, vOptionSettingCheck_ShandieDashWaitPostStack x15 y+5, ShandieDashWaitPostStack

Gui, ICScriptHub:Add, Button , x10 y+10 gIC_ShandieDashWait_SettingsSave, Save

IC_ShandieDashWait_AddToolTips()
IC_ShandieDashWait_Refresh()


IC_ShandieDashWait_SettingsSave(){
    global
    Gui, ICScriptHub:Submit, NoHide
    g_ShandieDashWaitUserSettings["ShandieDashWaitAtStart"] := OptionSettingCheck_ShandieDashWaitAtStart
    g_ShandieDashWaitUserSettings["ShandieDashWaitPostStack"] := OptionSettingCheck_ShandieDashWaitPostStack
    g_SF.WriteObjectToJSON( A_LineFile . "\..\DashWaitSettings.json" , g_ShandieDashWaitUserSettings )
    try ; avoid thrown errors when comobject is not available.
    {
        local SharedRunData := ComObjActive(g_BrivFarm.GemFarmGUID)
        SharedRunData.ReloadShandieDashWaitSettings()
    }
    return
}

IC_ShandieDashWait_AddToolTips() {
    GUIFunctions.AddToolTip( "OptionSettingCheck_ShandieDashWaitAtStart", "Shandie will dash wait at the start of run")
    GUIFunctions.AddToolTip( "OptionSettingCheck_ShandieDashWaitPostStack", "Shandie will dash wait after Briv has stacked successfully")    
}

IC_ShandieDashWait_Refresh() {
    g_ShandieDashWaitUserSettings := g_SF.LoadObjectFromJSON( A_LineFile . "\..\DashWaitSettings.json" )
    GuiControl,ICScriptHub:, OptionSettingCheck_ShandieDashWaitAtStart, % g_ShandieDashWaitUserSettings["ShandieDashWaitAtStart"]
    GuiControl,ICScriptHub:, OptionSettingCheck_ShandieDashWaitPostStack, % g_ShandieDashWaitUserSettings["ShandieDashWaitPostStack"]
}

IC_ShandieDashWait_ReloadSettings()
{
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
    
    if(g_ShandieDashWaitUserSettings["WriteSettings"] == true)
    {
        g_ShandieDashWaitUserSettings.Delete("WriteSettings")
        g_SF.WriteObjectToJSON( A_LineFile . "\..\DashWaitSettings.json" , g_ShandieDashWaitUserSettings )   
    }     
}