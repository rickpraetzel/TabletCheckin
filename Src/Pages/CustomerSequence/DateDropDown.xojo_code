#tag WebPage
Begin WebDialog DateDropDown
   Compatibility   =   ""
   Cursor          =   0
   Enabled         =   True
   Height          =   230
   HelpTag         =   ""
   HorizontalCenter=   0
   Index           =   0
   Left            =   0
   LockBottom      =   False
   LockHorizontal  =   False
   LockLeft        =   False
   LockRight       =   False
   LockTop         =   False
   LockVertical    =   False
   MinHeight       =   230
   MinWidth        =   245
   Resizable       =   False
   Style           =   "1457729535"
   TabOrder        =   0
   Title           =   "Untitled"
   Top             =   0
   Type            =   1
   VerticalCenter  =   0
   Visible         =   True
   Width           =   245
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
   Begin WebPopupMenu PopupMenu1
      Cursor          =   0
      Enabled         =   True
      Height          =   30
      HelpTag         =   ""
      HorizontalCenter=   0
      Index           =   -2147483648
      InitialValue    =   ""
      Left            =   20
      ListCount       =   0
      ListIndex       =   -1
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Scope           =   0
      Style           =   "379322367"
      TabOrder        =   0
      Text            =   ""
      Top             =   60
      VerticalCenter  =   0
      Visible         =   True
      Width           =   205
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
   Begin WebPopupMenu PopupMenu2
      Cursor          =   0
      Enabled         =   True
      Height          =   30
      HelpTag         =   ""
      HorizontalCenter=   0
      Index           =   -2147483648
      InitialValue    =   ""
      Left            =   20
      ListCount       =   0
      ListIndex       =   -1
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Scope           =   0
      Style           =   "379322367"
      TabOrder        =   0
      Text            =   ""
      Top             =   105
      VerticalCenter  =   0
      Visible         =   True
      Width           =   205
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
   Begin WebPopupMenu PopupMenu3
      Cursor          =   0
      Enabled         =   True
      Height          =   30
      HelpTag         =   ""
      HorizontalCenter=   0
      Index           =   -2147483648
      InitialValue    =   ""
      Left            =   20
      ListCount       =   0
      ListIndex       =   -1
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Scope           =   0
      Style           =   "379322367"
      TabOrder        =   0
      Text            =   ""
      Top             =   15
      VerticalCenter  =   0
      Visible         =   True
      Width           =   205
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
   Begin WebLabel Label1
      Cursor          =   1
      Enabled         =   True
      HasFocusRing    =   True
      Height          =   45
      HelpTag         =   ""
      HorizontalCenter=   0
      Index           =   -2147483648
      Left            =   15
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      Scope           =   2
      Style           =   "1006127103"
      TabOrder        =   2
      Text            =   "CANCEL"
      TextAlign       =   2
      Top             =   165
      VerticalCenter  =   0
      Visible         =   True
      Width           =   105
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
   Begin WebLabel Label2
      Cursor          =   1
      Enabled         =   True
      HasFocusRing    =   True
      Height          =   45
      HelpTag         =   ""
      HorizontalCenter=   0
      Index           =   -2147483648
      Left            =   125
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      Scope           =   2
      Style           =   "610942975"
      TabOrder        =   2
      Text            =   "SUBMIT"
      TextAlign       =   2
      Top             =   165
      VerticalCenter  =   0
      Visible         =   True
      Width           =   100
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
	#tag Event
		Sub Open()
		  self.mDate = new date()
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub loadDropDowns()
		  //Populates contents of the drop down 
		  
		  dim d as new date()
		  
		  //Populate months
		  self.PopupMenu1.DeleteAllRows()
		  self.popupmenu1.addrow("January")
		  self.popupmenu1.addrow("February")
		  self.popupmenu1.addrow("March")
		  self.popupmenu1.addrow("April")
		  self.popupmenu1.addrow("May")
		  self.popupmenu1.addrow("June")
		  self.popupmenu1.addrow("July")
		  self.popupmenu1.addrow("August")
		  self.popupmenu1.addrow("September")
		  self.popupmenu1.addrow("October")
		  self.popupmenu1.addrow("November")
		  self.popupmenu1.addrow("December")
		  
		  for ii as integer = 0 to self.popupmenu1.ListCount - 1
		    self.popupmenu1.RowTag(ii) = str(ii + 1)
		    
		  next
		  
		  //Populate years
		  self.PopupMenu3.DeleteAllRows()
		  self.PopupMenu3.AddRow(str(d.Year))
		  self.PopupMenu3.AddRow(Str(d.year + 1))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub show(optional thedate as Xojo.Core.Date)
		  //Overriddenshow. Initialize to a day
		  //@param theDate: [OPTIONAL] The date to initialize to
		  
		  dim theDay,theMonth,theYear as string
		  
		  self.loadDropDowns()
		  
		  if theDate <> Nil then
		    theDay = str(thedate.Day)
		    theMonth = str(theDate.Month)
		    theYear = str(theDate.Year)
		    
		  else
		    //Init to today
		    dim d as new date()
		    
		    theDay = str(d.Day)
		    theMonth = str(d.Month)
		    theYear = str(d.Year)
		    
		  end if 
		  
		  //MATCH YEAR
		  for ii as integer = 0 to self.PopupMenu3.ListCount - 1
		    if self.PopupMenu3.List(ii) = theYear then
		      self.PopupMenu3.ListIndex = ii
		      exit
		      
		    end if 
		    
		  next
		  
		  //MATCH MONTH
		  for ii as integer = 0 to self.PopupMenu1.ListCount - 1
		    if self.PopupMenu1.RowTag(ii) = theMonth then
		      self.PopupMenu1.ListIndex = ii
		      exit
		      
		    end if 
		    
		  next
		  
		  //MATCH DAY
		  for ii as integer = 0 to self.PopupMenu2.ListCount - 1
		    if self.PopupMenu2.RowTag(ii) = theDay then
		      self.PopupMenu2.ListIndex = ii
		      exit
		      
		    end if
		    
		  next
		  
		  super.Show()
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event dateSelected(theDate as Xojo.Core.Date)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mDate As Date
	#tag EndProperty


