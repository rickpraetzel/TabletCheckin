#tag Class
Protected Class SimpleLogger
	#tag Method, Flags = &h0
		Sub constructor(vNum as string, location as Xojo.IO.FolderItem, optional organizeByMonth as boolean = true)
		  //@throws: Xojo.io.IOException
		  
		  self.vNum = vNum
		  self.organizeByMonth = organizeByMonth
		  try
		    logBaseDirectory = location
		    initializeLogDiretoryStructure(logBaseDirectory)
		    initializeLogTimer()
		    
		  catch err as Xojo.IO.IOException
		    raise err
		    
		  end try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub createLogFile(location as Xojo.IO.FolderItem, value as loggable)
		  //@thorws: Xojo.IO.IOException
		  
		  try
		    dim output as Xojo.IO.TextOutputStream =_
		    Xojo.io.TextOutputStream.Create(location, Xojo.core.TextEncoding.UTF8)
		    output.WriteLine(strToText("#Version: " + vNum))
		    output.WriteLine(strToText("#Date: " + Xojo.core.Date.Now().ToText()))
		    output.WriteLine(strToText("#Fields: Time " + value.getFields()))
		    output.Close()
		    
		  catch err as Xojo.IO.IOException
		    raise err
		    
		  end try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub destructor()
		  RemoveHandler logFileTimer.Action, AddressOf handleTimerAction
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getLogFile(value as loggable) As Xojo.IO.FolderItem
		  //@throws: xojo.io.IOException
		  
		  dim logLocation as Xojo.IO.FolderItem = new Xojo.IO.FolderItem(strToText(pathToLogFIle))
		  if not logLocation.Exists then
		    initializeLogDiretoryStructure(logBaseDirectory)
		    
		  end if
		  
		  dim logFile as Xojo.IO.FolderItem = new Xojo.IO.FolderItem(strToText(pathToLogFIle + "/" + logFileName))
		  
		  try
		    if not logFile.Exists then
		      createLogFile(logFile, value)
		      
		    end if
		    
		    return logFile
		    
		  catch err as Xojo.IO.IOException
		    raise err
		    
		  end try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getPathToLogFile(location as Xojo.IO.FolderItem) As string
		  //@throws: Xojo.io.IOException
		  
		  try
		    dim ff as Xojo.IO.FolderItem = location.Child(kLogDirectoryName)
		    if not ff.Exists then
		      ff.CreateAsFolder()
		      
		    end if
		    
		    if organizeByMonth then 
		      ff = ff.Child(getYearMonth())
		      if not ff.Exists then
		        ff.CreateAsFolder()
		        
		      end if
		      
		    end if
		    
		    return ff.Path()
		    
		  catch ee as RuntimeException
		    dim err as new Xojo.IO.IOException()
		    err.Reason = "Unable to create log directory: " + ee.Reason
		    
		    raise err
		    
		  end try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getSecondsLeftInDay() As integer
		  Const kTotalSecondsInDay = 86400
		  dim currentSeconds as integer =_
		  xojo.core.date.Now.Hour * 60 * 60 +_
		  Xojo.core.date.Now.Minute * 60 +_
		  xojo.core.Date.Now.Second
		  
		  return kTotalSecondsInDay - currentSeconds
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getTimeString() As string
		  return Format(Xojo.core.Date.Now().Hour, "00") + ":" +_
		  Format(xojo.core.Date.now().Minute, "00") + ":" +_
		  Format(xojo.core.date.Now().Second, "00")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getYearMonth() As text
		  return Xojo.core.date.Now().Year.ToText() + mapMonth(Xojo.core.date.Now().Month)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub handleTimerAction(value as Timer)
		  try
		    initializeLogDiretoryStructure(logBaseDirectory)
		    setTimer()
		    
		  catch err as Xojo.IO.IOException
		    System.Log(System.LogLevelError, "Unable to write to create log: " + err.Reason)
		    
		  end try
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub initializeLogDiretoryStructure(location as Xojo.IO.FolderItem)
		  //@throws: xojo.io.IOException
		  
		  try 
		    logFileName = str(Xojo.Core.Date.Now.Year) + "-" + str(Xojo.Core.Date.Now.Month) + "-" + str(Xojo.Core.Date.Now.Day) + ".txt"
		    pathToLogFIle = getPathToLogFile(location)
		    
		  catch err as Xojo.IO.IOException
		    raise err
		    
		  end try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub initializeLogTimer()
		  logFileTimer = new Timer()
		  AddHandler logFileTimer.Action, AddressOf handleTimerAction
		  setTimer()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub log(value as loggable)
		  dim output as Xojo.IO.TextOutputStream
		  try
		    dim logFile as Xojo.IO.FolderItem = getLogFile(value)
		    output = Xojo.IO.TextOutputStream.Append(logFile, Xojo.Core.TextEncoding.UTF8)
		    output.WriteLine(strToText(getTimeString() + "  " + value.toString()))
		    output.Close()
		    
		  catch err as Xojo.IO.IOException
		    System.Log(System.LogLevelError, "Unable to write to log file: " + err.Reason)
		    
		  end try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function mapLogLevel(level as SimpleLogger.LogLevels) As Text
		  select case level
		  case SimpleLogger.LogLevels.Debug
		    return "Debug"
		    
		  case SimpleLogger.LogLevels.Warning 
		    return "Warning"
		    
		  case SimpleLogger.LogLevels.Critical
		    Return "Critical"
		    
		  end select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function mapLogLevel(level as String) As SimpleLogger.LogLevels
		  select case level
		  case "Debug"
		    return SimpleLogger.LogLevels.Debug
		    
		  case "Warning"
		    return SimpleLogger.LogLevels.Warning
		    
		  case "Critical"
		    Return SimpleLogger.LogLevels.Critical
		    
		  end select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function mapMonth(month as integer) As Text
		  select case month
		  case 1
		    return "JAN"
		    
		  case 2
		    return "FEB"
		    
		  case 3
		    return "MAR"
		    
		  case 4
		    return "APR"
		    
		  case 5
		    return "MAY"
		    
		  case 6
		    return "JUN"
		    
		  case 7
		    return "JUL"
		    
		  case 8
		    return "AUG"
		    
		  case 9
		    return "SEP"
		    
		  case 10
		    return "OCT"
		    
		  case 11
		    return "NOV"
		    
		  case 12
		    return "DEC"
		    
		  end select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub setTimer()
		  logFileTimer.Period = getSecondsLeftInDay() * 1000
		  logFileTimer.Mode = timer.ModeSingle
		  logFileTimer.Reset()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function strToText(ss as String) As Text
		  If ss.Encoding Is Nil Or Not ss.Encoding.IsValidData(ss) Then
		    ss = ss.DefineEncoding(Encodings.UTF8) 
		    
		  End If
		  
		  Return ss.ToText()
		  
		End Function
	#tag EndMethod


	#tag Note, Name = Version
		
		1.1.0
	#tag EndNote


	#tag Property, Flags = &h21
		Private logBaseDirectory As Xojo.IO.FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private logFileName As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private logFileTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private organizeByMonth As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private pathToLogFIle As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private today As Xojo.Core.Date
	#tag EndProperty

	#tag Property, Flags = &h21
		Private vNum As string
	#tag EndProperty


	#tag Constant, Name = kLogDirectoryName, Type = Text, Dynamic = False, Default = \"log", Scope = Private
	#tag EndConstant


	#tag Enum, Name = LogLevels, Type = Integer, Flags = &h0
		Debug
		  Warning
		Critical
	#tag EndEnum


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
