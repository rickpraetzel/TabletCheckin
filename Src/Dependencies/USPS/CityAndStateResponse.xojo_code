#tag Class
Protected Class CityAndStateResponse
Implements Parser
	#tag Method, Flags = &h0
		Sub constructor()
		  data = new Xojo.Core.Dictionary()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub parse(xml as XmlDocument)
		  //@throws: USPS.ParseException
		  
		  try
		    data.Value("city") = xml.FirstChild.FirstChild.FirstChild.NextSibling.FirstChild.Value
		    data.Value("state") = xml.FirstChild.FirstChild.FirstChild.NextSibling.NextSibling.FirstChild.Value
		    
		  catch ee as NilObjectException
		    dim err as new USPS.ParseException()
		    err.Reason = "Passed XML does not meet predefined structure"
		    
		    raise err 
		    
		  end try
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return data.Lookup("city", "")
			End Get
		#tag EndGetter
		city As string
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private data As Xojo.Core.Dictionary
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return data.Lookup("state", "")
			End Get
		#tag EndGetter
		state As string
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="city"
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
			Name="state"
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
	#tag EndViewBehavior
End Class
#tag EndClass
