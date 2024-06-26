global iskeeping := false

OnError(ErrorHandler)

ErrorHandler(Thrown, Mode) {
    X := 20
    Y := 20
    ToolTip("触发错误: " . Thrown.Message, X, Y)
    Sleep(2000)
    ToolTip("")
}


global lastAD := 'a'

CapsLock & o:: {
    Send "{Shift Down}{F10}{shift up}"
}
CapsLock & m:: {
    Send("{Control Down}{z}{Control Up}")
}
+BackSpace:: {
    Send("{Delete}")
}
CapsLock & BackSpace:: {
    Send("{Control Down}{BackSpace}{Control Up}")
}

CapsLock & p:: {
    ; Send("{Control Down}{z}{Control Up}")

    if (IsSet(iskeeping))
    {
        ; 如果变量已被赋值，执行这里的代码
        iskeeping := !iskeeping
    }
    else
    {
        ; 如果变量未被赋值，执行这里的代码
        global iskeeping := false
    }

    X := 20
    Y := 20
    ToolTip("切换", X, Y)
    Sleep(500)
    ToolTip("")

}

#HotIf WinActive("ahk_exe EtG.exe")
LButton:: {
    ; if (iskeeping) {
        MouseClick "left", , , 1, 0, "D"  ; 按住鼠标左键.
        
        while GetKeyState("LButton", "P") ;如果鼠标右键为按下的状态则进入循环
        {
            ; Click
            ; Sleep 120  ;

        }
        
        MouseClick "left", , , 1, 0, "U"  ; 释放鼠标按钮.
        
        return
    ; }
    ; else {
        ; MouseClick "left", , , 1, 0, "D"  ; 按住鼠标左键.
        ; Loop
        ; {
        ;     Sleep 10
        ;     if !GetKeyState("Nudmpad8", "P")  ; 按键已经被释放, 所以退出循环.
        ;         break
        ;     ; ... 此处放置您想要重复的任何动作.
        ; }
        ; MouseClick "left", , , 1, 0, "U"  ; 释放鼠标按钮.
    ; }

}
#HotIf



#HotIf WinActive("ahk_exe Astral Ascent.exe")

RAlt::{
    Send ("{s Down}{w Down}")
    Sleep 50 ; 这里的延时是为了确保按键被“按下”，可以根据需要调整
    Send(" {w Up}{s Up}")
    return
}
; s & RAlt::{
;     Send ("{s Down}{w Down}")
;     Sleep 50 ; 这里的延时是为了确保按键被“按下”，可以根据需要调整
;     Send(" {w Up}{s Up}")
;     return
; }
; s:: Send ("{s}")
#HotIf


; 通过双击CapsLock键来切换大小写
; 暂时禁用，采用下方的alt+capslk方式发送capslk事件

CapsLock:: return

; CapsLock::CapsLockDoubleClick()

; CapsLockDoubleClick() {
;     static lastPress := 0
;     threshold := 300  ; 设定双击的时间阈值为300毫秒
;     currentPress := A_TickCount
;     if (currentPress - lastPress <= threshold) {
;         ; 发生双击时执行的操作
;         SendInput ("{Blind}{CapsLock}")
;     }
;     lastPress := currentPress
; }


; 当前问题：capslk加一些未定义的按键，会触发capslk事件，导致大小写切换
; alt+capslk模拟capslk事件

!CapsLock:: SendInput ("{Blind}{CapsLock}")

; 模拟右移到结尾
CapsLock & `;:: {
    if GetKeyState("Shift", "P")
        Send("{Shift Down}{End}{Shift Up}")
    else
        Send("{End}")
    return
}
; 模拟左移到开头
CapsLock & h:: {
    if GetKeyState("Shift", "P")
        Send("{Shift Down}{Home}{Shift Up}")
    else
        Send("{Home}")
    return
}
; 模拟左键
CapsLock & j:: {
    if GetKeyState("Shift", "P")
        Send("{Shift Down}{Left}{Shift Up}")
    else
        Send("{Left}")
    return
}
; 模拟下键
CapsLock & k:: {
    if GetKeyState("Shift", "P")
        Send("{Shift Down}{Down}{Shift Up}")
    else
        Send("{Down}")

    return
}
; 模拟右键
CapsLock & l:: {
    if GetKeyState("Shift", "P")
        Send("{Shift Down}{Right}{Shift Up}")
    else
        Send("{Right}")
    return
}
; 模拟上键
CapsLock & i:: {
    if GetKeyState("Shift", "P")
        Send("{Shift Down}{Up}{Shift Up}")
    else
        Send("{Up}")
    return
}

; 模拟选中一个单词
CapsLock & w:: {
    Send("{Control Down}{Left}{Control Up}")
    Send("{Control Down}{Shift Down}{Right}{Control Up}{Shift Up}")
    return
}

; 获取当前窗口名
^!t:: {
    X := 20
    Y := 20
    ActiveWinId := WinGetID("A")  ; 获取当前活动窗口的ID
    ProcessName := WinGetProcessName("ahk_id " . ActiveWinId)  ; 获取窗口进程名
    ToolTip("当前运行的窗口的进程名是: " . ProcessName, X, Y)  ; 显示进程名
    Sleep(2000)
    ToolTip("", X, Y)
    return
}


; ; #HotIf WinActive('ahk_class Terraria.exe')
; a:: {
;     lastAD := 'a'
;     Send("{Blind}a")
;     return
; }

; d:: {
;     lastAD := 'd'
;     Send("{Blind}d")
;     return
; }

; XButton1:: {
;     X := 20
;     Y := 20
;     ToolTip("1触发", X, Y)
;     Sleep(2000)
;     ToolTip("")

;     if (lastAD = 'a')
;         SendInput("Blind a 2")
;     else if (lastAD = 'd')
;         Send("Blind d 2")
;     return
; }
; XButton2:: {
;     X := 20
;     Y := 20
;     ToolTip("2触发", X, Y)
;     Sleep(2000)
;     ToolTip("")

;     if (lastAD = 'a')
;         SendInput("Blind a 2")
;     else if (lastAD = 'd')
;         SendInput("Blind d 2")
;     return
; }
; ; #HotIf
