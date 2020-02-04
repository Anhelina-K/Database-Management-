
--1.1
--booking ticket
--a)Trying to book where booking is not available: this quary handle overbooking, and does not give opportunity to buy ticket to the events which alredy passed or cancalled
IF EXISTS (SELECT * FROM Event AS x where x.eventid='E009' and x.cancelled = 0 and x.event_date >= GETDATE())
BEGIN
IF(((SELECT SUM(amount_of_tickets) FROM Booking) <= (SELECT Venue.space_capacity FROM  Venue JOIN  Event x ON ( x.venueid=Venue.venueid) WHERE x.eventid='E009')))
BEGIN
INSERT INTO Booking  (bookingNumber, booking_date, amount_of_tickets, phone,  paid, eventId)
VALUES ('AA-15', '2019-12-11', 3, '+304476543',1 , 'E009')	
END
END;

SELECT * FROM Booking WHERE Booking.bookingNumber =  'AA-15'

--b)booking ticket

IF EXISTS (SELECT * FROM Event AS x where x.eventid='E004' and x.cancelled = 0  and x.event_date >= GETDATE())
BEGIN
IF(((SELECT SUM(amount_of_tickets) FROM Booking) <= (SELECT Venue.space_capacity FROM  Venue JOIN  Event x ON ( x.venueid=Venue.venueid) WHERE x.eventid='E004')))
BEGIN
INSERT INTO Booking  (bookingNumber, booking_date, amount_of_tickets, phone, paid, eventId)
VALUES ('AA-16', '2019-12-11', 3, '+304476543',0, 'E004')	
END
END;

SELECT * FROM Booking WHERE Booking.bookingNumber =  'AA-16'

--1.2
--cancelling a ticket booking
--cancele booked one

SELECT * FROM Booking WHERE Booking.bookingNumber =  'AA-10'

DELETE FROM Booking WHERE  Booking.bookingNumber =  'AA-10' AND paid = 0;

SELECT *FROM Booking WHERE Booking.bookingNumber =  'AA-10'

----Trying to cancele paid one
SELECT *FROM Booking WHERE Booking.bookingNumber =  'AA-11'
DELETE FROM Booking WHERE  Booking.bookingNumber =  'AA-11' AND paid = 0;

--1.3
--changing the number of tickets in a booking
--Before
SELECT * FROM Booking WHERE Booking.bookingNumber =  'AA-16'
--
 IF EXISTS (SELECT * FROM Booking AS x where x.bookingNumber = 'AA-16'  and x.paid = 0  and  DATEDIFF(DAY,SYSDATETIME(),booking_date)<= 3)
BEGIN
IF(((SELECT SUM(amount_of_tickets) FROM Booking) <= (SELECT Venue.space_capacity FROM  Venue JOIN  Event x ON ( x.venueid=Venue.venueid) WHERE x.eventid='E004')))
BEGIN
UPDATE  Booking SET amount_of_tickets = (amount_of_tickets + 2) WHERE bookingNumber = 'AA-16'
END
END;
--After operation
SELECT * FROM Booking WHERE Booking.bookingNumber =  'AA-16'


--1.4
--changing the status of booking to sold when tickets are purchased
--Before
SELECT * FROM Booking WHERE Booking.bookingNumber =  'AA-16'
---
IF EXISTS (SELECT * FROM Booking where bookingNumber = 'AA-16'  and paid = 0  and  DATEDIFF(DAY,SYSDATETIME(),booking_date)<= 3)
BEGIN
UPDATE  Booking SET paid = 1  WHERE bookingNumber = 'AA-16'
END;
---After
SELECT * FROM Booking WHERE Booking.bookingNumber =  'AA-16'


--1.5
--removing the unpurchased booking from the database after 3 days from booking

DELETE FROM Booking WHERE DATEDIFF(DAY, booking_date,SYSDATETIME()) > 3 AND paid=0

SELECT * FROM Booking

