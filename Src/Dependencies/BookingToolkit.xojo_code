#tag Module
Protected Module BookingToolkit
	#tag Method, Flags = &h0
		Function mapCreationMethod(value as BookingToolkit.CreationMethods) As text
		  Select case value
		  case BookingToolkit.CreationMethods.InPerson
		    return "InPerson"
		    
		  case BookingToolkit.CreationMethods.Phone
		    return "Phone"
		    
		  case BookingToolkit.CreationMethods.Online
		    return "Online"
		    
		  else
		    return ""
		    
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function mapCreationMethod(value as String) As BookingToolkit.CreationMethods
		  Select case value
		  case "InPerson"
		    return BookingToolkit.CreationMethods.InPerson
		    
		  case "Phone"
		    return BookingToolkit.CreationMethods.Phone
		    
		  case "Online"
		    return BookingToolkit.CreationMethods.Online
		    
		  else
		    return BookingToolkit.CreationMethods.None
		    
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function mapMeridian(ss as BookingToolkit.Meridians) As Text
		  Select case ss
		  case BookingToolkit.Meridians.AM
		    return "AM"
		    
		  case BookingToolkit.Meridians.PM
		    return "PM"
		    
		  else
		    Return ""
		    
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function mapMeridian(ss as string) As BookingToolkit.Meridians
		  //@throws: Xojo.core.InvalidArgumentException
		  
		  Select case ss
		  case "AM"
		    return BookingToolkit.Meridians.AM
		    
		  case "PM"
		    return BookingToolkit.Meridians.PM
		    
		  case ""
		    return BookingToolkit.Meridians.NONE
		    
		  else
		    dim err as new Xojo.Core.InvalidArgumentException()
		    err.Reason = "Unknown meridian passed"
		    
		    raise err
		    
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function mapResourceType(value as BookingToolkit.resourceTypes) As Text
		  select case value
		  case BookingToolkit.resourceTypes.Staff
		    return "STAFF"
		    
		  else
		    return "VEHICLE"
		    
		  end select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function mapresourceType(value as string) As BookingToolkit.resourceTypes
		  select case value
		  case "STAFF"
		    return BookingToolkit.resourceTypes.Staff
		    
		  else
		    return BookingToolkit.resourceTypes.Vehicle
		    
		  end select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function mapStatus(ss as BookingToolkit.Statuses) As Text
		  Select case ss
		  case BookingToolkit.Statuses.Active
		    Return "ACTIVE"
		    
		  case BookingToolkit.Statuses.Deleted
		    return "DELETED"
		    
		  case BookingToolkit.Statuses.Cancelled
		    return "CANCELLED"
		    
		  case BookingToolkit.Statuses.Pending
		    return "PENDING"
		    
		  else
		    return ""
		    
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function mapStatus(ss as String) As BookingToolkit.Statuses
		  //@throws: Xojo.core.InvalidArgumentException
		  
		  Select case ss
		  case "ACTIVE"
		    return BookingToolkit.Statuses.Active
		    
		  case "CANCELLED"
		    return BookingToolkit.Statuses.Cancelled
		    
		  case "DELETED"
		    return BookingToolkit.Statuses.Deleted
		    
		  case "PENDING"
		    Return BookingToolkit.Statuses.Pending
		    
		  else
		    dim err as new Xojo.Core.InvalidArgumentException()
		    err.Reason = "Unknown mode passed: " + UtilityFunctions.stringToText(ss)
		    
		    raise err
		    
		  End Select
		End Function
	#tag EndMethod


	#tag Note, Name = README
		- All of the CRUD methods for calendarevents, reservations, customers, resgearitems, and
		    resparts are a part of the BookingToolkit.Controller class. This allows for use in Xojo web
		    apps because each session can have its own Controller object.
		
		- The idea with this module was to minimize side effects 
		    - That said, all normalizing of data will be handled at the database level
		
		- Dates on resgear items re not accessed nor modified using this module in an effort to further 
		    normalize the database
		
		- This modules does rely on several triggers being present in tha database, so behavior can differ
		    between schemas that do and do not have those triggers loaded
		    - Updating commit ID for OCC
		    - Auto timestamping return date
		    - Auto generating informed consent timestamps
		    - Auto generating creating and update timestamps
		
		- CalendarEvents and Reservations
		    - Creation date, creator, and current status are stored within the objects themselves
		    - All changes to dates and statuses are contained within the change log
		    - Use an objects status as the sole flag for what state it is in
		    - Calendar events can be linked to the calendar module to know what kind of event they represent
		    - Creation date/time are never updated through this module making them read only values
		
	#tag EndNote

	#tag Note, Name = Version
		9.0.0
		
	#tag EndNote


	#tag Constant, Name = kAllCalEventFields, Type = String, Dynamic = False, Default = \"title\x2Cstartdate\x2Cenddate\x2Cstatus\x2CcreatorName\x2CcreationTimeStamp\x2CguideEmpSerial\x2CguideSerial\x2Cacceptsres\x2Cnotes\x2Crank\x2Cstaffempserial\x2CisPrivate\x2CtitleNotes\x2Cserial\x2CcalendarSerial\x2CbaseEventSerial\x2CmeetingParts\x2Cstarttime\x2CmoverDate\x2Cvehicle\x2CcommitID", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kAllCustomerFieldsUsed, Type = String, Dynamic = False, Default = \"profileID\x2CpaymentProfileID\x2Ccity\x2Ccompany\x2CcontactDiary\x2Ccountry\x2Cfirstname\x2Clastname\x2CdiscType\x2Cemail\x2Cemailoptout\x2CisCompany\x2CisEmp\x2Clists\x2Cphone\x2Cserial\x2Cshipcity\x2Cshipzip\x2Cstate\x2Cstreet\x2Ctobeinvoiced\x2Ctype\x2Czip\x2CcommitID\x2CisEmailValidated", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kAllResFieldsUsed, Type = String, Dynamic = False, Default = \"approvingGuide\x2Cbalance\x2CcalEventSerial\x2Cconsenttypedname\x2Ccreator\x2CcreatorSerial\x2CcustomerSerial\x2CendDate\x2CeventType\x2CgearRes_ID\x2Creservations.groupsize\x2CguideApprovedCanyons\x2ChasDayAfterGear\x2Chotel\x2ChowTheyHeard\x2Cgear_returned\x2Cpaid\x2CreservationDepositRedeemed\x2Ctaxable\x2Creservations.notes\x2Cremittance\x2Creservations.SERIAL\x2Cstartdate\x2CSTATUS\x2Ctotal\x2Creservations.contactDiary\x2Cinformedwhattobring\x2Cinformedcancellationpolicy\x2Cinformedtimezone\x2Cinformedpickuplocation\x2Creservations.commitID\x2CcreationTimeStamp\x2CcreationMethod", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kAllResGearItemFields, Type = String, Dynamic = False, Default = \"id\x2Csize\x2CgearType\x2Cqty\x2CresSerial\x2Crespartserial\x2Cserial\x2CneedsGearID\x2CgearTypeSerial\x2CdisplayInCalEvent", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kAllResPartFields, Type = String, Dynamic = False, Default = \"serial\x2CresSerial\x2Cage\x2Cheight\x2Cname\x2ClastName\x2Cgender\x2Cweight", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kRetiredFlag, Type = String, Dynamic = False, Default = \"rip", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kRetiredFlag1, Type = String, Dynamic = False, Default = \"rip", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kStatus_Retired, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kStatus_Retired1, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant


	#tag Enum, Name = CreationMethods, Type = Integer, Flags = &h0
		InPerson
		  Phone
		  Online
		None
	#tag EndEnum

	#tag Enum, Name = Meridians, Type = Integer, Flags = &h0
		AM
		  PM
		NONE
	#tag EndEnum

	#tag Enum, Name = resourceTypes, Flags = &h0
		Staff
		Vehicle
	#tag EndEnum

	#tag Enum, Name = Statuses, Type = Integer, Flags = &h0
		Cancelled
		  Deleted
		  Pending
		Active
	#tag EndEnum

	#tag Enum, Name = UpdateBehavior, Flags = &h0
		ENFORCE_DATA_CHECK
		SKIP_DATA_CHECK
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
