-- TABLE VENUE 
CREATE TABLE Venue 

(venueId CHAR(3)  NOT NULL, 

venueName VARCHAR(30) NOT NULL, 

space_capacity INTEGER NOT NULL, 

CONSTRAINT PK_Venue PRIMARY KEY (venueId),   

CONSTRAINT AK_Venue UNIQUE (venueName) 

); 

 
 -- TABLE EVENT

 CREATE TABLE Event 
( 

eventId CHAR(4) NOT NULL, 

eventName VARCHAR(30) NOT NULL, 

event_type  VARCHAR(8) NOT NULL, 

event_date DATE NOT NULL,  

ticket_price INTEGER NOT NULL, 

cancelled BIT NOT NULL,

venueId CHAR(3)  NOT NULL,  

CONSTRAINT PK_Event PRIMARY KEY (eventId), 

CONSTRAINT AK_Event UNIQUE (eventName) ,

CONSTRAINT FK_Event_Venue FOREIGN KEY (venueId) REFERENCES Venue(venueId) ON UPDATE CASCADE ON DELETE  CASCADE,
CONSTRAINT CHK_Event_event_type CHECK(event_type = 'concert' OR event_type = 'dance' OR event_type = 'play' OR event_type = 'others'),
CONSTRAINT CHK_Event_cancelled CHECK(cancelled = 1 OR cancelled = 0)

); 

-- TABLE PERFORMER
CREATE TABLE Performer 

( 

performerId CHAR(4) NOT NULL, 

performerName VARCHAR(30) NOT NULL, 

email VARCHAR(30) NOT NULL,  

origin VARCHAR(10) NOT NULL,  

phone VARCHAR(20) NOT NULL,  

SpecialRequest VARCHAR (50),


CONSTRAINT PK_Perfomer PRIMARY KEY (performerId) ,   

CONSTRAINT AK_Perfomer UNIQUE (performerName) ,

CONSTRAINT CHK_Performer_origin CHECK(origin= 'domestic' OR origin = 'foreigner') 
); 
 

 --TABLE Performer_On_Event

 CREATE TABLE Performer_On_Event
 (
performerId CHAR(4)  NOT NULL, 
eventId CHAR(4)  NOT NULL, 

CONSTRAINT PK_Performer_On_Event PRIMARY KEY (performerId, eventId),   
CONSTRAINT FK_Performer_On_Event_perfomer FOREIGN KEY(performerId) REFERENCES Performer(performerId)  ON UPDATE CASCADE ON DELETE  CASCADE,
  
CONSTRAINT FK_Performer_On_Event_event FOREIGN KEY(eventId) REFERENCES Event(eventId)  ON UPDATE CASCADE ON DELETE  CASCADE

 );

 -- TABLE Booking
 CREATE TABLE Booking 

( 

bookingNumber CHAR(5)   NOT NULL, 

booking_date DATE NOT NULL,  

amount_of_tickets INTEGER NOT NULL, 

phone VARCHAR(20) NOT NULL, 

paid BIT NOT NULL, 

eventId CHAR(4)  NOT NULL,  
 

CONSTRAINT PK_Booking PRIMARY KEY (bookingNumber), 

CONSTRAINT FK_Booking_Event FOREIGN KEY (eventId) REFERENCES Event(eventId)  ON UPDATE CASCADE ON DELETE  CASCADE,

CONSTRAINT CHK_Booking_booking_status CHECK(paid = 1 OR paid = 0)
)

