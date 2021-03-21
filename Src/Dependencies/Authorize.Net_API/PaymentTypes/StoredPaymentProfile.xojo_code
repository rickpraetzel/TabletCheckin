#tag Class
Protected Class StoredPaymentProfile
Inherits PaymentSource
	#tag Method, Flags = &h0
		Sub constructor(builder as StoredPaymentProfileBuilder)
		  super.constructor()
		  mTokenName = kPayWithProfileToken
		  customerProfile = builder.customerSerial
		  mPaymentProfileID = builder.paymentProfileSerial
		  validationMode = builder.validationMode
		  mCardOnFile = builder.cardOnFile
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getbillingInfo() As BillingProfile
		  //@Override
		  
		  if mCardOnFile <> Nil then
		    return mCardOnFile.getBillingInfo()
		    
		  end if
		  
		  return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getJson() As JSONItem
		  dim jsonBody as new JSONItem
		  dim containerJSON as new JSONItem
		  
		  jsonBody.Value("customerProfileId") = customerProfile
		  containerJSON.Value("paymentProfileId") = mPaymentProfileID
		  jsonBody.Value("paymentProfile") = containerJSON
		  
		  return jsonBody
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if mCardOnFile <> Nil then
			    return mCardOnFile
			    
			  end if
			  
			  return new CreditCard()
			End Get
		#tag EndGetter
		cardOnFile As CreditCard
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private customerProfile As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCardOnFile As CreditCard
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPaymentProfileID As string
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mPaymentProfileID
			End Get
		#tag EndGetter
		paymentProfileID As string
	#tag EndComputedProperty


	#tag Constant, Name = kPayWithProfileToken, Type = String, Dynamic = False, Default = \"profile", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="JSONTokenName"
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
			Name="paymentProfileID"
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
