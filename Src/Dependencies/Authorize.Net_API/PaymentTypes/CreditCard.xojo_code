#tag Class
Protected Class CreditCard
Inherits PaymentSource
	#tag Method, Flags = &h0
		Sub constructor()
		  Super.Constructor()
		  mTokenName = ""
		  ccNumber = ""
		  expirationDate = ""
		  cvvCode = ""
		  track2Data = ""
		  validationMode = ""
		  billingInfo = new BillingProfile()
		  mCardType = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(builder as CreditCardBuilder)
		  super.constructor()
		  mTokenName = kPayWithCCToken
		  ccNumber = builder.ccNumber
		  expirationDate = builder.expirationDate
		  cvvCode = builder.cvvCode
		  track2Data = builder.track2Data
		  validationMode = builder.validationMode
		  billingInfo = builder.billingInfo()
		  mCardType = builder.cardType
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getBillingInfo() As BillingProfile
		  //@Override
		  
		  if billingInfo <> Nil then
		    return billingInfo
		    
		  end if
		  
		  return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getJson() As JSONItem
		  dim jsonBody as new JSONItem()
		  dim jsonToken as new JSONItem()
		  
		  if track2Data <> "" then 
		    jsonBody.Value("track2") = track2Data
		    jsonToken.Value(kPayUsingTrackData) = jsonBody
		    
		  else 
		    jsonBody.Value("cardNumber") = self.ccNumber
		    jsonBody.Value("expirationDate") = self.expirationDate
		    if self.cvvCode <> "" then 
		      jsonBody.Value("cardCode") = self.cvvCode
		      
		    end if
		    
		    jsonToken.Value(self.kPayType) = jsonBody
		    
		  end if
		  
		  return jsonToken
		  
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private billingInfo As BillingProfile
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mCardType
			End Get
		#tag EndGetter
		CardType As string
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private ccNumber As string = "creditCard"
	#tag EndProperty

	#tag Property, Flags = &h21
		Private cvvCode As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private expirationDate As string
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if track2Data <> "" then
			    return true
			    
			  end if
			  
			  return false
			End Get
		#tag EndGetter
		isUsingTrack2 As boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if len(ccNumber) >= 4 then
			    return right(ccNumber, 4)
			    
			  end if
			  
			  return ""
			End Get
		#tag EndGetter
		lastFour As string
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCardType As string = "creditCard"
	#tag EndProperty

	#tag Property, Flags = &h21
		Private track2Data As string
	#tag EndProperty


	#tag Constant, Name = kPayType, Type = String, Dynamic = False, Default = \"creditCard", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kPayUsingTrackData, Type = String, Dynamic = False, Default = \"trackData", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kPayWithCCToken, Type = String, Dynamic = False, Default = \"payment", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="JSONTokenName"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CardType"
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
			Name="isUsingTrack2"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="lastFour"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
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
