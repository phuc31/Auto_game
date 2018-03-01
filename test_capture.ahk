!F10::
{
    coordmode, mouse, screen
    mousegetpos, x, y
    w := 35
    h := 35
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