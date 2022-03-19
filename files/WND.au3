#include-once

#include <WindowsConstants.au3>
#include <ScreenCapture.au3>

#include "OBJ.au3"
#include "LOG.au3"

#include "../ImageSearch/ImageSearch.au3"


;---------------------------------------------------------------------
;	WND_NewWindow
;---------------------------------------------------------------------

Func WND_NewWindow( $TitleText, $ClassName, $Command )
	local $WND = ObjCreate( 'Scripting.Dictionary' )
	$WND( 'WindowTitleText' ) = $TitleText
	$WND( 'WindowClassName' ) = $ClassName
	$WND( 'WindowCommand' ) = $Command
	$WND( 'WindowProcess' ) = 0			; Contains the handle to the process, if we started it.
	$WND( 'WindowHandle' ) = 0			; Contains the handle to the window.
	$WND( 'DefaultTimeout' ) = 10		; Default number of seconds to wait for screens and changes to activate.
	return $WND
endfunc


;---------------------------------------------------------------------
;	WND_HideMouse
;	- Moves mouse pointer out of the way.
;---------------------------------------------------------------------


Func WND_HideMouse( $WND )
	;~ LogTrace( "WND_HideMouse()" )
	mousemove( 0, 0, 10 )
	return
endfunc


;---------------------------------------------------------------------
;	WND_WindowIdentifier
;---------------------------------------------------------------------


Func WND_WindowIdentifier( $WND )
	If( $WND('WindowHandle') <> 0 ) Then return HWnd( $WND('WindowHandle') )
	return "[TITLE:" & $WND('WindowTitleText') & "; CLASS:" & $WND('WindowClassName') & "]"
endfunc


;---------------------------------------------------------------------
;	WND_Show
;---------------------------------------------------------------------


Func WND_Show( $WND )
	Local $wnd_id = WND_WindowIdentifier( $WND )
	;~ local $hwnd = 0
	;~ $hwnd = WinExists( $wnd_id )
	;~ if( $hwnd == 0 ) Then
	;~ 	$hwnd = WinWait( $wnd_id, "", $WND('DefaultTimeout') )
	;~ 	if ($hwnd == 0) then
	;~ 		return False
	;~ 	endif
	;~ EndIf

	local $hwnd = WinActivate( $wnd_id )
	$WND('WindowHandle') = $hwnd

	return True
endfunc


;=====================================================================
;=====================================================================
;
;	WND_GetPos
;
;	Gets the location of the window.
;
;---------------------------------------------------------------------
;	Parameters
;		$WND			: The application object.
;
;---------------------------------------------------------------------
;	Returns
;		This function returns a 2-element array storing the X and Y coordinates of the window,
;		Coordinates returned by this function are screen coordinates.
;		This function returns False if the window is not found.
;
;=====================================================================
;=====================================================================


;~ func WND_GetPos( $WND )
;~ 	LogTrace( "WND_GetPos(" & $WND('WindowTitleText') & ")" )

;~ 	local $task = StartTask( "Waiting for window", $WND('DefaultTimeout')  )
;~ 		local $hwnd = WinWait( "[TITLE:" & $WND('WindowTitleText') & "; CLASS:" & $WND('WindowClassName') & "]", "", $WND('DefaultTimeout') )
;~ 		if ($hwnd == 0) then
;~ 			local $message = "Unable to locate the window!";
;~ 			EndTask( $task, $message )
;~ 			LogError( $message )
;~ 			return false
;~ 		endif
;~ 		Local $pos = WinGetPos( $hwnd )
;~ 		$pos[0] += ($pos[2] - 1280) - 5
;~ 		$pos[1] += ($pos[3] - 720) - 5
;~ 	EndTask( $task, "OK" )

;~ 	return $pos
;~ endfunc


;=====================================================================
;=====================================================================
;
;	WND_GetClientRect
;
;	Gets the rectangle of the window's client area.
;
;---------------------------------------------------------------------
;	Parameters
;		$WND			: The application object.
;
;---------------------------------------------------------------------
;	Returns
;		This function returns a 4-element array storing the X, Y, W, and H coordinates of the rectangle,
;		Coordinates returned by this function are screen coordinates.
;		This function returns False if the window is not found.
;
;=====================================================================
;=====================================================================


