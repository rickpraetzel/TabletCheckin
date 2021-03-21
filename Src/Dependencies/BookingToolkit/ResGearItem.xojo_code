#tag Class
Protected Class ResGearItem
	#tag Method, Flags = &h0
		Sub constructor()
		  resPartSerial = new SQLSerial()
		  resSerial = new SQLSerial()
		  serial = new SQLSerial() 
		  gearTypeSerial = new SQLSerial()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(json as text)
		  using UtilityFunctions
		  
		  dim generator as Xojo.Core.Dictionary
		  generator = Xojo.data.ParseJSON(json)
		  
		  gearID = generator.Value("gearID")
		  gearSize = generator.Value("gearSize")
		  gearType = generator.Value("gearType")
		  dim gtser as string = generator.Value("gearTypeSerial")
		  gearTypeSerial = new SQLSerial(gtser)
		  
		  isDisplayedInCalEvent = convertStringToBoolean(generator.Value("isDisplayedInCalEvent"))
		  isTrackedByID = convertStringToBoolean(generator.Value("isTrackedByID"))
		  qty = val(generator.Value("qty"))
		  
		  dim rpser as string = generator.Value("resPartSerial")
		  resPartSerial = new SQLSerial(rpser)
		  
		  dim rser as string = generator.Value("resSerial")
		  resSerial = new SQLSerial(rser)
		  
		  dim ser as string = generator.Value("serial")
		  serial = new SQLSerial(ser)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function toJSON() As Text
		  using UtilityFunctions
		  
		  dim generator as new Xojo.Core.Dictionary()
		  generator.Value("gearID") = stringToText(gearID)
		  generator.Value("gearSize") = stringToText(gearSize)
		  generator.Value("gearType") = stringToText(gearType)
		  generator.Value("gearTypeSerial") = stringToText(gearTypeSerial.toString())
		  generator.Value("isDisplayedInCalEvent") = stringToText(convertBooleanToText(isDisplayedInCalEvent))
		  generator.Value("isTrackedByID") = stringToText(convertBooleanToText(isTrackedByID))
		  generator.Value("qty") = qty.ToText()
		  generator.Value("resPartSerial") = stringToText(resPartSerial.toString())
		  generator.Value("resSerial") = stringToText(resSerial.toString())
		  generator.Value("serial") = stringToText(serial.toString())
		  
		  return Xojo.Data.GenerateJSON(generator)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		gearID As string
	#tag EndProperty

	#tag Property, Flags = &h0
		gearSize As string
	#tag EndProperty

	#tag Property, Flags = &h0
		gearType As string
	#tag EndProperty

	#tag Property, Flags = &h0
		gearTypeSerial As sqlserial
	#tag EndProperty

	#tag Property, Flags = &h0
		isDisplayedInCalEvent As boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return resPartSerial.isInDatabase
			End Get
		#tag EndGetter
		isForParticiapant As boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return resSerial.isInDatabase
			End Get
		#tag EndGetter
		isForReservation As boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return serial.isInDatabase
			End Get
		#tag EndGetter
		isInDatabase As boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		isTrackedByID As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		qty As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		resPartSerial As SQLSerial
	#tag EndProperty

	#tag Property, Flags = &h0
		resSerial As SQLSerial
	#tag EndProperty

	#tag Property, Flags = &h0
		serial As SQLSerial
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="gearID"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="gearSize"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="gearType"
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
			Name="isDisplayedInCalEvent"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isForParticiapant"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isForReservation"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isInDatabase"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isTrackedByID"
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
			Name="qty"
			Group="Behavior"
			Type="Integer"
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
