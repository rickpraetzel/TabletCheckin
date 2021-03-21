#tag Class
Protected Class Modification
	#tag Method, Flags = &h0
		Sub constructor(empSerial as SQLSerial, details as String)
		  self.empSerial = empSerial
		  self.dateOfChange = xojo.core.date.now()
		  self.modificationDetails = details
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(empSerial as SQLSerial, details as String, dd as Date)
		  self.empSerial = empSerial
		  self.dateOfChange = new xojo.core.date(dd.Year, dd.Month, dd.Day, 0, 0, 0, 0, xojo.core.TimeZone.Current)
		  self.modificationDetails = details
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getDateOfChange() As Xojo.Core.Date
		  return dateOfChange
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getDetails() As String
		  return self.modificationDetails
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getEmpSerial() As SQLSerial
		  return empSerial
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private dateOfChange As Xojo.Core.Date
	#tag EndProperty

	#tag Property, Flags = &h21
		Private empSerial As SQLSerial
	#tag EndProperty

	#tag Property, Flags = &h21
		Private modificationDetails As string
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
