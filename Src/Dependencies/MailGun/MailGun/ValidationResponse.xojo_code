#tag Class
Protected Class ValidationResponse
	#tag Method, Flags = &h0
		Sub constructor(responseJSON as string)
		  //@throws: xojo.data.InvalidJSONException
		  
		  response = new Xojo.Core.Dictionary()
		  dim json as Text = UtilityFunctions.stringToText(responseJSON)
		  
		  try
		    response = xojo.data.ParseJSON(json)
		    
		  catch err as Xojo.Data.InvalidJSONException
		    raise err
		    
		  end try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function convertAutoArrayToStringArray(vv() as Auto) As string()
		  dim retValue() as string
		  for each value as string in vv
		    retValue.Append(value)
		    
		  next
		  
		  return retValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getAddress() As string
		  return response.Lookup("address", "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getAlternative() As string
		  return response.Lookup("did_you_mean", "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getReasons() As string()
		  dim emptyArray() as Auto
		  dim reasons() as Auto = response.Lookup("reason", emptyArray)
		  
		  return convertAutoArrayToStringArray(reasons)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getResult() As string
		  return response.Lookup("result", "undeliverable")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getRisk() As string
		  return response.Lookup("risk", "unknown")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isValidAddress() As boolean
		  const kSuccessIndicater = "deliverable"
		  return getResult() = kSuccessIndicater
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private response As Xojo.Core.Dictionary
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
