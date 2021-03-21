#tag Class
Protected Class Controller
	#tag Method, Flags = &h0
		Sub constructor(sql as MySQLCommunityServer)
		  //@throws: CalendarToolkit.CalRuntimeException
		  
		  if sql.Connect() then
		    try
		      loadCalendars(sql)
		      loadTripSpecifications(sql)
		      loadCalendarCategories(sql)
		      loadStartTimes(sql)
		      loadShuttleDestinations(sql)
		      
		    catch err as CalendarToolkit.CalRuntimeException
		      raise err
		      
		    end try
		    
		  else
		    dim err as new CalendarToolkit.CalRuntimeException()
		    err.Reason = "Unable to connect to MySQL database: " + UtilityFunctions.StringToText(sql.ErrorMessage)
		    err.ErrorNumber = sql.ErrorCode
		    raise err
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function copyArray(values() as CalendarToolkit.TripSpecification) As CalendarToolkit.TripSpecification()
		  dim newArray() as CalendarToolkit.TripSpecification
		  
		  for each value as CalendarToolkit.TripSpecification in values()
		    newArray.Append(value)
		    
		  next
		  
		  return newArray
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function extractColor(dbString as string) As Color
		  dim rr,gg,bb as string
		  
		  rr = Left(dbString, 3)
		  gg = Mid(dbString, 4, 3)
		  bb = right(dbString, 3)
		  
		  return RGB(val(rr), val(gg), val(bb))
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCalendar(ser as SQLSerial) As CalendarToolkit.Calendar
		  //@throws: CalendarToolkit.NoSuchItemException
		  
		  using CalendarToolkit
		  
		  try
		    Return calendars.Value(ser.toInteger()) 
		    
		  catch ee as KeyNotFoundException
		    #Pragma BreakOnExceptions false
		    dim err as new NoSuchItemException()
		    err.Reason = "The passed calendar serial does not exist: " + ser.toText()
		    
		    raise err
		    #Pragma BreakOnExceptions true 
		    
		  end try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCalendars() As CalendarToolkit.Calendar()
		  dim cals() as CalendarToolkit.Calendar
		  dim cal as CalendarToolkit.Calendar
		  for each entry as Xojo.Core.DictionaryEntry in calendars
		    cal = entry.Value
		    if cal.isActive() then 
		      cals.Append(entry.Value)
		      
		    end if
		    
		  next
		  
		  cals.sort(AddressOf sortViewable)
		  
		  return cals
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCalendars(category as string) As CalendarToolkit.Calendar()
		  //@throws: CalendarToolkit.NoSuchItemException
		  
		  using CalendarToolkit
		  
		  if calendarCategories.HasKey(category) then
		    dim cals() as Calendar
		    dim cat as CalendarCategory = calendarCategories.Value(category)
		    for each serial as SQLSerial in cat.getSerials()
		      cals.Append(calendars.Value(serial.toInteger()))
		      
		    next
		    
		    cals.sort(AddressOf sortViewable)
		    
		    return cals
		    
		  end if
		  
		  #Pragma BreakOnExceptions false
		  dim err as new NoSuchItemException()
		  err.Reason = "The specified calendar category does not exist: " + stringToText(category)
		  
		  raise err
		  #Pragma BreakOnExceptions true 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCategory(name as string) As CalendarToolkit.CalendarCategory
		  //@throws: CalendarToolkit.NoSuchItemException
		  
		  if calendarCategories.HasKey(name) then 
		    return calendarCategories.Value(name)
		    
		  end if
		  
		  #pragma BreakOnExceptions false 
		  dim err as new CalendarToolkit.NoSuchItemException()
		  err.Reason = "No category matching: " + UtilityFunctions.stringToText(name)
		  
		  raise err 
		  #Pragma BreakOnExceptions true 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getDropOffLocations(tripSpec as SQLSerial) As string()
		  if not shuttleDesinations.HasKey(tripSpec.toInteger()) then
		    dim spots() as string
		    return spots()
		    
		  end if
		  
		  dim destinations as CalendarToolkit.ShuttleLocations =_
		  shuttleDesinations.Value(tripSpec.toInteger())
		  
		  return destinations.dropOffLocations
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPickupLocations(tripSpec as SQLSerial) As string()
		  if not shuttleDesinations.HasKey(tripSpec.toInteger()) then
		    dim spots() as string
		    return spots()
		    
		  end if
		  
		  dim destinations as CalendarToolkit.ShuttleLocations =_
		  shuttleDesinations.Value(tripSpec.toInteger())
		  
		  return destinations.pickupLocations
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getStartTimes(tripSer as SQLSerial, effectiveDate as Xojo.Core.Date) As DateModule.Time()
		  dim times() as DateModule.Time
		  if startTimes.HasKey(tripSer.toInteger()) then
		    dim sTimes() as CalendarToolkit.StartTime = startTimes.Value(tripSer.toInteger())
		    for each stime as CalendarToolkit.StartTime in sTimes
		      if stime.isAppropriateForDate(effectiveDate) then
		        return sTime.getTimes()
		        
		      end if
		      
		    next
		    
		    
		  end if
		  
		  return times
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getTripSpecification(serial as SQLSerial) As CalendarToolkit.TripSpecification
		  //@throws: CalendarToolkit.NoSuchItemException
		  
		  using CalendarToolkit
		  
		  for each spec as TripSpecification in tripSpecifications
		    if spec.getSerial = serial then 
		      Return spec
		      
		    end if
		    
		  next
		  
		  #Pragma BreakOnExceptions false
		  dim err as new NoSuchItemException()
		  err.Reason = "Serial " + serial.toText() + " does not correspond to any specification"
		  
		  raise err
		  #Pragma BreakOnExceptions true 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getTripSpecifications(calSerial as SQLSerial) As CalendarToolkit.TripSpecification()
		  using CalendarToolkit
		  dim specs() as TripSpecification
		  for each spec as TripSpecification in tripSpecifications
		    if spec.getCalendarSerial() = calSerial and spec.isActive() then
		      specs.Append(spec)
		      
		    end if
		    
		  next
		  
		  specs.sort(AddressOf sortViewable)
		  return specs
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub loadCalendarCategories(sql as MySQLCommunityServer)
		  //@throws: Xojo.io.IOException
		  
		  calendarCategories = new Xojo.Core.Dictionary()
		  
		  dim stmt as string =_
		  "SELECT * FROM calendarCategories"
		  dim rs as RecordSet = sql.SQLSelect(stmt)
		  if rs <> Nil then
		    while not rs.EOF
		      calendarCategories.Value(rs.Field("category").StringValue) =_
		      new CalendarToolkit.CalendarCategory(rs.field("category").StringValue, rs.Field("calendarSerials").StringValue)
		      rs.MoveNext()
		      
		    wend
		    
		  else
		    dim err as Xojo.IO.IOException
		    err.Reason = UtilityFunctions.stringToText("query: " + stmt + kReturnKey + "produced error: " + sql.ErrorMessage)
		    
		    raise err
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub loadCalendars(sql as MySQLCommunityServer)
		  //@throws: Xojo.io.IOException
		  
		  using CalendarToolkit
		  using UtilityFunctions
		  
		  calendars = new Xojo.Core.Dictionary()
		  dim stmt as String =_
		  "SELECT * FROM calendars"
		  dim rs as RecordSet = sql.SQLSelect(stmt)
		  if rs <> Nil then 
		    dim cal as Calendar
		    while not rs.EOF
		      cal = CalendarBuilder.calendar()._
		      withParticipantCountMode(rs.field("participantCountMode").StringValue)._
		      isActive(rs.field("isActive").BooleanValue)._
		      autoContructsTitles(rs.field("buildeTitleFromEventDetails").BooleanValue)._
		      isAcceptsReservations(rs.field("acceptsres").BooleanValue)._
		      isBreadthIncentive(rs.field("isCountedAsBreadth").BooleanValue)._
		      withFillColor(extractColor(rs.field("color").StringValue))._
		      withName(DefineEncoding(rs.field("name").StringValue, Encodings.UTF8))._
		      withSerial(new SQLSerial(rs.Field("serial").IntegerValue))._
		      withViewOrder(rs.Field("viewOrder").IntegerValue)._
		      usesRank(convertIntToBoolean(rs.field("useRank").IntegerValue))._
		      getsLocationAudit(rs.Field("getsLocationAudit").BooleanValue)._
		      build()
		      
		      calendars.Value(cal.getSerial().toInteger()) = cal
		      rs.MoveNext()
		      
		    wend
		    
		  else
		    dim err as Xojo.IO.IOException
		    err.Reason = UtilityFunctions.stringToText("query: " + stmt + kReturnKey + "produced error: " + sql.ErrorMessage)
		    
		    raise err
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub loadShuttleDestinations(sql as MySQLCommunityServer)
		  shuttleDesinations = new Xojo.Core.Dictionary()
		  
		  dim stmt as string =_
		  "SELECT * FROM shuttleDestinations"
		  dim rs as RecordSet = sql.SQLSelect(stmt)
		  while not rs.EOF
		    dim loc as new CalendarToolkit.ShuttleLocations()
		    loc.pickupLocations = rs.Field("pickupLocations").StringValue.Split("|")
		    loc.dropOffLocations = rs.Field("dropOffLocations").StringValue.Split("|")
		    
		    shuttleDesinations.Value(rs.Field("specificationSerial").IntegerValue) = loc
		    rs.MoveNext()
		    
		  wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub loadStartTimes(sql as MySQLCommunityServer)
		  //@throws: Xojo.io.IOException
		  
		  using CalendarToolkit
		  
		  startTimes = new Xojo.Core.Dictionary()
		  dim stmt as String = "SELECT * FROM calendarTripStartTimes"
		  dim rs as RecordSet = sql.SQLSelect(stmt)
		  if rs = NIl then
		    dim err as Xojo.IO.IOException
		    err.Reason = UtilityFunctions.stringToText("query: " + stmt + kReturnKey + "produced error: " + sql.ErrorMessage)
		    
		    raise err
		    
		  end if 
		  
		  while not rs.EOF
		    dim times() as CalendarToolkit.StartTime
		    dim sTime as StartTime =_
		    StartTimeBuilder.startTime()._
		    withStartMonth(rs.Field("startMonth").IntegerValue)._
		    withEndMonth(rs.field("endMonth").IntegerValue)._
		    withTimeStrings(Split(rs.Field("startTimes").StringValue, kDelimiter))._
		    build()
		    
		    times = startTimes.Lookup(rs.field("tripSerial").IntegerValue, times)
		    times.Append(sTime)
		    startTimes.Value(rs.field("tripSerial").IntegerValue) = times
		    
		    rs.MoveNext()
		    
		  wend
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub loadTripSpecifications(sql as MySQLCommunityServer)
		  //@throws: Xojo.io.IOException
		  
		  using CalendarToolkit
		  
		  Redim tripSpecifications(-1)
		  dim stmt as string =_
		  "SELECT * FROM calendarTripSpecifications ORDER BY calendarSerial,title"
		  dim rs as RecordSet = sql.SQLSelect(stmt)
		  if rs <> Nil then
		    while not rs.EOF
		      tripSpecifications.Append(SpecificationBuilder.Specification()._
		      withDuration(new DateModule.Time(rs.field("duration").StringValue))._
		      isToBeDisplayed(rs.Field("isDisplayableInWGW").BooleanValue)._
		      isIncentivePay(rs.field("isEligibleForIncentives").BooleanValue)._
		      withShortName(rs.field("shortname").StringValue)._
		      withDefaultGearMonths(rs.field("defaultGearStartMonth").IntegerValue, rs.field("defaultGearEndMonth").IntegerValue)._
		      asMultiday(rs.Field("allowMultiday").BooleanValue)._
		      isActive(rs.field("isActive").BooleanValue)._
		      withDefualtParticipantCount(rs.field("defaultGroupSize").IntegerValue)._
		      withViewWeight(rs.field("viewWeight").IntegerValue)._
		      withCombinedSerialsString(rs.field("combinedTripSerials").StringValue)._
		      withPayCategory(mapPayCategory(rs.Field("payCategory").StringValue))._
		      withSerial(new SQLSerial(rs.Field("serial").IntegerValue))._
		      withCalSerial(new SQLSerial(rs.Field("calendarSerial").IntegerValue))._
		      withClusterSize(rs.Field("clusterSize").IntegerValue)._
		      withEventLength(mapEventLength(rs.Field("eventLength").StringValue))._
		      withTitle(DefineEncoding(rs.field("title").StringValue, Encodings.UTF8))._
		      usesClusters(convertIntToBoolean(rs.field("alertForClusters").IntegerValue))._
		      needsDefaultGear(convertIntToBoolean(rs.field("needsDefaultGear").IntegerValue))._
		      withClusterSerialString(rs.field("clusterSerials").StringValue)._
		      build())
		      
		      rs.MoveNext()
		      
		    wend
		    
		  else
		    dim err as Xojo.IO.IOException
		    err.Reason = UtilityFunctions.stringToText("query: " + stmt + kReturnKey + "produced error: " + sql.ErrorMessage)
		    
		    raise err
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function sortViewable(v1 as CalendarToolkit.ViewOrderable, v2 as CalendarToolkit.ViewOrderable) As integer
		  if v1.getViewOrder() > v2.getViewOrder() then
		    return 1
		    
		  end if
		  
		  if v1.getViewOrder() < v2.getViewOrder() then
		    return -1
		    
		  end if
		  
		  return 0
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private calendarCategories As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private calendars As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private shuttleDesinations As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private startTimes As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private tripSpecifications() As CalendarToolkit.TripSpecification
	#tag EndProperty


	#tag Constant, Name = kDelimiter, Type = String, Dynamic = False, Default = \"|", Scope = Private
	#tag EndConstant


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
End Class
#tag EndClass
