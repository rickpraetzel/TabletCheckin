#tag Class
Protected Class SQLSerial
	#tag Method, Flags = &h0
		Function clone() As SQLSerial
		  return new SQLSerial(serial)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor()
		  serial = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(serial as integer)
		  if serial >= 0 then 
		    self.serial = serial
		    
		  else
		    self.serial = 0
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(serial as string)
		  //@throws: UtilityFunctions.Exceptions.InvalidArgumentException
		  
		  if serial = "" then
		    self.serial = 0
		    return
		    
		  end if
		  
		  if IsNumeric(serial) then
		    if val(serial) >= 0 then
		      self.serial = val(serial)
		      
		    else
		      self.serial = 0
		      
		    end if
		    
		  else
		    #Pragma BreakOnExceptions false
		    dim err as new UtilityFunctions.Exceptions.InvalidArgumentException
		    raise err
		    #Pragma BreakOnExceptions true
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(rightSide as SQLSerial) As integer
		  if rightSide is Nil or rightSide.toInteger < self.serial then
		    return 1
		    
		  elseif rightSide.toInteger > self.serial then
		    return -1
		    
		  else
		    return 0
		    
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function toInteger() As integer
		  return serial
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function toString() As string
		  return str(serial)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function toText() As Text
		  return serial.ToText()
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if serial <> 0 then
			    return true
			    
			  end if
			  
			  return false
			End Get
		#tag EndGetter
		isInDatabase As boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private serial As Integer = 0
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
			Name="isInDatabase"
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
