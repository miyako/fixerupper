//%attributes = {"invisible":true}
/*

convert legacy grouped radio buttons

*/

$f:={\
forms: Formula:C1597($1.files(fk recursive:K87:7 | fk ignore invisible:K87:22).query("extension == :1"; ".4DForm")); \
files: Formula:C1597(This:C1470.forms(This:C1470.tableForms).combine(This:C1470.forms(This:C1470.projectForms))); \
tableForms: Folder:C1567("/SOURCES/TableForms"); \
projectForms: Folder:C1567("/SOURCES/Forms")}

$o:={prefixes: Formula:C1597($1.map(Formula:C1597(Substring:C12($1.value; 1; 1))).distinct())}

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
						: ($object.type="radio")
							$radios.push($object)
						Else 
							continue
					End case 
				End for each 
				If ($radios.length>1) && ($o.prefixes($radios.extract("dataSource")).length=1)
					For each ($radio; $radios)
						$radio.radioGroup:=$o.prefixes($radios.extract("dataSource"))[0]
					End for each 
					$form.touched:=True:C214
				End if 
		End case 
	End for each 
	If (Bool:C1537($form.touched))
		OB REMOVE:C1226($form; "touched")
		$file.setText(JSON Stringify:C1217($form; *))
	End if 
End for each 