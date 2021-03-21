#tag Class
Protected Class Resource
	#tag Method, Flags = &h0
		Sub constructor()
		  resourceSerial = new SQLSerial()
		  calendarEventSerial = new SQLSerial()
		  serial = new SQLSerial
		  resourceType = BookingToolkit.resourceTypes.Staff
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		calendarEventSerial As SQLSerial
	#tag EndProperty

	#tag Property, Flags = &h0
		resourceSerial As SQLSerial
	#tag EndProperty

	#tag Property, Flags = &h0
		resourceType As BookingToolkit.resourceTypes
	#tag EndProperty

	#tag Property, Flags = &h0
		serial As SQLSerial
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
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
			Name="resourceType"
			Group="Behavior"
			Type="BookingToolkit.resourceTypes"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
