AutoItSetOption( 'MustDeclareVars', 1 )

#include '../TASK.au3'

Local $task = StartTask( 'PixelGetColor() test' )
Local $number = 0
For $number = 1 to 100
	Local $color = PixelGetColor( 100, 100 )
Next
EndTask( $task )
