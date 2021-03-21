#tag Class
Protected Class ClusterDetails
	#tag Method, Flags = &h0
		Sub constructor(title as string, startTime as datemodule.time, groupSize as integer)
		  self.groupSize = groupSize
		  self.title = UtilityFunctions.stringToText(title)
		  self.startTime = startTime
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getSize() As integer
		  return groupSize
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getTime() As string
		  return startTime.format_12Hour
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getTitle() As text
		  return title
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private groupSize As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private startTime As DateModule.Time
	#tag EndProperty

	#tag Property, Flags = &h21
		Private title As text
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
