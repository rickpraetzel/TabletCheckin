#tag Class
Protected Class CustomerProfileBuilder
	#tag Method, Flags = &h0
		Function build() As CustomerProfile
		  return new CustomerProfile(self) 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(fullname as Name, merchantSerial as string)
		  customerName = fullname
		  self.merchantSerial = merchantSerial
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function setBillingInfo(billingInfo as BillingProfile) As CustomerProfileBuilder
		  self.billingInfo = billingInfo
		  return self 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function setEmail(email as String) As CustomerProfileBuilder
		  self.email = email
		  return self 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function setPhoneNumber(phoneNumber as String) As CustomerProfileBuilder
		  self.phoneNumber = phoneNumber
		  Return self
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		billingInfo As BillingProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private customerName As Name
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if phoneNumber <> "" then
			    return customerName.fullName + "|" + phoneNumber
			    
			  else
			    return customerName.fullName
			    
			  end if
			End Get
		#tag EndGetter
		description As string
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		email As string
	#tag EndProperty

	#tag Property, Flags = &h0
		merchantSerial As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private phoneNumber As string
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="description"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="email"
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
			Name="merchantSerial"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
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
