#tag Class
Protected Class Employee
	#tag Method, Flags = &h0
		Sub constructor()
		  height = new HumanHeight()
		  name = new DisplayName()
		  phone = new PhoneNumber()
		  serial = new SQLSerial()
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		email1 As string
	#tag EndProperty

	#tag Property, Flags = &h0
		email2 As string
	#tag EndProperty

	#tag Property, Flags = &h0
		forceReset As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		height As HumanHeight
	#tag EndProperty

	#tag Property, Flags = &h0
		isActive As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		login As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		name As BookingToolkit.DisplayName
	#tag EndProperty

	#tag Property, Flags = &h0
		passwordHash As string
	#tag EndProperty

	#tag Property, Flags = &h0
		phone As PhoneNumber
	#tag EndProperty

	#tag Property, Flags = &h0
		serial As SQLSerial
	#tag EndProperty

	#tag Property, Flags = &h0
		username As string
	#tag EndProperty

	#tag Property, Flags = &h0
		weight As integer
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
			Name="weight"
			Group="Behavior"
			Type="integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="email1"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="passwordHash"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="forceReset"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="email2"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="username"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isActive"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="login"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
