AutoItSetOption( 'MustDeclareVars', 1 )

#include "../WND.au3"

Global $WND = WND_NewWindow( 'Idle Champions', 'UnityWndClass', 'steam://rungameid/627690' )
WND_Show( $WND )
Local $client_rect = WND_GetClientRect( $WND )
WND_CaptureArea( $WND, 'client-capture.png', 0, 0, $client_rect[2], $client_rect[3] )
