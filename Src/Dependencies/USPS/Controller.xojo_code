#tag Class
Protected Class Controller
	#tag Method, Flags = &h0
		Sub constructor()
		  socket = new Xojo.Net.HTTPSocket()
		  AddHandler socket.pageReceived, AddressOf handlePageReceived
		  AddHandler socket.error, AddressOf handleNetworkError
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub destructor()
		  RemoveHandler socket.pagereceived, AddressOf handlePageReceived
		  RemoveHandler socket.error, AddressOf handleNetworkError
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function formatRequest(req as USPS.Request) As Text
		  dim xml as new XmlDocument()
		  
		  Dim root As XmlNode
		  root = xml.AppendChild(xml.CreateElement(req.getName()))
		  root.SetAttribute("USERID", self.userID)
		  root.AppendChild(req.toXML(xml))
		  
		  dim data as string = xml.ToString()
		  data = ReplaceAll(data, KXmlPrologue, "")
		  
		  data = data.DefineEncoding(Encodings.UTF8) 
		  
		  return UtilityFunctions.stringToText(EncodeURLComponent(data))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getLastRequest() As Text
		  return lastRequest
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub handleNetworkError(value as Xojo.Net.HTTPSocket, err as RuntimeException)
		  RaiseEvent NetworkError(err)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub handlePageReceived(value as Xojo.Net.HTTPSocket, URL as text, httpStatus as integer, content as Xojo.Core.MemoryBlock)
		  dim data as text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(content)
		  dim xml as new XmlDocument(data)
		  
		  if InStr(data, "<Error>") = 0 then
		    try
		      lastParser.parse(xml)
		      RaiseEvent ResponseReceived(lastParser)
		      
		    catch ee as USPS.ParseException
		      dim err as new USPS.ErrorResponse()
		      err.errorNumber = "500"
		      err.reason = ee.Reason
		      err.source = "Parser: " + lastRequest
		      
		      RaiseEvent Error(err) 
		      
		    end try
		    
		  else
		    RaiseEvent Error(new USPS.ErrorResponse(xml))
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub processRequest(req as USPS.Request)
		  //@throws USPS.CredentialException
		  
		  if userID <> "" and password <> "" then
		    lastRequest = req.getName()
		    lastParser = req.getResponseParser()
		    send(req)
		    
		  else
		    dim err as new USPS.CredentialException()
		    err.Reason = "No login credentials provided"
		    
		    raise err
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub send(req as USPS.Request)
		  dim message as text = "API=" + req.getAPIName() + "&" + "XML=" + formatRequest(req)
		  
		  if isSecure then
		    socket.Send("POST", kSecureEndpoint + "?" + message)
		    
		  else
		    socket.Send("POST", KStandardEndpoint + "?" + message)
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setCredentials(cred as USPS.Credentials)
		  self.userID = cred.userID
		  self.password = cred.password
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Error(error as USPS.ErrorResponse)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event NetworkError(err as RuntimeException)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ResponseReceived(response as USPS.Parser)
	#tag EndHook


	#tag Property, Flags = &h0
		isSecure As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private lastParser As USPS.Parser
	#tag EndProperty

	#tag Property, Flags = &h21
		Private lastRequest As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private password As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private socket As Xojo.Net.HTTPSocket
	#tag EndProperty

	#tag Property, Flags = &h21
		Private userID As Text
	#tag EndProperty


	#tag Constant, Name = kSearchPattern, Type = String, Dynamic = False, Default = \"\"0\"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kSecureEndpoint, Type = Text, Dynamic = False, Default = \"https://secure.shippingapis.com/ShippingAPI.dll", Scope = Private
	#tag EndConstant

	#tag Constant, Name = KStandardEndpoint, Type = Text, Dynamic = False, Default = \"http://production.shippingapis.com/ShippingAPI.dll", Scope = Private
	#tag EndConstant

	#tag Constant, Name = KXmlPrologue, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isSecure"
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
