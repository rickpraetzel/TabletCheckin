#tag Class
Protected Class GetCityStateFromZip
Implements Request
	#tag Method, Flags = &h0
		Sub constructor(zip as Integer)
		  self.zipcode = zip.ToText()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(zip as string)
		  self.zipcode = UtilityFunctions.stringToText(zip)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getAPIName() As Text
		  return kAPIName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getName() As Text
		  Return kRequestType
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getResponseParser() As USPS.Parser
		  return new USPS.CityAndStateResponse()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function toXML(generator as XmlDocument) As XmlNode
		  dim node as XmlNode = generator.CreateElement("ZipCode")
		  node.SetAttribute("ID","0")
		  dim child as XmlNode = node.AppendChild(generator.CreateElement("Zip5"))
		  child.AppendChild(generator.CreateTextNode(zipcode))
		  
		  return node
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		city As string
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private data As Xojo.Core.Dictionary
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		state As string
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private zipcode As Text
	#tag EndProperty


	#tag Constant, Name = kAPIName, Type = Text, Dynamic = False, Default = \"CityStateLookup", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kRequestType, Type = Text, Dynamic = False, Default = \"CityStateLookupRequest", Scope = Private
	#tag EndConstant


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
