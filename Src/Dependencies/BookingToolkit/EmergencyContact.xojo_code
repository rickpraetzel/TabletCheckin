#tag Class
Protected Class EmergencyContact
	#tag Method, Flags = &h0
		Sub constructor()
		  contactNumber = new BookingToolkit.PhoneNumber()
		  name = new BookingToolkit.DisplayName()
		  serial = new SQLSerial
		  customerSerial = new SQLSerial()
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		contactNumber As BookingToolkit.PhoneNumber
	#tag EndProperty

	#tag Property, Flags = &h0
		customerSerial As SQLSerial
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return serial.isInDatabase
			End Get
		#tag EndGetter
		isInDatabase As boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		name As BookingToolkit.DisplayName
	#tag EndProperty

	#tag Property, Flags = &h0
		relation As string
	#tag EndProperty

	#tag Property, Flags = &h0
		serial As SQLSerial
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
			Name="name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="relation"
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
			Name="isInDatabase"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
