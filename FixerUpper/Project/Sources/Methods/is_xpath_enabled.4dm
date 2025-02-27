//%attributes = {"invisible":true,"preemptive":"capable"}
#DECLARE()->$standard_xpath : Boolean

If (Application version:C493<"1830")
	$standard_xpath:=False:C215
Else 
	$standard_xpath:=True:C214
End if 

var $path : Text
$path:=Get 4D file:C1418(User settings file for data:K5:32)
If (Test path name:C476($path)#Is a document:K24:1)
	$path:=Get 4D file:C1418(User settings file:K5:31)
	If (Test path name:C476($path)#Is a document:K24:1)
		$path:=File:C1566("/SOURCES/settings.4DSettings").platformPath
	End if 
End if 

If (Test path name:C476($path)=Is a document:K24:1)
	$dom:=DOM Parse XML source:C719($path)
	If (OK=1)
		$misc:=DOM Find XML element:C864($dom; "/preferences/com.4d/database/misc")
		If (OK=1)
			var $attributeName; $attributeValue : Text
			For ($i; 1; DOM Count XML attributes:C727($misc))
				DOM GET XML ATTRIBUTE BY INDEX:C729($misc; $i; $attributeName; $attributeValue)
				If ($attributeName="standard_xpath")
					$standard_xpath:=Choose:C955($attributeValue="true"; True:C214; False:C215)
				End if 
			End for 
		End if 
		DOM CLOSE XML:C722($dom)
	End if 
End if 