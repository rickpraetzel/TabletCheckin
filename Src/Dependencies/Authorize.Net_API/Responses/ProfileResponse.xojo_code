#tag Class
Protected Class ProfileResponse
Inherits AbstractResponse
	#tag Method, Flags = &h21
		Private Function buildPaymentProfile(data as xojo.Core.Dictionary) As StoredPaymentProfile
		  dim builder as new StoredPaymentProfileBuilder()
		  call Builder.setPaymentProfileSerial(data.Lookup("customerPaymentProfileId", ""))
		  if data.HasKey("payment") then
		    call builder.setCardOnFile(extractCardOnFile(data))
		    
		  end if
		  
		  return builder.build()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(anetData as xojo.Core.Dictionary)
		  super.constructor(anetData)
		  if anetData.HasKey("paymentProfile") then
		    paymentProfiles.Append(buildPaymentProfile(anetData.value("paymentProfile")))
		    
		  elseif anetData.HasKey("profile") then
		    storeAllPaymentProfiles(anetData.Value("profile"))
		    
		  elseif anetData.HasKey("customerPaymentProfileId") then
		    paymentProfiles.Append(buildPaymentProfile(anetData))
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function extractBillingInfo(data as xojo.Core.Dictionary) As BillingProfile
		  dim custName as new Name(data.Lookup("firstName", ""), data.Lookup("lastName", ""))
		  dim builder as new BillingProfileBuilder(custName)
		  return builder._
		  setAddress(data.lookup("address", ""))._
		  setCity(data.lookup("city", ""))._
		  setCompany(data.lookup("company", ""))._
		  setCountry(data.lookup("country", ""))._
		  setPhoneNumber(data.lookup("phoneNumber", ""))._
		  setState(data.lookup("state", ""))._
		  setZipCode(data.lookup("zip", ""))._
		  build()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function extractCardOnFile(data as xojo.Core.Dictionary) As CreditCard
		  dim billing as BillingProfile
		  if data.HasKey("billTo") then
		    billing = extractBillingInfo(data.value("billTo"))
		    
		  end if
		  
		  dim temp as xojo.Core.Dictionary = data.value("payment")
		  if temp.HasKey("creditCard") then 
		    dim cardDetails as xojo.Core.Dictionary = temp.value("creditCard")
		    dim builder as new CreditCardBuilder()
		    if billing <> Nil then
		      call builder.setBillingInfo(billing)
		      
		    end if
		    
		    return builder._
		    setCCNumber(cardDetails.Lookup("cardNumber", ""))._
		    setExpirationDate(cardDetails.Lookup("expirationDate", ""))._
		    setCardType(cardDetails.Lookup("cardType", ""))._
		    build()
		    
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPaymentIDs() As string()
		  dim ids() as string
		  if data.HasKey("customerPaymentProfileIdList") then 
		    dim values() as auto = self.data.Value("customerPaymentProfileIdList")
		    
		    for each item as auto in values 
		      ids.Append(item)
		      
		    next
		    
		  end if
		  
		  return ids
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub storeAllPaymentProfiles(data as xojo.Core.Dictionary)
		  Using Xojo.Core
		  
		  const kProfilesKey = "paymentProfiles"
		  if data.HasKey(kProfilesKey) then
		    dim profiles() as Auto = data.Value(kProfilesKey)
		    for ii as integer = 0 to UBound(profiles)
		      paymentProfiles.Append(buildPaymentProfile(profiles(ii)))
		      
		    next
		    
		  end if
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return new Name(data.Lookup("firstName", ""), data.Lookup("lastName", "")) //XXX: Will this return the right name?
			End Get
		#tag EndGetter
		customerName As Name
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return self.data.Lookup("customerProfileId", "")
			End Get
		#tag EndGetter
		customerProfileID As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if UBound(paymentProfiles) <> -1 then
			    return true
			    
			  end if
			  
			  return false
			End Get
		#tag EndGetter
		hasPaymentProfiles As boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		paymentProfiles() As StoredPaymentProfile
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="errorMessage"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="lastErrorCode"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="statusMessage"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="customerProfileID"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="hasPaymentProfiles"
			Group="Behavior"
			Type="boolean"
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
