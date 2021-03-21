#tag Class
Protected Class CalendarEvent
	#tag Method, Flags = &h0
		Shared Function amendParticipantCountInTitle(title as string, numberToChange as Integer) As string
		  dim leftParen as integer = instr(title, "(")
		  dim rightPAren as integer = instr(title, ")") 
		  
		  if leftParen = 0 then
		    Return title
		    
		  end if
		  
		  dim leftHalf as string = left(title, instr(title, "("))
		  dim rightHalf as string = right(title, len(title) - instr(title, ")") + 1)
		  
		  dim gSize as String = "0"
		  if rightPAren <> leftParen + 1 then
		    gSize = mid(title, leftParen + 1, rightPAren - leftParen - 1)
		    
		  end if
		  
		  dim groupSize as integer = CDbl(gSize)
		  groupSize = groupSize + numberToChange
		  
		  return leftHalf + str(groupSize) + rightHalf
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function compareTo(otherEvent as BookingToolkit.CalendarEvent) As BookingToolkit.Difference()
		  //This is not a comparison of all fields. It relates to the fields that are realavent to the user, not the programmer.
		  //    Likewise, it does not compare fields that are planned to become depricated because I am not in the business of 
		  //    creating more work for myself
		  
		  dim differences() as BookingToolkit.Difference
		  if self.calendarSerial <> otherEvent.calendarSerial then
		    differences.Append(new BookingToolkit.Difference("Event Type", self.calendarSerial.toText(), otherEvent.calendarSerial.toText()))
		    
		  end if
		  
		  if datetoworddate(self.creationDate) <> datetoworddate(otherEvent.creationDate) then
		    differences.Append(new BookingToolkit.Difference("Creation Date", datetoworddate(self.creationDate) + " -> " +_
		    datetoworddate(otherEvent.creationDate)))
		    
		  end if
		  
		  if self.creatorName <> otherEvent.creatorName then
		    differences.Append(new BookingToolkit.Difference("Creator", self.creatorName, otherEvent.creatorName))
		    
		  end if
		  
		  if datetoworddate(self.startDate) <> datetoworddate(otherEvent.startDate) then
		    differences.Append(new BookingToolkit.Difference("Start Date", datetoworddate(self.startDate) + " -> " +_
		    datetoworddate(otherEvent.startDate)))
		    
		  end if
		  
		  if datetoworddate(self.endDate) <> datetoworddate(otherEvent.endDate) then
		    differences.Append(new BookingToolkit.Difference("End date", datetoworddate(self.endDate) + " -> " + datetoworddate(otherEvent.endDate)))
		    
		  end if
		  
		  if self.isPrivate <> otherEvent.isPrivate then
		    differences.Append(new BookingToolkit.Difference("Private", convertBooleanToText(self.isPrivate) + " -> " + convertBooleanToText(otherEvent.isPrivate)))
		    
		  end if
		  
		  if self.notes <> otherEvent.notes then
		    differences.Append(new BookingToolkit.Difference("Event Notes", self.notes + " -> " + otherEvent.notes))
		    
		  end if
		  
		  if self.startTime.format_12Hour() <> otherEvent.startTime.format_12Hour() then
		    differences.Append(new BookingToolkit.Difference("Start Time", self.startTime.format_12Hour() + " -> " +_
		    otherEvent.startTime.format_12Hour()))
		    
		  end if
		  
		  if self.titleNotes <> otherEvent.titleNotes then
		    differences.Append(new BookingToolkit.Difference("Title notes", self.titleNotes + " -> " + otherEvent.titleNotes))
		    
		  end if
		  
		  if self.tripSpecificationSerial <> otherEvent.tripSpecificationSerial then
		    differences.Append(new BookingToolkit.Difference("Trip Type", self.tripSpecificationSerial.toText(), otherEvent.tripSpecificationSerial.toText()))
		    
		  end if
		  
		  if self.serial <> otherEvent.serial then
		    Differences.Append(new BookingToolkit.Difference("Serial", serial.toText(), otherEvent.serial.toText()))
		    
		  end if
		  
		  if self.status <> otherEvent.status then
		    Differences.Append(new BookingToolkit.Difference("Status", _
		    BookingToolkit.mapStatus(status), _
		    BookingToolkit.mapStatus(otherEvent.status)))
		    
		  end if
		  
		  return Differences
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(optional commitID as integer)
		  creationDate = Xojo.core.date.Now()
		  endDate = xojo.core.Date.Now()
		  serial = new SQLSerial()
		  startDate = Xojo.core.date.Now()
		  staffEmpSerial = new SQLSerial()
		  guideEmpSerial = new SQLSerial()
		  guideEventSerial = new SQLSerial()
		  startTime = new DateModule.Time(7,30)
		  self.calendarSerial= new SQLSerial()
		  self.tripSpecificationSerial= new SQLSerial()
		  self.commitID = commitID
		  status = BookingToolkit.Statuses.Active
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(json as Text)
		  //@throws: Xojo.data.InvalidJSONException
		  //@throws:Xojo.core.InvalidArgumentException
		  
		  dim generator as Xojo.Core.Dictionary = Xojo.Data.ParseJSON(json)
		  dim temp as string
		  
		  try
		    temp = generator.Value("calendarSerial")
		    creationDate = wordDatetoCoreDate(generator.Value("creationDate"))
		    creatorName = generator.Value("creator")
		    endDate = wordDatetoCoreDate(generator.Value("endDate"))
		    temp = generator.Value("serial")
		    serial = new SQLSerial(temp)
		    startDate = wordDatetoCoreDate(generator.Value("startDate"))
		    temp = generator.Value("status")
		    status = BookingToolkit.mapStatus(temp)
		    title = generator.Value("title")
		    temp = generator.Value("guideEmpSerial")
		    guideEmpSerial = new SQLSerial(temp)
		    notes = generator.value("notes")
		    temp = generator.Value("baseEventSerial")
		    temp = generator.Value("guideEventSerial")
		    guideEventSerial = new SQLSerial(temp)
		    isAcceptReservations = convertStringToBoolean(generator.Value("isAcceptReservations"))
		    temp = generator.value("staffEmpSerial")
		    staffEmpSerial = new SQLSerial(temp)
		    temp = generator.Value("rank")
		    rank = val(temp)
		    isPrivate = convertStringToBoolean(generator.Value("isPrivate"))
		    
		    temp = generator.Value("calendarSerial")
		    self.calendarSerial = new SQLSerial(temp)
		    
		    temp = generator.Value("baseEventSerial")
		    self.tripSpecificationSerial = new SQLSerial(temp)
		    
		    if generator.HasKey("starttime") then
		      try
		        temp = generator.Value("starttime")
		        startTime = new DateModule.Time(temp)
		        
		      Catch err as Xojo.Core.InvalidArgumentException
		        dim ee as new Xojo.Core.InvalidArgumentException
		        ee.Reason = err.Reason
		        
		        raise ee 
		        
		      end try
		      
		    end if
		    
		  catch err as KeyNotFoundException
		    dim ee as new Xojo.core.InvalidArgumentException()
		    ee.Reason = "Improperly formatted json object passed. Missing necessary value."
		    
		    raise ee
		    
		  catch err as Xojo.Data.InvalidJSONException
		    raise err
		    
		  end try
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCommitID() As integer
		  return commitID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function toJSON() As Text
		  using UtilityFunctions 
		  
		  dim generator as new Xojo.Core.Dictionary()
		  
		  generator.Value("calendarSerial") = self.calendarSerial.toText()
		  generator.Value("creationDate") = stringToText(datetoworddate(creationDate))
		  generator.Value("creator") = stringToText(creatorName)
		  generator.Value("endDate") = stringToText(datetoworddate(endDate))
		  generator.Value("serial") = stringToText(serial.toString())
		  generator.Value("startDate") = stringToText(datetoworddate(startDate))
		  generator.Value("status") = stringToText(BookingToolkit.mapStatus(status))
		  generator.Value("title") = stringToText(title)
		  generator.Value("baseEventSerial") = self.tripSpecificationSerial.toText()
		  generator.Value("notes") = stringToText(notes)
		  generator.Value("guideEmpSerial") = stringToText(guideEmpSerial.toString())
		  generator.Value("guideEventSerial") = stringToText(guideEventSerial.toString())
		  generator.Value("isAcceptReservations") = convertBooleanToInteger(isAcceptReservations).ToText()
		  generator.Value("staffEmpSerial") = stringToText(staffEmpSerial.toString())
		  generator.Value("rank") = rank.ToText()
		  generator.Value("isPrivate") = UtilityFunctions.convertBooleanToInteger(isPrivate).ToText()
		  if startTime <> Nil then
		    generator.Value("starttime") = stringToText(startTime.format_SQL)
		    
		  end if
		  
		  return Xojo.data.GenerateJSON(generator) 
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		calendarSerial As SQLSerial
	#tag EndProperty

	#tag Property, Flags = &h21
		Private commitID As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		creationDate As Xojo.Core.date
	#tag EndProperty

	#tag Property, Flags = &h0
		creatorName As string
	#tag EndProperty

	#tag Property, Flags = &h0
		endDate As xojo.Core.Date
	#tag EndProperty

	#tag Property, Flags = &h0
		guideEmpSerial As SQLSerial
	#tag EndProperty

	#tag Property, Flags = &h0
		guideEventSerial As SQLSerial
	#tag EndProperty

	#tag Property, Flags = &h0
		isAcceptReservations As boolean
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
		isPrivate As boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if self.startTime.hour >= 12 then
			    return BookingToolkit.Meridians.PM
			    
			  end if
			  
			  return BookingToolkit.Meridians.AM
			End Get
		#tag EndGetter
		meridian As BookingToolkit.Meridians
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		notes As string
	#tag EndProperty

	#tag Property, Flags = &h0
		rank As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		serial As SQLSerial
	#tag EndProperty

	#tag Property, Flags = &h0
		staffEmpSerial As SQLSerial
	#tag EndProperty

	#tag Property, Flags = &h0
		startDate As xojo.Core.Date
	#tag EndProperty

	#tag Property, Flags = &h0
		startTime As DateModule.Time
	#tag EndProperty

	#tag Property, Flags = &h0
		status As BookingToolkit.Statuses
	#tag EndProperty

	#tag Property, Flags = &h0
		title As string
	#tag EndProperty

	#tag Property, Flags = &h0
		titleNotes As string
	#tag EndProperty

	#tag Property, Flags = &h0
		tripSpecificationSerial As SQLSerial
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="creatorName"
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
			Name="isAcceptReservations"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isInDatabase"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isPrivate"
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
			Name="rank"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="title"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="titleNotes"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="meridian"
			Group="Behavior"
			Type="BookingToolkit.Meridians"
		#tag EndViewProperty
		#tag ViewProperty
			Name="status"
			Group="Behavior"
			Type="BookingToolkit.Statuses"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
