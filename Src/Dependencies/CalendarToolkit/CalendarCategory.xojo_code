#tag Class
Protected Class CalendarCategory
	#tag Method, Flags = &h0
		Function checkIsInCategory(ser as SQLSerial) As boolean
		  return InStr(serials, ser.toString()) > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(name as string, serials as string)
		  self.name = name
		  self.serials = serials
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getName() As string
		  return name
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getSerials() As SQLSerial()
		  dim sers() as SQLSerial
		  for each ss as string in serials.Split("|")
		    sers.Append(new SQLSerial(ss))
		    
		  next
		  
		  return sers
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private name As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private serials As string
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
