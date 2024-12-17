//%attributes = {"invisible":true}
/*

change .pict image reference to .png

targets: icon, customBackgroundPicture, picture

*/

$f:={\
forms: Formula:C1597($1.files(fk recursive:K87:7 | fk ignore invisible:K87:22).query("extension == :1"; ".4DForm")); \
files: Formula:C1597(This:C1470.forms(This:C1470.tableForms).combine(This:C1470.forms(This:C1470.projectForms))); \
tableForms: Folder:C1567("/SOURCES/TableForms"); \
projectForms: Folder:C1567("/SOURCES/Forms")}

For each ($file; $f.files())
	$form:=JSON Parse:C1218($file.getText())
	For each ($page; $form.pages)
		Case of 
			: ($page=Null:C1517)
				continue
			Else 
				For each ($objectName; $page.objects)
					$object:=$page.objects[$objectName]
					For each ($attribute; ["icon"; "picture"; "customBackgroundPicture"])
						Case of 
							: ($object[$attribute]#Null:C1517) && (Value type:C1509($object[$attribute])=Is text:K8:3)
								If ($object[$attribute]="@.pict")
									$object[$attribute]:=Path to object:C1547($object[$attribute]).name+".png"
									$form.touched:=True:C214
								End if 
							Else 
								continue
						End case 
					End for each 
				End for each 
		End case 
	End for each 
	If (Bool:C1537($form.touched))
		OB REMOVE:C1226($form; "touched")
		$file.setText(JSON Stringify:C1217($form; *))
	End if 
End for each 
