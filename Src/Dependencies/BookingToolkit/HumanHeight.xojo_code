#tag Class
Protected Class HumanHeight
	#tag Method, Flags = &h0
		Sub constructor()
		  heightInInches = 0
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(height as integer, unit as Units = Units.Inches)
		  //@throws: Xojo.Core.InvalidArgumentException
		  
		  if height >= 0 then
		    select case unit
		    case units.Inches
		      heightInInches = height
		      
		    case units.Centimeters
		      heightInInches = round(height / kInchToCM)
		      
		    end select
		    
		    return 
		    
		  end if
		  
		  #Pragma BreakOnExceptions false 
		  dim err as new Xojo.Core.InvalidArgumentException()
		  err.Reason = "Parameter height must be a positive value"
		  
		  raise err 
		  #Pragma BreakOnExceptions true 
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(height as string)
		  //@throwss: Xojo.Core.InvalidArgumentException
		  
		  if height <> "" then 
		    if validateHeightStringFormat(height) then
		      heightInInches = extractFeet(height) * 12 + extractInches(height) 
		      return 
		      
		    end if 
		    
		  else
		    heightInInches = 0
		    return
		    
		  end if
		  
		  #Pragma BreakOnExceptions False
		  dim err as new Xojo.Core.InvalidArgumentException()
		  err.Reason = "Parameter height is improperly formatted"
		  
		  raise err
		  #Pragma BreakOnExceptions true 
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function extractFeet(height as string) As Integer
		  if height <> "" and height <> "0" then 
		    return val(left(height, InStr(height, "'") - 1))
		    
		  end if
		  
		  return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function extractInches(height as string) As Integer
		  if height <> "" and height <> "0" then 
		    return val(mid(height, InStr(height, "'") + 1, len(height) - instr(height, "'") - 1))
		    
		  end if
		  
		  return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function toString() As string
		  return str(feet) + "'" + str(inches) + chr(34)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function validateHeightStringFormat(height as string) As boolean
		  dim feetLocation as integer = instr(height, "'")
		  dim inchLocation as integer = instr(height, chr(34))
		  
		  if feetLocation <> 0 and inchLocation <> 0 then 
		    if inchLocation > feetLocation then
		      if inchLocation = len(height) then 
		        if IsNumeric(ReplaceAll(ReplaceAll(height, chr(34), ""), "'", "")) then
		          return true 
		          
		        end if
		        
		      end if
		      
		    end if
		    
		  end if
		  
		  return false 
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return round(heightInInches * kInchToCM)
			End Get
		#tag EndGetter
		centimeters As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return heightInInches \ 12
			End Get
		#tag EndGetter
		feet As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private heightInInches As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return heightInInches mod 12
			End Get
		#tag EndGetter
		inches As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return heightInInches
			  
			End Get
		#tag EndGetter
		totalInches As Integer
	#tag EndComputedProperty


	#tag Constant, Name = kInchToCM, Type = Double, Dynamic = False, Default = \"2.54", Scope = Private
	#tag EndConstant


	#tag Enum, Name = Units, Type = Integer, Flags = &h0
		Inches
		Centimeters
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="centimeters"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="feet"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="inches"
			Group="Behavior"
			Type="Integer"
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
			Name="totalInches"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
