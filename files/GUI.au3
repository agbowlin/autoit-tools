#include-once


#include <GUIConstantsEx.au3>
#include <FontConstants.au3>
;~ #include <GuiEdit.au3>
;~ #include <WinAPI.au3>
;~ #include <GuiScrollBars.au3>

#include "OBJ.au3"
#include "LOG.au3"

Global $GUI_TYPE_TAB_CONTROL = 'TabControl'
Global $GUI_TYPE_TAB_PAGE = 'TabPage'
Global $GUI_TYPE_HEADER = 'Header'
Global $GUI_TYPE_LABEL = 'Label'
Global $GUI_TYPE_CHECKBOX = 'Checkbox'
Global $GUI_TYPE_TEXTBOX = 'Textbox'
Global $GUI_TYPE_COMBO = 'Combo'
Global $GUI_TYPE_BUTTON = 'Button'


;---------------------------------------------------------------------
Func GUI_NewGui( $Title, $Width, $Height, $Style = -1 )
	local $GUI = OBJ_NewObject()
	;~ $GUI('Layout.Orientation') = 'vertical'
	;~ $GUI('Layout.Arrangement') = 'linear'
	;~ If( $Style <> -1 ) Then
	;~ 	$Style = BitOR( $Style, $WS_MINIMIZEBOX )
	;~ 	$Style = BitOR( $Style, $WS_CAPTION )
	;~ 	$Style = BitOR( $Style, $WS_POPUP )
	;~ 	$Style = BitOR( $Style, $WS_SYSMENU )
	;~ EndIf
	$GUI('Window.Width') = $Width
	$GUI('Window.Height') = $Height
	$GUI('Window.Handle') = GUICreate( $Title, $Width, $Height, -1, -1, $Style )
	$GUI('Window.FontName') = 'Tahoma'
	$GUI('Window.FontSize') = 10
	;~ $GUI('Window.ChildMargins') = 1
	Return $GUI
EndFunc


;~ ;---------------------------------------------------------------------
;~ Func GUI_NewRect( $GUI, $Top, $Left, $Width, $Height )
;~ 	Local $rect[4]
;~ 	$rect[0] = $Top
;~ 	$rect[1] = $Left
;~ 	$rect[2] = $Width
;~ 	$rect[3] = $Height
;~ 	Return $rect
;~ EndFunc


;---------------------------------------------------------------------
Func GUI_Destroy( $GUI )
	If( $GUI('Window.Handle') == 0 ) Then Return False
	GUIDelete( $GUI('Window.Handle') )
	Return True
EndFunc


;---------------------------------------------------------------------
Func GUI_HideWindow( $GUI )
	If( $GUI('Window.Handle') == 0 ) Then Return False
	GUISetState( @SW_HIDE, $GUI('Window.Handle') )
	Return True
EndFunc


;---------------------------------------------------------------------
Func GUI_ShowWindow( $GUI )
	If( $GUI('Window.Handle') == 0 ) Then Return False
	GUISetState( @SW_SHOW, $GUI('Window.Handle') )
	Return True
EndFunc


;~ ;---------------------------------------------------------------------
;~ ;~ Converts an array to a string list (e.g. '|value 1|value 2|value 3|')
;~ Func GUI_ArrayToList( $Array )
;~ 	LogError('Function not implemented!')
;~ EndFunc


;~ ;---------------------------------------------------------------------
;~ ;~ Converts a string list to an array
;~ Func GUI_ListToArray( $List )
;~ 	LogError('Function not implemented!')
;~ EndFunc


;---------------------------------------------------------------------
Func GUI_AddTabControl( $GUI, $Name, $Rect, $Style = -1, $Event = Null )
	If( $GUI('Window.Handle') == 0 ) Then Return False
	Local $hctl = GUICtrlCreateTab( $Rect('Left'), $Rect('Top'), $Rect('Width'), $Rect('Height'), $Style )
	;~ GUICtrlSetFont( $hctl, $GUI('Window.FontSize'), $FW_BOLD, $GUI_FONTUNDER, $GUI('Window.FontName') )
	If( $Name <> '' ) Then
		$GUI( $Name & '.Handle' ) = $hctl
		$GUI( $Name & '.Type' ) = $GUI_TYPE_TAB_CONTROL
		$GUI( $Name & '.Value' ) = ''
	EndIf
	Return $hctl
EndFunc


