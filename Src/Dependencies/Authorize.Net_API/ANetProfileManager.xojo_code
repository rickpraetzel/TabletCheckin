#tag Class
Protected Class ANetProfileManager
Inherits ANetController
	#tag Event
		Sub ResponseParsed(data as xojo.Core.Dictionary)
		  ResponseRecieved(new ProfileResponse(data)) 
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub constructor()
		  Super.Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub processRequest(theRequest as ANetProfileRequest)
		  //@Throws: UnsupportedOperationException, InvalidControllerStateException
		  if credentials <> Nil then 
		    dim jsonHead as string = theRequest.getRequestHeader()
		    dim theRequestJSON as JSONItem = theRequest.getJSON()
		    dim sendRequestBody as new JSONItem()
		    dim sendRequest as new JSONItem()
		    
		    sendRequestBody.Value(kMerchantToken) = credentials.getJson()
		    If theRequest.getCustomerID() <> "" then
		      sendRequestBody.Value("customerProfileId") = theRequest.getCustomerID()
		      
		    End If
		    
		    If theRequest.getSentinalToken() <> "" then
		      sendRequestBody.Value(theRequest.getSentinalToken()) = theRequestJSON
		      
		    End If
		    
		    if theRequest.getPaymentProfileID() <> "" then 
		      sendRequestBody.Value("customerPaymentProfileId") = theRequest.getPaymentProfileID()
		      
		    end if
		    
		    if theRequest.getValidationMode() <> "" then 
		      sendRequestBody.Value("validationMode") = theRequest.getValidationMode()
		      
		    end if
		    
		    sendRequest.Value(jsonHead) = sendRequestBody
		    try 
		      self.send(sendRequest)
		      
		    Catch err as UnsupportedOperationException
		      raise err
		      
		    end try
		    
		  else
		    raise generateCrentialsError()
		    
		  end if
		  
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ResponseRecieved(response as ProfileResponse)
	#tag EndHook


	#tag Constant, Name = kDuplicateRecordCode, Type = String, Dynamic = False, Default = \"E00039", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="isProcessingLiveRequests"
			Visible=false
			Group="Behavior"
			InitialValue="false"
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
