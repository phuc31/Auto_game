#Include %A_ScriptDir%/usefulLib.ahk
Gui -SysMenu
Gui, Add, Text,W300, Welcome Am Duong Su                                
Gui, Add, Text,W300, 
Gui, Show, W300 H50 X0 Y0, Auto Status
SetTitleMatchMode, 3
CoordMode, Pixel, Screen
CoordMode, Mouse, Relative
get_ngu_hon()
{
    while (1)
    {
        outMsg := "Dang kiem tra su kien"
        ControlSetText, Static1, %outMsg%, Auto Status
        ControlSetText, Static2, , Auto Status
        path = %A_ScriptDir%\NguHon\
        state := check_current_state(path)
        ;MsgBox,,, state * %state% *
        if (state <> "")
        {
            outMsg := "Da phat hien: " + state
            ;MsgBox,,, %outMsg%
            ControlSetText, Static1, %outMsg%, Auto Status
            ;MsgBox,,, %state%
            if (state == "phong_an")
            {
                wait_click(path, state)
                find_and_click(path, "Hone")
                sleep, 1000
            }
            else
            {
                wait_click(path, state)
            }
            outMsg := "Xong: " + state
            ControlSetText, Static1, %outMsg%, Auto Status
        }
        sleep, 1000
    }
}

check_current_state(path)
{
    stateList := ["khieu_chien", "san_sang", "win", "phong_an"]
    state := ""
    for index, name in stateList
    {
        ;MsgBox, %name%
        found := findImages(path,name, x, y)
        if (found)
        {
            state := name
            break
        }
    }
    return state
}

wait_click(path, name)
{
    while (1)
    {
        success := find_and_click(path, name)
        if (success)
        {
            break
        }
        Sleep, 10
    }
}

find_and_click(path, name)
{
    found := findImages(path, name, x, y)
    if(found)
    {
        ; click the image when found
        sleepTime := 2000
        if (name == "win")
        {
            y := y - 60
            sleepTime := 8000
            sleep, 2000
        }
        else if (name == "Hone")
        {
            x := x + 404 
        }
        else
            x := x + 20
        y := y + 20

        ;Click without using mouse
        windowName := "NoxPlayer"
        WinGetPos, winX, winY,,,%windowName%
        
        relativeX := x - winX
        relativeY := y - winY
        ControlClick, x%relativeX% y%relativeY%, %windowName% 
        
        ; confirm the click result
        outMsg := "Dang kiem tra do chinh xac chuot"
        ControlSetText, Static1, %outMsg%, Auto Status
        ;ControlSetText, Static2, Thay hinh : %name%, Auto Status
        
        ; wait until not found the image
        ; i := 0
        ; while(i<3)
        ; {
            ; sleep, 200
            ; ControlSetText, Static2, , Auto Status
            ; found := findImages(path, name, temp1, temp2)
            ; if (found == 0)
            ; {
                ; break
            ; }
            ; else
            ; {
                ; ControlSetText, Static2, Van con -> click chuot, Auto Status
                ; MouseClick, left, %x%, %y%
            ; }
            ; i := i + 1
        
        sleep, %sleepTime%
        ControlSetText, Static2, , Auto Status
        found := findImages(path, name, temp1, temp2)
        if (found == 0)
        {
            return 1
        }
        else
        {
            ControlSetText, Static2, Van con -> click chuot, Auto Status
            ;Click without mouse
            ControlClick, x%relativeX% y%relativeY%, %windowName% 
        }
        i := i + 1
        return 1
    }
    return 0
}

F8::
{
    get_ngu_hon()
    return
}
!F10::
{
    coordmode, mouse, screen
    mousegetpos, x, y
    w := 28
    h := 28
    tool = %A_ScriptDir%/capture_screen.exe
    index := 1
    while(1)
    {
        dstFile = %A_ScriptDir%\NguHon\khieu_chien%index%.bmp
        ;Msgbox, %dstFile%
        IfExist, %dstFile%
        {
            index := index + 1
        }
        else
        {
            break
        }
    }
    ;Msgbox, %dstFile%
    cmd = %tool% %x% %y% %w% %h% %dstFile%
    Run, %cmd%,,Hide
    return
}
F9::
    PAUSE