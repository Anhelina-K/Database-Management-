--Venue
INSERT INTO Venue(venueId, venueName, space_capacity ) VALUES 

('001', 'CardiffEmperium',3500), 

('002','CardiffParadise', 250); 

--Event

 
INSERT INTO Event(eventId,eventName, event_type, event_date, ticket_price,  cancelled, venueId)  VALUES 
('E001', 'EdShereen Tour 2019', 'concert','2019-12-25', 60,0, '001'), 
('E002','X-factor 2020','concert','2020-07-04', 85,0,'001'), 
('E003','Riverdance 2020','dance','2020-07-10', 55,0, '002'), 
('E004','ZZ Top Tour 2020','concert','2020-01-22', 72,0, '001'), 
('E005','Sara Aalto Tour 2020','concert','2020-08-12', 100,0, '001'), 
('E006','Rock Opera Mozart','others','2020-12-11' , 100,0, '002'), 
('E007','Le temps' ,'play','2020-09-16', 200,1, '002'),
('E009','World of Dance','dance','2020-01-04', 55,0, '002'),
('E010', 'Natalia Oureiro Tour 2019', 'concert', '2019-12-06', 100, 0, '001');



--Perfomer



INSERT INTO Performer(performerId, performerName, email, origin, phone, SpecialRequest) VALUES 

('001a','Saara Aalto' ,'saara@gmail.com','foreigner','+1-202-555-0185','vegan food'), 

('002a','Ed Sheeran','ed.sheeran@gmail.com','domestic','+1-202-555-0186','No pork'), 

('003a','Riverdance','riverdance@gmail.com','domestic','+1-202-555-0187', NULL), 

('004a','ZZ Top','dusty@hotmail.com','foreigner','+1-202-555-0188','Hamburger with salmon'), 

('007a','Natalie Ourero','Ourerp@yahoo.com','foreigner','+1-202-555-0188', NULL), 

('005a','Notre dame de paris','pierre@gmail.com' ,'foreigner','+1-202-555-0189', NULL), 

('006a','Mozart','mozart@gmail.com','foreigner','+1-202-555-0110','No pork');

--Perfomer on Event

INSERT INTO Performer_On_Event(performerId, eventId) VALUES 
('001a','E005'),
('001a','E002'),
('002a','E002'),
('002a','E001'),
('003a','E003'),
('004a','E004'),
('005a','E007'),
('006a','E006'),
('007a','E007'),
('002a','E009'),
('001a','E009'),
('003a','E009'),
('007a','E010')
--Booking
 
INSERT INTO Booking (bookingNumber, booking_date, amount_of_tickets, phone, paid, eventId)VALUES 
('AA-01' ,'2019-11-19',3, '+358-500-5553-282',1, 'E001'),
('AA-02', '2019-10-10',5,'+358-500-5553-283',1, 'E001'), 
('AA-03', '2019-07-09', 1,'+358-500-5553-284',1, 'E001'), 
('AA-04', '2019-09-01', 8,'+358-500-5553-285',1, 'E003'), 
('AA-05', '2019-08-15', 10,'+358-500-5553-286',1, 'E004'), 
('AA-06', '2019-08-27', 20,'+358-500-5553-287',1, 'E005'), 
('AA-07', '2019-11-19', 1,'+358-500-5553-288',0, 'E005'), 
('AA-08', '2019-09-07', 1,'+358-500-5553-289',1, 'E006'), 
('AA-09', '2019-10-17', 1,'+358-500-5553-270',0, 'E004'), 
('AA-10', '2019-12-12', 1,'+358-500-5553-271',0, 'E003'), 
('AA-11', '2019-12-01', 1,'+358-500-5553-272',1, 'E002'),
('AA-12', '2019-10-09', 12, '+358-500-5553-273',1, 'E010'),
('AA-13', '2019-10-09', 18, '+358-500-5553-273',1, 'E010'),
('AA-14', '2019-10-09', 250, '+358-500-5553-273',1, 'E009');