--1.6
--canceling an event 
SELECT * FROM Event WHERE eventId = 'E004'
--
UPDATE Event SET cancelled = 1 WHERE eventId = 'E004'
--
SELECT * FROM Event WHERE eventId = 'E004'
--1.7
--Refunding a client in a case of a cancelling an event

SELECT Event.eventId, Booking.bookingNumber, (Booking.amount_of_tickets * Event.ticket_price) AS 'Refund', Booking.phone FROM Booking
JOIN Event ON (Booking.eventId = Event.eventId)
WHERE cancelled = 1  AND paid = 1

--Deleting the booking number after giving the refund 
DELETE FROM Booking WHERE bookingNumber='AA-05'

SELECT * FROM Booking WHERE bookingNumber='AA-05'
--2.1

--What is Ed Sheeran’s contact email?
SELECT email FROM Performer 
WHERE performerName  = 'Ed Sheeran';

--1.2
--What dance performances are coming up next month?
declare @dt date = getdate()
SELECT eventName, event_type, event_date  AS 'Next Month'  FROM Event
WHERE event_type = 'dance'  AND month(event_date  ) = datepart(MM,dateadd(mm,1, @dt))



--1.3
--3. What concerts are coming up this month?
SELECT * FROM Event
WHERE event_type = 'concert'  AND MONTH(event_date) = MONTH(GETDATE()) AND cancelled=0 ;

-- 1.4
--4. When will Saara Aalto perform in Cardiff and what are her special requests for catering?
SELECT Performer.performerName ,Event.event_date, Performer.specialRequest
FROM Event 
JOIN  Performer_On_Event ON (Performer_On_Event.eventId = Event.eventId)
JOIN Performer ON (Performer_On_Event.performerId = Performer.performerId)
WHERE performerName = 'Saara Aalto';

--1.5
--How many tickets have been sold to Riverdance's dance performance ''Riverdance 2020" that takes place on 10.7.2020?
SELECT SUM(Booking.amount_of_tickets) AS 'Tickets sold' FROM  Booking
JOIN Event ON(Event.eventId = Booking.eventId)
WHERE Event.eventName = 'Riverdance 2020' AND Booking.paid = 1;

--1.6
--How many tickets are there left for ZZ Top's4 concert on 22.1.2020?
SELECT (Venue.space_capacity -  SUM(Booking.amount_of_tickets)) AS 'tickets left'
FROM Venue
JOIN Event ON (Venue.venueId = Event.venueId)
JOIN Booking ON (Event.eventId = Booking.eventId)
WHERE Event.eventName = 'ZZ Top Tour 2020' AND Event.event_date= '2020-01-22' AND Booking.paid = 1
GROUP BY Venue.space_capacity;

--1.7
-- How much money has the Cardiff Festival Association got from sold tickets this year?
SELECT  SUM(Event.ticket_price *   Booking.amount_of_tickets) AS'Total revenue' FROM  Event
JOIN Booking ON (Event.eventId = Booking.eventId)
WHERE YEAR(Event.event_date) = YEAR(SYSDATETIME()) AND paid = 1;

--1.8
/*Which artist has sold the highest number of tickets this year. Please notice that the artist can have performed several times this year. All the artist's performances count here.*/
SELECT s.performerName, s.eventId, s.Total FROM
		(SELECT  Performer.performerName,Event.eventId, SUM (w.amount_of_tickets) AS Total FROM Performer_On_Event 
		JOIN Performer ON (Performer.performerId =Performer_On_Event.performerId)
		JOIN Event ON (Event.eventId = Performer_On_Event.eventId)
		JOIN Booking w ON (w.eventId = Event.eventId)
		WHERE Year(Event.event_date) = YEAR(SYSDATETIME())
		GROUP BY performerName, Event.eventId) s
		WHERE s.Total >= (Select Max(w.amount_of_tickets) FROM Booking w
		JOIN Event ON(Event.eventId = w.eventId)
			WHERE w.paid = 1 AND Year(Event.event_date) = YEAR(SYSDATETIME())
		)