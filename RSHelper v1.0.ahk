Gui, +AlwaysOnTop -Resize +Caption +border
Gui, Color, 303030  ; background
Gui, Font, c777777  ; White text
Gui, Font, Bold, Segoe UI
Gui, Add, Text, x145 y443 cWhite gShowInfo3 vInfo4, ?
Gui, Add, Text, x145 y403 cWhite gShowInfo2 vInfo3, ?
Gui, Add, Text, x145 y13 cWhite gShowInfo1 vInfo2, ?
Gui, Add, Text, x145 y43 cWhite gShowInfo vInfo1, ?
Gui, Font, Norm
Gui, Font, s13 Italic, Segoe UI
Gui, Add, Text, x15 y13, Ability 1 Key:
Gui, Add, Hotkey, vAbility1Key x160 y10 w80 ;Default Keystroke Ability 1
Gui, Add, Text, x15 y43, Ability 1 Interval:
Gui, Add, Edit, vAbility1Interval x160 y40 w80 gValidateInput, ;Default Interval Ability 1

Gui, Add, Text, x15 y83, Ability 2 Key:
Gui, Add, Hotkey, vAbility2Key x160 y80 w80 ;Default Keystroke Ability 2
Gui, Add, Text, x15 y113, Ability 2 Interval:
Gui, Add, Edit, vAbility2Interval x160 y110 w80 gValidateInput, ;Default Interval Ability 2

Gui, Add, Text, x15 y153, Ability 3 Key:
Gui, Add, Hotkey, vAbility3Key x160 y150 w80 ;Default Keystroke Ability 3
Gui, Add, Text, x15 y183, Ability 3 Interval:
Gui, Add, Edit, vAbility3Interval x160 y180 w80 gValidateInput, ;Default Interval Ability 3

Gui, Add, Text, x15 y223, Ability 4 Key:
Gui, Add, Hotkey, vAbility4Key x160 y220 w80 ;Default Keystroke Ability 4
Gui, Add, Text, x15 y253, Ability 4 Interval:
Gui, Add, Edit, vAbility4Interval x160 y250 w80 gValidateInput, ;Default Interval Ability 4

Gui, Add, Text, x15 y293, Ability 5 Key:
Gui, Add, Hotkey, vAbility5Key x160 y290 w80 ;Default Keystroke Ability 5
Gui, Add, Text, x15 y323, Ability 5 Interval:
Gui, Add, Edit, vAbility5Interval x160 y320 w80 gValidateInput, ;Default Interval Ability 5

Gui, Add, Text, x15 y363, Toggle Launch:
Gui, Add, Hotkey, vToggleKey x160 y360 w80 Disabled, F3

Gui, Add, Text, x15 y403, Auto-Close After:
Gui, Add, Edit, vTimeoutInterval x160 y400 w80 gValidateInput,  ;Default Timout Interval

Gui, Add, Text, x15 y443, Auto-Looting:
Gui, Add, Checkbox, vEnableAutoLoot x160 y444

Gui, Font, Norm 
Gui, Add, Button, gSaveSettings x127 y485, Save Settings
Gui, Add, Button, gShowReadMe x30 y485, ReadMe
Gui, Show, x5 y5 w260 h540, RSHelper v1.0

toggle := false

Return

ShowInfo:
    ToolTip, Each input will be triggered at your set interval plus a random delay of 0 to 150 ms.
    SetTimer, RemoveToolTip, -4500 ; Auto-hide after 3 seconds
Return

ShowInfo1:
    ToolTip, Enter your key of choice (alt/ctrl/shift+key are supported)
    SetTimer, RemoveToolTip, -4500 ; Auto-hide after 3 seconds
Return

ShowInfo2:
    ToolTip, Script timout in minutes. (blank = infinite)
    SetTimer, RemoveToolTip, -4500 ; Auto-hide after 3 seconds
Return

