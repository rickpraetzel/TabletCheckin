#tag Module
Protected Module CalendarToolkit
	#tag Method, Flags = &h0
		Function mapCountMode(mode as CalendarToolkit.CountModes) As Text
		  select case mode
		  case CalendarToolkit.CountModes.SUM
		    Return "SUM"
		    
		  case CalendarToolkit.CountModes.SEPARATE
		    return "SEPARATE"
		    
		  else
		    return ""
		    
		  end select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function mapCountMode(mode as string) As CalendarToolkit.CountModes
		  select case mode
		  case "SUM"
		    Return CalendarToolkit.CountModes.SUM
		    
		  case "SEPARATE"
		    return CalendarToolkit.CountModes.SEPARATE
		    
		  else
		    return CalendarToolkit.CountModes.NONE
		    
		  end select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function mapEventLength(ll as CalendarToolkit.EventLengths) As string
		  select case ll
		  case CalendarToolkit.EventLengths.HALFDAY
		    return "Half Day"
		    
		  case CalendarToolkit.EventLengths.FULLDAY
		    return "Full Day"
		    
		  else
		    return ""
		    
		  end select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function mapEventLength(ll as string) As CalendarToolkit.EventLengths
		  //@throws: Xojo.core.InvalidArgumentException
		  
		  select case ll
		  case "Half Day"
		    return CalendarToolkit.EventLengths.HALFDAY
		    
		  case "Full Day"
		    return CalendarToolkit.EventLengths.FULLDAY
		    
		  case ""
		    return CalendarToolkit.EventLengths.NONE
		    
		  else
		    dim err as new Xojo.Core.InvalidArgumentException()
		    err.Reason = "Unknown meridian passed"
		    
		    raise err
		    
		  end select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function mapPayCategory(value as CalendarToolkit.PayCategories) As String
		  using CalendarToolkit
		  
		  select case value
		  case PayCategories.BASE
		    return "BASE"
		    
		  case PayCategories.ADVANCED
		    return "ADV"
		    
		  case PayCategories.NONE
		    Return ""
		    
		  end select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function mapPayCategory(value as String) As CalendarToolkit.PayCategories
		  using CalendarToolkit
		  
		  select case value
		  case "BASE"
		    return PayCategories.BASE
		    
		  case "ADV"
		    return PayCategories.ADVANCED
		    
		  case ""
		    Return PayCategories.NONE
		    
		  end select
		End Function
	#tag EndMethod


	#tag Note, Name = Version
		3.2.0
		
	#tag EndNote


	#tag Enum, Name = CountModes, Type = Integer, Flags = &h0
		NONE
		  SUM
		SEPARATE
	#tag EndEnum

	#tag Enum, Name = EventLengths, Flags = &h0
		HALFDAY
		  FULLDAY
		NONE
	#tag EndEnum

	#tag Enum, Name = PayCategories, Type = Integer, Flags = &h0
		BASE
		  ADVANCED
		NONE
	#tag EndEnum


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
	#tag EndViewBehavior
End Module
#tag EndModule
