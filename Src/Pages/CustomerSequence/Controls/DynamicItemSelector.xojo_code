#tag WebPage
Begin WebContainer DynamicItemSelector
   Compatibility   =   ""
   Cursor          =   0
   Enabled         =   True
   Height          =   60
   HelpTag         =   ""
   HorizontalCenter=   0
   Index           =   -2147483648
   Left            =   0
   LockBottom      =   True
   LockHorizontal  =   True
   LockLeft        =   False
   LockRight       =   False
   LockTop         =   True
   LockVertical    =   False
   ScrollbarsVisible=   0
   Style           =   "1457729535"
   TabOrder        =   0
   Top             =   0
   VerticalCenter  =   0
   Visible         =   True
   Width           =   304
   ZIndex          =   1
   _DeclareLineRendered=   False
   _HorizontalPercent=   0.0
   _IsEmbedded     =   False
   _Locked         =   False
   _NeedsRendering =   True
   _OfficialControl=   False
   _OpenEventFired =   False
   _ShownEventFired=   False
   _VerticalPercent=   0.0
   Begin WebLabel NotListedButton
      Cursor          =   1
      Enabled         =   True
      HasFocusRing    =   False
      Height          =   45
      HelpTag         =   ""
      HorizontalCenter=   0
      Index           =   -2147483648
      Left            =   12
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      Scope           =   2
      Style           =   "1006127103"
      TabOrder        =   0
      Text            =   "I AM NOT LISTED"
      TextAlign       =   2
      Top             =   1
      VerticalCenter  =   0
      Visible         =   True
      Width           =   280
      ZIndex          =   1
      _DeclareLineRendered=   False
      _HorizontalPercent=   0.0
      _IsEmbedded     =   False
      _Locked         =   False
      _NeedsRendering =   True
      _OfficialControl=   False
      _OpenEventFired =   False
      _VerticalPercent=   0.0
   End
End
#tag EndWebPage

#tag WindowCode
	#tag Method, Flags = &h0
		Sub clearControls()
		  for each custControl as ItemSelector in dynamicControls
		    RemoveHandler custControl.Selected, WeakAddressOf handleSelected
		    custControl.Close()
		    
		  next
		  
		  Redim dynamicControls(-1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub handleSelected(cc as ItemSelector, item as variant)
		  RaiseEvent ItemSelected(item)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub loadItems(customers() as bookingtoolkit.customer)
		  const kVerticalPadding = 30
		  const kControlHeight = 60
		  const kControlWidth = 304
		  dim currentTop as integer = 1
		  dim xCoord as integer = me.Width/2 - kControlWidth/2
		  for each customer as bookingtoolkit.customer in customers
		    dim custControl as new ItemSelector(customer)
		    custControl.LockLeft = false
		    custControl.LockRight = false 
		    custControl.LockHorizontal = true
		    custControl.EmbedWithin(self, xCoord, currentTop, kControlWidth, kControlHeight)
		    AddHandler custControl.Selected, WeakAddressOf handleSelected
		    dynamicControls.Append(custControl)
		    currentTop = currentTop + kControlHeight + kVerticalPadding
		    
		  next
		  
		  
		  NotListedButton.Top = currentTop
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub loadItems(reservations() as BookingToolkit.Reservation, specs() as CalendarToolkit.TripSpecification)
		  if UBound(reservations) <> UBound(specs) then
		    session.logEntry(763572, "The amount of reservations does not match the amount of specifications passed", SimpleLogger.LogLevels.Warning)
		    return
		    
		  end if
		  
		  const kVerticalPadding = 30
		  const kControlHeight = 60
		  const kControlWidth = 304
		  dim currentTop as integer = 1
		  dim xCoord as integer = me.Width/2 - kControlWidth/2
		  for ii as integer = 0 to UBound(reservations)
		    dim mcontrol as new ItemSelector(reservations(ii), specs(ii))
		    mControl.LockLeft = false
		    mControl.LockRight = false 
		    mControl.LockHorizontal = true
		    mControl.EmbedWithin(self, xCoord, currentTop, kControlWidth, kControlHeight)
		    AddHandler mControl.Selected, WeakAddressOf handleSelected
		    dynamicControls.Append(mControl)
		    currentTop = currentTop + kControlHeight + kVerticalPadding
		    
		  next
		  
		  NotListedButton.Top = currentTop
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setDeclineText(value as string)
		  NotListedButton.Text = value
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ItemNotFound()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ItemSelected(item as variant)
	#tag EndHook


	#tag Property, Flags = &h21
		Private dynamicControls() As ItemSelector
	#tag EndProperty


#tag EndWindowCode

#tag Events NotListedButton
	#tag Event
		Sub MouseUp(X As Integer, Y As Integer, Details As REALbasic.MouseEvent)
		  RaiseEvent ItemNotFound
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Cursor"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Automatic"
			"1 - Standard Pointer"
			"2 - Finger Pointer"
			"3 - IBeam"
			"4 - Wait"
			"5 - Help"
			"6 - Arrow All Directions"
			"7 - Arrow North"
			"8 - Arrow South"
			"9 - Arrow East"
			"10 - Arrow West"
			"11 - Arrow Northeast"
			"12 - Arrow Northwest"
			"13 - Arrow Southeast"
			"14 - Arrow Southwest"
			"15 - Splitter East West"
			"16 - Splitter North South"
			"17 - Progress"
			"18 - No Drop"
			"19 - Not Allowed"
			"20 - Vertical IBeam"
			"21 - Crosshair"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Position"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HorizontalCenter"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
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
		Name="LockBottom"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockHorizontal"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockVertical"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
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
		Name="ScrollbarsVisible"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Automatic"
			"1 - Always"
			"2 - Never"
			"3 - Vertical"
			"4 - Horizontal"
		#tag EndEnumValues
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
		Name="TabOrder"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
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
	#tag ViewProperty
		Name="VerticalCenter"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Position"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ZIndex"
		Visible=false
		Group="Behavior"
		InitialValue="1"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_DeclareLineRendered"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_HorizontalPercent"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Double"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_IsEmbedded"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_Locked"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_NeedsRendering"
		Visible=false
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_OfficialControl"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_OpenEventFired"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_ShownEventFired"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_VerticalPercent"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Double"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
