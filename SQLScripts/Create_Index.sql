--Indexes
CREATE NONCLUSTERED INDEX ix_FK_Event_Venue ON Event (venueId);
CREATE NONCLUSTERED INDEX ix_FK_Booking_Event ON Booking (eventId);