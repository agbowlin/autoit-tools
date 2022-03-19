#include-once


;~ #include <WinAPIFiles.au3>
#include <StringConstants.au3>

#include "OBJ.au3"


;---------------------------------------------------------------------
Func INI_ReadFile( $Filename, $StripQuotes = False )
	Local $ini = OBJ_NewObject()
	Local $section_names = IniReadSectionNames( $Filename )
	Local $section_count = $section_names[0]
	Local $section_number = 0
	For $section_number = 1 To $section_count
		Local $section_name = $section_names[ $section_number ]
		Local $section_values = IniReadSection( $Filename, $section_name )
		Local $entry_count = $section_values[0][0]
		Local $entry_number = 0
		For $entry_number = 1 to $entry_count
			Local $entry_name = $section_values[$entry_number][0]
			Local $entry_value = $section_values[$entry_number][1]
			$entry_value = StringStripWS( $entry_value, $STR_STRIPLEADING + $STR_STRIPTRAILING )
			If( $StripQuotes = True ) Then
				If (StringLeft( $entry_value, 1 ) = '"') And (StringRight( $entry_value, 1 ) = '"') Then
					$entry_value = StringLeft( $entry_value, StringLen( $entry_value ) - 1 )
					$entry_value = StringRight( $entry_value, StringLen( $entry_value ) - 1 )
				EndIf
			EndIf
			$ini( $section_name & '.' & $entry_name ) = $entry_value
		Next
	Next
	Return $ini
EndFunc


;---------------------------------------------------------------------
Func INI_WriteFile( $INI, $Filename )

	FileDelete( $Filename )

	Local $keys = $INI.Keys()
	Local $key_index = 0
	For $key_index = 0 To UBound( $keys ) - 1
		Local $full_key = $keys[$key_index]
		Local $first_dot_position = StringInStr( $full_key, '.' )
		Local $section = StringLeft( $full_key, $first_dot_position - 1 )
		Local $key = StringRight( $full_key, StringLen( $full_key ) - $first_dot_position )
		Local $value = $INI($full_key)
		IniWrite( $Filename, $section, $key, $value )
	Next

	Return
EndFunc


;~ ;---------------------------------------------------------------------
;~ Func INI_DumpToConsole( $INI )
;~ 	Local $keys = $INI.Keys()
;~ 	Local $key_index
;~ 	For $key_index = 0 To UBound( $keys ) - 1
;~ 		Local $key = $keys[$key_index]
;~ 		ConsoleWrite( $key & '=[' & $INI($key) & ']' & @CRLF )
;~ 	Next
;~ 	Return
;~ EndFunc


;---------------------------------------------------------------------
Func INI_ListSections( $INI )

	Local $section_names = '.'
	Local $keys = $INI.Keys()
	Local $key_index = 0
	For $key_index = 0 To UBound( $keys ) - 1
		Local $full_key = $keys[$key_index]
		Local $first_dot_position = StringInStr( $full_key, '.' )
		Local $section = StringLeft( $full_key, $first_dot_position - 1 )
		If( StringInStr( $section_names, '.' & $section & '.' ) = 0 ) Then
			$section_names &= $section & '.'
		EndIf
	Next

	$section_names = StringLeft( $section_names, StringLen( $section_names ) - 1 )
	$section_names = StringRight( $section_names, StringLen( $section_names ) - 1 )
	Return StringSplit( $section_names, '.', $STR_NOCOUNT )
EndFunc

