#Requires AutoHotkey v1+

; 定義一個函數來檢查當前窗口是否是遊戲窗口
IsGameWindow() {
    gameWindows := ["ahk_exe project8.exe", "窗口標題"]
    for _, window in gameWindows {
        if WinActive(window) {
            return true
        }
    }
    return false
}

; 使用 #If 指令和自定義函數來控制腳本行為
#If !IsGameWindow()

; 在這裡定義您的快捷鍵

; 終端機快捷鍵
#Enter::
{
    Run, wt.exe
    ;WinWait, ahk_exe wt.exe
    ;WinActivate 
    return
}

; 瀏覽器快捷鍵
#b::
{
    Run, C:\Program Files\Google\Chrome\Application\chrome.exe
    WinWait, ahk_exe C:\Program Files\Google\Chrome\Application\chrome.exe
    WinActivate 
    return
}

; 視窗控制
; #PgUp::WinMaximize, A ;
; #PgDn::WinMinimize, A ;
^q::WinClose, A ;

#If  ; 結束條件塊

; 終端機快捷鍵
; #Enter::
; {
;     Run, wt.exe
;     ;WinWait, ahk_exe wt.exe
;     ;WinActivate 
;     return
; }
; #Enter::Run, "C:\\Program Files\\Alacritty\\alacritty.exe"
; #Enter::Run, "C:\Program Files\WezTerm\wezterm-gui.exe"

; 瀏覽器快捷鍵
; #b::
; {
;     Run, firefox.exe
;     WinWait, ahk_exe firefox.exe
;     WinActivate 
;     return
; }