;---------------------------------------------------------------------
Func GUI_AddTabPage( $GUI, $Name, $Caption, $Event = Null )
	If( $GUI('Window.Handle') == 0 ) Then Return False
	Local $hctl = GUICtrlCreateTabItem( $Caption )
	;~ GUICtrlSetFont( $hctl, $GUI('Window.FontSize'), $FW_BOLD, $GUI_FONTUNDER, $GUI('Window.FontName') )
	If( $Name <> '' ) Then
		$GUI( $Name & '.Handle' ) = $hctl
		$GUI( $Name & '.Type' ) = $GUI_TYPE_TAB_PAGE
		$GUI( $Name & '.Value' ) = ''
	EndIf
	Return $hctl
EndFunc


;---------------------------------------------------------------------
Func GUI_AddHeader( $GUI, $Name, $Caption, $Rect, $Style = -1, $Event = Null )
	If( $GUI('Window.Handle') == 0 ) Then Return False
	Local $hctl = GUICtrlCreateLabel( $Caption, $Rect('Left'), $Rect('Top'), $Rect('Width'), $Rect('Height'), $Style )
	GUICtrlSetFont( $hctl, $GUI('Window.FontSize') + 2, $FW_BOLD, $GUI_FONTUNDER, $GUI('Window.FontName') )
	If( $Name <> '' ) Then
		$GUI( $Name & '.Handle' ) = $hctl
		$GUI( $Name & '.Type' ) = $GUI_TYPE_HEADER
		$GUI( $Name & '.Value' ) = False
	EndIf
	Return $hctl
EndFunc


;---------------------------------------------------------------------
Func GUI_AddLabel( $GUI, $Name, $Caption, $Rect, $Style = -1, $Event = Null )
	If( $GUI('Window.Handle') == 0 ) Then Return False
	Local $hctl = GUICtrlCreateLabel( $Caption, $Rect('Left'), $Rect('Top'), $Rect('Width'), $Rect('Height'), $Style )
	GUICtrlSetFont( $hctl, $GUI('Window.FontSize'), $FW_NORMAL, $GUI_FONTNORMAL, $GUI('Window.FontName') )
	If( $Name <> '' ) Then
		$GUI( $Name & '.Handle' ) = $hctl
		$GUI( $Name & '.Type' ) = $GUI_TYPE_LABEL
		$GUI( $Name & '.Value' ) = False
	EndIf
	If( $Event <> Null ) Then
		GUICtrlSetOnEvent( $hctl, $Event )
	EndIf
	Return $hctl
EndFunc


;---------------------------------------------------------------------
Func GUI_AddCheckbox( $GUI, $Name, $Caption, $Rect, $Style = -1, $Event = Null )
	If( $GUI('Window.Handle') == 0 ) Then Return False
	Local $hctl = GUICtrlCreateCheckbox( $Caption, $Rect('Left'), $Rect('Top'), $Rect('Width'), $Rect('Height'), $Style )
	GUICtrlSetFont( $hctl, $GUI('Window.FontSize'), $FW_NORMAL, $GUI_FONTNORMAL, $GUI('Window.FontName') )
	If( $Name <> '' ) Then
		$GUI( $Name & '.Handle' ) = $hctl
		$GUI( $Name & '.Type' ) = $GUI_TYPE_CHECKBOX
		$GUI( $Name & '.Value' ) = False
	EndIf
	If( $Event <> Null ) Then
		GUICtrlSetOnEvent( $hctl, $Event )
	EndIf
	Return $hctl
EndFunc


;---------------------------------------------------------------------
Func GUI_AddTextbox( $GUI, $Name, $Rect, $Style = -1, $Event = Null )
	If( $GUI('Window.Handle') == 0 ) Then Return False
	Local $hctl = GUICtrlCreateInput( '', $Rect('Left'), $Rect('Top'), $Rect('Width'), $Rect('Height'), $Style )
	GUICtrlSetFont( $hctl, $GUI('Window.FontSize'), $FW_NORMAL, $GUI_FONTNORMAL, $GUI('Window.FontName') )
	$GUI( $Name & '.Handle' ) = $hctl
	$GUI( $Name & '.Type' ) = $GUI_TYPE_TEXTBOX
	$GUI( $Name & '.Value' ) = False
	If( $Name <> '' ) Then
		$GUI( $Name & '.Handle' ) = $hctl
		$GUI( $Name & '.Type' ) = $GUI_TYPE_TEXTBOX
		$GUI( $Name & '.Value' ) = ''
	EndIf
	If( $Event <> Null ) Then
		GUICtrlSetOnEvent( $hctl, $Event )
	EndIf
	Return $hctl
EndFunc


