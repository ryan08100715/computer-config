; Ctrl + Alt + C 置中目前視窗
^!c::
WinGetPos, X, Y, W, H, A
SysGet, Mon, MonitorWorkArea
NewX := (MonRight - MonLeft - W) / 2
NewY := (MonBottom - MonTop - H) / 2
WinMove, A, , NewX, NewY
return
