; Function clickImage
; input:
;   path of image ()default empty string)
;   name of image (default empty string)
; output:
;   found or not
;   update: return position of image

findImages(imagePath := "", name := "", ByRef outputX := 0, ByRef outputY := 0) 
{
;;<>Chỗ này là tìm trên hình trên nền ứng dụng mọi lần làm auto cho Nhân
    ; Open the program window with name BlueStacks ...
	;WinActivate,BlueStacks
    ; Interprets the coordinates below as relative to the screen rather than the active window.
	;CoordMode, Pixel, Relative
    ;CoordMode, Mouse, Relative
;</>
    CoordMode, Pixel, Screen
    ; initialize variables
    imageIndex := 0 
	foundFlag := 0
    
    ; Scan all images with by name and index in the path
    ; Example:
    ; phuc1.bmp, phuc2.bmp, phuc3.bmp (in this case, index start from 1)
    
    while(1)
    {
        imageIndex := imageIndex + 1
        IfNotExist, %ImagePath%%name%%imageIndex%.bmp
                break
        
        ; Search the current image function
        ; Function doc: screen/ImageSearch
        
        ; A_ScreenWidth, A_ScreenHeight: size of main screen
        ; bonus : 
        ;    A_ScriptDir: path of this script
        ;    A_ScriptName: name of this script 
        ;   refer to: Basic Usage and Syntax / Variables and Express
        
        ImageSearch, outputX, outputY, 0, 0, A_ScreenWidth, A_ScreenHeight, %ImagePath%%name%%imageIndex%.bmp
        ; if not found
        ; ErrorLevel is Default of this language when call some related function.
        if ErrorLevel
        {
                foundFlag := 0
        }
        ; if found exit loop and foundFlag = 1
        else
        {
            foundFlag := 1
            ;ControlSetText, Static2, Thay hinh: %name%%imageIndex%, Auto Status
            break
        }
    }
    return foundFlag
}

