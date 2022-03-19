#include-once


#include <String.au3>


Global Const $SECONDS_PER_MINUTE	= 60
Global Const $MINUTES_PER_HOUR		= 60
Global Const $HOURS_PER_DAY			= 24

Global Const $TIME_FORMAT_DEFAULT			= 00	; 5 days, 3 hours, 28 minutes, 12 seconds
Global Const $TIME_FORMAT_LEADINGZEROS		= 01	; 05 days, 03 hours, 28 minutes, 12 seconds
Global Const $TIME_FORMAT_SHOWMILLISECONDS	= 02	; 5 days, 3 hours, 28 minutes, 12.186 seconds
Global Const $TIME_FORMAT_PROPERCASE		= 04	; 5 Days, 3 Hours, 28 Minutes, 12 Seconds
Global Const $TIME_FORMAT_SHORTFORM			= 08	; 5 days, 3 hrs, 28 mins, 12 secs
Global Const $TIME_FORMAT_SHORTERFORM		= 16	; 5d 3h 28m 12s


Func TIME_HumanFormat( $TimeSeconds, $TimeFormat = $TIME_FORMAT_DEFAULT, $TimeZeroText = '' )
	;~ ConsoleWrite('TIME_HumanFormat( ' & $TimeSeconds & ', ' & $TimeFormat & ' )' & @CRLF)

	Local $days = Floor( $TimeSeconds / ($HOURS_PER_DAY * $MINUTES_PER_HOUR * $SECONDS_PER_MINUTE) )
	$TimeSeconds -= $days * ($HOURS_PER_DAY * $MINUTES_PER_HOUR * $SECONDS_PER_MINUTE)
	;~ ConsoleWrite('days         = ' & $days & @CRLF)

	Local $hours = Floor( $TimeSeconds / ($MINUTES_PER_HOUR * $SECONDS_PER_MINUTE) )
	$TimeSeconds -= $hours * ($MINUTES_PER_HOUR * $SECONDS_PER_MINUTE)
	;~ ConsoleWrite('hours        = ' & $hours & @CRLF)
	
	Local $minutes = Floor( $TimeSeconds / $SECONDS_PER_MINUTE )
	$TimeSeconds -= $minutes * $SECONDS_PER_MINUTE
	;~ ConsoleWrite('minutes      = ' & $minutes & @CRLF)

	Local $seconds = Floor( $TimeSeconds )
	Local $milliseconds = Round( $TimeSeconds - $seconds, 3 )
	;~ ConsoleWrite('seconds      = ' & $seconds & @CRLF)
	;~ ConsoleWrite('milliseconds = ' & $milliseconds & @CRLF)

	Local $seperator_text = ', '
	Local $spacing_text = ' '

	Local $days_text = 'days'
	Local $hours_text = 'hours'
	Local $minutes_text = 'minutes'
	Local $seconds_text = 'seconds'

	;~ Convert to short form
	If( BitAND( $TimeFormat, $TIME_FORMAT_SHORTFORM ) == $TIME_FORMAT_SHORTFORM ) Then
		$days_text = 'days'
		$hours_text = 'hrs'
		$minutes_text = 'mins'
		$seconds_text = 'secs'
	EndIf

	;~ Convert to shorter form
	If( BitAND( $TimeFormat, $TIME_FORMAT_SHORTERFORM ) == $TIME_FORMAT_SHORTERFORM ) Then
		$days_text = 'd'
		$hours_text = 'h'
		$minutes_text = 'm'
		$seconds_text = 's'
		$seperator_text = ' '
		$spacing_text = ''
	EndIf

	;~ Convert to proper case
	If( BitAND( $TimeFormat, $TIME_FORMAT_PROPERCASE ) == $TIME_FORMAT_PROPERCASE ) Then
		$days_text = _StringProper ( $days_text )
		$hours_text = _StringProper ( $hours_text )
		$minutes_text = _StringProper ( $minutes_text )
		$seconds_text = _StringProper ( $seconds_text )
	EndIf

	;~ Add leading zeros
	If( BitAND( $TimeFormat, $TIME_FORMAT_LEADINGZEROS ) == $TIME_FORMAT_LEADINGZEROS ) Then
		$hours = _StringRepeat( '0', (2 - StringLen( '' & $hours )) ) & $hours
		$minutes = _StringRepeat( '0', (2 - StringLen( '' & $minutes )) ) & $minutes
		$seconds = _StringRepeat( '0', (2 - StringLen( '' & $seconds )) ) & $seconds
	EndIf

	;~ Build the formatted text string
	Local $text = ''
	If( $days > 0 ) Then
		$text &= $days & $spacing_text & $days_text
	EndIf
	If( (StringLen( $text ) > 0) Or ($hours > 0) ) Then
		If( StringLen( $text ) > 0 ) Then $text &= $seperator_text
		$text &= $hours & $spacing_text & $hours_text
	EndIf
	If( (StringLen( $text ) > 0) Or ($minutes > 0) ) Then
		If( StringLen( $text ) > 0 ) Then $text &= $seperator_text
		$text &= $minutes & $spacing_text & $minutes_text
	EndIf
	If( (StringLen( $text ) > 0) Or ($seconds > 0) ) Then
		If( StringLen( $text ) > 0 ) Then $text &= $seperator_text
		Local $msec = ''
		If( BitAND( $TimeFormat, $TIME_FORMAT_SHOWMILLISECONDS ) == $TIME_FORMAT_SHOWMILLISECONDS ) Then
			$msec = '' & Floor( $milliseconds * 1000 )
			$msec &= _StringRepeat( '0', (3 - StringLen( $msec )) )
			$msec = '.' & $msec
		EndIf
		$text &= $seconds & $msec & $spacing_text & $seconds_text
	EndIf

	If( StringLen( $text ) == 0 ) Then $text = $TimeZeroText

	Return $text
EndFunc

