AutoItSetOption( 'MustDeclareVars', 1 )

#include "../INI.au3"

Local $obj = OBJ_NewObject()
$obj('Test-1.key-a') = '1a'
$obj('Test-1.key-b') = '1b'
$obj('Test-1.key-c') = '1c'
$obj('Test-2.key-a') = '2a'
$obj('Test-2.key-b') = '2b'
$obj('Test-2.key-c') = '2c'
OBJ_DumpToConsole( $obj )

INI_WriteFile( $obj, 'test.ini' )
Local $ini = INI_ReadFile( 'test.ini' )
OBJ_DumpToConsole( $ini )

