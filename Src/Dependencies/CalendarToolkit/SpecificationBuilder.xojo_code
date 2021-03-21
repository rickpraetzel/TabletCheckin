#tag Class
Private Class SpecificationBuilder
	#tag Method, Flags = &h0
		Function asMultiday(value as Boolean) As CalendarToolkit.SpecificationBuilder
		  self.mIsMultiday = value
		  return self 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function build() As CalendarToolkit.TripSpecification
		  return new CalendarToolkit.TripSpecification(self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub constructor()
		  calendarSerial = new SQLSerial()
		  eventLength = CalendarToolkit.EventLengths.NONE
		  serial = new SQLSerial()
		  payCategory = CalendarToolkit.PayCategories.NONE
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isActive(value as boolean) As CalendarToolkit.SpecificationBuilder
		  mIsActive = value
		  return self 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isIncentivePay(value as boolean) As CalendarToolkit.SpecificationBuilder
		  self.isEligibleForIncentives = value
		  
		  return self 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isToBeDisplayed(value as boolean) As CalendarToolkit.SpecificationBuilder
		  self.isDisplayableInWGW = value
		  return self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function needsDefaultGear(value as boolean) As CalendarToolkit.SpecificationBuilder
		  self.needsDefaultGear = value
		  return self 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Specification() As CalendarToolkit.SpecificationBuilder
		  return new CalendarToolkit.SpecificationBuilder()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function usesClusters(value as boolean) As CalendarToolkit.SpecificationBuilder
		  self.usesClusters = value
		  return self 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function withCalSerial(serial as SQLSerial) As CalendarToolkit.SpecificationBuilder
		  calendarSerial = serial
		  return self 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function withClusterSerialString(serialString as string) As CalendarToolkit.SpecificationBuilder
		  self.clusterSerials = serialString
		  return self 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function withClusterSize(clusterSize as Integer) As CalendarToolkit.SpecificationBuilder
		  self.clusterSize = clusterSize
		  return self 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function withCombinedSerialsString(sers as string) As CalendarToolkit.SpecificationBuilder
		  combinedSerials = sers
		  return self 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function withDefaultGearMonths(startMonth as integer, endMonth as integer) As CalendarToolkit.SpecificationBuilder
		  self.gearStartMonth = startMonth
		  self.gearEndMonth = endMonth
		  
		  return self 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function withDefualtParticipantCount(partCount as integer) As CalendarToolkit.SpecificationBuilder
		  self.defaultGroupSize = partCount
		  return self 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function withDuration(duration as DateModule.Time) As CalendarToolkit.SpecificationBuilder
		  self.duration = duration
		  return self 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function withEventLength(length as CalendarToolkit.EventLengths) As CalendarToolkit.SpecificationBuilder
		  eventLength = length 
		  return self 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function withPayCategory(category as CalendarToolkit.PayCategories) As CalendarToolkit.SpecificationBuilder
		  payCategory = category
		  return self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function withSerial(serial as SQLSerial) As CalendarToolkit.SpecificationBuilder
		  self.serial = serial
		  return self 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function withShortName(shortName as string) As CalendarToolkit.SpecificationBuilder
		  self.shortName = shortName
		  return self 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function withTitle(title as string) As CalendarToolkit.SpecificationBuilder
		  self.title = title
		  return self 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function withViewWeight(viewWeight as Integer) As CalendarToolkit.SpecificationBuilder
		  self.viewWeight = viewWeight
		  return self 
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		calendarSerial As SQLSerial
	#tag EndProperty

	#tag Property, Flags = &h0
		clusterSerials As string
	#tag EndProperty

	#tag Property, Flags = &h0
		clusterSize As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		combinedSerials As string
	#tag EndProperty

	#tag Property, Flags = &h0
		defaultGroupSize As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		duration As DateModule.Time
	#tag EndProperty

	#tag Property, Flags = &h0
		eventLength As CalendarToolkit.EventLengths
	#tag EndProperty

	#tag Property, Flags = &h0
		gearEndMonth As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		gearStartMonth As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		isDisplayableInWGW As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		isEligibleForIncentives As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		mIsActive As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		mIsMultiday As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		needsDefaultGear As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		payCategory As CalendarToolkit.PayCategories
	#tag EndProperty

	#tag Property, Flags = &h0
		serial As SQLSerial
	#tag EndProperty

	#tag Property, Flags = &h0
		shortName As string
	#tag EndProperty

	#tag Property, Flags = &h0
		title As string
	#tag EndProperty

	#tag Property, Flags = &h0
		usesClusters As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		viewWeight As Integer
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
		#tag ViewProperty
			Name="clusterSize"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="needsDefaultGear"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="title"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="usesClusters"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="defaultGroupSize"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="combinedSerials"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="viewWeight"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="mIsActive"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="mIsMultiday"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="clusterSerials"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="gearEndMonth"
			Group="Behavior"
			Type="integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="gearStartMonth"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isDisplayableInWGW"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isEligibleForIncentives"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="shortName"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="eventLength"
			Group="Behavior"
			Type="CalendarToolkit.EventLengths"
		#tag EndViewProperty
		#tag ViewProperty
			Name="payCategory"
			Group="Behavior"
			Type="CalendarToolkit.PayCategories"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
