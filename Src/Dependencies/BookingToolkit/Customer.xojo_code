#tag Class
Protected Class Customer
	#tag Method, Flags = &h0
		Function compareTo(otherCustomer as BookingToolkit.Customer) As BookingToolkit.Difference()
		  dim differences() as BookingToolkit.Difference
		  
		  if name.firstname <> otherCustomer.Name.firstname then
		    differences.Append(new BookingToolkit.Difference("Firstname", name.firstname, otherCustomer.Name.firstname))
		    
		  end if
		  
		  if Name.lastName <> otherCustomer.Name.lastName then
		    differences.Append(new BookingToolkit.Difference("lastName", Name.lastName, otherCustomer.Name.lastName))
		    
		  end if
		  
		  if phoneNumber.getUnformattedNumber() <> otherCustomer.phoneNumber.getUnformattedNumber() then
		    differences.Append(new BookingToolkit.Difference("Phone number", phoneNumber.getFormattedNumber(), otherCustomer.phoneNumber.getFormattedNumber()))
		    
		  end if
		  
		  if email <> otherCustomer.email then
		    differences.Append(new BookingToolkit.Difference("Email address", email, otherCustomer.email))
		    
		  end if
		  
		  if street <> otherCustomer.street then
		    differences.Append(new BookingToolkit.Difference("Address", street, otherCustomer.street))
		    
		  end if
		  
		  if zip <> otherCustomer.zip then
		    differences.Append(new BookingToolkit.Difference("Zip code", zip, otherCustomer.zip))
		    
		  end if
		  
		  if ANetPaymentProfileID <> otherCustomer.ANetPaymentProfileID or aNetProfileID <> otherCustomer.aNetProfileID then
		    differences.Append(new BookingToolkit.Difference("ANet information", "These customers have different authorize.net payment information"))
		    
		  end if
		  
		  return differences
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(optional commitID as integer)
		  phoneNumber = new BookingToolkit.PhoneNumber()
		  name = new BookingToolkit.DisplayName()
		  serial = new SQLSerial()
		  self.commitID = commitID
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCommitID() As integer
		  return commitID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(rightSide as BookingToolkit.Customer) As integer
		  if rightSide is Nil then
		    return 1
		    
		  end if
		  
		  if rightSide.serial = self.serial then
		    return 0
		    
		  end if
		  
		  if rightSide.Name.fullName = self.Name.fullName and rightSide.phoneNumber.getUnformattedNumber() = self.phoneNumber.getUnformattedNumber() then
		    return 0
		    
		  end if
		  
		  return -1
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		ANetPaymentProfileID As string
	#tag EndProperty

	#tag Property, Flags = &h0
		aNetProfileID As string
	#tag EndProperty

	#tag Property, Flags = &h0
		checked As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		city As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private commitID As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		company As string
	#tag EndProperty

	#tag Property, Flags = &h0
		contactdiary As string
	#tag EndProperty

	#tag Property, Flags = &h0
		country As string
	#tag EndProperty

	#tag Property, Flags = &h0
		disctype As string
	#tag EndProperty

	#tag Property, Flags = &h0
		email As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if ANetPaymentPRofileID <> "" then
			    return true
			    
			  end if
			  
			  return false
			End Get
		#tag EndGetter
		hasStorePaymentProfile As boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		iscompany As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		isEmailVerified As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		isemp As boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return serial.isInDatabase
			End Get
		#tag EndGetter
		isInDatabase As boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Name As BookingToolkit.DisplayName
	#tag EndProperty

	#tag Property, Flags = &h0
		phoneNumber As BookingToolkit.PhoneNumber
	#tag EndProperty

	#tag Property, Flags = &h0
		serial As SQLSerial
	#tag EndProperty

	#tag Property, Flags = &h0
		state As string
	#tag EndProperty

	#tag Property, Flags = &h0
		street As string
	#tag EndProperty

	#tag Property, Flags = &h0
		tobeinvoiced As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		zip As string
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="ANetPaymentProfileID"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="aNetProfileID"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="checked"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="city"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="company"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="contactdiary"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="country"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="disctype"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="email"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="hasStorePaymentProfile"
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
			Name="iscompany"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isemp"
			Group="Behavior"
			InitialValue="0"
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
			Name="state"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="street"
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
			Name="tobeinvoiced"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="zip"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isInDatabase"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isEmailVerified"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
