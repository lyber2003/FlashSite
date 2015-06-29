#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\icons\dancing.ico
#AutoIt3Wrapper_Outfile=puthGeneratorGoogle.exe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <Array.au3>
#include <string.au3>

;MsgBox(0, "", $CmdLineRaw)

If $CmdLine[0]>0 Then


	$puth=$CmdLine[1]
	ConsoleWrite($CmdLine[1])
;$puthArray=StringSplit($puth,"\www" & @LF)
;_ArrayDisplay($puthArray)
$posWWW=StringInStr($puth,"www")
ConsoleWrite("position WWW: " & $posWWW & @LF)
ConsoleWrite("trimmed string: " & StringTrimLeft($puth,$posWWW+2)& @LF)
$filePuth=StringTrimLeft($puth,$posWWW+2)
$filePuth=StringReplace( $filePuth, "\", "/",0)


;MsgBox(0, "", $filePuth)
$host="http://37.57.234.41"
$host="https://googledrive.com/host/0B-lOxB6iLdGlLWtlcFdqeEhiSDg"
$dir="http://www.raidcall.com/direct&php?url=" & $host & $filePuth
;MsgBox(0, "", $dir)
ClipPut($dir)
ToolTip($dir)
sleep(4000)

Local $hFileOpen = FileOpen("link.txt", 2)
    If $hFileOpen = -1 Then
        MsgBox($MB_SYSTEMMODAL, "", "An error occurred when reading the file.")

    EndIf


FileWrite($hFileOpen,$dir)
FileClose($hFileOpen)
	Exit



Else




$puth=@ScriptDir

;$puthArray=StringSplit($puth,"\www" & @LF)
;_ArrayDisplay($puthArray)
$posWWW=StringInStr($puth,"www")
ConsoleWrite("position WWW: " & $posWWW & @LF)
ConsoleWrite("trimmed string: " & StringTrimLeft($puth,$posWWW-1)& @LF)
$dir=$puth
;MsgBox(0, "", $dir)
ClipPut($dir)


Local $hFileOpen = FileOpen("Directory.txt", 2)
    If $hFileOpen = -1 Then
        MsgBox($MB_SYSTEMMODAL, "", "An error occurred when reading the file.")

    EndIf


FileWrite($hFileOpen,$dir)
FileClose($hFileOpen)
	Exit

EndIf
