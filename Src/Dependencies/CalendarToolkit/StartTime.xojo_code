#tag Class
Private Class StartTime
	#tag Method, Flags = &h0
		Sub constructor(builder as CalendarToolkit.StartTimeBuilder)
		  self.startMonth = builder.startMonth
		  self.endMonth = builder.endMonth
		  self.timeStrings = builder.timeStrings
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getTimes() As DateModule.Time()
		  dim times() as DateModule.Time
		  for each ss as string in timeStrings
		    try
		      times.Append(new DateModule.Time(ss))
		      
		    catch err as DateModule.InvalidArgumentException
		      //TODO: log internal 
		      
		    end try
		    
		  next
		  
		  return times 
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isAppropriateForDate(dd as Xojo.Core.Date) As boolean
		  return dd.Month >= startMonth and dd.Month <= endMonth
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private endMonth As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private startMonth As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private timeStrings() As string
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
	#tag EndViewBehavior
End Class
#tag EndClass
