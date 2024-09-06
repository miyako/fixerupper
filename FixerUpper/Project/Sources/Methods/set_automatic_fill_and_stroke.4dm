//%attributes = {"invisible":true}
/*

make lagacy form objects dark mode aware

targets: button, line, rectangle, text, input
require: /SOURCES/styleSheets.css

*/

$f:={\
forms: Formula:C1597($1.files(fk recursive:K87:7 | fk ignore invisible:K87:22).query("extension == :1"; ".4DForm")); \
files: Formula:C1597(This:C1470.forms(This:C1470.tableForms).combine(This:C1470.forms(This:C1470.projectForms))); \
tableForms: Folder:C1567("/SOURCES/TableForms"); \
projectForms: Folder:C1567("/SOURCES/Forms")}

$o:={classes: Formula:C1597($1.class=Null:C1517 ? [] : Split string:C1554($1.class; " "; sk trim spaces:K86:2 | sk ignore empty strings:K86:1))}

For each ($file; $f.files())
	$form:=JSON Parse:C1218($file.getText())
	For each ($page; $form.pages)
		Case of 
			: ($page=Null:C1517)
				continue
			Else 
				For each ($objectName; $page.objects)
					$object:=$page.objects[$objectName]
					Case of 
						: ($object.type="button") && ($object.stroke="#000000")
							OB REMOVE:C1226($object; "stroke")
							OB REMOVE:C1226($object; "fill")
							$object.class:=$o.classes($object).push("normal").join(" ")
							$form.touched:=True:C214
							
						: ($object.type="line") && (($object.stroke=Null:C1517) || ($object.stroke="#FFFFFF"))
							OB REMOVE:C1226($object; "stroke")
							OB REMOVE:C1226($object; "fill")
							$object.class:=$o.classes($object).push("normal").join(" ")
							$form.touched:=True:C214
							
						: ($object.type="rectangle") && (($object.fill=Null:C1517) || ($object.fill="#FFFFFF"))
							OB REMOVE:C1226($object; "stroke")
							OB REMOVE:C1226($object; "fill")
							$object.class:=$o.classes($object).push("normal").join(" ")
							$form.touched:=True:C214
							
						: ($object.type="text") && ($object.stroke="#000000")
							OB REMOVE:C1226($object; "stroke")
							OB REMOVE:C1226($object; "fill")
							$object.class:=$o.classes($object).push("normal").join(" ")
							$form.touched:=True:C214
							
						: ($object.type="input") && ($object.stroke="#000000")
							OB REMOVE:C1226($object; "stroke")
							OB REMOVE:C1226($object; "fill")
							$object.class:=$o.classes($object).push("normal").join(" ")
							$form.touched:=True:C214
						Else 
							continue
					End case 
				End for each 
		End case 
	End for each 
	If (Bool:C1537($form.touched))
		OB REMOVE:C1226($form; "touched")
		$file.setText(JSON Stringify:C1217($form; *))
	End if 
End for each 