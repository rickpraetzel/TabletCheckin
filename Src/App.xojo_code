#tag Class
Protected Class App
Inherits WebApplication
	#tag Event
		Sub Open(args() as String)
		  if not DebugBuild then
		    call Daemonize()
		    
		  end if 
		  
		  setLogger()
		  dim sql as MySQLCommunityServer = getDatabaseConnection()
		  preferences = getPreferences(sql)
		  self.logEntry("APPLICATION START")
		  loadCalendarData(sql)
		  instantiateRefreshTimer()
		  sql.Close()
		  self.logEntry("APPLICATION STARTUP COMPLETE")
		End Sub
	#tag EndEvent

	#tag Event
		Function UnhandledException(Error As RuntimeException) As Boolean
		  self.logEntry(782569, "Unhandled exception was thrown to App", error, SimpleLogger.LogLevels.Critical)
		  break
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub alertTechnician(entry as loggable)
		  if not DebugBuild then 
		    dim cmd as string =_
		    "curl -s --user 'api:" + preferences.Lookup("emailKey", "")+ "' https://api.mailgun.net/v3/accounts.zionadventures.com/messages " +_
		    "-F from='Error Report <no-reply@accounts.zionadventures.com>' " +_
		    "-F to=technology@zionadventures.com " +_
		    "-F subject='MobiCal Error' " +_
		    "-F template='mobical_error' " +_
		    "-F h:X-Mailgun-Variables='" + entry.toJSON() + "'"
		    
		    dim ss as new Shell()
		    ss.Mode = 0
		    ss.Execute(cmd)
		    ss.Close()
		    
		  else
		    break
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getANetMerchantAuthentication() As MerchantAuthentication
		  if DebugBuild then 
		    return new MerchantAuthentication(preferences.Lookup("sandboxID", ""),_
		    preferences.Lookup("sandboxKey", ""))
		    
		  end if
		  
		  return new MerchantAuthentication(preferences.Lookup("cardNotPresentMerchantID", ""),_
		  preferences.Lookup("cardNotPresentMerchantKey", ""))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getDatabaseConnection() As MySQLCommunityServer
		  dim db as new MySQLCommunityServer()
		  db.DatabaseName = "ZacReg"
		  db.Host = "192.168.0.102"
		  if DebugBuild then
		    db.DatabaseName = "ZacTest"
		    
		  else
		    db.DatabaseName = "ZacReg"
		    
		  end if
		  
		  db.UserName = "mobical"
		  db.Password = "wh4td01ng"
		  db.port = 3306
		  
		  return db
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLineHeight(ss as WebStyle) As double
		  select case ss.Name
		  case "Title", "Subtitle"
		    return 50
		    
		  case "Body", "Body_Alert", "LinkText"
		    return 30.5
		    
		  case "HintText"
		    return 22
		    
		    
		  case "LinkText_Small"
		    return 20
		    
		  else
		    return 30
		    
		  end Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPixelsPerCharacter(ss as WebStyle) As double
		  select case ss.Name
		  case "Title", "Subtitle"
		    return 17
		    
		  case "Body", "Body_Alert", "LinkText"
		    return 10.5
		    
		  else
		    return 7
		    
		  end select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPreferences(db as MySQLCommunityServer) As Xojo.Core.Dictionary
		  self.logEntry("getting preferences from database")
		  
		  dim prefs as new Xojo.Core.Dictionary()
		  if db.Connect() then
		    dim stmt as String ="SELECT * FROM preferences_OnlineCheckin"
		    dim rs as RecordSet = db.SQLSelect(stmt)
		    if rs <> Nil then 
		      while not rs.EOF
		        prefs.Value(rs.field("preferenceName").StringValue) = rs.field("value").StringValue
		        rs.MoveNext()
		        
		      wend
		      
		    else
		      self.logEntry(198654, "Unable to load preferences: " + db.ErrorMessage, Nil, SimpleLogger.LogLevels.Critical)
		      
		    end if
		    
		  else
		    self.logEntry(198653, "Unable to load preferences: " + db.ErrorMessage, Nil, SimpleLogger.LogLevels.Critical)
		    
		  end if
		  
		  return prefs
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub handleTimerAction(tt as Timer)
		  self.logEntry("Refreshing app preferences")
		  dim sql as MySQLCommunityServer = getDatabaseConnection()
		  preferences = getPreferences(sql)
		  loadCalendarData(sql)
		  sql.Close()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub instantiateRefreshTimer()
		  self.logEntry("Creating refresh timer")
		  refreshTimer = new Timer()
		  refreshTimer.Mode = Timer.ModeMultiple
		  refreshTimer.Period = refreshPeriod
		  
		  AddHandler refreshTimer.Action, WeakAddressOf handleTimerAction
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub loadCalendarData(sql as MySQLCommunityServer)
		  self.logEntry("Loading calendar data")
		  
		  try
		    calendarData = new CalendarToolkit.Controller(sql)
		    
		  catch err as CalendarToolkit.CalRuntimeException
		    self.logEntry(764329, "Unable to load calendars", err, SimpleLogger.LogLevels.Critical)
		    
		  end try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub logEntry(errNum as integer, msg as string, optional err as RuntimeException, logLevel as SimpleLogger.LogLevels = SimpleLogger.LogLevels.Debug)
		  dim lineItem as new LogLineItem()
		  lineItem.errorNum = errNum
		  lineItem.msg = msg
		  lineItem.err = err
		  
		  if logLevel = SimpleLogger.LogLevels.Critical then
		    alertTechnician(lineItem)
		    
		  end if
		  
		  dim needsLogging as boolean = (logLevel = SimpleLogger.LogLevels.Critical or logLevel = SimpleLogger.LogLevels.Warning or isDebugMode)
		  if logger <> NIl and needsLogging then 
		    logger.log(lineItem)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub logEntry(lineitem as loggable)
		  if lineitem.getLogLevel() = SimpleLogger.LogLevels.Critical then
		    alertTechnician(lineitem)
		    
		  end if
		  
		  dim needsLogging as boolean = (lineitem.getLogLevel()= SimpleLogger.LogLevels.Critical or lineitem.getLogLevel()= SimpleLogger.LogLevels.Warning or isDebugMode)
		  if logger <> NIl and needsLogging then 
		    logger.log(lineItem)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub logEntry(msg as string, logLevel as SimpleLogger.LogLevels = SimpleLogger.LogLevels.Debug)
		  dim lineitem as new LogLineItem()
		  lineItem.msg = msg
		  
		  if logLevel = SimpleLogger.LogLevels.Critical then
		    alertTechnician(lineitem)
		    
		  end if
		  
		  dim needsLogging as boolean = (logLevel = SimpleLogger.LogLevels.Critical or logLevel = SimpleLogger.LogLevels.Warning or isDebugMode)
		  if logger <> NIl and needsLogging then 
		    logger.log(lineItem)
		    
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub setLogger()
		  dim vNum as string = str(app.MajorVersion) + "." + str(app.MinorVersion) + "." + str(app.BugVersion)
		  dim ff as Xojo.IO.FolderItem
		  
		  ff = Xojo.IO.SpecialFolder.ApplicationSupport.Child("OnlineCheckin")
		  
		  if not ff.Exists then
		    ff.CreateAsFolder()
		    
		  end if
		  
		  logger = new SimpleLogger(vNum, ff)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		calendarData As CalendarToolkit.Controller
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  if DebugBuild then
			    return true
			    
			  end if
			  
			  if preferences = Nil then
			    return false
			    
			  end if
			  
			  const kDefaultValue = "0"
			  return convertStringToBoolean(preferences.Lookup("isDebugMode", kDefaultValue))
			End Get
		#tag EndGetter
		Private isDebugMode As boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		logger As SimpleLogger
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mLogo Is Nil Then
			    Dim temp As Xojo.IO.FolderItem = xojo.io.SpecialFolder.GetResource("zacLogoRound.png")
			    dim picFile as FolderItem = new FolderItem(temp.Path, FolderItem.PathTypeShell)
			    if picFile is Nil or not picFile.Exists then
			      'self.logEntry("Unable to load image file")
			      return nil
			      
			    End If
			    
			    Try
			      mLogo = new WebPicture(100,100,Array(picFile))
			      mLogo.Filename = picFile.Name
			      mLogo.MIMEType = "image/png"
			      mLogo.Session = Nil
			      
			    Catch err As IOException
			      'self.logEntry(165341, "Unable to load " + picFile.ShellPath, err, SimpleLogger.LogLevels.Warning)
			      mLogo = Nil
			      
			    End Try
			    
			  End If
			  
			  Return mLogo
			End Get
		#tag EndGetter
		Logo As WebPicture
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mLogo As Webpicture
	#tag EndProperty

	#tag Property, Flags = &h0
		preferences As Xojo.Core.Dictionary
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  const kDefaultValue = "300"
			  dim value as string = preferences.Lookup("refreshSeconds", kDefaultValue)
			  
			  return val(value) * 1000
			End Get
		#tag EndGetter
		Private refreshPeriod As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private refreshTimer As Timer
	#tag EndProperty


	#tag Constant, Name = kDataError, Type = String, Dynamic = False, Default = \"E00003", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kDecline, Type = String, Dynamic = False, Default = \"E00027", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kDuplicateRecordCode, Type = String, Dynamic = False, Default = \"", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kExpiredError, Type = String, Dynamic = False, Default = \"E00027", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kGenericError, Type = String, Dynamic = False, Default = \"E00001", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLengthError, Type = String, Dynamic = False, Default = \"E00015", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLongestLineWidth, Type = Double, Dynamic = False, Default = \"800", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
