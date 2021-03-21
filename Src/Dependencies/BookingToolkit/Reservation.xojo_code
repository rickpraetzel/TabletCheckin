#tag Class
Protected Class Reservation
	#tag Method, Flags = &h0
		Function compareTo(otherRes as BookingToolkit.Reservation) As BookingToolkit.Difference()
		  //This is not a comparison of all fields. It relates to the fields that are realavent to the user, not the programmer.
		  //    Likewise, it does not compare fields that are planned to become depricated because I am not in the business of 
		  //    creating more work for myself
		  
		  dim diffs() as BookingToolkit.Difference
		  
		  if self.approvingGuide <> otherRes.approvingGuide then
		    diffs.Append(new BookingToolkit.Difference("Approving Guide", approvingGuide, otherRes.approvingGuide))
		    
		  end if
		  
		  if self.balance <> otherRes.balance then
		    diffs.Append(new BookingToolkit.Difference("Balance Due", self.balance.ToText(), otherRes.balance.ToText()))
		    
		  end if
		  
		  if self.calendarEventSerial <> otherRes.calendarEventSerial then
		    diffs.Append(new BookingToolkit.Difference("Calendar Event Serial", self.calendarEventSerial.toString(), otherRes.calendarEventSerial.toString()))
		    
		  end if
		  
		  if self.consentTypedName <> otherRes.consentTypedName then
		    diffs.Append(new BookingToolkit.Difference("Informed Consent", self.consentTypedName, otherRes.consentTypedName))
		    
		  end if
		  
		  if self.contactDiary <> otherRes.contactDiary then
		    diffs.Append(new BookingToolkit.Difference("Contact Diary", self.contactDiary, otherRes.contactDiary))
		    
		  end if
		  
		  if self.creatorName <> otherRes.creatorName then
		    diffs.Append(new BookingToolkit.Difference("Creator", self.creatorName, otherRes.creatorName))
		    
		  end if
		  
		  if self.customerSerial <> otherRes.customerSerial then 
		    diffs.Append(new BookingToolkit.Difference("Customer serial", customerSerial.toText(), otherRes.customerSerial.toText()))
		    
		  end if
		  
		  if self.startDate.compareTo(otherRes.startDate) <> 0 then
		    diffs.Append(new BookingToolkit.Difference("Start Date", self.startDate, otherRes.startDate))
		    
		  end if
		  
		  if self.endDate.compareTo(otherRes.endDate) <> 0 then
		    diffs.Append(new BookingToolkit.Difference("End Date", endDate, otherRes.endDate))
		    
		  end if
		  
		  if self.groupSize <> otherRes.groupSize then
		    diffs.Append(new BookingToolkit.Difference("Group Size", self.groupSize.ToText(), otherRes.groupSize.ToText()))
		    
		  end if
		  
		  if self.guideApprovedCanyons <> otherRes.guideApprovedCanyons then
		    diffs.Append(new BookingToolkit.Difference("Guide Approved Canyons", "There have been modifications made to the canyons to the guide approved canyons"))
		    
		  end if
		  
		  if self.hasDayAfterGear <> otherRes.hasDayAfterGear then
		    diffs.Append(new BookingToolkit.Difference("Day After Gear", "The day after gear between these two reservations is different"))
		    
		  end if
		  
		  if self.hotel <> otherRes.hotel then
		    diffs.Append(new BookingToolkit.Difference("Hotel", self.hotel, otherRes.hotel))
		    
		  end if
		  
		  
		  if self.howTheyHeard <> otherRes.howTheyHeard then
		    diffs.Append(new BookingToolkit.Difference("How They Heard", self.howTheyHeard, otherRes.howTheyHeard))
		    
		  end if
		  
		  if self.creationDate.compareTo(otherRes.creationDate) <> 0 then
		    diffs.Append(new BookingToolkit.Difference("Initiated On Date", creationDate, otherRes.creationDate))
		    
		  end if
		  
		  if self.isInformedOfCancellationPolicy <> otherRes.isInformedOfCancellationPolicy then
		    diffs.Append(new BookingToolkit.Difference("Informed About Cancellation Policy", convertBooleanToText(self.isInformedOfCancellationPolicy), convertBooleanToText(otherRes.isInformedOfCancellationPolicy)))
		    
		  end if
		  
		  if self.isInformedOfCancellationPolicy <> otherRes.isInformedPickupLocation then
		    diffs.Append(new BookingToolkit.Difference("Informed About Pickup Location", convertBooleanToText(self.isInformedOfCancellationPolicy), convertBooleanToText(otherRes.isInformedOfCancellationPolicy)))
		    
		  end if
		  
		  if self.isInformedOfCancellationPolicy <> otherRes.isInformedTimeZone then
		    diffs.Append(new BookingToolkit.Difference("Informed About Time Zone", convertBooleanToText(self.isInformedTimeZone), convertBooleanToText(otherRes.isInformedTimeZone)))
		    
		  end if
		  
		  if self.isInformedOfCancellationPolicy <> otherRes.isInformedWhatToBring then
		    diffs.Append(new BookingToolkit.Difference("Informed About What To Bring", convertBooleanToText(self.isInformedWhatToBring), convertBooleanToText(otherRes.isInformedWhatToBring)))
		    
		  end if
		  
		  if self.notes <> otherRes.notes then
		    diffs.Append(new BookingToolkit.Difference("Reservation Notes", self.notes, otherRes.notes))
		    
		  end if
		  
		  if self.remittance <> otherRes.remittance then
		    diffs.Append(new BookingToolkit.Difference("Remittance", self.remittance.ToText(), otherRes.remittance.ToText()))
		    
		  end if
		  
		  if self.serial <> otherRes.serial then
		    diffs.Append(new BookingToolkit.Difference("Reservation Serial", self.serial.toText(), otherRes.serial.toText()))
		    
		  end if
		  
		  if self.status <> otherRes.status then
		    diffs.Append(new BookingToolkit.Difference("Status",_
		    BookingToolkit.mapStatus(status),_
		    BookingToolkit.mapStatus(otherRes.status)))
		    
		  end if
		  
		  if creationMethod <> otherRes.creationMethod then
		    diffs.Append(new BookingToolkit.Difference("Creation method",_
		    BookingToolkit.mapCreationMethod(creationMethod),_
		    BookingToolkit.mapCreationMethod(otherRes.creationMethod)))
		    
		  end if
		  
		  return diffs
		  
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(optional commitID as integer, optional firstName as string, optional lastname as string)
		  serial = new SQLSerial()
		  calendarEventSerial = new SQLSerial()
		  customerSerial = new SQLSerial()
		  status = BookingToolkit.Statuses.Active
		  isTaxable = true
		  self.commitID = commitID
		  creationDate = xojo.core.date.Now()
		  creationMethod = BookingToolkit.CreationMethods.None
		  startDate = xojo.core.date.Now()
		  endDate = xojo.core.date.Now()
		  mName = new BookingToolkit.DisplayName(firstName, lastname)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCommitID() As integer
		  return self.commitID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCustomerName() As BookingToolkit.DisplayName
		  return mName
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		approvingGuide As string
	#tag EndProperty

	#tag Property, Flags = &h0
		balance As double
	#tag EndProperty

	#tag Property, Flags = &h0
		calendarEventSerial As SQLSerial
	#tag EndProperty

	#tag Property, Flags = &h21
		Private commitID As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		consentTypedName As string
	#tag EndProperty

	#tag Property, Flags = &h0
		contactDiary As Text
	#tag EndProperty

	#tag Property, Flags = &h0
		creationDate As xojo.core.date
	#tag EndProperty

	#tag Property, Flags = &h0
		creationMethod As BookingToolkit.CreationMethods
	#tag EndProperty

	#tag Property, Flags = &h0
		creatorName As string
	#tag EndProperty

	#tag Property, Flags = &h0
		creatorSerial As string
	#tag EndProperty

	#tag Property, Flags = &h0
		customerSerial As SQLSerial
	#tag EndProperty

	#tag Property, Flags = &h0
		endDate As Xojo.Core.Date
	#tag EndProperty

	#tag Property, Flags = &h0
		gaveInformedConsent As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		gearResID As string
	#tag EndProperty

	#tag Property, Flags = &h0
		groupSize As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		guideApprovedCanyons As string
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return customerSerial.isInDatabase
			End Get
		#tag EndGetter
		hasCustomer As boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		hasDayAfterGear As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		hotel As string
	#tag EndProperty

	#tag Property, Flags = &h0
		howTheyHeard As string
	#tag EndProperty

	#tag Property, Flags = &h0
		isGearReturned As boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Note
			return serial.isInDatabase
		#tag EndNote
		#tag Getter
			Get
			  return serial.isInDatabase
			End Get
		#tag EndGetter
		isInDatabase As boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		isInformedOfCancellationPolicy As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		isInformedPickupLocation As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		isInformedTimeZone As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		isInformedWhatToBring As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		isPaid As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		isReservationDepositRedeemed As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		isTaxable As boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return calendarEventSerial.isInDatabase
			End Get
		#tag EndGetter
		isViewableOnCalendar As boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mName As BookingToolkit.DisplayName
	#tag EndProperty

	#tag Property, Flags = &h0
		notes As string
	#tag EndProperty

	#tag Property, Flags = &h0
		remittance As double
	#tag EndProperty

	#tag Property, Flags = &h0
		serial As SQLSerial
	#tag EndProperty

	#tag Property, Flags = &h0
		startDate As Xojo.Core.Date
	#tag EndProperty

	#tag Property, Flags = &h0
		status As BookingToolkit.Statuses
	#tag EndProperty

	#tag Property, Flags = &h0
		total As double
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="approvingGuide"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="balance"
			Group="Behavior"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="consentTypedName"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="contactDiary"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="creatorName"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="creatorSerial"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="gaveInformedConsent"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="gearResID"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="groupSize"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="guideApprovedCanyons"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="hasCustomer"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="hasDayAfterGear"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="hotel"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="howTheyHeard"
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
			Name="isGearReturned"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isInDatabase"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isPaid"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isReservationDepositRedeemed"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isTaxable"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isViewableOnCalendar"
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
			Name="notes"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="remittance"
			Group="Behavior"
			Type="double"
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
		#tag ViewProperty
			Name="total"
			Group="Behavior"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isInformedOfCancellationPolicy"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isInformedPickupLocation"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isInformedTimeZone"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isInformedWhatToBring"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="creationMethod"
			Group="Behavior"
			Type="BookingToolkit.CreationMethods"
		#tag EndViewProperty
		#tag ViewProperty
			Name="status"
			Group="Behavior"
			Type="BookingToolkit.Statuses"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
