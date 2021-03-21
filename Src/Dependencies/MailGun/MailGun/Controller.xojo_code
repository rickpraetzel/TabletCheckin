#tag Class
Protected Class Controller
	#tag Method, Flags = &h0
		Sub constructor(auth as MailGun.Authentication)
		  apiEndpoint = auth.getEndpoint()
		  key = auth.getKey()
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
		Private Function getSendCommand(mail as MailGun.Email) As string
		  dim cmd as string =_
		  "curl -s --user 'api:" + key + "' " + apiEndpoint + "/" + mail.domain + "/messages " +_
		  "-F from='" + mail.sender.getFormattedAddress() + "' " +_
		  "-F to='" + mail.getRecipientsString() + "' " +_
		  "-F subject='" + mail.subject + "' " +_
		  "-F template='" + mail.templateName + "' "
		  
		  if mail.variablesJSON <> "" then 
		    cmd = cmd + "-F h:X-Mailgun-Variables='" + mail.variablesJSON + "'"
		    
		  end if
		  
		  return cmd
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub handleCompleted(ss as shell)
		  dim output as string = ss.ReadAll()
		  dim json as Text = UtilityFunctions.stringToText(output)
		  try
		    dim data as Xojo.Core.Dictionary = xojo.data.ParseJSON(json)
		    dim msg as string = data.Lookup("message", "")
		    const kSuccessMessage = "Queued. Thank you."
		    if msg <> kSuccessMessage then
		      RaiseEvent Error("Unable to send email: " + msg)
		      return
		      
		    end if
		    
		    RaiseEvent EmailSent
		    
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
		Sub send(mail as MailGun.Email)
		  if apiEndpoint = "" or key = "" then
		    RaiseEvent Error("Credentials have not been set")
		    return
		    
		  end if
		  
		  dim cmd as string = getSendCommand(mail)
		  senderShell.Execute(cmd)
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event EmailSent()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Error(msg as string)
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
