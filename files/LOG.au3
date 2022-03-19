#include-once

#include <WinAPIError.au3>
#include <MsgBoxConstants.au3>

#include "OBJ.au3"


;=====================================================================
;=====================================================================
;
;	Logger.au3
;
;=====================================================================
;=====================================================================


global const $LOGLEVEL_ALL					= 0
global const $LOGLEVEL_TRACE				= 1
global const $LOGLEVEL_DEBUG				= 2
global const $LOGLEVEL_INFO					= 3
global const $LOGLEVEL_WARN					= 4
global const $LOGLEVEL_ERROR				= 5
global const $LOGLEVEL_NONE					= 999


;---------------------------------------------------------------------
; Log Settings
;---------------------------------------------------------------------


Global $LOG = OBJ_NewObject()

$LOG( 'LogTitle' ) = 'Logger'
$LOG( 'LogLevel' ) = $LOGLEVEL_ALL

$LOG( 'ToolTip.LogLevel' ) = $LOGLEVEL_NONE
$LOG( 'ToolTip.AddTimestamp' ) = True

$LOG( 'MessageBox.LogLevel' ) = $LOGLEVEL_WARN
$LOG( 'MessageBox.AddTimestamp' ) = False

$LOG( 'File.LogLevel' ) = $LOGLEVEL_NONE
$LOG( 'File.AddTimestamp' ) = True

$LOG( 'Console.LogLevel' ) = $LOGLEVEL_ALL
$LOG( 'Console.AddTimestamp' ) = True


;---------------------------------------------------------------------
; Log functions
;---------------------------------------------------------------------


Func LogMessage( $LogLevel, $Message )

	; Check for global minimum log level.
	If( $LogLevel < $LOG('LogLevel') ) Then
		Return
	EndIf
	
	Local $date_stamp = "" & @YEAR & "-" & @MON & "-" & @MDAY 
	Local $time_stamp = "" & @HOUR & ":" & @MIN & ":" & @SEC & "." & @MSEC
	Local $timestamp = '| ' & $date_stamp & ' | ' & $time_stamp
	;~ Local $timestamped_message = "[" & $timestamp & "] " & $Message
	Local $log_title = $LOG('LogTitle')
	
	Local $loglevel_text = ''
	Local $messagebox_flags = $IDOK + $MB_SYSTEMMODAL
	Local $tooltip_icon = 0;
	If( $LogLevel = $LOGLEVEL_TRACE ) Then
		$loglevel_text = "TRACE "
		$messagebox_flags += 0
		$tooltip_icon = 0
	ElseIf( $LogLevel = $LOGLEVEL_DEBUG ) Then
		$loglevel_text = "DEBUG "
		$messagebox_flags += 0
		$tooltip_icon = 0
	ElseIf( $LogLevel = $LOGLEVEL_INFO ) Then
		$loglevel_text = "INFO  "
		$messagebox_flags += $MB_ICONINFORMATION
		$tooltip_icon = 1
	ElseIf( $LogLevel = $LOGLEVEL_WARN ) Then
		$loglevel_text = "WARN  "
		$messagebox_flags += $MB_ICONWARNING
		$tooltip_icon = 2
	ElseIf( $LogLevel = $LOGLEVEL_ERROR ) Then
		$loglevel_text = "ERROR "
		$messagebox_flags += $MB_ICONERROR
		$tooltip_icon = 3
	EndIf

	Local $log_title_level = $log_title & ': ' & $loglevel_text

	; Message Window: Displays a message box containing the message text
	if( $LogLevel >= $LOG( 'MessageBox.LogLevel' ) ) then
		; Get the message text to output.
		local $text = $Message
		If( $LOG( 'MessageBox.AddTimestamp' ) == True ) Then
			$text = $timestamp & ' | ' & $text
		EndIf
		; Output the message.
		MsgBox( $messagebox_flags, $log_title_level, $text )
	endif

	; Tooltip: Displays a tooltip in the upper-left corner of the screen
	if( $LogLevel >= $LOG( 'ToolTip.LogLevel' ) ) then
		; Get the message text to output.
		local $text = $Message
		If( $LOG( 'ToolTip.AddTimestamp' ) == True ) Then
			$text = $timestamp & ' | ' & $text
		EndIf
		; Output the message.
		ToolTip( $text, 0, 0, $log_title_level, $tooltip_icon, 4 )
	endif

	; File: Appends the message text to a log file
	if( $LogLevel >= $LOG( 'File.LogLevel' ) ) then
		local $filename = @ScriptDir & "\" & $log_title & "." & $date_stamp & ".log"
		; Get the message text to output.
		local $text = $loglevel_text & ' | ' & $Message
		If( $LOG( 'File.AddTimestamp' ) == True ) Then
			$text = $timestamp & ' | ' & $text
		EndIf
		; Output the message.
		FileWriteLine( $filename, $text )
	endif
	
	; File: Appends the message text to a log file
	if( $LogLevel >= $LOG( 'Console.LogLevel' ) ) then
		; Get the message text to output.
		local $text = $loglevel_text & ' | ' & $Message
		If( $LOG( 'Console.AddTimestamp' ) == True ) Then
			$text = $timestamp & ' | ' & $text
		EndIf
		; Output the message.
		ConsoleWrite( $text & @CRLF )
	endif
	
	return
EndFunc


;---------------------------------------------------------------------
Func LogTrace( $Message )
	LogMessage( $LOGLEVEL_TRACE, $Message )
EndFunc


;---------------------------------------------------------------------
Func LogDebug( $Message )
	LogMessage( $LOGLEVEL_DEBUG, $Message )
endfunc


;---------------------------------------------------------------------
func LogInfo( $Message )
	LogMessage( $LOGLEVEL_INFO, $Message )
endfunc


;---------------------------------------------------------------------
func LogWarn( $Message )
	LogMessage( $LOGLEVEL_WARN, $Message )
endfunc


;---------------------------------------------------------------------
func LogError( $Message )
	LogMessage( $LOGLEVEL_ERROR, $Message )
endfunc


;---------------------------------------------------------------------
Func LastErrorText()
	Local $text = ''
	$text &= '@error = ' & @error & @CRLF
	$text &= '@extended = ' & @extended & @CRLF
	$text &= '_WinAPI_GetLastError() = ' & _WinAPI_GetLastError() & @CRLF
	Return $text
EndFunc

