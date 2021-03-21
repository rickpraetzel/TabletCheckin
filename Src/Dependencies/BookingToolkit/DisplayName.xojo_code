#tag Class
Protected Class DisplayName
	#tag Method, Flags = &h21
		Private Function capatalize(name as String) As string
		  return Uppercase(left(name, 1)) + Right(name, len(name) - 1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor()
		  mfirstName = ""
		  mlastName = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(firstName as string)
		  mfirstName = ReplaceAll(capatalize(firstName), "\", "")
		  mlastName = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(firstName as string, lastName as string)
		  mfirstName = ReplaceAll(capatalize(firstName), "\", "")
		  mlastName = ReplaceAll(capatalize(lastName), "\", "") 
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if mFirstName <> "" and mLastName <> "" then
			    return mLastName + ", " + mFirstName
			    
			  elseif mFirstName <> "" then
			    return mFirstName
			    
			  elseif mLastName <> "" then
			    return mLastName
			    
			  else
			    return kNamePLaceholder
			    
			  end if
			End Get
		#tag EndGetter
		directoryName As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mFirstName
			End Get
		#tag EndGetter
		firstname As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if mFirstName <> "" and mLastName <> "" then
			    return mFirstName + " " + mLastName
			    
			  elseif mFirstName <> "" then
			    return mFirstName
			    
			  elseif mLastName <> "" then
			    return mLastName
			    
			  end if
			  
			  return ""
			End Get
		#tag EndGetter
		fullName As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mLastName
			  
			End Get
		#tag EndGetter
		lastname As string
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mFirstName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastName As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mFirstName + " " + left(mLastName,1)
			End Get
		#tag EndGetter
		popupName As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return ReplaceAll(mFirstName, "'", "\'")
			End Get
		#tag EndGetter
		sqlSafeFirstname As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return ReplaceAll(mLastName, "'", "\'")
			End Get
		#tag EndGetter
		sqlSafeLastname As string
	#tag EndComputedProperty


	#tag Constant, Name = kNamePLaceholder, Type = String, Dynamic = False, Default = \"No Name", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="directoryName"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="firstname"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="fullName"
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
			Name="lastname"
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
			Name="sqlSafeFirstname"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sqlSafeLastname"
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
		#tag ViewProperty
			Name="popupName"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
