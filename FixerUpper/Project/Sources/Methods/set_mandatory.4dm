//%attributes = {"invisible":true}
/*

make mandatory fields "not_null"

targets: fields
require: standard xpath

*/

ASSERT:C1129(is_xpath_enabled)

$catalogFile:=File:C1566("/SOURCES/catalog.4DCatalog")
$dom:=DOM Parse XML source:C719($catalogFile.platformPath)

If (OK=1)
	ARRAY TEXT:C222($madatory_fields; 0)
	$madatory_field:=DOM Find XML element:C864($dom; "/base/table/field/field_extra[@mandatory=true]"; $madatory_fields)
	For ($i; 1; Size of array:C274($madatory_fields))
		$madatory_field:=$madatory_fields{$i}
		$field:=DOM Find XML element:C864($madatory_field; "../")
		DOM SET XML ATTRIBUTE:C866($field; "not_null"; True:C214)
		DOM SET XML ATTRIBUTE:C866($field; "never_null"; False:C215)
	End for 
	DOM EXPORT TO FILE:C862($dom; $catalogFile.platformPath)
	DOM CLOSE XML:C722($dom)
	RESTART 4D:C1292
End if 