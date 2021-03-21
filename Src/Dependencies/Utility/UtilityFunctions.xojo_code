#tag Module
Protected Module UtilityFunctions
	#tag Method, Flags = &h0
		Function convertBooleanToInteger(value as boolean) As integer
		  if value then
		    return 1
		    
		  else
		    return 0
		    
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function convertBooleanToText(value as boolean) As Text
		  if value then
		    return "1"
		    
		  else
		    return "0"
		    
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function convertIntToBoolean(value as integer) As boolean
		  if value = 1 then 
		    return true
		    
		  elseif value = 0 then 
		    return false 
		    
		  end if
		  
		  #Pragma BreakOnExceptions false
		  dim err as xojo.Core.InvalidArgumentException
		  err.Reason = "Unknown value passed"
		  err.ErrorNumber = 1
		  
		  raise err 
		  #Pragma BreakOnExceptions true 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function convertStringToBoolean(value as string) As boolean
		  if value = "1" then 
		    return true
		    
		  elseif value = "0" then 
		    return false 
		    
		  end if
		  
		  #Pragma BreakOnExceptions false
		  dim err as xojo.Core.InvalidArgumentException
		  err.Reason = "Unknown value passed"
		  err.ErrorNumber = 1
		  
		  raise err 
		  #Pragma BreakOnExceptions true 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getExceptionType(err as RunTimeException) As String
		  if err <> NIl then 
		    dim tInfo as Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(err)
		    
		    return tInfo.FullName
		    
		  end if
		  
		  return "" 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getMaxSerial(db as MySQLCommunityServer, tableName as string) As SQLSerial
		  if db <> Nil and db.Connect() then
		    dim stmt as string =_
		    "SELECT MAX(serial) AS ser FROM " + tableName
		    dim rs as recordset = db.SQLSelect(stmt)
		    if rs <> Nil then
		      return new SQLSerial(rs.Field("ser").IntegerValue)
		      
		    else
		      #Pragma BreakOnExceptions false
		      dim err as new xojo.Core.InvalidArgumentException
		      err.Message = "Unknown table name passed"
		      err.ErrorNumber = 2
		      raise err
		      #Pragma BreakOnExceptions true
		      
		    end if
		    
		  else
		    #Pragma BreakOnExceptions false
		    dim err as new xojo.Core.InvalidArgumentException
		    err.Message = "Invalid database passed"
		    err.ErrorNumber = 1
		    raise err
		    #Pragma BreakOnExceptions true
		    
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getUniqueTime() As string
		  dim d as Xojo.Core.Date = Xojo.Core.Date.Now
		  return str(d.year) + str(d.month) + str(d.day) + str(d.hour) + str(d.minute) + str(d.Second) + str(d.Nanosecond)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function inchesToFeetString(inches as Integer) As String
		  return str(inches \ 12) + "'" + str(inches MOD 12) + "''"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function join(extends serials() as SQLSerial, delimiter as string) As string
		  dim retString as string
		  for ii as integer = 0 to UBound(serials)
		    if ii <> 0 then
		      retString = retString + delimiter + serials(ii).toString()
		      
		    else
		      retString = serials(ii).toText()
		      
		    end if
		    
		  next
		  
		  return retString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function stringToText(ss as String) As Text
		  If ss.Encoding Is Nil Or Not ss.Encoding.IsValidData(ss) Then
		    ss = ss.DefineEncoding(Encodings.UTF8) 
		    
		  End If
		  
		  Return ss.ToText()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function toSQLSerialArray(extends value as string, delimiter as string) As SQLSerial()
		  //@throws: UtilityFunctions.Exceptions.InvalidArgumentException
		  
		  dim serials() as SQLSerial
		  dim values() as string = value.Split(delimiter)
		  for ii as integer = 0 to UBound(values)
		    try
		      serials.Append(new SQLserial(values(ii)))
		      
		    catch err as Xojo.Core.InvalidArgumentException
		      #Pragma BreakOnExceptions false
		      dim ee as new UtilityFunctions.Exceptions.InvalidArgumentException()
		      ee.Reason = err.Reason
		      
		      raise ee
		      #Pragma BreakOnExceptions true
		      
		    end try
		    
		  next
		  
		  return serials 
		End Function
	#tag EndMethod


	#tag Note, Name = Verison
		6.0.0
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return stringToText(chr(8))
			End Get
		#tag EndGetter
		kBackspaceKey As Text
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return stringToText(chr(34))
			End Get
		#tag EndGetter
		kDoubleQuoteCharacter As Text
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return stringToText(chr(31))
			End Get
		#tag EndGetter
		kDownArrowKey As Text
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return stringToText(chr(3))
			End Get
		#tag EndGetter
		kEnterKey As Text
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return stringToText(chr(27))
			End Get
		#tag EndGetter
		kEscKey As Text
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return stringToText(chr(28))
			End Get
		#tag EndGetter
		kLeftArrowKey As Text
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return stringToText(chr(10))
			End Get
		#tag EndGetter
		kNewLineKey As Text
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return stringToText(chr(13))
			End Get
		#tag EndGetter
		kReturnKey As Text
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return stringToText(chr(29))
			End Get
		#tag EndGetter
		kRightArrowKey As Text
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return stringToText(chr(9))
			End Get
		#tag EndGetter
		kTabKey As Text
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return stringToText(chr(30))
			End Get
		#tag EndGetter
		kUpArrowKey As Text
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="kBackspaceKey"
			Group="Behavior"
			Type="Text"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="kDoubleQuoteCharacter"
			Group="Behavior"
			Type="Text"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="kDownArrowKey"
			Group="Behavior"
			Type="Text"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="kEnterKey"
			Group="Behavior"
			Type="Text"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="kEscKey"
			Group="Behavior"
			Type="Text"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="kLeftArrowKey"
			Group="Behavior"
			Type="Text"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="kNewLineKey"
			Group="Behavior"
			Type="Text"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="kReturnKey"
			Group="Behavior"
			Type="Text"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="kRightArrowKey"
			Group="Behavior"
			Type="Text"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="kTabKey"
			Group="Behavior"
			Type="Text"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="kUpArrowKey"
			Group="Behavior"
			Type="Text"
			EditorType="MultiLineEditor"
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
End Module
#tag EndModule
