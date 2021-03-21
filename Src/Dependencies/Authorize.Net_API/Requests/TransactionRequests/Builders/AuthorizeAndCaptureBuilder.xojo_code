#tag Class
Protected Class AuthorizeAndCaptureBuilder
	#tag Method, Flags = &h0
		Function build() As AuthorizeAndCaptureReq
		  return new AuthorizeAndCaptureReq(self) 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(amount as double, paymentInfo as PaymentSource)
		  self.amountToCharge = str(amount)
		  self.paymentInfo = paymentInfo
		  isSavingProfile = false 
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function setInvoiceNumber(invoiceSerial as String) As AuthorizeAndCaptureBuilder
		  self.invoiceSerial = invoiceSerial
		  return self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function setSaveProfile() As AuthorizeAndCaptureBuilder
		  isSavingProfile = true
		  return self
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		amountToCharge As string
	#tag EndProperty

	#tag Property, Flags = &h0
		invoiceSerial As string
	#tag EndProperty

	#tag Property, Flags = &h0
		isSavingProfile As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		paymentInfo As PaymentSource
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="amountToCharge"
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
			Name="invoiceSerial"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isSavingProfile"
			Group="Behavior"
			Type="boolean"
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