#tag EndWindowCode

#tag Events PopupMenu1
	#tag Event
		Sub SelectionChanged()
		  dim d as new date()
		  dim theUbound,temp as integer
		  
		  if me.ListIndex <> -1 then 
		    //Set stored month
		    temp = val(me.RowTag(me.ListIndex))
		    self.mDate.Month = temp
		    
		    
		    //Get total num days in month
		    select case me.Text
		    case "November", "September", "June", "April"
		      theUbound = 30
		      
		    case "February"
		      if d.Year mod 4 = 0 then
		        if d.Year mod 100 = 0 then 
		          if d.year mod 400 = 0 then
		            theUbound = 29
		            
		          else
		            theUbound = 28
		            
		          end if
		          
		        else
		          theUbound = 29
		          
		        end if
		        
		      else
		        theUbound = 28
		        
		      end if 
		      
		    else
		      theUbound = 31
		      
		    end Select
		    
		    //Populate days of month 
		    self.PopupMenu2.DeleteAllRows()
		    d.Month = me.RowTag(me.ListIndex)
		    for ii as integer = 1 to theUBound
		      d.day = ii
		      self.PopupMenu2.AddRow(datetodayofweek(d) + " - " + str(ii))
		      self.PopupMenu2.RowTag(ii - 1) = str(ii)
		      
		    next
		    
		  end if 
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PopupMenu2
	#tag Event
		Sub SelectionChanged()
		  if me.ListIndex <> -1 then 
		    dim temp as Integer
		    
		    //Update stored day
		    temp = val(me.RowTag(me.ListIndex))
		    self.mDate.Day = temp
		    
		  end if 
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PopupMenu3
	#tag Event
		Sub SelectionChanged()
		  dim temp as integer
		  
		  temp = val(me.Text)
		  self.mDate.Year = temp
		  self.mDate.Year = temp //XXX: THIS WAS ADDED BC 1ST CALL WAS NOT SETTING DATE, STRANGE XOJO BUG
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Label1
	#tag Event
		Sub MouseUp(X As Integer, Y As Integer, Details As REALbasic.MouseEvent)
		  self.Close()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Label2
	#tag Event
		Sub MouseUp(X As Integer, Y As Integer, Details As REALbasic.MouseEvent)
		  if xojo.core.date.now().compareTo(mDate.toCoreDate()) = 1 then
		    MsgBox "Return date can not be in the past"
		    return
		    
		  end if
		  
		  RaiseEvent dateSelected(mDate.toCoreDate())
		  self.Close()
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
		Group="Behavior"
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
		Visible=false
		Group="ID"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=false
		Group="Position"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockHorizontal"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockVertical"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Minimum Size"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Minimum Size"
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
		Name="Resizable"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
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
		Name="TabOrder"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Behavior"
		InitialValue="Untitled"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=false
		Group="Position"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Behavior"
		InitialValue="1"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"1 - Sheet"
			"2 - Palette"
			"3 - Modal"
		#tag EndEnumValues
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
		Visible=false
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Behavior"
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
