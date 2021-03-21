#tag Class
Protected Class Authentication
	#tag Method, Flags = &h0
		Sub constructor(apiEndpoint as string, key as string)
		  self.apiEndpoint = apiEndpoint
		  self.key = key
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getEndpoint() As string
		  return apiEndpoint
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getKey() As string
		  return key
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private apiEndpoint As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private key As string
	#tag EndProperty


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