ShowInfo3:
    ToolTip, Script will periodically send a spacebar keystroke (default 20-30seconds)
    SetTimer, RemoveToolTip, -4500 ; Auto-hide after 3 seconds
Return

If (toggle) { ; Only activate timers if toggle is on
    SetTimer, Ability1, %Ability1Interval%
    SetTimer, Ability2, %Ability2Interval%
    SetTimer, Ability3, %Ability3Interval%
    SetTimer, Ability4, %Ability4Interval%
    SetTimer, Ability5, %Ability5Interval%
}

Return

; Toggle script on/off
#If
$F3::  ; Default toggle key
    toggle := !toggle
    if (toggle) {
        Gui, Submit, NoHide ; Save the changes from the GUI
        Ability1Interval := ConvertTime(Ability1Interval)
        Ability2Interval := ConvertTime(Ability2Interval)
        Ability3Interval := ConvertTime(Ability3Interval)
        Ability4Interval := ConvertTime(Ability4Interval)
        Ability5Interval := ConvertTime(Ability5Interval)

        SetTimer, Ability1, %Ability1Interval%
        SetTimer, Ability2, %Ability2Interval%
        SetTimer, Ability3, %Ability3Interval%
        SetTimer, Ability4, %Ability4Interval%
        SetTimer, Ability5, %Ability5Interval%

        ; Start Auto-looting if enabled
        if (EnableAutoLoot) {
            SetTimer, AutoLoot, % RandomDelay(20000, 30000)
        }

        ; Start Auto-Close Timer if a value is set
        if (TimeoutInterval != "" && TimeoutInterval > 0) {
            AutoCloseTime := TimeoutInterval * 60000  ; Convert minutes to milliseconds
            SetTimer, AutoClose, %AutoCloseTime%
        }

        ShowTip("RSHelper is running...")
        ToolTip, Settings Saved
        Sleep, 1000
        ToolTip,
    } else {
        SetTimer, Ability1, Off
        SetTimer, Ability2, Off
        SetTimer, Ability3, Off
        SetTimer, Ability4, Off
        SetTimer, Ability5, Off
        SetTimer, AutoClose, Off ; Stop auto-close if script is stopped
        ShowTip()
    }
    SetTimer, RemoveTooltip, -1500
Return

#If
RemoveTooltip:
    Tooltip
Return

; Ability 1 action
Ability1:
    Random, randDelay, 0, 150 ; Default delay
    Sleep, randDelay
    Send, %Ability1Key%
Return

; Ability 2 action
Ability2:
    Random, randDelay, 0, 150 ; Default delay
    Sleep, randDelay
    Send, %Ability2Key%
Return

; Ability 3 action
Ability3:
    Random, randDelay, 0, 150 ; Default delay
    Sleep, randDelay
    Send, %Ability3Key%
Return

; Ability 4 action
Ability4:
    Random, randDelay, 0, 150 ; Default delay
    Sleep, randDelay
    Send, %Ability4Key%
Return

; Ability 5 action
Ability5:
    Random, randDelay, 0, 150 ; Default delay
    Sleep, randDelay
    Send, %Ability5Key%
Return

; Hotkey to stop the script
F12::ExitApp