Func WND_GetClientRect( $WND )

	;~ Get the window location and dimensions.
	Local $wnd_id = WND_WindowIdentifier( $WND )
	Local $wnd_rect = WinGetPos( $wnd_id )
	Local $client_size = WinGetClientSize( $wnd_id )

	Local $cy_caption = _WinAPI_GetSystemMetrics( $SM_CYCAPTION )
	Local $cx_fixed_frame = _WinAPI_GetSystemMetrics( $SM_CXFIXEDFRAME )
	Local $cy_fixed_frame = _WinAPI_GetSystemMetrics( $SM_CYFIXEDFRAME )

	Local $client_rect[4]
	$client_rect[0] = $wnd_rect[0] + (($cx_fixed_frame + 1) * 2)				; ???
	$client_rect[1] = $wnd_rect[1] + (($cy_fixed_frame + 1) * 2) + $cy_caption	; ???
	$client_rect[2] = $client_size[0]
	$client_rect[3] = $client_size[1]

	return $client_rect
endfunc


;=====================================================================
;=====================================================================
;
;	WND_ImageSearchArea
;
;	Searches an area of the window for an image.
;
;---------------------------------------------------------------------
;	Parameters
;		$WND			: The application object.
;		$ImageFilename	: The filename of the template image to search for.
;		$Left			: The left edge of the search area, relative to the window.
;		$Top			: The top edge of the search area, relative to the window.
;		$Width			: The width of the search area.
;		$Height			: The height of the search area.
;		$Tolerance		: The image matching tolerance (0-255).
;
;---------------------------------------------------------------------
;	Returns
;		If the image is found, it returns the center point of the found image.
;		Coordinates returned by this function are screen coordinates.
;		If the image is not found, it returns False.
;
;=====================================================================
;=====================================================================


Func WND_ImageSearchArea( $WND, $ImageFilename, $Left, $Top, $Width, $Height, $Tolerance )

	If( Not FileExists( $ImageFilename ) ) Then
		LogError('The image file does not exist:' & @CRLF & $ImageFilename)
		Return False
	EndIf

	;~ Get the application dimensions.
	Local $client_rect = WND_GetClientRect( $WND )
	Local $screen_left = $client_rect[0] + $Left
	Local $screen_top = $client_rect[1] + $Top
	Local $screen_right = $screen_left + $Width
	Local $screen_bottom = $screen_top + $Height

	;~ Search for the image.
	Local $x = 0
	Local $y = 0
	Local $find_image = _ImageSearchArea( $ImageFilename, 1, $screen_left, $screen_top, $screen_right, $screen_bottom, $x, $y, $Tolerance )
	if( $find_image == 0 ) then
		Return False
	endif

	;~ Convert coordinates to window coordinates.
	$x -= $client_rect[0]
	$y -= $client_rect[1]

	;~ Return the center of the found image.
	LogTrace('Found image [' & $ImageFilename & '] at (' & $x & ', ' & $y & ')')
	local $image_pos[2]
	$image_pos[0] = $x
	$image_pos[1] = $y
	return $image_pos
endfunc


;=====================================================================
;=====================================================================
;
;	WND_CaptureArea
;
;	Captures an area of the screen within the window.
;
;---------------------------------------------------------------------
;	Parameters
;		$WND			: The application object.
;		$ImageFilename	: The filename to save the captured image.
;		$Left			: The left edge of the capture area, relative to the window.
;		$Top			: The top edge of the capture area, relative to the window.
;		$Width			: The width of the capture area.
;		$Height			: The height of the capture area.
;
;---------------------------------------------------------------------
;	Returns
;		This function does not return anything.
;
;=====================================================================
;=====================================================================


Func WND_CaptureArea( $WND, $ImageFilename, $Left, $Top, $Width, $Height )

	;~ Get the application dimensions.
	Local $client_rect = WND_GetClientRect( $WND )
	Local $screen_left = $client_rect[0] + $Left
	Local $screen_top = $client_rect[1] + $Top
	Local $screen_right = $screen_left + $Width
	Local $screen_bottom = $screen_top + $Height

	;~ Capture the image.
	_ScreenCapture_Capture( $ImageFilename, $screen_left, $screen_top, $screen_right, $screen_bottom, False )
	
	return
