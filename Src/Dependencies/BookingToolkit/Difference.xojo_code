#tag Class
Protected Class Difference
	#tag Method, Flags = &h0
		Sub constructor(propertyName as string, differenceValue as string)
		  self.propertyName = UtilityFunctions.stringToText(propertyName)
		  self.differenceValue = UtilityFunctions.stringToText(differenceValue)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(propertyName as string, value1 as string, value2 as string)
		  self.propertyName = UtilityFunctions.stringToText(propertyName)
		  self.differenceValue = UtilityFunctions.stringToText(value1 + " -> " + value2)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(propertyName as string, value1 as Xojo.Core.Date, value2 as xojo.core.date)
		  self.propertyName = UtilityFunctions.stringToText(propertyName)
		  self.differenceValue = UtilityFunctions.stringToText(_
		  value1.ToText(xojo.core.Locale.Current, xojo.core.Date.FormatStyles.Medium, xojo.core.date.FormatStyles.None) + " -> " +_
		  value2.ToText(xojo.core.Locale.Current, xojo.core.Date.FormatStyles.Medium, xojo.core.date.FormatStyles.None))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getExplanation() As Text
		  return differenceValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPropertyName() As Text
		  return propertyName
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private differenceValue As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private propertyName As Text
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
