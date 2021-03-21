#tag Class
Protected Class Shuttle
	#tag Method, Flags = &h0
		Sub addReservation(ss as BookingToolkit.ShuttleReservation)
		  reservations.Value(ss.reservationSerial.toInteger()) = ss
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor()
		  reservations = new Xojo.Core.Dictionary()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getAssignedSeats() As string()
		  dim ss as BookingToolkit.ShuttleReservation
		  dim assignedSeats() as string
		  for each entry as Xojo.Core.DictionaryEntry in reservations
		    ss = entry.Value
		    for each seat as string in ss.seats
		      assignedSeats.Append(seat)
		      
		    next
		    
		  next
		  
		  return assignedSeats
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getReservationCount() As integer
		  return reservations.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getShuttleReservation(res as BookingToolkit.Reservation) As BookingToolkit.ShuttleReservation
		  if not reservations.HasKey(res.serial.toInteger()) then
		    dim shuttleRes as new BookingToolkit.ShuttleReservation()
		    shuttleRes.reservationSerial = res.serial
		    shuttleres.calEventSerial = res.calendarEventSerial
		    
		    return shuttleRes
		    
		  end if
		  
		  return reservations.Value(res.serial.toInteger())
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub removeReservation(res as BookingToolkit.Reservation)
		  if not Reservations.HasKey(res.serial.toInteger()) then
		    return
		    
		  end if
		  
		  reservations.Remove(res.serial.toInteger())
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private reservations As Xojo.Core.Dictionary
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
