//%attributes = {"invisible":true}
/*

make b/w form objects dark mode aware

require: /LOGS/Conversion yyyy-MM-ddThh-mm-ss.json
require: /SOURCES/styleSheets.css
require: /RESOURCES/Images/library/highlight-button.svg

*/

$files:=Folder:C1567(fk logs folder:K87:17)\
.files(fk ignore invisible:K87:22)\
.query("name == :1 and extension == :2"; "Conversion@"; ".json")\
.orderBy("name desc")

If ($files.length#0)
	$logFile:=$files[0]
	$log:=JSON Parse:C1218($logFile.getText(); Is object:K8:27)
	$messages:=[\
		"'Background offset' 3D button style is not supported."; \
		"Highlight buttons are unsupported and converted as invisible buttons. You may consider using 3D buttons instead."]
	For each ($message; $log.messages.query("message in :1"; $messages))
		$formName:=$message.form
		$objectName:=$message.object
		If ($message.table#Null:C1517)
			$formFile:=File:C1566("/SOURCES/TableForms/"+String:C10($message.table)+"/"+$formName+"/form.4DForm")
		Else 
			$formFile:=File:C1566("/SOURCES/Forms/"+$formName+"/form.4DForm")
		End if 
		$form:=JSON Parse:C1218($formFile.getText(); Is object:K8:27)
		For each ($page; $form.pages)
			Case of 
				: ($page=Null:C1517)
					continue
				: ($page.objects[$objectName]=Null:C1517)
					continue
				Else 
					$object:=$page.objects[$objectName]
					$object.class:="highlight-button"
					For each ($property; ["customBackgroundPicture"; "focusable"; "imageHugsTitle"; "style"; "iconFrames"; "display"])
						OB REMOVE:C1226($object; $property)
					End for each 
					break
			End case 
		End for each 
		$formFile.setText(JSON Stringify:C1217($form; *))
	End for each 
End if 