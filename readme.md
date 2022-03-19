

- OBJ
	- Func OBJ_NewObject() : Returns $OBJ
	- Func OBJ_ListGroups( $OBJ )
	- Func OBJ_ListGroupKeys( $OBJ, $GroupName )
	- Func OBJ_DumpToConsole( $OBJ )

- LOG
	- Global $LOG
	- Func LogMessage( $LogLevel, $Message )
	- Func LogTrace( $Message )
	- Func LogDebug( $Message )
	- func LogInfo( $Message )
	- func LogWarn( $Message )
	- func LogError( $Message )

- INI
	- Func INI_ReadFile( $Filename, $StripQuotes = False ) : Returns $INI
	- Func INI_WriteFile( $INI, $Filename )
	- Func INI_ListSections( $INI )

- TIME
	- Func TIME_HumanFormat( $TimeSeconds, $TimeFormat = $TIME_FORMAT_DEFAULT, $TimeZeroText = '' )

- TASK
	- Func StartTask( $TaskName, $ExpectedWait = 0 ) : Returns $TASK
	- Func TaskAge( $TASK )
	- Func EndTask( $TASK, $Message = "" )

- RECT
	- Func RECT_NewRect( $Left = 0, $Top = 0, $Width = 0, $Height = 0 ) : Returns $RECT
	- Func RECT_ToString( $RECT )
	- Func RECT_ToArray( $RECT )
	- Func RECT_FromArray( $RECT, $Array )
	- Func RECT_MoveToLT( $RECT, $Left, $Top )
	- Func RECT_MoveByXY( $RECT, $X, $Y )
	- Func RECT_ResizeWH( $RECT, $Width, $Height )
	- Func RECT_CenterPoint( $RECT )
	- Func RECT_ContainsPoint( $RECT, $Point )
	- Func RECT_ContainsRect( $OuterRect, $InnerRect )
	- Func RECT_Equals( $Rect1, $Rect2 )

- WND
	- Func WND_NewWindow( $TitleText, $ClassName, $Command ) : Returns $WND
	- Func WND_HideMouse( $WND )
	- Func WND_WindowIdentifier( $WND )
	- Func WND_Show( $WND )
	- Func WND_GetClientRect( $WND )
	- Func WND_ImageSearchArea( $WND, $ImageFilename, $Left, $Top, $Width, $Height, $Tolerance )
	- Func WND_CaptureArea( $WND, $ImageFilename, $Left, $Top, $Width, $Height )
	- Func WND_MouseLeftClick( $WND, $X, $Y )
	- Func WND_GetColor( $WND, $X, $Y )
	- Func WND_HighlightArea( $WND, $Left, $Top, $Width, $Height, $Color = 0xFF, $PenWidth = 4, $Times = 1 )

- GUI
	- Func GUI_NewGui( $Title, $Width, $Height, $Style = -1 ) : Returns $GUI
	- Func GUI_Destroy( $GUI )
	- Func GUI_HideWindow( $GUI )
	- Func GUI_ShowWindow( $GUI )
	- Func GUI_AddHeader( $GUI, $Name, $Caption, $Rect, $Style = -1 )
	- Func GUI_AddLabel( $GUI, $Name, $Caption, $Rect, $Style = -1 )
	- Func GUI_AddCheckbox( $GUI, $Name, $Caption, $Rect, $Style = -1 )
	- Func GUI_AddTextbox( $GUI, $Name, $Rect, $Style = -1 )
	- Func GUI_AddCombo( $GUI, $Name, $List, $Rect, $Style = -1 )
	- Func GUI_AddButton( $GUI, $Name, $Caption, $Rect, $Style = -1 )
	- Func GUI_GetValue( $GUI, $Name )
	- Func GUI_SetValue( $GUI, $Name, $Value )