; FUNCTIONS FUNCTIONS FUNCTIONS FUNCTIONS FUNCTIONS FUNCTIONS FUNCTIONS FUNCTIONS FUNCTIONS FUNCTIONS FUNCTIONS FUNCTIONS
SaveSettings:
    ; Let user choose where to save the script
    FileSelectFile, SavePath, S16, %A_Desktop%\RSHelper_Saved.ahk, Save Script As, *.ahk
    if (SavePath = "")
        return  ; User canceled the save dialog.

    ; Read the current script's contents
    FileRead, ScriptContent, %A_ScriptFullPath%

    ; Submit the GUI to get the latest values
    Gui, Submit, NoHide 

    ; Replace the hotkeys and intervals in the script
    Loop, 9
    {
        EnableVar := "Enable" A_Index
        AbilityKeyVar := "Ability" A_Index "Key"
        DelayVar := "Delay" A_Index

        EnableValue := %EnableVar% ? "1" : "0"  ; Convert checkbox state to 1 or 0
        AbilityKeyValue := %AbilityKeyVar%
        DelayValue := %DelayVar%

        ; Replace the Enable checkbox variable
        ScriptContent := StrReplace(ScriptContent, "v" EnableVar, "Enable" A_Index)

        ; Preserve the existing y-coordinates for Hotkeys and set the saved key
        HotkeyLinePattern := "Gui, Add, Hotkey, v" AbilityKeyVar " x(\d+) y(\d+) w(\d+).*"
        ScriptContent := RegExReplace(ScriptContent, HotkeyLinePattern, "Gui, Add, Hotkey, v" AbilityKeyVar " x$1 y$2 w$3, " AbilityKeyValue)

        ; Save Ability Interval Values
        AbilityIntervalVar := "Ability" A_Index "Interval"
        GuiControlGet, IntervalValue, , %AbilityIntervalVar%
        ScriptContent := RegExReplace(ScriptContent, "Gui, Add, Edit, v" AbilityIntervalVar " x(\d+) y(\d+) w(\d+).*", "Gui, Add, Edit, v" AbilityIntervalVar " x$1 y$2 w$3, " IntervalValue)
    }

    ; Save Start/Stop Key
    GuiControlGet, StartStopKey
    ScriptContent := RegExReplace(ScriptContent, "Gui, Add, Hotkey, vStartStopKey x(\d+) y(\d+) w(\d+).*", "Gui, Add, Hotkey, vStartStopKey x$1 y$2 w$3, " StartStopKey)

    ; Save Auto-Close Timer
    GuiControlGet, TimeoutInterval
    ScriptContent := RegExReplace(ScriptContent, "Gui, Add, Edit, vTimeoutInterval x(\d+) y(\d+) w(\d+).*", "Gui, Add, Edit, vTimeoutInterval x$1 y$2 w$3, " TimeoutInterval)

    ; Save Auto-Looting Checkbox
    GuiControlGet, EnableAutoLoot
    AutoLootValue := EnableAutoLoot ? "Checked" : ""
    ScriptContent := RegExReplace(ScriptContent, "Gui, Add, Checkbox, vEnableAutoLoot x(\d+) y(\d+).*", "Gui, Add, Checkbox, vEnableAutoLoot x$1 y$2 " AutoLootValue)

    ; Save the updated script
    FileDelete, %SavePath%
    FileAppend, %ScriptContent%, %SavePath%

    MsgBox, Script saved successfully! It is now a standalone version with your settings.
return

ShowReadMe:
    Gui, ReadMe: Destroy  ; Close any existing ReadMe window
    Gui, ReadMe: +Owner +AlwaysOnTop +ToolWindow
    Gui, ReadMe: Color, 303030  ; Dark grey background

    Gui, ReadMe: Font, s12 c777777 Bold, Segoe UI  ; Bold grey text for title
    Gui, ReadMe: Add, Text, x10 y10 w380, Thank you for using RSHelper!
    
    Gui, ReadMe: Font, Norm 
    Gui, ReadMe: Font, s10 c777777 Italic, Segoe UI
    Gui, ReadMe: Add, Text, x245 y10 w380, by Ingame
    Gui, ReadMe: Font, Norm 
    Gui, ReadMe: Add, Text, x10 y50 w865, How to use:
    Gui, ReadMe: Add, Text, x10 y75 w380, 1: Enter Keys and Intervals based on Cooldown Timers
    Gui, ReadMe: Add, Text, x10 y90 w380, 2: Use each of the Keys once ingame, then start script (f3)
    Gui, ReadMe: Add, Text, x10 y105 w380, 3: Use "Save Settings" to save a duplicate precoded script.
    Gui, ReadMe: Font, s20 c777777 bold, Segoe UI
    Gui, ReadMe: Add, Text, x10 y180 w380, Note!
    Gui, ReadMe: Font, s11 c777777 Italic, Segoe UI
    Gui, ReadMe: Add, Text, x10 y230 w380, The use of this software violates Jagex's Terms of Service and may result in the permanent suspension of your account. Use at your own risk.
    Gui, ReadMe: Font, Norm 
    Gui, ReadMe: Add, Button, gOpenPayPal x130 y140 w150, Buy me a Coffee!
    Gui, ReadMe: Add, Button, gCloseReadMe x130 y310 w150, Agree and Close
    Gui, ReadMe: Show, x275 y10 w400 h370, RSHelper - Instructions
