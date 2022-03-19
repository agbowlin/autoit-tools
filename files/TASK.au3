#include-once

#include "LOG.au3"


;=====================================================================
;=====================================================================
;
;	TASK.au3
;
;	Functions for tracking the length of time it takes for a task to complete.
;
;=====================================================================
;=====================================================================


;---------------------------------------------------------------------
; Task functions
;---------------------------------------------------------------------


Func StartTask( $TaskName, $ExpectedWait = 0 )
	local $message = "Task started [" & $TaskName & "]"
	if( $ExpectedWait > 0 ) then
		$message = $message & " with expected wait of [" & $ExpectedWait & "] seconds"
	endif
	$message = $message & "."
	LogTrace( $message )
	local $task[ 2 ]
	$task[ 0 ] = $TaskName
	$task[ 1 ] = timerinit()
	return $task;
endfunc


Func TaskAge( $TASK )
	local $time = timerdiff( $TASK[ 1 ] )
	local $seconds = ($time / 1000)
	return $seconds
endfunc


Func EndTask( $TASK, $Message = "" )
	local $time = timerdiff( $TASK[ 1 ] )
	local $seconds = ($time / 1000)
	LogTrace( "Task completed [" & $TASK[ 0 ] & "] in [" & stringformat( "%.2f", $seconds ) & "] seconds. " & $Message )
	return
endfunc