endfunc


;=====================================================================
;=====================================================================
;
;	WND_MouseLeftClick
;
;	Clicks the left mouse button within the window.
;
;---------------------------------------------------------------------
;	Parameters
;		$WND			: The application object.
;		$X				: The X coordinate of the mouse click, relative to the window.
;		$Y				: The Y coordinate of the mouse click, relative to the window.
;
;---------------------------------------------------------------------
;	Returns
;		This function does not return anything.
;
;=====================================================================
;=====================================================================


Func WND_MouseLeftClick( $WND, $X, $Y )
	Local $client_rect = WND_GetClientRect( $WND )
	Local $screen_x = $client_rect[0] + $X
	Local $screen_y = $client_rect[1] + $Y
	MouseClick( $MOUSE_CLICK_LEFT, $screen_x, $screen_y )
	return
endfunc


;=====================================================================
;=====================================================================
;
;	WND_GetColor
;
;	Gets the color of the pixel located at X and Y.
;
;---------------------------------------------------------------------
;	Parameters
;		$WND			: The application object.
;		$X				: The X coordinate of the pixel, relative to the window.
;		$Y				: The Y coordinate of the pixel, relative to the window.
;
;---------------------------------------------------------------------
;	Returns
;		This function return the color of the pixel located at X and Y.
;
;=====================================================================
;=====================================================================


Func WND_GetColor( $WND, $X, $Y )
	Local $client_rect = WND_GetClientRect( $WND )
	Local $screen_x = $client_rect[0] + $X
	Local $screen_y = $client_rect[1] + $Y
	Local $color = PixelGetColor( $screen_x, $screen_y )
	Return $color
endfunc


;=====================================================================
;=====================================================================
;
;	WND_HighlightArea
;
;	Draws a rectangle within the window.
;
;---------------------------------------------------------------------
;	Parameters
;		$WND			: The application object.
;		$Left			: The left edge of the rectangle, relative to the window.
;		$Top			: The top edge of the rectangle, relative to the window.
;		$Width			: The width of the rectangle.
;		$Height			: The height of the rectangle.
;		$Color			: The color of the rectangle. Defaults to 0xFF (red).
;		$PenWidth		: The height of the rectangle. Defaults to 4.
;		$Times			: Number of times to redraw the rectangle. Used when the application is constantly refreshing. Defaults to 1.
;
;---------------------------------------------------------------------
;	Returns
;		This function does not return anything.
;
;=====================================================================
;=====================================================================


Func WND_HighlightArea( $WND, $Left, $Top, $Width, $Height, $Color = 0xFF, $PenWidth = 4, $Times = 1 )

	Local $client_rect = WND_GetClientRect( $WND )
    Local $x1 = $client_rect[0] + $Left
    Local $x2 = $x1 + $Width
    Local $y1 = $client_rect[1] + $Top
    Local $y2 = $y1 + $Height

	Local $index
	For $index = 1 to $Times
		Local $hDC = _WinAPI_GetWindowDC( 0 ) ; DC of entire screen (desktop)
		Local $hPen = _WinAPI_CreatePen( $PS_SOLID, $PenWidth, $Color )
		Local $obj_orig = _WinAPI_SelectObject($hDC, $hPen)

		_WinAPI_DrawLine($hDC, $x1, $y1, $x2, $y1) ; horizontal to right
		_WinAPI_DrawLine($hDC, $x2, $y1, $x2, $y2) ; vertical down on right
		_WinAPI_DrawLine($hDC, $x2, $y2, $x1, $y2) ; horizontal to left right
		_WinAPI_DrawLine($hDC, $x1, $y2, $x1, $y1) ; vertical up on left

		; clear resources
		_WinAPI_SelectObject($hDC, $obj_orig)
		_WinAPI_DeleteObject($hPen)
		_WinAPI_ReleaseDC(0, $hDC)
	Next

	return
EndFunc


