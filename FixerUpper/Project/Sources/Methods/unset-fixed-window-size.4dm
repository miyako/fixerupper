//%attributes = {"invisible":true}
/*

remove windowSizingX=fixed, windowSizingY=fixed
before v2004, forms could have window size "with constraints"
instead of modern resizing properties

*/

$f:={\
forms: Formula:C1597($1.files(fk recursive:K87:7 | fk ignore invisible:K87:22).query("extension == :1"; ".4DForm")); \
files: Formula:C1597(This:C1470.forms(This:C1470.tableForms).combine(This:C1470.forms(This:C1470.projectForms))); \
tableForms: Folder:C1567("/SOURCES/TableForms"); \
projectForms: Folder:C1567("/SOURCES/Forms")}

For each ($file; $f.files())
	$form:=JSON Parse:C1218($file.getText())
	If ($form.windowSizingX#Null:C1517) && ($form.windowSizingX="fixed")
		OB REMOVE:C1226($form; "windowSizingX")
		$form.touched:=True:C214
	End if 
	If ($form.windowSizingY#Null:C1517) && ($form.windowSizingY="fixed")
		OB REMOVE:C1226($form; "windowSizingY")
		$form.touched:=True:C214
	End if 
	If (Bool:C1537($form.touched))
		OB REMOVE:C1226($form; "touched")
		$file.setText(JSON Stringify:C1217($form; *))
	End if 
End for each 