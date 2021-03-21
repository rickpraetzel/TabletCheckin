#tag Class
Protected Class LogLineItem
Implements loggable
	#tag Method, Flags = &h0
		Sub constructor()
		  logLevel = SimpleLogger.LogLevels.Debug
		  custSerial = new SQLSerial()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getExceptionString() As string
		  if err <> Nil then
		    return getExceptionType(err) + chr(10) + "Exception Details: " + str(err.ErrorNumber) + ":" + err.Reason + chr(10) + join(err.stack,EndOfLine.UNIX)
		    
		  end if
		  
		  return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getExceptionType(err as RunTimeException) As String
		  if err <> NIl then 
		    dim tInfo as Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(err)
		    
		    return tInfo.FullName
		    
		  end if
		  
		  return "" 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getFields() As string
		  return "Log-Level  SessionID  Remote-Address  Cust-Serial  Msg  Error-Number  MySQLError  Exc" 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLogLevel() As SimpleLogger.LogLevels
		  Return logLevel
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function mapLogLevel(ll as SimpleLogger.LogLevels) As string
		  select case ll
		  case SimpleLogger.LogLevels.Critical
		    return "CRITICAL"
		    
		  case SimpleLogger.LogLevels.Debug
		    return "DEBUG"
		    
		  case SimpleLogger.LogLevels.Warning
		    return "WARNING"
		    
		  end select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function toJSON() As string
		  using UtilityFunctions
		  
		  dim generator as new Xojo.Core.Dictionary()
		  
		  generator.Value("sessionID") = stringToText(sessionID)
		  generator.Value("remoteAddress") = stringToText(remoteAddress)
		  generator.Value("custSerial") = custSerial.toInteger().ToText()
		  generator.Value("msg") = stringToText(msg)
		  generator.Value("errorNum") = errorNum.ToText()
		  generator.Value("mysqlError") = stringToText(mysqlError)
		  generator.Value("err") = stringToText(getExceptionString())
		  
		  return ReplaceAll(xojo.data.GenerateJSON(generator), "'", "")
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function toString() As string
		  // Part of the loggable interface.
		  dim ss as string
		  
		  ss = mapLogLevel(self.logLevel)
		  
		  if sessionID <> "" then 
		    ss = ss + kDelimiter + sessionID
		    
		  else
		    ss = ss + kDelimiter + kPlaceholder
		    
		  end if
		  
		  if remoteAddress <> "" then
		    ss = ss + kDelimiter + remoteAddress
		    
		  else
		    ss = ss + kDelimiter + kPlaceholder
		    
		  end if
		  
		  if custSerial <> nil then 
		    ss = ss + kDelimiter + custSerial.toString()
		    
		  else
		    ss = ss + kDelimiter + kPlaceholder
		    
		  end if
		  
		  if msg <> "" then
		    ss = ss + kDelimiter + msg
		    
		  else
		    ss = ss + kDelimiter + kPlaceholder
		    
		  end if
		  
		  ss = ss + kDelimiter + str(errorNum)
		  
		  if mysqlError <> "" then
		    ss = ss + kDelimiter + mysqlError
		    
		  else
		    ss = ss + kDelimiter + kPlaceholder
		    
		  end if
		  
		  if err <> NIl then
		    ss = ss + kDelimiter + getExceptionString()
		    
		  else
		    ss = ss + kDelimiter + kPlaceholder
		    
		  end if
		  
		  return ss
		  
		End Function
	#tag EndMethod


	#tag Note, Name = README
		This is a simple class I wrote to implement Loggable. You can create whatever class you want  as
		long as it implements that interface. For that interface, the order that the toString() method puts items
		together needs to match the order of fields returned by the getfields() method. 
		
		I picked the properties based upon internal state of the Online Reservations application. Obviously,
		you should change them to suit the needs to whatever app you are logging for. 
		 
	#tag EndNote


	#tag Property, Flags = &h0
		custSerial As SQLSerial
	#tag EndProperty

	#tag Property, Flags = &h0
		err As RuntimeException
	#tag EndProperty

	#tag Property, Flags = &h0
		errorNum As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		logLevel As SimpleLogger.LogLevels
	#tag EndProperty

	#tag Property, Flags = &h0
		msg As string
	#tag EndProperty

	#tag Property, Flags = &h0
		mysqlError As string
	#tag EndProperty

	#tag Property, Flags = &h0
		remoteAddress As string
	#tag EndProperty

	#tag Property, Flags = &h0
		sessionID As string
	#tag EndProperty


	#tag Constant, Name = kDelimiter, Type = String, Dynamic = False, Default = \"   ", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kPlaceholder, Type = String, Dynamic = False, Default = \"--", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="errorNum"
			Group="Behavior"
			Type="integer"
		#tag EndViewProperty
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
			Name="msg"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
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
		#tag ViewProperty
			Name="sessionID"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="logLevel"
			Group="Behavior"
			Type="SimpleLogger.LogLevels"
			EditorType="Enum"
			#tag EnumValues
				"0 - Debug"
				"1 - Warning"
				"2 - Critical"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="mysqlError"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="remoteAddress"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
