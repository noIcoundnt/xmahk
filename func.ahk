#Requires AutoHotkey v2.0
ShowToolTip(text, x, y, duration)
{
    ToolTip(text, x, y)
    Sleep(duration)
    ToolTip("")
}

