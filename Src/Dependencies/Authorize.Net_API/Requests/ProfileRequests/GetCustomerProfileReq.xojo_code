#tag Class
Protected Class GetCustomerProfileReq
Inherits AbstractProfileRequest
	#tag Method, Flags = &h0
		Sub constructor(customerID as string)
		  Super.Constructor()
		  validationMode = ""
		  requestType = kTypeGetCustomerProfile
		  requestHeaderKey = kGetCustomerProfileHeader
		  requestBodyKey= "" 
		  aNetCustomerID = customerID
		  paymentProfileSerial = ""
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="sentinalToken"
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
