#tag Class
Protected Class Controller
	#tag Method, Flags = &h0
		Sub addEmergencyContact(contact as BookingToolkit.EmergencyContact)
		  dim stmt as string =_
		  "INSERT INTO emergencyContacts(customerSerial, firstname, lastname, contactPhone, relation) VALUES(?,?,?,?,?)"
		  dim ps as MySQLPreparedStatement = mSqlServer.Prepare(stmt)
		  ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		  ps.Bind(0, contact.customerSerial.toString())
		  ps.BindType(1, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		  ps.Bind(1, contact.name.sqlSafeFirstname)
		  ps.BindType(2, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		  ps.Bind(2, contact.name.sqlSafeLastname)
		  ps.BindType(3, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		  ps.Bind(3, contact.contactNumber.getUnformattedNumber()) 
		  ps.BindType(4, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		  ps.Bind(4, contact.relation)
		  
		  ps.SQLExecute()
		  if mSqlServer.Error then
		    #Pragma BreakOnExceptions false
		    dim err as new BookingToolkit.Exceptions.EmergencyContactException()
		    err.Reason = UtilityFunctions.stringToText(mSqlServer.ErrorMessage)
		    err.ErrorNumber = mSqlServer.ErrorCode
		    
		    raise err
		    #pragma BreakOnExceptions true
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub amendAssociatedEvents(dets as BookingToolkit.CalendarEvent)
		  //@throws: Xojo.io.IOException
		  
		  dim cmd as string =_
		  "UPDATE calendarevents,employees SET title = CONCAT(employees.popupname, ' - ', '" + dets.title + "'), startdate = " + datetoworddate(dets.startDate) + ", enddate = " + datetoworddate(dets.endDate) +_
		  " WHERE primaryEventSerial = " + dets.serial.toString() + " AND employees.serial = staffEmpSerial"
		  mSqlServer.SQLExecute(cmd)
		  
		  if mSqlServer.Error then 
		    dim err as new Xojo.IO.IOException()
		    err.Reason = "Unable to update events associated with: " + dets.serial.toText() + ", using: " + stringToText(cmd)
		    
		    raise err
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function buildCalEventFromFullRecordSet(rs as RecordSet) As BookingToolkit.CalendarEvent
		  dim cc as new BookingToolkit.CalendarEvent(rs.field("commitID").IntegerValue)
		  
		  cc.title = UtilityFunctions.stringToText(rs.field("title").StringValue)
		  cc.startDate = wordDatetoCoreDate(rs.field("startDate").StringValue)
		  cc.endDate = wordDatetoCoreDate(rs.field("endDate").StringValue)
		  cc.status = BookingToolkit.mapStatus(rs.field("status").StringValue)
		  cc.creatorName = rs.field("creatorName").StringValue
		  
		  'dim values() as string = rs.Field("creatordate").StringValue.Split("|")
		  'if UBound(values) = 1 then
		  'cc.creator = values(0)
		  'cc.creationDate = wordDatetoCoreDate(values(1))
		  '
		  'else
		  'cc.creationDate = xojo.core.date.Now() //XXX: This is creating bad data...
		  '
		  'end if
		  
		  dim temp as string = rs.field("creationTimeStamp").StringValue
		  
		  cc.creationDate =_
		  xojo.core.Date.FromText(UtilityFunctions.stringToText(rs.field("creationTimeStamp").StringValue))
		  cc.guideEmpSerial = new SQLSerial(rs.field("guideEmpSerial").IntegerValue)
		  cc.guideEventSerial = new SQLSerial(rs.field("guideSerial").IntegerValue)
		  cc.isAcceptReservations = convertIntToBoolean(rs.field("acceptsres").IntegerValue)
		  cc.notes = stringToText(rs.field("notes").StringValue)
		  cc.rank = rs.field("rank").IntegerValue
		  cc.staffEmpSerial = new SQLSerial(rs.field("staffEmpSerial").IntegerValue)
		  cc.isPrivate = convertIntToBoolean(rs.Field("isPrivate").IntegerValue)
		  cc.titleNotes = UtilityFunctions.stringToText(rs.Field("titleNotes").StringValue)
		  cc.serial = new SQLSerial(rs.field("serial").IntegerValue)
		  cc.calendarSerial = new SQLSerial(rs.field("calendarSerial").StringValue)
		  cc.tripSpecificationSerial = new SQLSerial(rs.field("baseEventSerial").IntegerValue)
		  
		  if rs.Field("starttime").StringValue <> "" and rs.Field("starttime").StringValue <> "00:00:00" then
		    try
		      cc.startTime = new DateModule.Time(rs.Field("starttime").StringValue)
		      
		    catch err as Xojo.Core.InvalidArgumentException
		      self.reportError(158750, err, " Unable to build starttime for cal event with ser: " + cc.serial.toString())
		      
		    end try
		    
		  else
		    cc.startTime = nil
		    
		  end if
		  
		  return cc
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function buildCustomerFromRecordset(customerRecordSet as RecordSet) As BookingToolkit.Customer
		  dim customer as new BookingToolkit.Customer(customerRecordSet.Field("commitID").IntegerValue)
		  
		  if customerRecordSet <> NIl and not (customerRecordSet.EOF and customerRecordSet.BOF) then
		    customer.aNetProfileID = DefineEncoding(customerRecordSet.field("profileID").StringValue, Encodings.UTF8)
		    customer.ANetPaymentPRofileID = DefineEncoding(customerRecordSet.field("paymentProfileID").StringValue, Encodings.UTF8)
		    customer.city = DefineEncoding(customerRecordSet.Field("city").StringValue, Encodings.UTF8)
		    customer.company = DefineEncoding(customerRecordSet.Field("company").StringValue, Encodings.UTF8)
		    customer.contactdiary = DefineEncoding(customerRecordSet.Field("contactdiary").StringValue, Encodings.UTF8)
		    customer.country = DefineEncoding(customerRecordSet.field("country").StringValue, Encodings.UTF8)
		    customer.name = new BookingToolkit.DisplayName(customerRecordSet.field("firstname").StringValue, customerRecordSet.field("lastname").StringValue)
		    customer.disctype = DefineEncoding(customerRecordSet.field("disctype").StringValue, Encodings.UTF8)
		    customer.email = DefineEncoding(customerRecordSet.Field("email").StringValue, Encodings.UTF8)
		    customer.iscompany = convertIntToBoolean(customerRecordSet.Field("iscompany").IntegerValue)
		    customer.isemp = convertIntToBoolean(customerRecordSet.Field("isemp").IntegerValue)
		    customer.phoneNumber = new BookingToolkit.PhoneNumber(customerRecordSet.Field("phone").StringValue) 
		    customer.serial = new SQLSerial(customerRecordSet.Field("serial").IntegerValue)
		    customer.state = DefineEncoding(customerRecordSet.Field("state").StringValue, Encodings.UTF8)
		    customer.street = DefineEncoding(customerRecordSet.field("street").StringValue, Encodings.UTF8)
		    customer.tobeinvoiced = convertIntToBoolean(customerRecordSet.field("tobeinvoiced").IntegerValue)
		    customer.zip = DefineEncoding(customerRecordSet.Field("zip").StringValue, Encodings.UTF8)
		    customer.isEmailVerified = convertIntToBoolean(customerRecordSet.Field("isEmailValidated").IntegerValue)
		    
		  end if
		  
		  return customer
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function buildRandomAddressQuery(randomSerials() as string) As string
		  dim stmt as string = "SELECT streetAddress FROM fakeAddresses WHERE serial = "
		  if UBound(randomSerials) > -1 then 
		    stmt = stmt + randomSerials(0)
		    randomSerials.Remove(0)
		    for each serial as string in randomSerials
		      stmt = stmt + " OR serial = " + serial
		      
		    next
		    
		  end if
		  
		  return stmt
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function buildReservationFromFullReservationRecordSet(rs as RecordSet) As BookingToolkit.Reservation
		  dim res as new BookingToolkit.Reservation(rs.Field("commitID").IntegerValue, rs.Field("firstname").StringValue, rs.Field("lastname").StringValue)
		  
		  res.approvingGuide = rs.Field("approvingGuide").StringValue
		  res.balance = rs.Field("balance").DoubleValue
		  res.calendarEventSerial = new SQLSerial(rs.field("caleventSerial").IntegerValue)
		  res.consentTypedName = rs.field("consenttypedname").StringValue
		  res.creatorName = rs.field("creator").StringValue
		  res.creatorSerial = rs.field("creatorSerial").StringValue
		  res.customerSerial = new SQLSerial(rs.Field("customerSerial").IntegerValue)
		  res.endDate = wordDatetoCoreDate(str(rs.field("enddate").IntegerValue))
		  res.gearResID = rs.field("gearres_ID").StringValue
		  res.groupSize = rs.field("groupsize").IntegerValue
		  res.guideApprovedCanyons = rs.Field("guideApprovedCanyons").StringValue
		  res.hasDayAfterGear = convertIntToBoolean(rs.field("hasDayAfterGear").IntegerValue)
		  res.hotel = rs.field("hotel").StringValue
		  res.howTheyHeard = rs.Field("howTheyHeard").StringValue
		  res.creationDate =_
		  xojo.core.date.FromText(UtilityFunctions.stringToText(rs.field("CreationTimeStamp").StringValue))
		  res.isGearReturned = convertIntToBoolean(rs.field("gear_returned").IntegerValue)
		  res.isPaid = convertIntToBoolean(rs.field("paid").IntegerValue)
		  res.isReservationDepositRedeemed = convertIntToBoolean(rs.Field("reservationDepositRedeemed").IntegerValue)
		  res.isTaxable = convertIntToBoolean(rs.Field("taxable").IntegerValue)
		  res.notes = stringToText(rs.field("notes").StringValue)
		  res.remittance = rs.field("remittance").DoubleValue
		  res.serial = new SQLSerial(rs.field("serial").IntegerValue)
		  res.startDate = wordDatetoCoreDate(str(rs.Field("startdate").IntegerValue))
		  res.status = BookingToolkit.mapStatus(rs.field("status").StringValue)
		  res.total = rs.Field("total").DoubleValue
		  res.contactDiary = UtilityFunctions.stringToText(rs.field("contactDiary").StringValue)
		  res.isInformedWhatToBring = rs.Field("informedwhattobring").BooleanValue
		  res.isInformedOfCancellationPolicy = rs.field("informedcancellationpolicy").BooleanValue
		  res.isInformedTimeZone = rs.Field("informedtimezone").BooleanValue
		  res.isInformedPickupLocation = rs.Field("informedpickuplocation").BooleanValue
		  res.creationMethod = BookingToolkit.mapCreationMethod(rs.Field("creationMethod").StringValue)
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function buildResGearItemFormFullRecordSet(rs as RecordSet) As BookingToolkit.ResGearItem
		  dim item as new BookingToolkit.ResGearItem()
		  
		  item.gearID = rs.Field("id").StringValue
		  item.gearSize = rs.Field("size").StringValue
		  item.gearType = rs.Field("gearType")
		  item.qty = rs.Field("qty").IntegerValue
		  item.resPartSerial = new SQLSerial(rs.field("respartserial").StringValue)
		  item.resSerial = new SQLSerial(rs.field("resSerial").IntegerValue)
		  item.serial = new SQLSerial(rs.Field("serial").IntegerValue)
		  item.isTrackedByID = convertIntToBoolean(rs.Field("needsGearID").IntegerValue)
		  item.gearTypeSerial = new SQLSerial(rs.Field("gearTypeSerial").IntegerValue)
		  item.isDisplayedInCalEvent = convertIntToBoolean(rs.Field("displayInCalEvent").IntegerValue)
		  
		  return item
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function buildShuttleReservationFromRecordSet(rs as RecordSet) As BookingToolkit.ShuttleReservation
		  dim shuttleRes as new BookingToolkit.ShuttleReservation
		  shuttleRes.serial = new SQLSerial(rs.Field("serial").IntegerValue)
		  shuttleRes.reservationSerial = new SQLSerial(rs.field("resSerial").integerValue)
		  shuttleRes.calEventSerial = new SQLSerial(rs.Field("calEventSerial").IntegerValue)
		  shuttleRes.pickUpLocation = rs.Field("pickupLocation").StringValue
		  shuttleRes.dropOffLocation = rs.Field("dropOffLocation").StringValue
		  shuttleRes.seats = rs.Field("seatAssignments").StringValue.Split("|")
		  shuttleRes.returnShuttleSerial = new SQLSerial(rs.Field("returnShuttleSerial").IntegerValue)
		  shuttleRes.isPresent = UtilityFunctions.convertIntToBoolean(rs.Field("isPresent").IntegerValue)
		  
		  return shuttleRes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function checkIsCustomerAReturn(serial as SQLSerial) As boolean
		  //@throws: ReservationException
		  
		  dim stmt as String =_
		  "SELECT serial FROM reservations WHERE customerserial = " + serial.toString() +_
		  " AND reservations.startdate < " + datetoworddate(xojo.core.date.Now)
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  if rs <> Nil then
		    if rs.RecordCount > 0 then 
		      return true
		      
		    end if
		    
		    return false
		    
		  end if
		  
		  #Pragma BreakOnExceptions False
		  dim err as BookingToolkit.Exceptions.ReservationException = getReservationException()
		  
		  raise err
		  #Pragma BreakOnExceptions true 
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(sql as MySQLCommunityServer)
		  //@throws: Xojo.io.IOException
		  
		  if not sql.Connect() then
		    dim err as new Xojo.IO.IOException()
		    err.Reason = "Unable to connect to MySQL database: " + UtilityFunctions.StringToText(mSqlServer.ErrorMessage)
		    err.ErrorNumber = mSqlServer.ErrorCode
		    raise err
		    
		  end if
		  
		  mSqlServer = sql
		  employees = new BookingToolkit.EmployeeTable(sql)
		  vehicles = getVehicles()
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function createCustomerSearchPreparedStatement(custDetails as BookingToolkit.Customer) As MySQLPreparedStatement
		  dim stmt,phoneNumber,firstname,lastname,email as string 
		  
		  phoneNumber = custDetails.phoneNumber.getUnformattedNumber()
		  email = custDetails.email
		  firstname = custDetails.Name.firstname
		  lastname = custDetails.Name.lastname
		  
		  if phoneNumber <> "" then
		    stmt = " AND phone = ?"
		    
		  end if
		  
		  if email <> "" then
		    stmt = stmt + " AND email = ?"
		    
		  end if
		  
		  if firstname <> "" then
		    stmt = stmt + " AND firstname = ?"
		    
		  end if
		  
		  if lastname <> "" then
		    stmt = stmt + " AND lastname = ?"
		    
		  end if
		  
		  const kLengthLeadingAND = 5
		  stmt = "SELECT " + kAllCustomerFieldsUsed + " FROM customers WHERE " + right(stmt, Len(stmt) - kLengthLeadingAND) + " ORDER BY lastname, firstname"
		  dim ps as MySQLPreparedStatement = mSqlServer.Prepare(stmt)
		  
		  dim currentBindNumber as integer = 0
		  if phoneNumber <> "" then
		    ps.BindType(currentBindNumber, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.Bind(currentBindNumber, phoneNumber)
		    currentBindNumber = currentBindNumber + 1
		    
		  end if
		  
		  if email <> "" then
		    ps.BindType(currentBindNumber, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.Bind(currentBindNumber, email)
		    currentBindNumber = currentBindNumber + 1
		    
		  end if
		  
		  if firstname <> "" then
		    ps.BindType(currentBindNumber, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.Bind(currentBindNumber, firstname)
		    currentBindNumber = currentBindNumber + 1
		    
		  end if
		  
		  if lastname <> "" then
		    ps.BindType(currentBindNumber, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.Bind(currentBindNumber, lastname)
		    currentBindNumber = currentBindNumber + 1
		    
		  end if
		  
		  return ps
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function createNewCalendarEvent(calevent as BookingToolkit.CalendarEvent) As sqlSerial
		  Using DateModule
		  
		  dim dr as new DatabaseRecord()
		  
		  dr.Column("title") = calevent.title
		  dr.Column("startDate") = datetoworddate(calevent.startDate)
		  dr.Column("endDate") = datetoworddate(calevent.endDate)
		  dr.Column("status") = BookingToolkit.mapStatus(calevent.status)
		  dr.Column("creatorName") = calevent.creatorName
		  dr.Column("guideEmpSerial") = calevent.guideEmpSerial.toString()
		  dr.Column("guideSerial") = calevent.guideEventSerial.toString()
		  dr.column("acceptsres") = convertBooleanToText(calevent.isAcceptReservations)
		  dr.Column("notes") = calevent.notes
		  dr.Column("rank") = calevent.rank.ToText()
		  dr.Column("staffEmpSerial") = calevent.staffEmpSerial.toString()
		  if calevent.startTime <> NIl then 
		    dr.Column("starttime") = calevent.startTime.format_SQL
		    
		  end if
		  
		  dr.Column("isPrivate") = convertBooleanToText(calevent.isPrivate)
		  dr.Column("titleNotes") = calevent.titleNotes
		  dr.Column("baseEventSerial") = calevent.tripSpecificationSerial.toText()
		  dr.Column("calendarSerial") = calevent.calendarSerial.toText()
		  dr.Column("status") = BookingToolkit.mapStatus(calevent.status)
		  dr.Column("titleNotes") = calevent.titleNotes
		  
		  mSqlServer.InsertRecord("calendarEvents", dr)
		  if not mSqlServer.error then
		    return new SQLSerial(mSqlServer.GetInsertID())
		    
		  end if
		  
		  #Pragma BreakOnExceptions false
		  dim err as BookingToolkit.Exceptions.CalEventException = getCalEventException()
		  raise err
		  #Pragma BreakOnExceptions true 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function createNewCustomer(cust as BookingToolkit.Customer) As SQLSerial
		  using UtilityFunctions
		  dim newRec as new DatabaseRecord()
		  
		  newRec.Column("profileID") = cust.aNetProfileID
		  newRec.Column("city") = cust.city
		  newRec.Column("company") = cust.company
		  newRec.Column("contactdiary") = cust.contactdiary
		  newRec.Column("country") = cust.country
		  newRec.Column("disctype") = cust.disctype
		  newRec.Column("email") = cust.email
		  newRec.Column("firstname") = cust.Name.sqlSafeFirstname
		  newRec.Column("iscompany") = convertBooleanToText(cust.iscompany)
		  newRec.Column("isemp") = convertBooleanToText(cust.isemp)
		  newRec.Column("lastname") = cust.Name.sqlSafeLastname
		  newRec.Column("paymentProfileID") = cust.ANetPaymentPRofileID
		  newRec.Column("phone") = cust.phoneNumber.getUnformattedNumber()
		  newRec.Column("state") = cust.state
		  newRec.Column("street") = cust.street
		  newRec.Column("tobeinvoiced") = convertBooleanToText(cust.tobeinvoiced)
		  newRec.Column("zip") = cust.zip
		  newRec.Column("dateCreated") = datetoworddate(Xojo.Core.Date.Now) 
		  newRec.Column("isEmailValidated") = convertBooleanToText(cust.isEmailVerified)
		  
		  mSqlServer.InsertRecord("customers", newRec)
		  if not mSqlServer.error then
		    return new SQLSerial(mSqlServer.GetInsertID())
		    
		  end if
		  
		  #Pragma BreakOnExceptions false
		  dim err as BookingToolkit.Exceptions.CustomerException = getCustomerException()
		  if InStr(err.Reason, "Duplicate") > 0 then //XXX: CAN THIS BE BASED OF MYSQL ERROR CODE 1062
		    dim newError as new BookingToolkit.Exceptions.DuplicateCustomerException
		    newError.Reason = "Customer already exists"
		    newError.ErrorNumber = 1
		    newError.originalCustomerSerial = getCustomerSerial(cust)
		    raise newError
		    
		  end if
		  raise err
		  #Pragma BreakOnExceptions true 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function createNewReservation(resDetails as BookingToolkit.Reservation) As SQLSerial
		  //@Throws: ReservationException
		  
		  using UtilityFunctions
		  using DateModule
		  
		  dim dr as new DatabaseRecord()
		  dr.column("approvingGuide") = resDetails.approvingGuide
		  dr.column("balance") = str(resDetails.balance)
		  dr.column("caleventSerial") = resDetails.calendarEventSerial.toString()
		  dr.column("consenttypedname") = resDetails.consentTypedName
		  dr.column("creator") = resDetails.creatorName
		  dr.column("creatorSerial") = resDetails.creatorSerial
		  dr.column("customerSerial") = resDetails.customerSerial.toString()
		  if resDetails.endDate <> Nil then 
		    dr.column("enddate") = datetoworddate(resDetails.endDate)
		    
		  end if
		  dr.column("gearres_ID") = resDetails.gearResID
		  dr.column("groupsize") = str(resDetails.groupSize)
		  dr.column("guideApprovedCanyons") = resDetails.guideApprovedCanyons
		  dr.column("hasDayAfterGear") = convertBooleanToText(resDetails.hasDayAfterGear)
		  dr.column("hotel") = resDetails.hotel
		  dr.column("howTheyHeard") = resDetails.howTheyHeard
		  dr.column("gear_returned") = convertBooleanToText(resDetails.isGearReturned)
		  dr.column("paid") = convertBooleanToText(resDetails.isPaid)
		  dr.column("reservationDepositRedeemed") = convertBooleanToText(resDetails.isReservationDepositRedeemed)
		  dr.column("taxable") = convertBooleanToText(resdetails.isTaxable)
		  dr.column("notes") = resDetails.notes
		  dr.column("remittance") = str(resDetails.remittance)
		  if resDetails.startDate <> Nil then 
		    dr.column("startdate") = datetoworddate(resDetails.startDate)
		    
		  end if
		  dr.column("status") = BookingToolkit.mapStatus(resDetails.status)
		  dr.column("total") = str(resDetails.total)
		  dr.Column("contactDiary") = resDetails.contactDiary
		  dr.Column("informedwhattobring")= convertBooleanToText(resDetails.isInformedWhatToBring)
		  dr.Column("informedcancellationpolicy") = convertBooleanToText(resDetails.isInformedOfCancellationPolicy)
		  dr.Column("informedtimezone") = convertBooleanToText(resDetails.isInformedTimeZone)
		  dr.Column("informedpickuplocation") = convertBooleanToText(resDetails.isInformedPickupLocation)
		  dr.column("creationMethod") = BookingToolkit.mapCreationMethod(resDetails.creationMethod)
		  
		  mSqlServer.InsertRecord("Reservations", dr)
		  if not mSqlServer.error then
		    return new SQLSerial(mSqlServer.GetInsertID())
		    
		  end if
		  
		  #Pragma BreakOnExceptions false 
		  dim err as BookingToolkit.Exceptions.ReservationException = getReservationException()
		  raise err
		  #Pragma BreakOnExceptions true 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function createNewShuttleReservation(ss as BookingToolkit.ShuttleReservation) As SQLSerial
		  //@throws: BookingToolkit.Exceptions.ReservationException
		  
		  dim dr as new DatabaseRecord()
		  
		  dr.Column("resSerial") = ss.reservationSerial.toString()
		  dr.Column("calEventSerial") = ss.calEventSerial.toString()
		  dr.Column("pickupLocation") = ss.pickUpLocation
		  dr.Column("dropOfflocation") = ss.dropOffLocation
		  dr.Column("seatAssignments") = ss.getSeatString()
		  dr.Column("returnShuttleSerial") = ss.returnShuttleSerial.toString()
		  
		  mSqlServer.InsertRecord("shuttleReservations", dr)
		  
		  if mSqlServer.Error then
		    dim err as BookingToolkit.Exceptions.ReservationException = getReservationException()
		    raise err
		    
		  end if
		  
		  return new SQLSerial(mSqlServer.GetInsertID())
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function createResGearItem(item as BookingToolkit.ResGearItem) As SQLSerial
		  //@thorws: BookingToolkit.Exceptions.ResGearItemException
		  
		  dim dr as new DatabaseRecord()
		  dr.Column("size") = item.gearSize
		  dr.Column("geartype") = item.gearType
		  dr.Column("respartserial") = item.resPartSerial.toString()
		  dr.Column("resserial") = item.resSerial.toString()
		  dr.Column("qty") = str(item.qty)
		  dr.Column("needsGearID") = convertBooleanToText(item.isTrackedByID)
		  dr.Column("gearTypeSerial") = item.gearTypeSerial.toString()
		  dr.Column("displayInCalEvent") = UtilityFunctions.convertBooleanToText(item.isDisplayedInCalEvent)
		  
		  mSqlServer.InsertRecord("resgearitems", dr)
		  
		  if not mSqlServer.Error then
		    return new SQLSerial(mSqlServer.GetInsertID())
		    
		  end if
		  
		  dim err as new BookingToolkit.Exceptions.ResGearItemException()
		  err.Reason = UtilityFunctions.stringToText(mSqlServer.ErrorMessage)
		  err.ErrorNumber = mSqlServer.ErrorCode
		  
		  raise err 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function createResource(aa as BookingToolkit.Resource) As SQLSerial
		  //@throws BookingToolkit.Exceptions.CalEventException
		  
		  dim dr as new DatabaseRecord()
		  dr.Column("calendarEventSerial") = aa.calendarEventSerial.toString()
		  dr.Column("resourceSerial") = aa.resourceSerial.toString()
		  dr.Column("resourceType") = BookingToolkit.mapresourceType(aa.resourceType)
		  
		  mSqlServer.InsertRecord("calendarEventResourceAssignments", dr)
		  if mSqlServer.Error then
		    dim err as BookingToolkit.Exceptions.CalEventException= getCalEventException()
		    raise err
		    
		  end if
		  
		  return new SQLSerial(mSqlServer.GetInsertID())
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function createResPart(participant as BookingToolkit.ResPart) As SQLSerial
		  //@throws: BookingToolkit.Exceptions.ResPartException
		  
		  dim dr as new DatabaseRecord()
		  dr.Column("height") = str(participant.height.totalInches)
		  dr.Column("name") = participant.name.sqlSafeFirstname
		  dr.Column("lastName") = participant.name.sqlSafeLastname
		  dr.Column("resserial") = participant.resSerial.toString()
		  dr.Column("weight") = str(participant.weight)
		  dr.Column("age") = str(participant.age)
		  dr.Column("gender") = participant.gender
		  
		  mSqlServer.InsertRecord("resparts", dr)
		  if not mSqlServer.Error then
		    return new SQLSerial(mSqlServer.GetInsertID())
		    
		  end if
		  
		  dim err as new BookingToolkit.Exceptions.ResPartException()
		  err.Reason = UtilityFunctions.stringToText(mSqlServer.ErrorMessage)
		  err.ErrorNumber = mSqlServer.ErrorCode
		  
		  raise err 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deleteCustomer(customerSerial as SQLSerial)
		  dim stmt as string =_
		  "DELETE FROM customers WHERE serial = " + customerSerial.toString()
		  mSqlServer.SQLExecute(stmt)
		  
		  if mSqlServer.Error then
		    dim err as BookingToolkit.Exceptions.CustomerException = getCustomerException()
		    raise err
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deleteEmergencyContact(serial as SQLSerial)
		  dim stmt as string = "DELETE FROM emergencyContacts WHERE serial = " + serial.toString()
		  mSqlServer.SQLExecute(stmt)
		  
		  if mSqlServer.Error then
		    #Pragma BreakOnExceptions true 
		    dim err as BookingToolkit.Exceptions.CustomerException = getCustomerException()
		    
		    raise err
		    #Pragma BreakOnExceptions false
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deleteReservation(resSerial as SQLSerial)
		  //Most reservations should have their status changed to DELETED and call updateReservation,
		  //    This method provides a way to fully remove a reservation which will not be done all that often
		  
		  //@throws: BookingToolkit.Exceptions.ReservationException
		  
		  dim stmt as string =_
		  "DELETE FROM reservations WHERE serial = " + resSerial.toString()
		  mSqlServer.SQLExecute(stmt)
		  
		  if mSqlServer.Error then
		    #Pragma BreakOnExceptions false
		    dim err as new BookingToolkit.Exceptions.ReservationException
		    err.Reason = UtilityFunctions.stringToText(mSqlServer.ErrorMessage)
		    err.ErrorNumber = mSqlServer.ErrorCode
		    
		    raise err
		    #Pragma BreakOnExceptions true
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deleteResGearItem(item as BookingToolkit.ResGearItem)
		  //@throws: ReservationException
		  
		  #Pragma BreakOnExceptions false
		  try
		    deleteResGearItem(item.serial)
		    
		  catch err as BookingToolkit.Exceptions.ReservationException
		    raise err
		    
		  end try
		  
		  #Pragma BreakOnExceptions false
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deleteResGearItem(serial as SQLSerial)
		  //@throws: BookingToolkit.Exceptions.ResGearItemException
		  
		  dim stmt as string =_
		  "DELETE FROM resgearitems WHERE serial = " + serial.toString()
		  mSqlServer.SQLExecute(stmt)
		  
		  if mSqlServer.Error then
		    #Pragma BreakOnExceptions false
		    dim err as new BookingToolkit.Exceptions.ResGearItemException
		    err.Reason = UtilityFunctions.stringToText(mSqlServer.ErrorMessage)
		    err.ErrorNumber = mSqlServer.ErrorCode
		    
		    raise err
		    #Pragma BreakOnExceptions true
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deleteResource(ser as SQLSerial)
		  //@throws: BookingToolkit.Exceptions.CalEventException
		  
		  dim cmd as string =_
		  "DELETE FROM calendarEventResourceAssignments WHERE serial = " + ser.toString()
		  mSqlServer.SQLExecute(cmd)
		  
		  if mSqlServer.Error then
		    dim err as BookingToolkit.Exceptions.CalEventException= getCalEventException()
		    raise err
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deleteResPart(participant as BookingToolkit.ResPart)
		  //@throws: ReservationException
		  
		  #Pragma BreakOnExceptions false
		  try
		    deleteResPart(participant.serial)
		    
		  catch err as BookingToolkit.Exceptions.ReservationException
		    raise err
		    
		  end try
		  
		  #Pragma BreakOnExceptions false
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deleteResPart(serial as SQLSerial)
		  //@throws: BookingToolkit.Exceptions.ResGearItemException
		  
		  dim stmt as string =_
		  "DELETE FROM resparts WHERE serial = " + serial.toString()
		  mSqlServer.SQLExecute(stmt)
		  
		  
		  //TODO: this needs to also delete any associated resgearitems
		  
		  
		  if mSqlServer.Error then
		    #Pragma BreakOnExceptions false
		    dim err as new BookingToolkit.Exceptions.ResGearItemException
		    err.Reason = UtilityFunctions.stringToText( mSqlServer.ErrorMessage)
		    err.ErrorNumber = mSqlServer.ErrorCode
		    
		    raise err
		    #Pragma BreakOnExceptions true
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deleteShuttleReservation(resSerial as SQLSerial)
		  //@throws: BookingToolkit.Exceptions.ReservationException
		  
		  dim cmd as string = "DELETE FROM shuttleReservations WHERE serial = " + resSerial.toString()
		  mSqlServer.SQLExecute(cmd)
		  
		  if mSqlServer.Error then
		    dim err as BookingToolkit.Exceptions.ReservationException = getReservationException()
		    
		    raise err
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub destructor()
		  if mSqlServer <> Nil then
		    mSqlServer.Close()
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getAllReservationsForCustomer(serial as SQLSerial) As BookingToolkit.Reservation()
		  //@throws: BookingToolkit.Exceptions.ReservationException
		  
		  dim stmt as string =_
		  "SELECT " + kAllResFieldsUsed + ",IF(isnull(firstname), '', firstname) AS firstname,IF(isnull(lastname), '', lastname) AS lastname FROM reservations LEFT JOIN customers ON customers.serial = customerserial WHERE customerserial = " + serial.toString()
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  if rs <> nil then
		    dim reservations() as BookingToolkit.Reservation
		    while not rs.EOF 
		      reservations.Append(buildReservationFromFullReservationRecordSet(rs))
		      rs.MoveNext()
		      
		    wend
		    
		    return reservations
		    
		  end if
		  
		  #Pragma BreakOnExceptions false
		  dim err as BookingToolkit.Exceptions.ReservationException = getReservationException()
		  
		  raise err
		  #Pragma BreakOnExceptions true 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getAssignedResources(calSerial as SQLSerial) As BookingToolkit.Resource()
		  //@throws: BookingToolkit.Exceptions.CalEventException
		  
		  dim stmt as string =_
		  "SELECT * FROM calendarEventResourceAssignments WHERE calendarEventSerial = " + calSerial.toString()
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  if rs = nil then
		    dim err as BookingToolkit.Exceptions.CalEventException= getCalEventException()
		    raise err
		    
		  end if
		  
		  dim Resources() as BookingToolkit.Resource
		  while not rs.EOF
		    dim Resource as new BookingToolkit.Resource()
		    Resource.serial = new SQLSerial(rs.Field("serial").IntegerValue)
		    resource.resourceSerial = new SQLSerial(rs.Field("resourceSerial").IntegerValue)
		    Resource.calendarEventSerial = new SQLSerial(rs.Field("calendarEventSerial").IntegerValue)
		    Resource.resourceType = BookingToolkit.mapresourceType(rs.Field("resourceType").StringValue)
		    Resources.Append(Resource)
		    
		    rs.MoveNext()
		    
		  wend
		  
		  return Resources
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getAssignedResources(dd as xojo.core.date) As BookingToolkit.Resource()
		  dim resources() as BookingToolkit.Resource
		  dim stmt as string =_
		  "SELECT cera.* FROM calendarEventResourceAssignments cera,calendarevents ce WHERE calendarEventSerial = ce.serial AND enddate >= " +_
		  datetoworddate(dd) + " AND startate <= " + datetoworddate(dd)
		  
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  if rs = nil then
		    self.reportError(825133, getCalEventException(), "Unable to get resources with string: " + stmt)
		    return resources
		    
		  end if
		  
		  while not rs.EOF
		    dim Resource as new BookingToolkit.Resource()
		    Resource.serial = new SQLSerial(rs.Field("serial").IntegerValue)
		    resource.resourceSerial = new SQLSerial(rs.Field("resourceSerial").IntegerValue)
		    Resource.calendarEventSerial = new SQLSerial(rs.Field("calendarEventSerial").IntegerValue)
		    Resource.resourceType = BookingToolkit.mapresourceType(rs.Field("resourceType").StringValue)
		    Resources.Append(Resource)
		    
		    rs.MoveNext()
		    
		  wend
		  
		  return Resources
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getAssignedResources(dd as Xojo.Core.Date, tt as DateModule.Time) As BookingToolkit.Resource()
		  dim resources() as BookingToolkit.Resource
		  dim stmt as string =_
		  "SELECT cera.* FROM calendarEventResourceAssignments cera,calendarevents ce WHERE calendarEventSerial = ce.serial AND enddate >= " +_
		  datetoworddate(dd) + " AND startate <= " + datetoworddate(dd) + " AND startime <= '" + tt.format_SQL + "' AND endtime >= '" + tt.format_SQL + "'"
		  
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  if rs = nil then
		    self.reportError(825133, getCalEventException(), "Unable to get resources with string: " + stmt)
		    return resources
		    
		  end if
		  
		  while not rs.EOF
		    dim Resource as new BookingToolkit.Resource()
		    Resource.serial = new SQLSerial(rs.Field("serial").IntegerValue)
		    resource.resourceSerial = new SQLSerial(rs.Field("resourceSerial").IntegerValue)
		    Resource.calendarEventSerial = new SQLSerial(rs.Field("calendarEventSerial").IntegerValue)
		    Resource.resourceType = BookingToolkit.mapresourceType(rs.Field("resourceType").StringValue)
		    Resources.Append(Resource)
		    
		    rs.MoveNext()
		    
		  wend
		  
		  return Resources
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCalendarEvent(ser as SQLSerial) As BookingToolkit.CalendarEvent
		  //@throws: as BookingToolkit.Exceptions.CalEventException
		  
		  dim stmt as string =_
		  "SELECT " + kAllCalEventFields + " FROM calendarEvents WHERE serial = " + ser.toString()
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  if rs <> nil and rs.RecordCount = 1 then
		    return buildCalEventFromFullRecordSet(rs)
		    
		  end if
		  
		  dim err as new BookingToolkit.Exceptions.CalEventException()
		  err.Reason = "Unable to locate record"
		  
		  raise err
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCalendarEvents(staffSerial as SQLSerial, dd as Xojo.Core.Date) As BookingToolkit.CalendarEvent()
		  dim events() as BookingToolkit.CalendarEvent
		  
		  dim stmt as string =_
		  "SELECT " + kAllCalEventFields + " FROM calendarevents WHERE SERIAL IN " +_ 
		  "(SELECT calendarEventSerial FROM calendarEventResourceAssignments WHERE resourceSerial = " + staffSerial.toString() + " AND resourceType = 'STAFF')" +_
		  " AND startdate <= " + datetoworddate(dd) + " AND enddate >= " + datetoworddate(dd) +_
		  " AND status <> '" + BookingToolkit.mapStatus(BookingToolkit.Statuses.Deleted) + "'" +_
		  " ORDER BY startDate ASC, calendarSerial DESC, baseEventSerial DESC, starttime ASC"
		  
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  while not rs.EOF
		    events.Append(buildCalEventFromFullRecordSet(rs))
		    rs.MoveNext()
		    
		  wend
		  
		  Return events
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCalendarEvents(d1 as xojo.core.date, d2 as xojo.core.date) As BookingToolkit.CalendarEvent()
		  //@throws: as BookingToolkit.Exceptions.CalEventException
		  
		  dim stmt as string =_
		  "SELECT " + kAllCalEventFields + " FROM calendarEvents WHERE endDate >= " + datetoworddate(d1) + " AND startdate <= " + datetoworddate(d2) + " AND status <> 'DELETED' ORDER BY startDate ASC, calendarSerial DESC, baseEventSerial DESC, starttime ASC"
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  if rs <> nil then
		    dim values() as BookingToolkit.CalendarEvent 
		    while not rs.EOF
		      values.Append(buildCalEventFromFullRecordSet(rs))
		      rs.MoveNext()
		      
		    wend
		    
		    Return values
		    
		  else
		    dim err as new BookingToolkit.Exceptions.CalEventException()
		    err.Reason = "Unable to locate record"
		    
		    raise err
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getCalEventException() As BookingToolkit.Exceptions.CalEventException
		  dim err as new BookingToolkit.Exceptions.CalEventException()
		  err.Reason = UtilityFunctions.StringToText(mSqlServer.ErrorMessage)
		  err.ErrorNumber = mSqlServer.ErrorCode
		  
		  return err 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCluster(ee as BookingToolkit.CalendarEvent, clusterSerials() as SQLSerial) As BookingToolkit.ClusterDetails()
		  //@throws: BookingToolkit.Exceptions.CalEventException
		  
		  dim stmt as string = "SELECT calendarevents.serial, startTime, title, sum(CASE WHEN groupsize IS NULL THEN 0 ELSE groupsize END) AS gSize FROM " +_
		  "calendarEvents LEFT JOIN reservations ON " +_
		  "reservations.caleventserial = calendarevents.serial WHERE " +_
		  "calendarEvents.serial <> " + ee.serial.toString() +_
		  " AND calendarEvents.status = 'ACTIVE' AND (reservations.status IS NULL OR reservations.status = 'Active') AND " +_
		  "calendarEvents.startdate = "+ datetoworddate(ee.startDate) +_
		  " AND baseEventSerial IN (" + clusterSerials.join(",") +_
		  ") AND starttime = '"+ ee.startTime.format_SQL + "' GROUP BY calendarevents.serial"
		  
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  if rs = Nil then
		    dim err as new BookingToolkit.Exceptions.CalEventException()
		    err.Reason = "Unable to get cluster: " + UtilityFunctions.stringToText(mSqlServer.ErrorMessage)
		    
		    raise err
		    
		  end if 
		  
		  dim events() as BookingToolkit.ClusterDetails
		  while not rs.EOF
		    events.Append(new BookingToolkit.ClusterDetails(_
		    rs.Field("title").StringValue,_
		    new DateModule.Time(rs.field("startTime").StringValue),_
		    rs.Field("gSize").IntegerValue))
		    
		    rs.MoveNext()
		    
		  wend
		  
		  return events()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCustomer(custSerial as SQLSerial) As BookingToolkit.Customer
		  //@throws: BookingToolkit.Exceptions.NoSuchItemException
		  
		  using UtilityFunctions
		  
		  dim stmt as string =_
		  "SELECT " + kAllCustomerFieldsUsed + " FROM customers WHERE serial = " + custSerial.toString()
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  if rs <> NIl and not (rs.EOF and rs.BOF) then
		    return buildCustomerFromRecordset(rs)
		    
		  else
		    #Pragma BreakOnExceptions false
		    dim err as new BookingToolkit.Exceptions.NoSuchItemException()
		    err.Reason = "Unable to gather customer information"
		    err.ErrorNumber = 1
		    raise err
		    #Pragma BreakOnExceptions true 
		    
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getCustomerException() As BookingToolkit.Exceptions.CustomerException
		  dim err as new BookingToolkit.Exceptions.CustomerException()
		  err.Reason = UtilityFunctions.StringToText(mSqlServer.ErrorMessage)
		  err.ErrorNumber = mSqlServer.ErrorCode
		  
		  return err 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getCustomerSerial(cust as BookingToolkit.Customer) As SQLSerial
		  dim stmt as string =_
		  "SELECT serial FROM customers WHERE firstname = '" + cust.Name.firstname + "' AND lastname = '" + cust.Name.lastname + "' AND phone = '" + cust.phoneNumber.getUnformattedNumber() + "'"
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  if rs <> nil and not (rs.EOF and rs.BOF) then
		    return new SQLSerial(rs.Field("Serial").IntegerValue)
		    
		  end if
		  
		  dim err as BookingToolkit.Exceptions.CustomerException = getCustomerException()
		  raise err 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCustomersFromDetails(custDetails as BookingToolkit.Customer) As BookingToolkit.Customer()
		  dim customers() as BookingToolkit.Customer
		  dim ps as MySQLPreparedStatement = createCustomerSearchPreparedStatement(custDetails)
		  dim rs as RecordSet = ps.SQLSelect()
		  dim custSerial as SQLSerial
		  if rs <> NIl then
		    while not rs.EOF
		      try
		        custSerial = new SQLSerial(rs.Field("serial").IntegerValue)
		        customers.Append(getCustomer(custSerial))
		        
		      catch err as BookingToolkit.Exceptions.NoSuchItemException
		        self.reportError(875417, err, "Unable to find customer from one that exists: " + custSerial.toText())
		        
		      end try
		      
		      rs.MoveNext()
		      
		    wend
		    
		  end if
		  
		  return customers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getDatabaseException() As BookingToolkit.Exceptions.RunTimeException
		  dim err as new BookingToolkit.Exceptions.RunTimeException()
		  err.Reason = UtilityFunctions.StringToText(mSqlServer.ErrorMessage)
		  err.ErrorNumber = mSqlServer.ErrorCode
		  
		  return err 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getEmergecyContacts(customerSerial as SQLSerial) As BookingToolkit.EmergencyContact()
		  dim contacts() as BookingToolkit.EmergencyContact
		  dim stmt as string =_
		  "SELECT * FROM emergencyContacts WHERE customerSerial = " + customerSerial.toString()
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  if rs <> NIl then
		    while not rs.EOF
		      dim newContact as new BookingToolkit.EmergencyContact()
		      newContact.contactNumber = new BookingToolkit.PhoneNumber(rs.Field("contactPhone").StringValue)
		      newContact.customerSerial = new SQLSerial(rs.Field("customerSerial").IntegerValue)
		      newContact.name = new BookingToolkit.DisplayName(rs.Field("firstName").StringValue, rs.Field("lastName").StringValue)
		      newContact.relation = rs.Field("relation").StringValue
		      newContact.serial = new SQLSerial(rs.field("Serial").IntegerValue)
		      contacts.Append(newContact)
		      
		      rs.MoveNext()
		      
		    wend
		    
		  end if
		  
		  return contacts
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getFakeAddresses(numAddresses as Integer) As string()
		  if numAddresses > 0 then
		    dim addresses() as string 
		    dim stmt as string = buildRandomAddressQuery(getRandomSerialsArray(numAddresses))
		    dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		    if rs <> Nil then
		      while not rs.EOF
		        addresses.Append(rs.field("streetAddress").StringValue)
		        rs.MoveNext()
		        
		      wend
		      
		      return addresses
		      
		    end if
		    
		  end if
		  
		  #Pragma BreakOnExceptions false 
		  dim err as Xojo.Core.InvalidArgumentException
		  err.Reason = "Requested number must be positive"
		  
		  raise err
		  #Pragma BreakOnExceptions true 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getMatchingEvents(profile as BookingToolkit.CalendarEvent) As BookingToolkit.CalendarEvent()
		  //@throws: BookingToolkit.Exceptions.CalEventException
		  
		  using DateModule
		  
		  dim matchingEvents(-1) as BookingToolkit.CalendarEvent
		  dim stmt as string =_
		  "SELECT " + kAllCalEventFields + " FROM calendarevents WHERE " +_
		  "startdate = " + datetoworddate(profile.startDate) +_
		  " AND enddate = " + datetoworddate(profile.endDate) +_
		  " AND status = 'ACTIVE'"
		  
		  if profile.calendarSerial <> NIl then
		    stmt = stmt + " AND calendarSerial = " + profile.calendarSerial.toString() 
		    
		  end if
		  
		  if profile.tripSpecificationSerial <> Nil then
		    stmt = stmt + " AND baseEventSerial = " + profile.tripSpecificationSerial.toString()
		    
		  end if
		  
		  if profile.startTime <> Nil then
		    stmt = stmt + " AND starttime = '" + profile.startTime.format_SQL() + "'"
		    
		  end if
		  
		  stmt = stmt + " ORDER BY startdate ASC, calendarSerial DESC,baseEventSerial DESC, startTime ASC"
		  
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  if rs <> Nil then
		    while not rs.EOF
		      dim prof as BookingToolkit.CalendarEvent  = buildCalEventFromFullRecordSet(rs)
		      matchingEvents.Append(prof)
		      
		      rs.MoveNext()
		      
		    Wend
		    
		  else
		    #Pragma BreakOnExceptions false
		    dim err as BookingToolkit.Exceptions.CalEventException = getCalEventException()
		    raise err
		    #Pragma BreakOnExceptions true
		    
		  end if
		  
		  return matchingEvents
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getModifications(calEvent as BookingToolkit.CalendarEvent) As BookingToolkit.Modification()
		  //@throws: BookingToolkit.Exceptions.RunTimeException
		  
		  dim stmt as string =_
		  "SELECT * FROM changeLog_CalendarEvents WHERE calEventSerial = " + calEvent.serial.toString() + " ORDER by creationDate ASC"
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  if rs <> Nil then
		    dim mods() as BookingToolkit.Modification
		    while not rs.eof
		      dim mm as new BookingToolkit.Modification(_
		      new SQLSerial(rs.Field("empSerial").IntegerValue),_
		      rs.Field("notes").StringValue,_
		      rs.Field("creationDate").DateValue)
		      
		      mods.Append(mm)
		      rs.MoveNext()
		      
		    wend
		    
		    return mods
		    
		  end if
		  
		  
		  if mSqlServer.Error then
		    dim err as new BookingToolkit.Exceptions.RunTimeException()
		    err.Reason = "Unable to retrieve records: " + UtilityFunctions.stringToText(mSqlServer.ErrorMessage)
		    
		    raise err
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getModifications(res as BookingToolkit.Reservation) As BookingToolkit.Modification()
		  //@throws: BookingToolkit.Exceptions.RunTimeException
		  
		  dim stmt as string =_
		  "SELECT * FROM changeLog_Reservations WHERE resSerial = " + res.serial.toString() + " ORDER BY creationDate ASC"
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  if rs <> Nil then
		    dim mods() as BookingToolkit.Modification
		    while not rs.eof
		      dim mm as new BookingToolkit.Modification(_
		      new SQLSerial(rs.Field("empSerial").IntegerValue),_
		      rs.Field("notes").StringValue,_
		      rs.Field("creationDate").DateValue)
		      
		      mods.Append(mm)
		      rs.MoveNext()
		      
		    wend
		    
		    return mods
		    
		  end if
		  
		  
		  if mSqlServer.Error then
		    dim err as new BookingToolkit.Exceptions.RunTimeException()
		    err.Reason = "Unable to retrieve records: " + UtilityFunctions.stringToText(mSqlServer.ErrorMessage)
		    
		    raise err
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getRandomSerialsArray(size as Integer) As string()
		  dim uniqueSerials as new Xojo.Core.Dictionary()
		  dim serials() as string
		  dim randomSerial as Integer
		  dim ii as integer = 0
		  while ii <= size - 1
		    randomSerial = Xojo.math.RandomInt(1, 150)
		    if not uniqueSerials.HasKey(randomSerial) then
		      uniqueSerials.Value(randomSerial) = Nil
		      serials.Append(str(randomSerial))
		      
		      ii = ii + 1
		      
		    end if
		    
		  wend
		  
		  return serials 
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getReservation(resSerial as SQLSerial) As BookingToolkit.Reservation
		  //@throws: BookingToolkit.Exceptions.NoSuchItemException
		  
		  using UtilityFunctions
		  using DateModule
		  
		  dim stmt as string =_
		  "SELECT " + kAllResFieldsUsed + ",IF(isnull(firstname), '', firstname) AS firstname,IF(isnull(lastname), '', lastname) AS lastname FROM reservations LEFT JOIN customers ON customers.serial = reservations.customerserial  WHERE reservations.serial = " + resSerial.toString()
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  if rs <> NIl and not (rs.EOF and rs.BOF) then
		    return buildReservationFromFullReservationRecordSet(rs)
		    
		  else
		    #Pragma BreakOnExceptions false
		    dim err as new BookingToolkit.Exceptions.NoSuchItemException()
		    err.Reason = "Unable to gather reservation information"
		    err.ErrorNumber = 2
		    raise err
		    #Pragma BreakOnExceptions true 
		    
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getReservationException() As BookingToolkit.Exceptions.ReservationException
		  dim err as new BookingToolkit.Exceptions.ReservationException()
		  err.Reason = UtilityFunctions.StringToText(mSqlServer.ErrorMessage)
		  err.ErrorNumber = mSqlServer.ErrorCode
		  
		  return err 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getReservationsForCalEvent(ser as SQLSerial) As BookingToolkit.Reservation()
		  //@throws: BookingToolkit.Exceptions.NoSuchItemException
		  
		  using UtilityFunctions
		  using DateModule
		  
		  dim stmt as string =_
		  "SELECT " + kAllResFieldsUsed + ",IF(isnull(firstname), '', firstname) AS firstname,IF(isnull(lastname), '', lastname) AS lastname FROM reservations LEFT JOIN customers ON customers.serial = reservations.customerserial "+_
		  "WHERE caleventSerial = " + ser.toString() + " AND status <> 'Deleted' ORDER BY lastname"
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  dim reservations() as BookingToolkit.Reservation
		  if rs <> NIl  then
		    while not rs.EOF
		      reservations.Append(buildReservationFromFullReservationRecordSet(rs))
		      rs.MoveNext()
		      
		    wend
		    
		    return reservations
		    
		  else
		    #Pragma BreakOnExceptions false
		    dim err as new BookingToolkit.Exceptions.NoSuchItemException()
		    err.Reason = "Unable to gather reservation information for caleventserial: " + ser.toText()
		    err.ErrorNumber = 2
		    raise err
		    #Pragma BreakOnExceptions true 
		    
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getResGearItemsFromReservation(resSerial as SQLSerial) As BookingToolkit.ResGearItem()
		  //@Throws: BookingToolkit.Exceptions.ReservationException
		  
		  dim stmt as string =_
		  "SELECT " + kAllResGearItemFields + " FROM resgearitems WHERE resserial = " + resSerial.toString()
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  if rs <> Nil then
		    dim items() as BookingToolkit.ResGearItem
		    while not rs.EOF 
		      items.Append(buildResGearItemFormFullRecordSet(rs))
		      rs.MoveNext()
		      
		    wend
		    
		    return items
		    
		  end if
		  
		  #Pragma BreakOnExceptions false
		  dim err as BookingToolkit.Exceptions.ReservationException = getReservationException()
		  raise err
		  #Pragma BreakOnExceptions true 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getResParts(resSerial as SQLSerial) As BookingToolkit.ResPart()
		  //@Throws: BookingToolkit.Exceptions.ReservationException
		  
		  dim stmt as string =_
		  "SELECT rp.age,rp.gender,rp.height,rp.name,rp.lastname,rp.serial AS rp_serial,rp.weight,rgi.respartserial,rgi.id,rgi.size,rgi.gearType,rgi.qty,rgi.serial AS rgi_serial,rgi.needsGearID,rgi.gearTypeSerial,rgi.displayInCalEvent FROM resparts rp LEFT JOIN resgearItems rgi ON rgi.respartserial = rp.serial WHERE rp.resserial = " + resSerial.toString()
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  if rs <> Nil then
		    dim participants() as BookingToolkit.ResPart
		    while not rs.EOF 
		      dim participant as new BookingToolkit.ResPart()
		      participant.age = rs.field("age").IntegerValue
		      participant.gender = rs.Field("gender").StringValue
		      participant.height = new BookingToolkit.HumanHeight(rs.Field("height").IntegerValue)
		      participant.name = new BookingToolkit.DisplayName(rs.Field("name").StringValue, rs.field("lastName").StringValue)
		      participant.serial = new SQLSerial(rs.Field("rp_serial").IntegerValue)
		      participant.resSerial = resSerial.clone()
		      participant.weight = rs.Field("weight").IntegerValue
		      
		      if not IsNull(rs.Field("rgi_serial").IntegerValue) then
		        dim item as new BookingToolkit.ResGearItem()
		        item.gearID = rs.Field("id").StringValue
		        item.gearSize = rs.Field("size").StringValue
		        item.gearType = rs.Field("gearType")
		        item.qty = rs.Field("qty").IntegerValue
		        item.resPartSerial = new SQLSerial(rs.field("respartserial").StringValue)
		        item.resSerial = resSerial.clone()
		        item.serial = new SQLSerial(rs.Field("rgi_serial").IntegerValue)
		        item.isTrackedByID = convertIntToBoolean(rs.Field("needsGearID").IntegerValue)
		        item.gearTypeSerial = new SQLSerial(rs.Field("gearTypeSerial").IntegerValue)
		        item.isDisplayedInCalEvent = convertIntToBoolean(rs.Field("displayInCalEvent").IntegerValue)
		        
		        participant.personalGearItem = item
		        
		      end if
		      
		      participants.Append(participant)
		      
		      rs.MoveNext()
		      
		    wend
		    
		    return participants
		    
		  end if
		  
		  #Pragma BreakOnExceptions false
		  dim err as BookingToolkit.Exceptions.ReservationException = getReservationException()
		  raise err
		  #Pragma BreakOnExceptions true 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getShuttleForCalendarEvent(calEventSerial as SQLSerial) As BookingToolkit.Shuttle
		  dim stmt as string =_
		  "SELECT * FROM shuttleReservations WHERE calEventSerial = " + calEventSerial.toString()
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  
		  dim theShuttle as new BookingToolkit.Shuttle()
		  while not rs.EOF
		    theShuttle.addReservation(buildShuttleReservationFromRecordSet(rs))
		    rs.MoveNext()
		    
		  wend
		  
		  return theShuttle
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getShuttleReservation(ser as SQLSerial) As BookingToolkit.ShuttleReservation
		  //@throws: BookingToolkit.Exceptions.NoSuchItemException
		  
		  dim stmt as string = "SELECT * FROM shuttleReservations WHERE serial = " + ser.toString()
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  if rs = nil or rs.RecordCount = 0 then
		    dim err as new BookingToolkit.Exceptions.NoSuchItemException()
		    
		    raise err
		    
		  end if
		  
		  return buildShuttleReservationFromRecordSet(rs)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getVehicles() As BookingToolkit.Vehicle()
		  dim Vehicles() as BookingToolkit.Vehicle
		  
		  dim stmt as string =_
		  "SELECT serial,name,seats,status FROM vehicles WHERE inUse = 1 ORDER BY name ASC"
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  while not rs.EOF
		    dim vv as new BookingToolkit.Vehicle()
		    vv.serial = new SQLSerial(rs.Field("Serial").IntegerValue)
		    vv.name = rs.Field("name").StringValue
		    vv.seats = rs.Field("seats").IntegerValue
		    vv.isInService = rs.Field("status").StringValue = "In Service" //XXX: this needs to be better some day
		    Vehicles.Append(vv)
		    rs.MoveNext()
		    
		  wend
		  
		  return Vehicles
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function mergeCustomerRecords(existingCustomerSerial as sqlserial, newCustomerDetails as BookingToolkit.Customer) As BookingToolkit.Customer
		  //@throws: BookingToolkit.Exceptions.CustomerException
		  
		  dim mergedCust as BookingToolkit.Customer = getCustomer(existingCustomerSerial)
		  mergedCust.Name = newCustomerDetails.Name
		  mergedCust.phoneNumber = newCustomerDetails.phoneNumber
		  if newCustomerDetails.iscompany then 
		    mergedCust.iscompany = newCustomerDetails.iscompany
		    
		  end if
		  
		  if newCustomerDetails.isemp then 
		    mergedCust.isemp = true
		    
		  end if
		  
		  if newCustomerDetails.tobeinvoiced then 
		    mergedCust.tobeinvoiced = true
		    
		  end if
		  
		  if newCustomerDetails.isEmailVerified then 
		    mergedCust.isEmailVerified = true
		    
		  end if
		  
		  if newCustomerDetails.aNetProfileID <> "" then 
		    mergedCust.aNetProfileID = newCustomerDetails.aNetProfileID
		    
		  end if
		  
		  if newCustomerDetails.city <> "" then 
		    mergedCust.city = newCustomerDetails.city
		    
		  end if
		  
		  if newCustomerDetails.company <> "" then
		    mergedCust.company = newCustomerDetails.company
		    
		  end if
		  
		  if newCustomerDetails.contactdiary <> "" then 
		    mergedCust.contactdiary = newCustomerDetails.contactdiary
		    
		  end if
		  
		  if newCustomerDetails.country <> "" then
		    mergedCust.country = newCustomerDetails.country
		    
		  end if
		  
		  if newCustomerDetails.disctype <> "" then 
		    mergedCust.disctype = newCustomerDetails.disctype
		    
		  end if
		  
		  if newCustomerDetails.email <> "" then 
		    mergedCust.email = newCustomerDetails.email
		    
		  end if
		  
		  if newCustomerDetails.ANetPaymentProfileID <> "" then 
		    mergedCust.ANetPaymentProfileID = newCustomerDetails.ANetPaymentProfileID
		    
		  end if
		  
		  if newCustomerDetails.state <> "" then 
		    mergedCust.state = newCustomerDetails.state
		    
		  end if
		  
		  if newCustomerDetails.street <> "" then 
		    mergedCust.street = newCustomerDetails.street
		    
		  end if
		  
		  if newCustomerDetails.zip <> "" then 
		    mergedCust.zip = newCustomerDetails.zip
		    
		  end if
		  
		  try
		    return updateCustomer(mergedCust)
		    
		  catch err as BookingToolkit.Exceptions.CustomerException
		    raise err
		    
		  end try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub reportError(errNum as integer, err as runtimeException, optional msg as string)
		  using UtilityFunctions
		  dim dr as new DatabaseRecord()
		  
		  if not DebugBuild then 
		    dim errorMsg as string 
		    if err <> NIl then
		      errorMsg = "EXCEPTION: " + getExceptionType(err) + ": " + err.Reason + kReturnKey + join(err.stack,EndOfLine.UNIX)
		      
		    else
		      errorMsg = "The exception passed was nil"
		      
		    end if
		    
		    dr.Column("reportingAppName") =  "EventResCustomerModule " + str(app.MajorVersion) + "." + str(app.MinorVersion) + "." + str(app.BugVersion)
		    dr.Column("errorLoggedByApp") = "MESSAGE PASSED: " + kReturnKey +_
		    "ERROR: " + str(errNum) + kReturnKey + ", " + msg + kReturnKey +_
		    "SQL STATE: " + str(mSqlServer.ErrorCode) + " " + mSqlServer.ErrorMessage + kReturnKey +_
		    errorMsg
		    
		    mSqlServer.InsertRecord("errorsForJamrozToLookAt", dr)
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub storeModification(calEvent as bookingtoolkit.CalendarEvent, theMod as BookingToolkit.Modification)
		  //@throws: BookingToolkit.Exceptions.CalEventException
		  
		  dim dr as new DatabaseRecord()
		  dr.Column("calEventSerial") = CalEvent.serial.toString()
		  dr.Column("empSerial") = theMod.getEmpSerial.toString()
		  dr.Column("notes") = theMod.getDetails()
		  
		  mSqlServer.InsertRecord("changeLog_CalendarEvents", dr)
		  
		  if mSqlServer.Error then
		    dim err as new BookingToolkit.Exceptions.CalEventException()
		    err.Reason = "Unable to insert record: " + UtilityFunctions.stringToText(mSqlServer.ErrorMessage)
		    
		    raise err
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub storeModification(res as bookingtoolkit.Reservation, theMod as BookingToolkit.Modification)
		  //@throws: BookingToolkit.Exceptions.CalEventException
		  
		  dim dr as new DatabaseRecord()
		  dr.Column("resSerial") = res.serial.toString()
		  dr.Column("empSerial") = theMod.getEmpSerial.toString()
		  dr.Column("notes") = theMod.getDetails()
		  
		  mSqlServer.InsertRecord("changeLog_Reservations", dr)
		  
		  if mSqlServer.Error then
		    dim err as new BookingToolkit.Exceptions.CalEventException()
		    err.Reason = "Unable to insert record: " + UtilityFunctions.stringToText(mSqlServer.ErrorMessage)
		    
		    raise err
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function updateCalendarEvent(cc as BookingToolkit.CalendarEvent, optional mode as BookingToolkit.UpdateBehavior = BookingToolkit.UpdateBehavior.ENFORCE_DATA_CHECK) As BookingToolkit.CalendarEvent
		  //This method provides optional enforcement of Optimistic Concurrency Control (OCC)
		  //    through the optional mode parameter.
		  //@param mode: Controls whether or not commitID is used. The default value is
		  //    ENFORCE_DATA_CHECK, meaning that commitID is checked and if found to be invalid an exception 
		  //    is thrown. You may override this behavior by passing SKIP_DATA_CHECK and forcing an update to take 
		  //    place
		  
		  //@throws: BookingToolkit.Exceptions.CalEventException
		  //@throws: BookingToolkit.Exceptions.RecordAlreadyModifiedException
		  
		  dim stmt as string =_
		  "SELECT * FROM calendarevents WHERE serial = " + cc.serial.toString()
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  if rs <> Nil then
		    if mode = BookingToolkit.UpdateBehavior.SKIP_DATA_CHECK or rs.Field("commitID").IntegerValue = cc.getCommitID() then
		      rs.edit()
		      if cc.startTime <> Nil then
		        rs.Field("starttime").StringValue = cc.startTime.format_SQL
		        
		      else
		        rs.Field("starttime").Value = nil 
		        
		      end if
		      
		      rs.field("title").StringValue = cc.title
		      rs.field("startDate").StringValue = datetoworddate(cc.startDate)
		      rs.field("endDate").StringValue = datetoworddate(cc.endDate)
		      rs.field("status").StringValue = BookingToolkit.mapStatus(cc.status)
		      rs.field("calendarSerial").StringValue = cc.calendarSerial.toString()
		      rs.field("creatorName").StringValue = cc.creatorName
		      rs.field("baseEventSerial").IntegerValue = cc.tripSpecificationSerial.toInteger()
		      rs.field("guideEmpSerial").IntegerValue = cc.guideEmpSerial.toInteger()
		      rs.field("guideSerial").IntegerValue = cc.guideEventSerial.toInteger()
		      rs.field("acceptsres").IntegerValue = convertBooleanToInteger(cc.isAcceptReservations)
		      rs.field("notes").StringValue = cc.notes
		      rs.field("rank").IntegerValue = cc.rank
		      rs.field("staffEmpSerial").IntegerValue = cc.staffEmpSerial.toInteger()
		      rs.Field("isPrivate").IntegerValue = convertBooleanToInteger(cc.isPrivate)
		      rs.field("titleNotes").StringValue = cc.titleNotes
		      
		      rs.Update()
		      
		      if not mSqlServer.Error then
		        try
		          //XXX: This is here for current compatibility with the guide pay system. Once that changes this can go
		          self.amendAssociatedEvents(cc)
		          rs =  mSqlServer.SQLSelect(stmt)
		          
		          return buildCalEventFromFullRecordSet(rs)
		          
		        catch err as Xojo.IO.IOException
		          dim ee as new BookingToolkit.Exceptions.CalEventException()
		          ee.Reason = err.Reason
		          
		          raise ee
		          
		        end try
		        
		      else
		        dim err as new BookingToolkit.Exceptions.CalEventException()
		        err.Reason = "Unable to update record: " + stringToText(mSqlServer.ErrorMessage)
		        
		        raise err
		        
		      end if
		      
		    else
		      dim err as new BookingToolkit.Exceptions.RecordAlreadyModifiedException()
		      err.UpdatedValue = buildCalEventFromFullRecordSet(rs)
		      
		      raise err 
		      
		    end if
		    
		  else
		    dim err as new BookingToolkit.Exceptions.CalEventException()
		    err.Reason = "Attempting to update a calendar event that does not exist"
		    
		    raise err
		    
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function updateCustomer(cust as BookingToolkit.Customer, optional mode as BookingToolkit.UpdateBehavior = BookingToolkit.UpdateBehavior.ENFORCE_DATA_CHECK) As BookingToolkit.Customer
		  //This method provides optional enforcement of Optimistic Concurrency Control (OCC)
		  //    through the optional mode parameter.
		  //@param mode: Controls whether or not commitID is used. The default value is
		  //    ENFORCE_DATA_CHECK, meaning that commitID is checked and if found to be invalid an exception 
		  //    is thrown. You may override this behavior by passing SKIP_DATA_CHECK and forcing an update to take 
		  //    place
		  
		  //@throws: BookingToolkit.Exceptions.CustomerException
		  //@throw: BookingToolkit.Exceptions.RecordAlreadyModifiedException
		  
		  using UtilityFunctions
		  
		  dim stmt as string =_
		  "SELECT " + kAllCustomerFieldsUsed + " FROM customers WHERE serial = " + cust.serial.toString()
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  if rs <> NIl then
		    if mode = BookingToolkit.UpdateBehavior.SKIP_DATA_CHECK or rs.field("commitID").IntegerValue = cust.getCommitID() then 
		      rs.Edit()
		      rs.field("profileID").StringValue = cust.aNetProfileID
		      rs.Field("city").StringValue = cust.city
		      rs.Field("company").StringValue = cust.company
		      rs.Field("contactdiary").StringValue = cust.contactdiary
		      rs.field("country").StringValue = cust.country
		      rs.field("disctype").StringValue = cust.disctype
		      rs.Field("email").StringValue = cust.email
		      rs.field("firstname").StringValue = cust.Name.sqlSafeFirstname
		      rs.Field("iscompany").IntegerValue = convertBooleanToInteger(cust.iscompany)
		      rs.Field("isemp").IntegerValue = convertBooleanToInteger(cust.isemp)
		      rs.field("lastname").StringValue = cust.Name.sqlSafeLastname
		      rs.field("paymentProfileID").StringValue = cust.ANetPaymentProfileID
		      rs.Field("phone").StringValue = cust.phoneNumber.getUnformattedNumber()
		      rs.Field("state").StringValue = cust.state
		      rs.field("street").StringValue = cust.street
		      rs.field("tobeinvoiced").IntegerValue = convertBooleanToInteger(cust.tobeinvoiced)
		      rs.Field("zip").StringValue = cust.zip
		      rs.Field("isEmailValidated").IntegerValue = convertBooleanToInteger(cust.isEmailVerified)
		      rs.Update()
		      
		      if not mSqlServer.error then
		        rs  = mSqlServer.SQLSelect(stmt)
		        return buildCustomerFromRecordset(rs)
		        
		      end if
		      
		    else
		      dim err as new BookingToolkit.Exceptions.RecordAlreadyModifiedException()
		      err.UpdatedValue = buildCustomerFromRecordset(rs)
		      
		      raise err 
		      
		    end if
		    
		  end if
		  
		  #Pragma BreakOnExceptions false
		  dim err as BookingToolkit.Exceptions.CustomerException = getCustomerException()
		  if InStr(err.Reason, "Duplicate") > 0 then
		    dim newError as new BookingToolkit.Exceptions.DuplicateCustomerException()
		    newError.Reason = "Customer already exists"
		    newError.ErrorNumber = 1
		    newError.originalCustomerSerial = getCustomerSerial(cust)
		    raise newError
		    
		  end if
		  
		  raise err
		  #Pragma BreakOnExceptions true 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateEmergencyContact(contact as BookingToolkit.EmergencyContact)
		  //@throws: BookingToolkit.Exceptions.NoSuchItemException
		  //!@throws: BookingToolkit.Exceptions.EmergencyContactException
		  
		  dim stmt as string = "SELECT * FROM emergencyContacts WHERE serial = " + contact.serial.toString()
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  if rs <> NIl and not rs.eof then
		    rs.Edit()
		    rs.Field("firstName").StringValue = contact.name.sqlSafeFirstname
		    rs.field("lastName").StringValue = contact.name.sqlSafeLastname
		    rs.Field("relation").StringValue = contact.relation
		    rs.Field("contactPhone").StringValue = contact.contactNumber.getUnformattedNumber()
		    
		    rs.Update()
		    
		    if mSqlServer.Error then
		      #Pragma BreakOnExceptions false
		      dim err as new BookingToolkit.Exceptions.EmergencyContactException
		      err.Reason = UtilityFunctions.stringToText(mSqlServer.ErrorMessage)
		      err.ErrorNumber = mSqlServer.ErrorCode
		      
		      raise err
		      #Pragma BreakOnExceptions true 
		      
		    end if
		    
		    return 
		    
		  end if
		  
		  #Pragma BreakOnExceptions false
		  if rs.EOF then
		    dim err as new BookingToolkit.Exceptions.NoSuchItemException()
		    raise err
		    
		  else
		    dim err as new BookingToolkit.Exceptions.RunTimeException()
		    err.Reason = UtilityFunctions.stringToText(mSqlServer.ErrorMessage)
		    err.ErrorNumber = mSqlServer.ErrorCode
		    
		    raise err
		    
		  end if
		  #Pragma BreakOnExceptions true 
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function updateReservation(resDetails as BookingToolkit.Reservation, optional mode as BookingToolkit.UpdateBehavior = BookingToolkit.UpdateBehavior.ENFORCE_DATA_CHECK) As BookingToolkit.Reservation
		  //This method provides optional enforcement of Optimistic Concurrency Control (OCC)
		  //    through the optional mode parameter.
		  //@param mode: Controls whether or not commitID is used. The default value is
		  //    ENFORCE_DATA_CHECK, meaning that commitID is checked and if found to be invalid an exception 
		  //    is thrown. You may override this behavior by passing SKIP_DATA_CHECK and forcing an update to take 
		  //    place
		  
		  //@Throws: BookingToolkit.Exceptions.ReservationException
		  //@throws: BookingToolkit.Exceptions.RecordAlreadyModifiedException
		  
		  using UtilityFunctions
		  using DateModule
		  
		  dim stmt as string =_
		  "SELECT " + kAllResFieldsUsed + " FROM reservations WHERE serial = " + resDetails.serial.toString()
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  if rs <> NIl then
		    if mode = BookingToolkit.UpdateBehavior.SKIP_DATA_CHECK or rs.Field("commitID").IntegerValue = resDetails.getCommitID() then 
		      rs.Edit()
		      rs.Field("approvingGuide").StringValue = resDetails.approvingGuide
		      rs.Field("balance").DoubleValue = resDetails.balance
		      rs.field("caleventSerial").IntegerValue = resDetails.calendarEventSerial.toInteger()
		      rs.field("consenttypedname").StringValue = resDetails.consentTypedName
		      rs.field("creator").StringValue = resDetails.creatorName
		      rs.field("creatorSerial").IntegerValue = val(resDetails.creatorSerial)
		      rs.Field("customerSerial").StringValue = resDetails.customerSerial.toString()
		      if resDetails.endDate <> Nil then 
		        rs.field("enddate").StringValue = datetoworddate(resDetails.endDate)
		        
		      end if
		      rs.field("gearres_ID").StringValue = resDetails.gearResID
		      rs.field("groupsize").IntegerValue = resDetails.groupSize
		      rs.Field("guideApprovedCanyons").StringValue = resDetails.guideApprovedCanyons
		      rs.field("hasDayAfterGear").IntegerValue = convertBooleanToInteger(resDetails.hasDayAfterGear)
		      rs.field("hotel").StringValue = resDetails.hotel
		      rs.Field("howTheyHeard").StringValue = resDetails.howTheyHeard
		      rs.field("gear_returned").IntegerValue = convertBooleanToInteger(resDetails.isGearReturned)
		      rs.field("paid").IntegerValue = convertBooleanToInteger(resDetails.isPaid)
		      rs.Field("reservationDepositRedeemed").IntegerValue = convertBooleanToInteger(resDetails.isReservationDepositRedeemed)
		      rs.Field("taxable").IntegerValue = convertBooleanToInteger(resdetails.isTaxable)
		      rs.field("notes").StringValue = resDetails.notes
		      rs.field("remittance").DoubleValue = resDetails.remittance
		      rs.field("serial").IntegerValue = resDetails.serial.toInteger()
		      if resDetails.startDate <> Nil then 
		        rs.Field("startdate").StringValue = datetoworddate(resDetails.startDate)
		        
		      end if
		      rs.field("status").StringValue = BookingToolkit.mapStatus(resDetails.status)
		      rs.Field("total").DoubleValue = resDetails.total
		      rs.Field("contactDiary").StringValue = resDetails.contactDiary
		      rs.Field("informedwhattobring").IntegerValue = convertBooleanToInteger(resDetails.isInformedWhatToBring)
		      rs.field("informedcancellationpolicy").IntegerValue= convertBooleanToInteger(resDetails.isInformedOfCancellationPolicy)
		      rs.Field("informedtimezone").IntegerValue = convertBooleanToInteger(resDetails.isInformedTimeZone)
		      rs.Field("informedpickuplocation").IntegerValue = convertBooleanToInteger(resDetails.isInformedPickupLocation)
		      rs.Field("creationMethod").StringValue = BookingToolkit.mapCreationMethod(resDetails.creationMethod)
		      
		      rs.Update()
		      
		      if not mSqlServer.error then
		        return getReservation(resDetails.serial)
		        
		      end if
		      
		    else
		      dim err as new BookingToolkit.Exceptions.RecordAlreadyModifiedException()
		      err.UpdatedValue = getReservation(resDetails.serial)
		      
		      raise err 
		      
		    end if
		    
		  end if
		  
		  #Pragma BreakOnExceptions false 
		  dim err as BookingToolkit.Exceptions.ReservationException = getReservationException()
		  raise err
		  #Pragma BreakOnExceptions true 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateResGearID(serial as SQLSerial, id as string)
		  //@throws: BookingToolkit.Exceptions.ResGearItemException
		  
		  dim stmt as string =_
		  "UPDATE resgearitems SET id = '" + id +"' WHERE serial = " + serial.toString()
		  mSqlServer.SQLExecute(stmt)
		  if mSqlServer.Error then
		    #Pragma BreakOnExceptions false
		    dim err as new BookingToolkit.Exceptions.ResGearItemException()
		    err.Reason = UtilityFunctions.stringToText(mSqlServer.ErrorMessage)
		    err.ErrorNumber = mSqlServer.ErrorCode
		    
		    raise err
		    #Pragma BreakOnExceptions true
		    
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateResGearItem(item as BookingToolkit.ResGearItem)
		  //@throws: BookingToolkit.Exceptions.ReservationException
		  
		  dim stmt as string =_
		  "SELECT " + kAllResGearItemFields + " FROM resgearitems WHERE serial = " + item.serial.toString()
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  if rs <> Nil and not rs.EOF then
		    rs.Edit()
		    rs.Field("id").StringValue = item.gearID
		    rs.Field("size").StringValue = item.gearSize
		    rs.Field("geartype").StringValue = item.gearType
		    rs.Field("needsGearId").IntegerValue = UtilityFunctions.convertBooleanToInteger(item.isTrackedByID)
		    rs.Field("qty").IntegerValue = item.qty
		    rs.Field("respartserial").StringValue = item.resPartSerial.toString()
		    rs.Field("resserial").StringValue = item.resSerial.toString()
		    rs.Field("gearTypeSerial").StringValue = item.gearTypeSerial.toString()
		    rs.field("displayInCalEvent").IntegerValue = UtilityFunctions.convertBooleanToInteger(item.isDisplayedInCalEvent)
		    
		    rs.Update()
		    
		    if not mSqlServer.Error then
		      return 
		      
		    else
		      dim err as BookingToolkit.Exceptions.ReservationException = getReservationException()
		      raise err
		      
		    end if
		    
		  end if
		  
		  dim err as new BookingToolkit.Exceptions.ResGearItemException
		  err.Reason = UtilityFunctions.stringToText(mSqlServer.ErrorMessage)
		  err.ErrorNumber = mSqlServer.ErrorCode
		  
		  raise err
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateResPart(participant as BookingToolkit.ResPart)
		  //@throws: BookingToolkit.Exceptions.RunTimeException
		  //XXX: this currently will not delete data, only change it. Do we like that?
		  
		  dim stmt as string =_
		  "SELECT " + kAllResPartFields + " FROM resparts WHERE serial = " + participant.serial.toString()
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  if rs <> Nil and not rs.EOF then
		    rs.Edit()
		    if participant.age <> 0 then
		      rs.field("age").IntegerValue = participant.age
		      
		    end if
		    
		    if participant.gender <> "" then
		      rs.Field("gender").StringValue = participant.gender
		      
		    end if
		    
		    if participant.height.totalInches <> 0 then
		      rs.field("height").IntegerValue = participant.height.totalInches
		      
		    end if
		    
		    if participant.name.fullName <> "" then
		      rs.Field("name").StringValue = participant.name.sqlSafeFirstname
		      rs.field("lastName").StringValue = participant.name.sqlSafeLastname
		      
		    end if
		    
		    rs.field("resSerial").IntegerValue = participant.resSerial.toInteger()
		    
		    if participant.weight <> 0 then
		      rs.Field("weight").IntegerValue = participant.weight
		      
		    end if
		    
		    rs.Update()
		    
		    if not mSqlServer.Error then
		      return 
		      
		    else
		      dim err as BookingToolkit.Exceptions.ReservationException = getReservationException()
		      raise err
		      
		    end if
		    
		  end if
		  
		  dim err as new BookingToolkit.Exceptions.RunTimeException()
		  err.Reason = UtilityFunctions.stringToText(mSqlServer.ErrorMessage)
		  err.ErrorNumber = mSqlServer.ErrorCode
		  
		  raise err
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateShuttleReservation(shuttleRes as BookingToolkit.ShuttleReservation)
		  //@throws: BookingToolkit.Exceptions.ReservationException
		  
		  dim stmt as string =_
		  "SELECT * FROM shuttleReservations WHERE serial = " + shuttleRes.serial.toString()
		  dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		  if rs = Nil or rs.RecordCount = 0 then
		    dim err as BookingToolkit.Exceptions.ReservationException = getReservationException()
		    
		    raise err
		    
		  end if
		  
		  rs.Edit()
		  rs.Field("calEventSerial").IntegerValue = shuttleres.calEventSerial.toInteger()
		  rs.Field("resSerial").IntegerValue = shuttleres.reservationSerial.toInteger()
		  rs.Field("returnShuttleSerial").IntegerValue = shuttleRes.returnShuttleSerial.toInteger()
		  rs.Field("isPresent").IntegerValue = UtilityFunctions.convertBooleanToInteger(shuttleRes.isPresent)
		  rs.Field("pickupLocation").StringValue = shuttleRes.pickUpLocation
		  rs.Field("dropoffLocation").StringValue = shuttleRes.dropOffLocation
		  rs.Field("seatAssignments").StringValue = shuttleRes.getSeatString()
		  
		  rs.Update()
		  
		  if mSqlServer.Error then
		    dim err as BookingToolkit.Exceptions.ReservationException = getReservationException()
		    
		    raise err
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function validateGearID(id as String, gearTypeSerial as integer) As boolean
		  //@throws: ResGearItemRetiredException
		  
		  if validateGearIDFormat(id) then
		    dim stmt as string =_
		    "SELECT status FROM rentalgearfleet WHERE gearSerial = '" + id + "' AND gearTypeSerial = " + str(gearTypeSerial)
		    dim rs as RecordSet = mSqlServer.SQLSelect(stmt)
		    if rs <> Nil and rs.RecordCount > 0 then
		      if rs.Field("status").IntegerValue <> kStatus_Retired then 
		        return true
		        
		      end if
		      
		      #Pragma BreakOnExceptions false
		      dim err as new BookingToolkit.Exceptions.ResGearItemRetiredException()
		      
		      raise err
		      #Pragma BreakOnExceptions true
		      
		    end if
		    
		  end if
		  
		  return false
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function validateGearIDFormat(id as String) As boolean
		  if id = kRetiredFlag then
		    return true
		    
		  end if 
		  
		  if id <> "" then 
		    dim searcher as new RegEx()
		    searcher.SearchPattern = "[1-4]{0,1}[A-Z]+\d+[A-Z]*"
		    dim match as RegExMatch = searcher.Search(id)
		    if match <> Nil then
		      return len(match.SubExpressionString(0)) = len(id)
		      
		    end if
		    
		  end if
		  
		  return false 
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		employees As BookingToolkit.EmployeeTable
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSqlServer As MySQLCommunityServer
	#tag EndProperty

	#tag Property, Flags = &h0
		vehicles() As BookingToolkit.Vehicle
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
	#tag EndViewBehavior
End Class
#tag EndClass
