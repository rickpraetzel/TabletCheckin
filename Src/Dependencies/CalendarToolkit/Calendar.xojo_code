#tag Class
Protected Class Calendar
Implements ViewOrderable
	#tag Method, Flags = &h0
		Sub constructor()
		  self.acceptsReservations = false
		  self.fillColor = &c000000
		  self.name = ""
		  self.serial = new SQLSerial()
		  self.useRank = false
		  self.viewOrder = 0
		  self.getsLocationAudit = false
		  self.isQualifiedForBreadth = false
		  self.autoContructTitle = false
		  self.mIsActive = false
		  self.participantCountMode = CalendarToolkit.CountModes.NONE
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(builder as CalendarToolkit.CalendarBuilder)
		  self.acceptsReservations = builder.acceptsReservations
		  self.fillColor = builder.fillColor
		  self.name = builder.name
		  self.serial = builder.serial
		  self.useRank = builder.useRank
		  self.viewOrder = builder.viewOrder
		  self.getsLocationAudit = builder.getsLocationAudit
		  self.isQualifiedForBreadth = builder.isQualifiedForBreadth
		  self.autoContructTitle = builder.autoContructTitle
		  self.mIsActive = builder.mIsActive
		  self.participantCountMode = builder.participantCountMode
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getColor() As color
		  return fillColor
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getName() As string
		  return name
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getParticipantCountMode() As CalendarToolkit.CountModes
		  return participantCountMode
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getSerial() As sqlSerial
		  return serial.clone()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getViewOrder() As integer
		  return viewOrder
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isAcceptingRes() As boolean
		  return acceptsReservations
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isActive() As boolean
		  return mIsActive
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isAutoConstructTitles() As boolean
		  return autoContructTitle
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isBreadthIncentive() As boolean
		  return isQualifiedForBreadth
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isLocationAudited() As boolean
		  return getsLocationAudit
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isUseRank() As boolean
		  return useRank
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private acceptsReservations As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private autoContructTitle As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fillColor As color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private getsLocationAudit As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private isQualifiedForBreadth As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsActive As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private name As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private participantCountMode As CalendarToolkit.CountModes
	#tag EndProperty

	#tag Property, Flags = &h21
		Private serial As sqlSerial
	#tag EndProperty

	#tag Property, Flags = &h21
		Private useRank As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private viewOrder As Integer
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="name"
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
