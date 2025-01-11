

; 程序错误的回调函数，不过从来没看见他调用过(
OnError(ErrorHandler)
ErrorHandler(Thrown, Mode) {
    X := 20
    Y := 20
    ToolTip("触发错误: " . Thrown.Message, X, Y)
    Sleep(2000)
    ToolTip("")
}

; 图片转为base64 img标签
CapsLock & q::{
     ; 调用Python脚本并获取剪贴板的第一个内容
     output := RunPythonScript("pythonw", "process_clipboard.pyw")
     ; 将Python脚本的输出复制到剪贴板
     Send(output)
}
RunPythonScript(pythonPath, scriptPath) {
    outputVar := ""
    RunWait(pythonPath ' `"' scriptPath '`" ' A_ScriptDir  " Hide", outputVar)
    return outputVar
}

; 通过powertoy映射目前可以将copilot键比较好的映射到Rctrl上，所以这个映射先取消 2024-11-22
; F23::AppsKey


; 触发鼠标右键
CapsLock & o::{
    setShiftedState()
    Send("{AppsKey}") ; 模拟按下应用键
    
}
; CapsLock & a:: {
;     Send("")
; }

; 手中的键盘突然开始取消
CapsLock & m:: {
    Send("{Control Down}{z}{Control Up}")
}

; 
+BackSpace:: {
    Send("{Delete}")
}
; 删除word
CapsLock & BackSpace:: {
    Send("{Control Down}{BackSpace}{Control Up}")
}

; 挺进地牢的脚本，不太好用
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


; 为了星座上升而写的脚本，暂时没啥用，不管了
global lastAD := 'a'
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


; 当前问题：capslk加一些未定义的按键，会触发capslk事件，导致大小写切换，不过本身键盘在处理没有组合键的时候就是这样的，所以也不用什么特别处理
; alt+capslk模拟capslk事件


isShifted:=0

!CapsLock:: SendInput ("{Blind}{CapsLock}")
CapsLock:: {
    if(isShifted == 0){
        global isShifted
        isShifted:=1

        X := 20
        Y := 20
        ToolTip("当前的值是: " . isShifted, X, Y)  ; 显示进程名
        ; Sleep(2000)
        ToolTip("", X, Y)   
        
        return
    }else{
        isShifted:=0
        
    }
}

setShiftedState(){
    global isShifted
    isShifted:=0
}

; 模拟右移到结尾
CapsLock & `;:: {
    if (GetKeyState("Shift", "P") || isShifted == 1) {
        Send("{Shift Down}{End}{Shift Up}")
        SetTimer setShiftedState,-1000
        
    } else {        
        Send("{End}")
    }
    return
}

; 模拟左移到开头
CapsLock & h:: {
    if (GetKeyState("Shift", "P") || isShifted == 1) {
        Send("{Shift Down}{Home}{Shift Up}")
        SetTimer setShiftedState,-1000
        
    } else {
        Send("{Home}")
    }
    return
}

; 模拟左键
CapsLock & j:: {
    if (GetKeyState("Shift", "P") || isShifted == 1) {
        Send("{Shift Down}{Left}{Shift Up}")
        SetTimer setShiftedState,-1000
    } else {
        Send("{Left}")
    }
    return
}

; 模拟下键
CapsLock & k:: {
    if (GetKeyState("Shift", "P") || isShifted == 1) {
        Send("{Shift Down}{Down}{Shift Up}")
        SetTimer setShiftedState,-1000

    } else {
        Send("{Down}")
    }
    return
}

; 模拟右键
CapsLock & l:: {
    if (GetKeyState("Shift", "P") || isShifted == 1) {
        Send("{Shift Down}{Right}{Shift Up}")
        SetTimer setShiftedState,-1000

    } else {
        Send("{Right}")
    }
    return
}

; 模拟上键
CapsLock & i:: {
    if (GetKeyState("Shift", "P") || isShifted == 1) {
        Send("{Shift Down}{Up}{Shift Up}")
        SetTimer setShiftedState,-1000

    } else {
        Send("{Up}")
    }
    return
}

; 模拟左跳word
CapsLock & 9:: {
    if (GetKeyState("Shift", "P") || isShifted == 1) {
        Send("{Control Down}{Shift Down}{Left}{Shift Up}{Control Up}")
        SetTimer setShiftedState,-1000

    } else {
        Send("{Control Down}{Left}{Control Up}")

    }
    return
}
; 模拟右跳word
CapsLock & 0:: {
    if (GetKeyState("Shift", "P") || isShifted == 1) {
        Send("{Control Down}{Shift Down}{Right}{Shift Up}{Control Up}")
        SetTimer setShiftedState,-1000

    } else {
        Send("{Control Down}{Right}{Control Up}")

    }
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

