#tag Class
Protected Class ResPart
	#tag Method, Flags = &h0
		Sub constructor()
		  resSerial = new SQLSerial()
		  serial = new SQLSerial()
		  name = new BookingToolkit.DisplayName()
		  height = new BookingToolkit.HumanHeight()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(json as Text)
		  dim generator as Xojo.Core.Dictionary = Xojo.data.ParseJSON(json)
		  
		  age = val(generator.Value("age"))
		  gender = generator.Value("gender")
		  
		  dim hh as integer = val(generator.Value("height"))
		  height = new BookingToolkit.HumanHeight(hh)
		  
		  dim fName as string = generator.Value("firstName")
		  dim lName as string = generator.Value("lastName")
		  name = new BookingToolkit.DisplayName(fName, lName)
		  
		  dim rSer as string = generator.Value("resSerial")
		  resSerial = new SQLSerial(rSer)
		  
		  dim ser as string = generator.Value("serial")
		  serial = new SQLSerial(ser)
		  weight = val(generator.Value("weight"))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function toJSON() As Text
		  using UtilityFunctions
		  
		  dim generator as new Xojo.Core.Dictionary()
		  
		  generator.Value("age") = stringToText(age.ToText())
		  generator.Value("gender") = stringToText(gender)
		  generator.Value("height") = height.totalInches.ToText()
		  generator.Value("firstName") = stringToText(name.firstname)
		  generator.Value("lastName") = stringToText(name.lastname)
		  generator.Value("resSerial") = stringToText(resSerial.toString())
		  generator.Value("serial") = stringToText(serial.toString())
		  generator.Value("weight") = weight.ToText()
		  
		  return Xojo.Data.GenerateJSON(generator)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		age As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		gender As string
	#tag EndProperty

	#tag Property, Flags = &h0
		height As BookingToolkit.HumanHeight
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return serial.isInDatabase
			End Get
		#tag EndGetter
		isInDatabase As boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		name As BookingToolkit.DisplayName
	#tag EndProperty

	#tag Property, Flags = &h0
		personalGearItem As BookingToolkit.ResGearItem
	#tag EndProperty

	#tag Property, Flags = &h0
		resSerial As SQLSerial
	#tag EndProperty

	#tag Property, Flags = &h0
		serial As SQLSerial
	#tag EndProperty

	#tag Property, Flags = &h0
		weight As Integer
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="age"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="gender"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
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
			Name="name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="name"
			Group="Behavior"
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
			Name="weight"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
