#tag Class
Protected Class EmployeeTable
	#tag Method, Flags = &h21
		Private Function buildEmployeeFromRecordSet(rs as RecordSet) As Employee
		  dim emp as new BookingToolkit.Employee()
		  
		  emp.name = new DisplayName(rs.Field("firstname").StringValue, rs.Field("lastname").StringValue)
		  emp.email1 = rs.field("email1").StringValue
		  emp.email2 = rs.field("email2").StringValue
		  emp.username = rs.field("username").StringValue
		  emp.serial = new SQLSerial(rs.field("serial").IntegerValue)
		  emp.forceReset = rs.Field("forceMobiCalReset").BooleanValue
		  emp.passwordHash = rs.field("mobiCalPassword").StringValue
		  emp.height = new HumanHeight(rs.Field("height").IntegerValue)
		  emp.weight = rs.Field("weight").IntegerValue
		  emp.phone = new PhoneNumber(rs.field("cell").StringValue)
		  emp.isActive = UtilityFunctions.convertIntToBoolean(rs.Field("status").IntegerValue)
		  emp.login = rs.Field("login").IntegerValue
		  
		  return emp
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(connection as MySQLCommunityServer)
		  //@throws: BookingToolkit.Exceptions.RunTimeException
		  
		  if not connection.Connect() then
		    dim err as new BookingToolkit.Exceptions.RunTimeException
		    err.Reason = "Unable to connect to DB"
		    
		    raise err
		    
		  end if
		  
		  loadAllEmployees(connection)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getActiveEmployee(login as integer) As BookingToolkit.Employee
		  //@Throws: NoSuchUserExcepiton
		  
		  for each emp as BookingToolkit.Employee in emps
		    if emp.login = login then
		      if not emp.isActive then
		        exit
		        
		      end if
		      
		      return emp
		      
		    end if
		    
		  next
		  
		  #Pragma BreakOnExceptions false
		  dim err as new BookingToolkit.Exceptions.NoSuchEmployeeException
		  raise err
		  #pragma BreakOnExceptions true
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getActiveEmployee(username as string) As BookingToolkit.Employee
		  //@throws: BookingToolkit.Exceptions.NoSuchEmployeeException
		  
		  if not usernameLookup.HasKey(username) or username = "" then
		    #Pragma BreakOnExceptions false
		    dim err as new BookingToolkit.Exceptions.NoSuchEmployeeException
		    raise err
		    #pragma BreakOnExceptions true
		    
		  end if 
		  
		  dim index as integer = usernameLookup.Value(username)
		  
		  return emps(index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getActiveEmployee(username as string, password as string) As BookingToolkit.Employee
		  //@throws: BookingToolkit.Exceptions.NoSuchEmployeeException
		  
		  if not usernameLookup.HasKey(username) then
		    #Pragma BreakOnExceptions false
		    dim err as new BookingToolkit.Exceptions.NoSuchEmployeeException
		    raise err
		    #pragma BreakOnExceptions true
		    
		  end if 
		  
		  dim index as integer = usernameLookup.Value(username)
		  
		  if emps(index).passwordHash <> password then
		    #Pragma BreakOnExceptions false
		    dim err as new BookingToolkit.Exceptions.NoSuchEmployeeException
		    raise err
		    #pragma BreakOnExceptions true
		    
		  end if
		  
		  return emps(index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getActiveEmployees() As BookingToolkit.Employee()
		  dim retEmployees() as BookingToolkit.Employee
		  for each emp as BookingToolkit.Employee in emps
		    if emp.isActive then
		      retEmployees.Append(emp)
		      
		    end if
		    
		  next
		  
		  return retEmployees
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getEmployee(serial as SQLSerial) As BookingToolkit.Employee
		  //@Throws: NoSuchUserExcepiton
		  
		  for each emp as BookingToolkit.Employee in emps
		    if emp.serial = serial then
		      return emp
		      
		    end if
		    
		  next
		  
		  #Pragma BreakOnExceptions false
		  dim err as new BookingToolkit.Exceptions.NoSuchEmployeeException
		  raise err
		  #pragma BreakOnExceptions true
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub loadAllEmployees(con as MySQLCommunityServer)
		  //@throws: BookingToolkit.Exceptions.IOException
		  
		  redim emps(-1)
		  dim stmt as string =_
		  "SELECT " + kEmployeeFields + " FROM employees ORDER BY popupName ASC"
		  
		  dim rs as RecordSet = con.SQLSelect(stmt)
		  
		  if rs = nil then
		    dim err as new BookingToolkit.Exceptions.RunTimeException()
		    err.Reason = UtilityFunctions.stringToText("Unable to access database: " +  con.ErrorMessage)
		    
		    raise err
		    
		  end if
		  
		  usernameLookup = new Xojo.Core.Dictionary()
		  while not rs.EOF
		    dim emp as bookingtoolkit.Employee = buildEmployeeFromRecordSet(rs)
		    emps.Append(emp)
		    if emp.username <> "" then 
		      usernameLookup.Value(emp.username) = UBound(emps)
		      
		    end if
		    
		    rs.MoveNext()
		    
		  wend
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		emps() As BookingToolkit.Employee
	#tag EndProperty

	#tag Property, Flags = &h21
		Private usernameLookup As Xojo.Core.Dictionary
	#tag EndProperty


	#tag Constant, Name = kEmployeeFields, Type = String, Dynamic = False, Default = \"serial\x2Cfirstname\x2Clastname\x2Ccell\x2Cemail1\x2Cemail2\x2Cheight\x2Cweight\x2CmobiCalPassword\x2CforceMobiCalReset\x2Cstatus\x2Clogin\x2Cusername", Scope = Private
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
