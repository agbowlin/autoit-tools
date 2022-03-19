AutoItSetOption( 'MustDeclareVars', 1 )

#include "../TIME.au3"

;~ ConsoleWrite( TIME_HumanFormat( 4000.42, $TIME_FORMAT_DEFAULT ) & @CRLF )
;~ ConsoleWrite( TIME_HumanFormat( 4000.42, $TIME_FORMAT_LEADINGZEROS ) & @CRLF )
;~ ConsoleWrite( TIME_HumanFormat( 4000.42, $TIME_FORMAT_LEADINGZEROS + $TIME_FORMAT_SHOWMILLISECONDS ) & @CRLF )

Local $format = $TIME_FORMAT_DEFAULT
$format += $TIME_FORMAT_LEADINGZEROS
$format += $TIME_FORMAT_SHOWMILLISECONDS
;~ $format += $TIME_FORMAT_PROPERCASE
;~ $format += $TIME_FORMAT_SHORTFORM
$format += $TIME_FORMAT_SHORTERFORM

ConsoleWrite( TIME_HumanFormat( 4000.42, $format ) & @CRLF )

