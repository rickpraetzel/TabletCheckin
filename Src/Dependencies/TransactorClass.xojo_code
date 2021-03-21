#tag Class
Protected Class TransactorClass
	#tag Property, Flags = &h0
		active As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		amexlast4 As string
	#tag EndProperty

	#tag Property, Flags = &h0
		cellnumber As string
	#tag EndProperty

	#tag Property, Flags = &h0
		cellprovider As string
	#tag EndProperty

	#tag Property, Flags = &h0
		checked As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Marks whether this person can handle guide commission or not
		#tag EndNote
		commissionStatus As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		ddbankname As string
	#tag EndProperty

	#tag Property, Flags = &h0
		ddblindacctnumber As string
	#tag EndProperty

	#tag Property, Flags = &h0
		directdeposit As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		dryPantPref1 As string
	#tag EndProperty

	#tag Property, Flags = &h0
		dryPantPref2 As string
	#tag EndProperty

	#tag Property, Flags = &h0
		email As string
	#tag EndProperty

	#tag Property, Flags = &h0
		empshiftserial As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		feddeductions As string
	#tag EndProperty

	#tag Property, Flags = &h0
		firstname As string
	#tag EndProperty

	#tag Property, Flags = &h0
		homeaddress As String
	#tag EndProperty

	#tag Property, Flags = &h0
		hourly As double
	#tag EndProperty

	#tag Property, Flags = &h0
		iconpic As picture
	#tag EndProperty

	#tag Property, Flags = &h0
		isaguide As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		issalaried As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		lastname As string
	#tag EndProperty

	#tag Property, Flags = &h0
		location As string
	#tag EndProperty

	#tag Property, Flags = &h0
		login As string
	#tag EndProperty

	#tag Property, Flags = &h0
		maritalstatus As string
	#tag EndProperty

	#tag Property, Flags = &h0
		name As string
	#tag EndProperty

	#tag Property, Flags = &h0
		nickname As string
	#tag EndProperty

	#tag Property, Flags = &h0
		payperiodsalary As double
	#tag EndProperty

	#tag Property, Flags = &h0
		payschedule As string
	#tag EndProperty

	#tag Property, Flags = &h0
		popupname As string
	#tag EndProperty

	#tag Property, Flags = &h0
		privileges As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			This marks an employee's work loging status
			
			0: Does not track progress
			1: Tracks progress
			2: Views progress
			3: Does both
			
			EJ 06/27/14
		#tag EndNote
		progressTracking As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		rate As double
	#tag EndProperty

	#tag Property, Flags = &h0
		receivesEquityStipend As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		serial As string
	#tag EndProperty

	#tag Property, Flags = &h0
		shifttype As string
	#tag EndProperty

	#tag Property, Flags = &h0
		SMSsetting As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		ssnumber As string
	#tag EndProperty

	#tag Property, Flags = &h0
		statedeductions As string
	#tag EndProperty

	#tag Property, Flags = &h0
		suitPref1 As string
	#tag EndProperty

	#tag Property, Flags = &h0
		suitPref2 As String
	#tag EndProperty

	#tag Property, Flags = &h0
		w4additionalwithholding As Double = 0.00
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="active"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="amexlast4"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="cellnumber"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="cellprovider"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="checked"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="commissionStatus"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ddbankname"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ddblindacctnumber"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="directdeposit"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="dryPantPref1"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="dryPantPref2"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="email"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="empshiftserial"
			Group="Behavior"
			InitialValue="0"
			Type="integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="feddeductions"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="firstname"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="homeaddress"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="hourly"
			Group="Behavior"
			InitialValue="0"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="iconpic"
			Group="Behavior"
			InitialValue="0"
			Type="picture"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isaguide"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="issalaried"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="lastname"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="location"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="login"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="maritalstatus"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="nickname"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="payperiodsalary"
			Group="Behavior"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="payschedule"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="popupname"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="privileges"
			Group="Behavior"
			InitialValue="0"
			Type="integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="progressTracking"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="rate"
			Group="Behavior"
			InitialValue="0"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="receivesEquityStipend"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="serial"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="shifttype"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SMSsetting"
			Group="Behavior"
			InitialValue="0"
			Type="integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ssnumber"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="statedeductions"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="suitPref1"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="suitPref2"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="w4additionalwithholding"
			Group="Behavior"
			InitialValue="0.00"
			Type="Double"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
