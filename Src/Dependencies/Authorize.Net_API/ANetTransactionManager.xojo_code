#tag Class
Protected Class ANetTransactionManager
Inherits ANetController
	#tag Event
		Sub ResponseParsed(data as xojo.Core.Dictionary)
		  ResponseRecieved(new TransactionResponse(data)) 
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub constructor()
		  Super.Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub processRequest(theRequest as ANetTransactionRequest)
		  //@Throws: UnsupportedOperationException, InvalidControllerStateException
		  
		  if credentials <> Nil then 
		    dim jsonHead as string
		    dim theRequestJSON as new JSONItem()
		    dim sendRequestBody as new JSONItem()
		    dim sendRequest as new JSONItem()
		    
		    jsonHead = theRequest.getRequestHeader()
		    theRequestJSON = theRequest.getJSON()
		    sendRequestBody.Value(kMerchantToken) = credentials.getJson()
		    sendRequestBody.Value(theRequest.getSentinalToken()) = theRequestJSON
		    
		    sendRequest.Value(theRequest.getRequestHeader()) = sendRequestBody
		    
		    try 
		      self.send(sendRequest)
		      
		    catch err as UnsupportedOperationException
		      raise err
		      
		    end try
		    
		  else
		    raise generateCrentialsError()
		    
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ResponseRecieved(response as TransactionResponse)
	#tag EndHook


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