return

CloseReadMe:
    Gui, ReadMe: Destroy
return

ConvertTime(timeInput) {
    StringReplace, timeInput, timeInput, `,, ., All  ; Replace commas with dots
    timeInput := Trim(timeInput)  ; Remove spaces

    if (timeInput = "min, sec")
        return 100000000

    parts := StrSplit(timeInput, ".")  
    minutes := parts[1] * 60000  ; Convert the first part to minutes
    seconds := (parts.MaxIndex() > 1) ? parts[2] * 1000 : 0  ; Convert second part to whole seconds

    return minutes + seconds
}

ShowTip(s:="", pos:="y20", color:="Red|00FFFF") {
    static bak, idx
    if (bak=color "," pos "," s)
      return
    bak:=color "," pos "," s
    SetTimer, ShowTip_ChangeColor, Off
    Gui, ShowTip: Destroy
    if (s="")
      return
    ; WS_EX_NOACTIVATE:=0x08000000, WS_EX_TRANSPARENT:=0x20
    Gui, ShowTip: +LastFound +AlwaysOnTop +ToolWindow -Caption +E0x08000020
    Gui, ShowTip: Color, FFFFF0
    WinSet, TransColor, FFFFF0 150
    Gui, ShowTip: Margin, 10, 5
    Gui, ShowTip: Font, Q4 s10 bold
    Gui, ShowTip: Add, Text,, %s%
    Gui, ShowTip: Show, NA %pos%, ShowTip
    SetTimer, ShowTip_ChangeColor, 1500 ;delay on colourchange
    ShowTip_ChangeColor:
    Gui, ShowTip: +AlwaysOnTop
    r:=["Black", "White"]
    Gui, ShowTip: Font, % "Q3 c" r[idx:=Mod(Round(idx),r.length())+1]
    GuiControl, ShowTip: Font, Static1
    return
  }

  Gui, Add, Edit, vAbility1Interval x120 y30 w80, 1000
Gui, Add, Text, x+5 yp w15 h20 gShowIntervalInfo, ?
return

AutoClose:
    ExitApp
Return

ValidateInput:
    GuiControlGet, input, , %A_GuiControl%  ; Get input value
    cleanedInput := RegExReplace(input, "[^0-9.,]")  ; Remove all non-numeric, non-dot, and non-comma characters
    if (input != cleanedInput)  ; If invalid characters were removed
        GuiControl, , %A_GuiControl%, %cleanedInput%  ; Update field with cleaned input
return

AutoLoot:
    if (toggle && EnableAutoLoot) {
        Random, randDelay, 20000, 30000  ; Random delay between 20-30 sec
        Send, {Space}  ; Simulate pressing spacebar
        SetTimer, AutoLoot, %randDelay%  ; Reset timer with new delay
    } else {
        SetTimer, AutoLoot, Off  ; Stop if auto-loot is disabled
    }
Return

RandomDelay(min, max) {
    Random, randValue, min, max
    return randValue
}

OpenPayPal:
    Run, https://paypal.me/Kaoms
return

GuiClose:
ExitApp