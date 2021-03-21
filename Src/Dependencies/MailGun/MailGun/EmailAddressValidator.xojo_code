#tag Class
Protected Class EmailAddressValidator
	#tag Method, Flags = &h0
		Sub constructor()
		  instantiateShell()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub destructor()
		  senderShell.Close()
		  RemoveHandler senderShell.completed, WeakAddressOf handleCompleted
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function extactResponseJSON(shellResponse as String) As Text
		  dim startPosition as integer = InStr(shellResponse, "{")
		  dim charCountDesired as integer = len(shellResponse) - startPosition + 1
		  dim json as string = Right(shellResponse, charCountDesired)
		  
		  return UtilityFunctions.stringToText(json) 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub handleCompleted(ss as shell)
		  dim output as string = ss.ReadAll()
		  
		  if instr(output, "{") = 0 or instr(output, "}") = 0 then
		    return
		    
		  end if
		  
		  dim json as Text = extactResponseJSON(output)
		  try
		    dim response as new MailGun.ValidationResponse(json)
		    RaiseEvent ValidationComplete(response)
		    
		  catch err as Xojo.Data.InvalidJSONException
		    RaiseEvent Error("There was an error parsing the response" + err.reason)
		    
		  end try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub instantiateShell()
		  senderShell = new Shell()
		  senderShell.Mode = 1
		  AddHandler senderShell.completed, WeakAddressOf handleCompleted
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setCredentials(creds as MailGun.Authentication)
		  self.key = creds.getKey()
		  self.apiEndpoint = creds.getEndpoint()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub validateEmailAddress(address as string)
		  if key = "" or apiEndpoint = "" then
		    RaiseEvent Error("Credentials have not been set")
		    return
		    
		  end if
		  
		  dim cmd as string = "curl -G --user 'api:" + key + "' -G " +_
		  apiEndpoint + " " +_
		  "--data-urlencode address='" + address + "'"
		  
		  senderShell.Execute(cmd)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Error(msg as string)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ValidationComplete(response as MailGun.ValidationResponse)
	#tag EndHook


	#tag Property, Flags = &h21
		Private apiEndpoint As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private key As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private senderShell As Shell
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
