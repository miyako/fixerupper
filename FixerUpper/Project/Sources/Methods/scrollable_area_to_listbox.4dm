//%attributes = {"invisible":true}
/*

convert legacy scrollable area to listbox

*/

$f:={\
forms: Formula:C1597($1.files(fk recursive:K87:7 | fk ignore invisible:K87:22).query("extension == :1"; ".4DForm")); \
files: Formula:C1597(This:C1470.forms(This:C1470.tableForms).combine(This:C1470.forms(This:C1470.projectForms))); \
tableForms: Folder:C1567("/SOURCES/TableForms"); \
projectForms: Folder:C1567("/SOURCES/Forms")}

$o:={min: Formula:C1597(($1#Null:C1517) && ($1<$2) ? $1 : $2); max: Formula:C1597(($1#Null:C1517) && ($1>$2) ? $1 : $2)}

For each ($file; $f.files())
	$form:=JSON Parse:C1218($file.getText())
	If ($form.editor.groups#Null:C1517)
		For each ($groupName; $form.editor.groups)
			$listbox:={objects: []; columns: []; page: Null:C1517; \
				type: "listbox"; \
				top: Null:C1517; left: Null:C1517; right: 0; bottom: 0; \
				selectionMode: "single"; showHeaders: False:C215; resizingMode: "legacy"; \
				horizontalLineStroke: "transparent"; \
				scrollbarHorizontal: "hidden"}
			For each ($objectName; $form.editor.groups[$groupName])
				For each ($page; $form.pages)
					Case of 
						: ($page=Null:C1517)
							continue
						: ($page.objects=Null:C1517)
							continue
						Else 
							$object:=$page.objects[$objectName]
							Case of 
								: ($object.type="listbox") && ($object.columns.length=1)
									$listbox.page:=$page
									$listbox.objects.push($objectName)
									$column:=$object.columns[0]
									$column.truncateMode:="none"
									$column.width:=Bool:C1537($object.scrollbarVertical) ? 0 : $object.width
									$listbox.columns.push($column)
									$listbox.top:=$o.min($listbox.top; $object.top)
									$listbox.left:=$o.min($listbox.left; $object.left)
									$listbox.right:=$o.max($object.left+$object.width; $listbox.right)
									$listbox.bottom:=$o.max($object.top+$object.height; $listbox.bottom)
								Else 
									continue
							End case 
					End case 
				End for each 
			End for each 
			If ($listbox.columns.length=$form.editor.groups[$groupName].length)
				$page:=$listbox.page
				$listbox.width:=$listbox.right-$listbox.left
				$listbox.height:=$listbox.bottom-$listbox.top
				OB REMOVE:C1226($listbox; "page")
				OB REMOVE:C1226($listbox; "right")
				OB REMOVE:C1226($listbox; "bottom")
				For each ($objectName; $listbox.objects)
					OB REMOVE:C1226($page.objects; $objectName)
				End for each 
				OB REMOVE:C1226($listbox; "objects")
				OB REMOVE:C1226($form.editor.groups; $groupName)
				$page.objects[$groupName]:=$listbox
				$form.touched:=True:C214
			End if 
		End for each 
	End if 
	If (Bool:C1537($form.touched))
		OB REMOVE:C1226($form; "touched")
		$file.setText(JSON Stringify:C1217($form; *))
	End if 
End for each 