;---------------------------------------------------------------------
Func GUI_AddCombo( $GUI, $Name, $List, $Rect, $Style = -1, $Event = Null )
	If( $GUI('Window.Handle') == 0 ) Then Return False
	Local $hctl = GUICtrlCreateCombo( '', $Rect('Left'), $Rect('Top'), $Rect('Width'), $Rect('Height'), $Style )
	GUICtrlSetFont( $hctl, $GUI('Window.FontSize'), $FW_NORMAL, $GUI_FONTNORMAL, $GUI('Window.FontName') )
	GUICtrlSetData( $hctl, $List )
	If( $Name <> '' ) Then
		$GUI( $Name & '.Handle' ) = $hctl
		$GUI( $Name & '.Type' ) = $GUI_TYPE_COMBO
		$GUI( $Name & '.List' ) = $List
		$GUI( $Name & '.Value' ) = ''
	EndIf
	If( $Event <> Null ) Then
		GUICtrlSetOnEvent( $hctl, $Event )
	EndIf
	Return $hctl
EndFunc


;---------------------------------------------------------------------
Func GUI_AddButton( $GUI, $Name, $Caption, $Rect, $Style = -1, $Event = Null )
	If( $GUI('Window.Handle') == 0 ) Then Return False
	Local $hctl = GUICtrlCreateButton( $Caption, $Rect('Left'), $Rect('Top'), $Rect('Width'), $Rect('Height'), $Style )
	GUICtrlSetFont( $hctl, $GUI('Window.FontSize'), $FW_NORMAL, $GUI_FONTNORMAL, $GUI('Window.FontName') )
	If( $Name <> '' ) Then
		$GUI( $Name & '.Handle' ) = $hctl
		$GUI( $Name & '.Type' ) = $GUI_TYPE_BUTTON
		$GUI( $Name & '.Value' ) = ''
	EndIf
	If( $Event <> Null ) Then
		GUICtrlSetOnEvent( $hctl, $Event )
	EndIf
	Return $hctl
EndFunc


;---------------------------------------------------------------------
Func GUI_GetValue( $GUI, $Name )
	Local $hctl = $GUI( $Name & '.Handle' )
	If( Not $hctl ) Then
		LogError( 'Control does not have a valid handle: ' & $Name )
		Return False
	EndIf

	Local $type = $GUI( $Name & '.Type' )
	Local $value = Null
	Switch( $type )
		
		Case $GUI_TYPE_HEADER
			LogError( 'GetValue operation not implemented for: ' & $type )
		
		Case $GUI_TYPE_LABEL
			LogError( 'GetValue operation not implemented for: ' & $type )
		
		Case $GUI_TYPE_CHECKBOX
			$value = (BitAND( GUICtrlRead( $hctl ), $GUI_CHECKED ) == $GUI_CHECKED)
		
		Case $GUI_TYPE_TEXTBOX
			$value = GUICtrlRead( $hctl )
		
		Case $GUI_TYPE_COMBO
			$value = GUICtrlRead( $hctl )
		
		Case $GUI_TYPE_BUTTON
			$value = GUICtrlRead( $hctl )
		
		Case Else
			LogError( 'Unknown control type: ' & $type )
	
	EndSwitch

	$GUI( $Name & '.Value' ) = $value
	Return $value
EndFunc


;---------------------------------------------------------------------
Func GUI_SetValue( $GUI, $Name, $Value )
	Local $hctl = $GUI( $Name & '.Handle' )
	If( Not $hctl ) Then
		LogError( 'Control does not have a valid handle: ' & $Name )
		Return False
	EndIf

	Local $type = $GUI( $Name & '.Type' )
	;~ LogTrace( 'Setting ' & $type & ' control [' & $hctl & '] value to [' & $Value & ']' )
	Switch( $type )
		
		Case $GUI_TYPE_HEADER
			GUICtrlSetData( $hctl, $Value )
		
		Case $GUI_TYPE_LABEL
			GUICtrlSetData( $hctl, $Value )
		
		Case $GUI_TYPE_CHECKBOX
			iF( $Value = False ) Then
				GUICtrlSetState( $hctl, $GUI_UNCHECKED )
			Else
				GUICtrlSetState( $hctl, $GUI_CHECKED )
			EndIf
		
		Case $GUI_TYPE_TEXTBOX
			GUICtrlSetData( $hctl, $Value )
		
		Case $GUI_TYPE_COMBO
			GUICtrlSetData( $hctl, $GUI( $Name & '.List' ), $Value )
		
		Case $GUI_TYPE_BUTTON
			GUICtrlSetData( $hctl, $Value )

		Case Else
			LogError( 'Unknown control type: ' & $type )
	
	EndSwitch

	$GUI( $Name & '.Value' ) = $Value
	Return True
EndFunc
