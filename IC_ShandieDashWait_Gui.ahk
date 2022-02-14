

GUIFunctions.AddTab("Shandie Dash Wait")

Gui, ICScriptHub:Tab, Shandie Dash Wait

Gui, ICScriptHub:Font, w700
Gui, ICScriptHub:Add, Text, , Shandie Dash Wait Settings
Gui, ICScriptHub:Font, w400

Gui, ICScriptHub:Add, Checkbox, vOptionSettingCheck_ShandieDashWaitAtStart x15 y+5, ShandieDashWaitAtStart
Gui, ICScriptHub:Add, Checkbox, vOptionSettingCheck_ShandieDashWaitPostStack x15 y+5, ShandieDashWaitPostStack

Gui, ICScriptHub:Add, Button , x10 y+10 gIC_ShandieDashWait_SettingsSave, Save

Gui, ICScriptHub:Add, Text, x10 y+10, You will need to reload ScriptHub (and the BrivGemFarm if already running) for changes to take effect

IC_ShandieDashWait_AddToolTips()
IC_ShandieDashWait_Refresh()


IC_ShandieDashWait_SettingsSave(){
    global
    Gui, ICScriptHub:Submit, NoHide
    g_ShandieDashWaitUserSettings["ShandieDashWaitAtStart"] := OptionSettingCheck_ShandieDashWaitAtStart
    g_ShandieDashWaitUserSettings["ShandieDashWaitPostStack"] := OptionSettingCheck_ShandieDashWaitPostStack
    g_SF.WriteObjectToJSON( A_LineFile . "\..\..\IC_ShandieDashWait\DashWaitSettings.json" , g_ShandieDashWaitUserSettings )
    try ; avoid thrown errors when comobject is not available.
    {
        local SharedRunData := ComObjActive("{416ABC15-9EFC-400C-8123-D7D8778A2103}")
        SharedRunData.ReloadSettings("RefreshSettingsView")
    }
    return
}

IC_ShandieDashWait_AddToolTips() {
    GUIFunctions.AddToolTip( "OptionSettingCheck_ShandieDashWaitAtStart", "Shandie will dash wait at the start of run")
    GUIFunctions.AddToolTip( "OptionSettingCheck_ShandieDashWaitPostStack", "Shandie will dash wait after Briv has stacked successfully")    
}

IC_ShandieDashWait_Refresh() {
    g_ShandieDashWaitUserSettings := g_SF.LoadObjectFromJSON( A_LineFile . "\..\..\IC_ShandieDashWait\DashWaitSettings.json" )
    GuiControl,ICScriptHub:, OptionSettingCheck_ShandieDashWaitAtStart, % g_ShandieDashWaitUserSettings["ShandieDashWaitAtStart"]
    GuiControl,ICScriptHub:, OptionSettingCheck_ShandieDashWaitPostStack, % g_ShandieDashWaitUserSettings["ShandieDashWaitPostStack"]
}