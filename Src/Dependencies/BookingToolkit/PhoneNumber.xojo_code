#tag Class
Protected Class PhoneNumber
	#tag Method, Flags = &h0
		Sub constructor()
		  plainNumber = ""
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(numberText as string)
		  plainNumber = extractPlainNumber(numberText)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function extractPlainNumber(numberString as string) As string
		  dim thePlainNumber as string
		  dim currentChar as string
		  dim startIndex as integer = 1
		  
		  thePlainNumber = extractValidCharacters(numberString)
		  if left(thePlainNumber, 3) = kUSExitCode then
		    isUSNumber = false
		    thePlainNumber = right(thePlainNumber, len(thePlainNumber) - len(kUSExitCode))
		    
		  end if 
		  
		  if len(thePlainNumber) > 10 then
		    isUSNumber = false
		    
		  end if
		  
		  return thePlainNumber
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function extractValidCharacters(numberString as string) As string
		  dim currentChar,validString as String
		  
		  if left(numberString, 1) = kExitCharacter then
		    isUSNumber = false
		    
		  end if
		  
		  for ii as integer = 0 to len(numberString)
		    currentChar = mid(numberString, ii, 1)
		    if IsNumeric(currentChar) then
		      validString = validString + currentChar
		      
		    end if
		    
		  next
		  
		  return validString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function formatForeign() As string
		  return "(" + kUSExitCode + ")" + plainNumber
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function formatUS() As string
		  return left(plainNumber, 3) + "-" + mid(plainNumber, 4,3) + "-" + right(plainNumber, 4) 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getFormattedNumber() As string
		  if plainNumber <> "" then 
		    if isUSNumber then
		      return formatUS()
		      
		    else
		      return formatForeign()
		      
		    end if
		    
		  end if 
		  
		  return ""
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getMaskedNumber() As String
		  if plainNumber <> "" then
		    return "(XXX)XXX-" + right(plainNumber, 4)
		    
		  end if
		  
		  return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getUnformattedNumber() As string
		  if isUSNumber then
		    return plainNumber
		    
		  else
		    return kExitCharacter + plainNumber
		    
		  end if
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private isUSNumber As boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private plainNumber As string
	#tag EndProperty


	#tag Constant, Name = kExitCharacter, Type = String, Dynamic = False, Default = \"+", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kUSExitCode, Type = String, Dynamic = False, Default = \"011", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
