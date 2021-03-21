#tag Class
Private Class StartTimeBuilder
	#tag Method, Flags = &h0
		Function build() As CalendarToolkit.StartTime
		  return new CalendarToolkit.StartTime(self)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function startTime() As CalendarToolkit.StartTimeBuilder
		  return new CalendarToolkit.StartTimeBuilder()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function withEndMonth(mm as integer) As CalendarToolkit.StartTimeBuilder
		  endMonth = mm
		  return self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function withStartMonth(mm as integer) As CalendarToolkit.StartTimeBuilder
		  startMonth = mm
		  return self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function withTimeStrings(strings() as string) As CalendarToolkit.StartTimeBuilder
		  timeStrings = strings
		  return self 
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		endMonth As Integer = 12
	#tag EndProperty

	#tag Property, Flags = &h0
		startMonth As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h0
		timeStrings() As string
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
			Name="startMonth"
			Group="Behavior"
			InitialValue="1"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="endMonth"
			Group="Behavior"
			InitialValue="12"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
