#include-once

#include "OBJ.au3"


;---------------------------------------------------------------------
Func RECT_NewRect( $Left = 0, $Top = 0, $Width = 0, $Height = 0 )
	local $Rect = OBJ_NewObject()
	$Rect('Left') = $Left
	$Rect('Top') = $Top
	$Rect('Width') = $Width
	$Rect('Height') = $Height
	Return $Rect
EndFunc


;---------------------------------------------------------------------
Func RECT_ToString( $RECT )
	Local $rect_string = ''
	$rect_string &= '( ' & $RECT('Left') & ', ' & $RECT('Top') & ' )'
	$rect_string &= '[ ' & $RECT('Width') & ' x ' & $RECT('Height') & ' ]'
	Return $rect_string
EndFunc


;---------------------------------------------------------------------
Func RECT_ToArray( $RECT )
	Local $rect_array[4]
	$rect_array[0] = $RECT('Left')
	$rect_array[1] = $RECT('Top')
	$rect_array[2] = $RECT('Width')
	$rect_array[3] = $RECT('Height')
	Return $rect_array
EndFunc


;---------------------------------------------------------------------
Func RECT_FromArray( $RECT, $Array )
	$RECT('Left') = $Array[0 ]
	$RECT('Top') = $Array[1]
	$RECT('Width') = $Array[2]
	$RECT('Height') = $Array[3]
	Return True
EndFunc


;---------------------------------------------------------------------
Func RECT_MoveToLT( $RECT, $Left, $Top )
	$RECT('Left') = $Left
	$RECT('Top') = $Top
	Return True
EndFunc


;---------------------------------------------------------------------
Func RECT_MoveByXY( $RECT, $X, $Y )
	$RECT('Left') += $X
	$RECT('Top') += $Y
	Return True
EndFunc


;---------------------------------------------------------------------
Func RECT_MoveByRC( $RECT, $Rows, $Cols )
	$RECT('Top') += ($Rows * $RECT('Height'))
	$RECT('Left') += ($Cols * $RECT('Width'))
	Return True
EndFunc


;---------------------------------------------------------------------
Func RECT_ResizeWH( $RECT, $Width, $Height )
	$RECT('Width') = $Width
	$RECT('Height') = $Height
	Return True
EndFunc


;---------------------------------------------------------------------
Func RECT_CenterPoint( $RECT )
	local $point[2]
	$point[0] = $RECT('Left') + ($RECT('Width') / 2)
	$point[1] = $RECT('Top') + ($RECT('Height') / 2)
	Return True
EndFunc


;---------------------------------------------------------------------
Func RECT_ContainsPoint( $RECT, $Point )
	If( $Point[0] < $RECT('Left') ) Then Return False
	If( $Point[0] >= ($RECT('Left') + $RECT('Width')) ) Then Return False
	If( $Point[1] < $RECT('Top') ) Then Return False
	If( $Point[1] >= ($RECT('Top') + $RECT('Height')) ) Then Return False
	Return True
EndFunc


;---------------------------------------------------------------------
Func RECT_ContainsRect( $OuterRect, $InnerRect )
	If( $InnerRect('Left') < $OuterRect('Left') ) Then Return False
	If( $InnerRect('Top') < $OuterRect('Top') ) Then Return False
	If( ($InnerRect('Left') + $InnerRect('Width')) > ($OuterRect('Left') + $OuterRect('Width')) ) Then Return False
	If( ($InnerRect('Top') + $InnerRect('Height')) > ($OuterRect('Top') + $OuterRect('Height')) ) Then Return False
	Return True
EndFunc


;---------------------------------------------------------------------
Func RECT_Equals( $Rect1, $Rect2 )
	If( $Rect1('Left') <> $Rect2('Left') ) Then Return False
	If( $Rect1('Top') <> $Rect2('Top') ) Then Return False
	If( $Rect1('Width') <> $Rect2('Width') ) Then Return False
	If( $Rect1('Height') <> $Rect2('Height') ) Then Return False
	Return True
EndFunc


;---------------------------------------------------------------------
;~ Func RECT_Intersection( $Rect1, $Rect2 )
;~ 	Local $rect = RECT_NewRect()

;~ 	If( RECT_ContainsPoint( $Rect1, [ $Rect2('Left'), $Rect2('Top') ] ) ) Then
;~ 		$rect('Top')
;~ 	Else
;~ 	EndIf

;~ 	Return $rect
;~ EndFunc


