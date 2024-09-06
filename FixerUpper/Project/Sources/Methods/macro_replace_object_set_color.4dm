//%attributes = {"invisible":true,"preemptive":"incapable"}
#DECLARE($method_path : Text; $method_name : Text)

$OBJECT_SET_COLOR:=Replace string:C233(Command name:C538(271); " "; "\\s"; *)
$OBJECT_SET_RGB_COLORS:=Command name:C538(628)

var $code : Text
GET MACRO PARAMETER:C997(Highlighted method text:K5:18; $code)

ARRAY LONGINT:C221($pos; 0)
ARRAY LONGINT:C221($len; 0)

$f:={quote: Formula:C1597("\""+$1+"\""); convert: Formula:C1597(This:C1470.quote(SVG_Color_from_index($1+1)))}

$i:=1

$line:=""

$cap_asterisk:="(\\*;)?"
$cap_object:="([^;]+)"
$cap_args:="(.+)"
While (Match regex:C1019("("+$OBJECT_SET_COLOR+")\\s*\\("\
+$cap_asterisk+$cap_object+";"+$cap_args+"\\)"; $code; $i; $pos; $len))
	
	$line+=Substring:C12($code; $i; $pos{0}-$i)
	
	$asterisk:=Substring:C12($code; $pos{2}; $len{2})
	$object:=Substring:C12($code; $pos{3}; $len{3})
	$args:=Split string:C1554(Substring:C12($code; $pos{4}; $len{4}); ";")
	
	$color:=$args.length#0 ? $args[0] : ""
	$altColor:=$args.length>1 ? $args[1] : ""
	
	$i:=$pos{0}+$len{0}
	
	$idx:=Formula from string:C1601($color).call()
	
	$fg:=-$idx & 0x00FF
	$bg:=-$idx & 0xFF00 >> 8
	
	$fg:=$f.convert($fg)
	$bg:=$f.convert($bg)
	
	$translate:=$OBJECT_SET_RGB_COLORS+"("+[$asterisk+$object; $fg; $bg].join(";")
	
	If ($altColor#"")
		$translate+=";"
		$idx:=Formula from string:C1601($altColor).call()
		$bg:=-$idx & 0xFF00 >> 8
		$bg:=$f.convert($bg)
		$translate+=$bg
	End if 
	
	$translate+=")"
	$line+=$translate
End while 

$line+=Substring:C12($code; $i)

SET MACRO PARAMETER:C998(Highlighted method text:K5:18; $line)