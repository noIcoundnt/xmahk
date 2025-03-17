#Requires AutoHotkey v2.0.17+

class mouse_task_view {
    static hotkey     := '^!c'      ; Set a hotkey to toggle functionality
    
    ; === Internal ===
    static cornerSize := Max(Min(Round(A_ScreenWidth * 0.005), Round(A_ScreenHeight * 0.005)), 5)
    static mouseHook  := 0
    static triggered  := false
    static enabled    := true
    
    static __New() {
        this.mouseHook := DllCall('SetWindowsHookEx'
            ,'int'  , 14
            ,'ptr'  , CallbackCreate((code, wp, lp) => this.LowLevelMouseProc(code, wp, lp))
            ,'ptr'  , 0
            ,'uint' , 0
        )
        Hotkey('$' this.hotkey, this.ToggleHotCorner.Bind(this))
        OnExit(*) => DllCall('UnhookWindowsHookEx', 'ptr', this.mouseHook)
    }
    
    static ToggleHotCorner(hk) {
        this.enabled := !this.enabled
        msg := 'Hot Corner: ' (this.enabled ? 'Enabled' : 'Disabled')
        this.notify(msg)
    }
    
    static notify(msg, x:=0, y:=0, id:=1) {
        if (A_CoordModeToolTip != 'Screen')
            A_CoordModeToolTip := 'Screen'
        ToolTip(msg, x, y, id)
        SetTimer(ToolTip, -1000)
    }
    
    static LowLevelMouseProc(nCode, wParam, lParam, arr*) {
        static WM_MOUSEMOVE := 0x0200
        if (nCode >= 0 && this.enabled && wParam = WM_MOUSEMOVE) {
            if A_CoordModeMouse != 'Screen'
                A_CoordModeMouse := 'Screen'
            MouseGetPos(&xpos, &ypos)
            if (xpos <= this.cornerSize && ypos <= this.cornerSize) {
                if (!this.triggered)
                    Send('#{Tab}')
                    ,this.triggered := true
            }  else this.triggered := false
        }
        
        return DllCall('CallNextHookEx'
            ,'ptr'  , 0
            ,'int'  , nCode
            ,'ptr'  , wParam
            ,'ptr'  , lParam
        )
    }
}