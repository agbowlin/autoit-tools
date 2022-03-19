#include-once


#include <StringConstants.au3>


;---------------------------------------------------------------------
Func OBJ_NewObject()
	Local $obj = ObjCreate('Scripting.Dictionary')
	Return $obj
EndFunc


;---------------------------------------------------------------------
;~ Duplicates all dictionary entries into a new dictionary.
Func OBJ_Clone( $OBJ )
	Local $clone = OBJ_NewObject()

	Local $keys = $OBJ.Keys()
	Local $key_index = 0
	For $key_index = 0 To UBound( $keys ) - 1
		Local $key = $keys[$key_index]
		$clone[$key] = $OBJ[$key]
	Next

	Return $clone
EndFunc


;---------------------------------------------------------------------
;~ List all the groups within a dictionary.
Func OBJ_ListGroups( $OBJ )

	Local $group_names = '.'
	Local $keys = $OBJ.Keys()
	Local $key_index = 0
	For $key_index = 0 To UBound( $keys ) - 1
		Local $full_key = $keys[$key_index]
		Local $first_dot_position = StringInStr( $full_key, '.' )
		Local $section = StringLeft( $full_key, $first_dot_position - 1 )
		If( StringInStr( $group_names, '.' & $section & '.' ) = 0 ) Then
			$group_names &= $section & '.'
		EndIf
	Next

	$group_names = StringLeft( $group_names, StringLen( $group_names ) - 1 )
	$group_names = StringRight( $group_names, StringLen( $group_names ) - 1 )
	Return StringSplit( $group_names, '.', $STR_NOCOUNT )
EndFunc


;---------------------------------------------------------------------
;~ List all the keys within a dictionary group.
Func OBJ_ListGroupKeys( $OBJ, $GroupName )

	Local $group_keys = '.'
	Local $keys = $OBJ.Keys()
	Local $key_index = 0
	For $key_index = 0 To UBound( $keys ) - 1
		Local $full_key = $keys[$key_index]
		if( StringLeft( $full_key, StringLen( $GroupName ) + 1 ) == ($GroupName & '.') ) Then
			Local $key_name = StringRight( $full_key, StringLen( $full_key ) - (StringLen( $GroupName ) + 1) )
			$group_keys &= $key_name & '.'
		EndIf
	Next

	$group_keys = StringLeft( $group_keys, StringLen( $group_keys ) - 1 )
	$group_keys = StringRight( $group_keys, StringLen( $group_keys ) - 1 )
	Return StringSplit( $group_keys, '.', $STR_NOCOUNT )
EndFunc



;---------------------------------------------------------------------
;~ Dump a dictionary to the console.
Func OBJ_DumpToConsole( $OBJ )
	Local $group_names = OBJ_ListGroups( $OBJ )
	Local $group_index = 0
	For $group_index = 0 To UBound($group_names) - 1
		Local $group_name = $group_names[$group_index]
		ConsoleWrite( $group_name & @CRLF )
		Local $key_names = OBJ_ListGroupKeys( $OBJ, $group_name )
		Local $key_index = 0
		For $key_index = 0 To UBound($key_names) - 1
			Local $key_name = $key_names[$key_index]
			ConsoleWrite( ' -- ' & $key_name & ' = ' & $OBJ($group_name & '.' & $key_name) & @CRLF )
		Next
	Next
	Return
EndFunc


