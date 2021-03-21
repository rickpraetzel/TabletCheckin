#tag Class
Protected Class TripSpecification
Implements ViewOrderable
	#tag Method, Flags = &h0
		Sub constructor()
		  self.calendarSerial = new SQLSerial()
		  self.clusterSize = 0
		  self.eventLength = CalendarToolkit.EventLengths.NONE
		  self.needsDefaultGear = false
		  self.serial = new SQLSerial()
		  self.title = ""
		  self.usesClusters = false
		  self.payCategory = CalendarToolkit.PayCategories.NONE
		  self.viewWeight = 0
		  self.defaultGroupSize = 0
		  self.combinedSerials = ""
		  self.mIsActive = false
		  self.mIsMultiday = false 
		  self.duration = new DateModule.Time
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(builder as CalendarToolkit.SpecificationBuilder)
		  self.calendarSerial = builder.calendarSerial
		  self.clusterSize = builder.clusterSize
		  self.eventLength = builder.eventLength
		  self.needsDefaultGear = builder.needsDefaultGear
		  self.serial = builder.serial
		  self.title = builder.title
		  self.usesClusters = builder.usesClusters
		  self.payCategory = builder.payCategory
		  self.viewWeight = builder.viewWeight
		  self.defaultGroupSize = builder.defaultGroupSize
		  self.combinedSerials = builder.combinedSerials
		  self.mIsActive = builder.mIsActive
		  self.mIsMultiday = builder.mIsMultiday
		  self.clusterSerials = builder.clusterSerials
		  self.isEligibleForIncentives = builder.isEligibleForIncentives
		  self.gearStartMonth = builder.gearStartMonth
		  self.gearEndMonth = builder.gearEndMonth
		  self.isDisplayableInWGW = builder.isDisplayableInWGW
		  self.shortName = builder.shortName
		  self.duration = builder.duration
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCalendarSerial() As SQLSerial
		  return calendarSerial.clone()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getClusterSerials() As SQLSerial()
		  return clusterSerials.toSQLSerialArray("|")
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getClusterSize() As integer
		  return clusterSize
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCombinedSerials() As string
		  Return combinedSerials
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getdefaultGroupSize() As integer
		  return defaultGroupSize
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getDuration() As DateModule.Time
		  return duration
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getEventLenth() As CalendarToolkit.EventLengths
		  return eventLength
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPayCategory() As CalendarToolkit.PayCategories
		  return payCategory
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getSerial() As SQLSerial
		  return serial.clone()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getShortName() As string
		  return shortName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getTitle() As string
		  return title
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getViewOrder() As integer
		  return viewWeight
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isActive() As boolean
		  return mIsActive
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isEligibleForIncentivePay() As boolean
		  return isEligibleForIncentives
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isInDefaultGearTimePeriod(dd as Xojo.Core.Date) As boolean
		  if needsDefaultGear and dd <> Nil then
		    return dd.Month >= gearStartMonth or dd.Month <= gearEndMonth
		    
		  end if
		  
		  return false
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isMultiday() As boolean
		  return mIsMultiday
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isNeedsDefaultGear() As boolean
		  return needsDefaultGear
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isToBeDisplayed() As boolean
		  return isDisplayableInWGW
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isUsingClusters() As boolean
		  return usesClusters
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private calendarSerial As SQLSerial
	#tag EndProperty

	#tag Property, Flags = &h21
		Private clusterSerials As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private clusterSize As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private combinedSerials As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private defaultGroupSize As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private duration As DateModule.Time
	#tag EndProperty

	#tag Property, Flags = &h21
		Private eventLength As CalendarToolkit.EventLengths
	#tag EndProperty

	#tag Property, Flags = &h21
		Private gearEndMonth As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private gearStartMonth As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private isDisplayableInWGW As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private isEligibleForIncentives As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsActive As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsMultiday As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private needsDefaultGear As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private payCategory As CalendarToolkit.PayCategories
	#tag EndProperty

	#tag Property, Flags = &h21
		Private serial As SQLSerial
	#tag EndProperty

	#tag Property, Flags = &h21
		Private shortName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private title As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private usesClusters As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private viewWeight As Integer
	#tag EndProperty


	#tag ViewBehavior
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
