//%attributes = {"invisible":true,"preemptive":"incapable"}
#DECLARE($method_path : Text; $method_name : Text)

$ENABLE_BUTTON:=Replace string:C233(Command name:C538(192); " "; "\\s"; *)
$DISABLE_BUTTON:=Replace string:C233(Command name:C538(193); " "; "\\s"; *)
$OBJECT_SET_ENABLED:=Command name:C538(1123)
$TRUE:=Command name:C538(214)
$FALSE:=Command name:C538(215)

var $code : Text
GET MACRO PARAMETER:C997(Highlighted method text:K5:18; $code)

ARRAY LONGINT:C221($pos; 0)
ARRAY LONGINT:C221($len; 0)

$f:={quote: Formula:C1597("\""+$1+"\""); _enable: Command name:C538(192); enable: Formula:C1597($1=This:C1470._enable)}

$i:=1

$line:=""

$cap_asterisk:="(\\*;)?"
$cap_object:="(.+)"
$cap_command:="(?:"+$ENABLE_BUTTON+")|(?:"+$DISABLE_BUTTON+")"

While (Match regex:C1019("("+$cap_command+")\\s*\\("\
+$cap_asterisk+$cap_object+"\\)"; $code; $i; $pos; $len))
	
	$line+=Substring:C12($code; $i; $pos{0}-$i)
	$command:=Substring:C12($code; $pos{1}; $len{1})
	$asterisk:=Substring:C12($code; $pos{2}; $len{2})
	$object:=Substring:C12($code; $pos{3}; $len{3})
	
	$i:=$pos{0}+$len{0}
	
	If ($f.enable($command))
		$translate:=$OBJECT_SET_ENABLED+"("+[$asterisk+$object; $TRUE].join(";")
	Else 
		$translate:=$OBJECT_SET_ENABLED+"("+[$asterisk+$object; $FALSE].join(";")
	End if 
	
	$translate+=")"
	$line+=$translate
End while 

$line+=Substring:C12($code; $i)

SET MACRO PARAMETER:C998(Highlighted method text:K5:18; $line)