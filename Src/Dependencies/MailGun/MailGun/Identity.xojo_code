#tag Class
Protected Class Identity
	#tag Method, Flags = &h0
		Sub constructor(name as string, emailAddress as string)
		  self.name = name
		  self.emailAddress = emailAddress
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getFormattedAddress() As string
		  return name + "<" + emailAddress + ">"
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private emailAddress As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private name As string
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="name"
			Group="Behavior"
			Type="String"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
