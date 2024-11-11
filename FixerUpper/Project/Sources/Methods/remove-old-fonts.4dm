//%attributes = {"invisible":true}
/*

remove old fonts that may not render well in Direct2D mode

*/

$f:={\
forms: Formula:C1597($1.files(fk recursive:K87:7 | fk ignore invisible:K87:22).query("extension == :1"; ".4DForm")); \
files: Formula:C1597(This:C1470.forms(This:C1470.tableForms).combine(This:C1470.forms(This:C1470.projectForms))); \
tableForms: Folder:C1567("/SOURCES/TableForms"); \
projectForms: Folder:C1567("/SOURCES/Forms")}

$badFontFamilyNames:=["ＭＳ ゴシック"]

For each ($file; $f.files())
	$form:=JSON Parse:C1218($file.getText())
	For each ($page; $form.pages)
		Case of 
			: ($page=Null:C1517)
				continue
			Else 
				$radios:=[]
				For each ($objectName; $page.objects)
					$object:=$page.objects[$objectName]
					Case of 
						: ($object.fontFamily#Null:C1517) && ($badFontFamilyNames.indexOf($object.fontFamily)#-1)
							OB REMOVE:C1226($object; "fontFamily")
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