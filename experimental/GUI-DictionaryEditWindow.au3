#include-once

#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <GuiScrollBars.au3>

#include "../LOG.au3"
#include "../RECT.au3"
#include "../GUI.au3"
#include "../INI.au3"


;---------------------------------------------------------------------
Func GUI_EditDictionary_Create( $Dictionary )
	LogTrace( 'GUI_EditDictionary_Create()')

	;~ Create the GUI Window
	Local $wnd_width = 400
	Local $wnd_height = 500
	Local $window_style = 0
	$window_style += $WS_MINIMIZEBOX
	$window_style += $WS_CAPTION
	$window_style += $WS_POPUP
	$window_style += $WS_SYSMENU
	$window_style += $WS_SIZEBOX
	$window_style += $WS_VSCROLL
	Local $gui = GUI_NewGui( 'Edit Dictionary', $wnd_width, $wnd_height, $window_style )

	;~ Get the measurements for a two-column grid
	Local $child_margins = 1
	Local $col_width = ($wnd_width / 2) - (2 * $child_margins)
	Local $row_height = 23
	Local $x1 = $child_margins
	Local $x2 = ($wnd_width / 2) + $child_margins

	;~ Add a row for each dictionary entry
	Local $keys = $Dictionary.Keys()
	Local $rect = RECT_NewRect( $x1, 5, $col_width, $row_height )
	Local $key_index = 0
	Local $hctl = 0
	;~ Local $dock = $GUI_DOCKLEFT + $GUI_DOCKRIGHT
	Local $dock = $GUI_DOCKALL
	For $key_index = 0 To UBound( $keys ) - 1
		Local $key = $keys[$key_index]
		;~ Entry Name
		RECT_MoveToLT( $rect, $x1, $rect('Top') )
		$hctl = GUI_AddLabel( $gui, $key & '_label', $key, $rect, $SS_RIGHT )
		GUICtrlSetResizing( $hctl, $dock )
		;~ Entry Value
		RECT_MoveToLT( $rect, $x2, $rect('Top') )
		$hctl = GUI_AddTextbox( $gui, $key, $rect )
		GUICtrlSetResizing( $hctl, $dock )
		GUI_SetValue( $gui, $key, $Dictionary($key) )
		;~ Next Row
		RECT_MoveByXY( $rect, 0, $row_height + $child_margins )
	Next

	;~ Show the GUI Window
	If Not GUI_ShowWindow( $gui ) Then
		LogError( 'GUI_ShowWindow failed!' )
		Exit
	EndIf
    _GUIScrollBars_Init( $Gui('Window.Handle'), -1, $rect('Top') )

	Return $gui
EndFunc


;---------------------------------------------------------------------
Func GUI_EditDictionary_Layout( $GUI, $WindowMessage )
	Return
EndFunc


;---------------------------------------------------------------------
Func GUI_EditDictionary_Process( $GUI, $WindowMessage )
	Return
EndFunc


;---------------------------------------------------------------------
Func GUI_EditDictionary_Destroy( $GUI )
	LogTrace( 'GUI_EditDictionary_Destroy()')
	GUI_Destroy( $GUI )
EndFunc


