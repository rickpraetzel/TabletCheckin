#tag Class
Protected Class AbstractResponse
	#tag Method, Flags = &h21
		Private Function buildRepresentation(depth as integer, theKey as string, values as Auto) As string
		  //Used to recusively build a string representation of an anet
		  //    response Dictionary while simultaniously storing the 
		  //    data that is holds 
		  //@param depth: the current depth of the parser
		  //@param values: The values to inspect at this depth
		  //@return: A string representation of values
		  
		  //PRE: We know that all dictionary keys will be of type string or text
		  dim indentaiton as string = getDepthCharacter(depth)
		  dim retString as string
		  dim TypeInfo as xojo.Introspection.TypeInfo
		  
		  TypeInfo = Xojo.Introspection.GetType(values)
		  Select case TypeInfo.FullName
		  case "String","Text" //The simplest case, we terminate here
		    retString = ": " + values
		    if theKey <> "" and not data.HasKey(theKey) then //Store value if it hasnt already been stored
		      data.Value(theKey) = values
		      
		    end if
		    
		  case "Xojo.Core.Dictionary" //We must recursively search through all keys
		    Using Xojo.Core
		    
		    dim theDict as Dictionary = values
		    retString = chr(10)
		    for each entry as DictionaryEntry in theDict
		      retString = retString + indentaiton + entry.Key + buildRepresentation(depth + 1, entry.key, entry.Value)
		      retString = retString + chr(10)
		      
		    next
		    
		  case "Auto()" //We know that these arrays will only store dictionaries 
		    dim theArray() as Auto = values
		    for ii as integer = 0 to UBound(theArray)
		      retString = retString + indentaiton + buildRepresentation(depth + 1, "", theArray(ii))
		      
		    next
		    
		  End Select
		  
		  Return retString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub constructor(anetData as xojo.Core.Dictionary)
		  Using Xojo.Core
		  dim retString as string
		  
		  data = new Dictionary()
		  for each entry as DictionaryEntry in anetData
		    //PRE: We know that all dictionary keys will be of type string or text
		    retString = retString + entry.Key + buildRepresentation(1, entry.key, entry.Value)
		    retString= retString + chr(10)
		    
		  next
		  
		  stringRep = ReplaceAll(retString, chr(10) + chr(10), chr(10)) //clear out double spaces 
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getDepthCharacter(depth as integer) As string
		  //Returns the current indentation based upon how deep in the tree
		  //    the string scanner is
		  //@param depth: The current depth number
		  //@return: The corrent indentation character
		  
		  const ind = "  " //using two spaces
		  dim retVal as string 
		  
		  for ii as integer = 0 to depth
		    retVal = retVal + ind
		    
		  next
		  
		  return retVal
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isSuccess() As boolean
		  //@return: True if the request was a success and false otherwise
		  
		  if data.Lookup("code", "") = kSuccessCode or data.Lookup("code", "") = "1" then
		    return true
		    
		  end if 
		  
		  return false 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function toString() As string
		  return stringRep
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected data As xojo.Core.Dictionary
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if data.HasKey("errorText") then
			    return data.Value("errorText")
			    
			  end if
			  
			  return data.Lookup("text", "")
			  
			End Get
		#tag EndGetter
		errorMessage As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return data.Lookup("code", "0")
			End Get
		#tag EndGetter
		lastErrorCode As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return data.Lookup("resultCode", "")
			End Get
		#tag EndGetter
		statusMessage As string
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private stringRep As string
	#tag EndProperty


	#tag Constant, Name = kSuccessCode, Type = String, Dynamic = False, Default = \"I00001", Scope = Protected
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="errorMessage"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="lastErrorCode"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="statusMessage"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
