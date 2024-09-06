//%attributes = {"invisible":true}
/*

unselect on close box form event

*/

$f:={\
forms: Formula:C1597($1.files(fk recursive:K87:7 | fk ignore invisible:K87:22).query("extension == :1"; ".4DForm")); \
files: Formula:C1597(This:C1470.forms(This:C1470.tableForms).combine(This:C1470.forms(This:C1470.projectForms))); \
tableForms: Folder:C1567("/SOURCES/TableForms"); \
projectForms: Folder:C1567("/SOURCES/Forms")}

For each ($file; $f.files())
	$form:=JSON Parse:C1218($file.getText())
	If ($form.events#Null:C1517)
		$idx:=$form.events.indexOf("onCloseBox")
		If ($idx#-1)
			$form.events.remove($idx)
			$form.touched:=True:C214
		End if 
	End if 
	If (Bool:C1537($form.touched))
		OB REMOVE:C1226($form; "touched")
		$file.setText(JSON Stringify:C1217($form; *))
	End if 
End for each 
