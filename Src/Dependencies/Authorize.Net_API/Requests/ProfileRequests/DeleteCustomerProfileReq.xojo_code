#tag Class
Protected Class DeleteCustomerProfileReq
Inherits AbstractProfileRequest
	#tag Method, Flags = &h0
		Sub constructor(customerID as string)
		  //@param customerID: ANet customer serial
		  
		  Super.Constructor()
		  requestType = kTypeDeleteCustomerProfile
		  requestHeaderKey = kDeleteCustomerRequestHeader
		  requestBodyKey= ""
		  aNetCustomerID = customerID
		  validationMode = ""
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
