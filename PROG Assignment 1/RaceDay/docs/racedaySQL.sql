CREATE DATABASE RACEDAYDBS;

CREATE TABLE USERS(
userID VARCHAR(20) NOT NULL PRIMARY KEY,
email VARCHAR(50) NOT NULL UNIQUE,
passwordHash VARCHAR(255) NOT NULL,
role VARCHAR(50) NOT NULL DEFAULT 'Participant'
CHECK (role = 'Organiser'OR role = 'Participant'));

CREATE TABLE PARTICIPANT(
participantID VARCHAR(20) NOT NULL PRIMARY KEY,
userID VARCHAR(20) NOT NULL UNIQUE,
name VARCHAR(50) NOT NULL,
surname VARCHAR(50),
FOREIGN KEY (userID) REFERENCES USERS(userID));

CREATE TABLE ORGANISER(
organiserID VARCHAR(20) NOT NULL PRIMARY KEY,
userID VARCHAR(20) NOT NULL UNIQUE,
organiser_Name VARCHAR(50) NOT NULL,
phone_Number VARCHAR(20) NOT NULL,
address VARCHAR(255) NOT NULL,
FOREIGN KEY (userID) REFERENCES USERS(userID));

CREATE TABLE TOWN(
townID VARCHAR(20) NOT NULL PRIMARY KEY,
town_Name VARCHAR(100) NOT NULL,
province VARCHAR(100) NOT NULL,
postal_Code VARCHAR(20) NOT NULL);

CREATE TABLE EVENT(
eventID VARCHAR(20) NOT NULL PRIMARY KEY,
organiserID VARCHAR(20) NOT NULL,
townID VARCHAR(20) NOT NULL,
event_Name VARCHAR(50) NOT NULL,
description VARCHAR(255) NOT NULL,
event_Date DATE NOT NULL,
event_Type VARCHAR (30) NOT NULL,
venue VARCHAR(30) NOT NULL,
race_Distance VARCHAR(50) NOT NULL,
FOREIGN KEY (organiserID) REFERENCES ORGANISER (organiserID),
FOREIGN KEY (townID) REFERENCES TOWN (townID));

CREATE TABLE CATEGORY(
categoryID VARCHAR(20) NOT NULL PRIMARY KEY,
category_Name VARCHAR(50) NOT NULL,
description VARCHAR(255) NOT NULL);

CREATE TABLE EVENTCATEGORY(
eventCategoryID VARCHAR(20) NOT NULL PRIMARY KEY,
eventID VARCHAR(20) NOT NULL,
categoryID VARCHAR(20) NOT NULL,
FOREIGN KEY (eventID) REFERENCES EVENT(eventID),
FOREIGN KEY (categoryID) REFERENCES CATEGORY(categoryID));

CREATE TABLE ROUTE(
routeID VARCHAR(20) NOT NULL PRIMARY KEY,
eventID VARCHAR(20) NOT NULL,
route_Name VARCHAR(50) NOT NULL,
route_Description VARCHAR(255) NOT NULL,
mapURL VARCHAR(255) NOT NULL,
FOREIGN KEY (eventID) REFERENCES EVENT(eventID));

CREATE TABLE ENROLMENT(
enrolmentID VARCHAR(20) NOT NULL PRIMARY KEY,
participantID VARCHAR(20) NOT NULL,
eventCategoryID VARCHAR(20) NOT NULL,
enrolment_Date VARCHAR(20) NOT NULL
FOREIGN KEY (participantID) REFERENCES PARTICIPANT(participantID),
FOREIGN KEY (eventCategoryID) REFERENCES EVENTCATEGORY(eventCategoryID));
 
CREATE TABLE RESULT(
resultID VARCHAR(20) NOT NULL PRIMARY KEY,
enrolmentID VARCHAR(20) NOT NULL,
finish_Time TIME NOT NULL,
distance SMALLINT NOT NULL,
completionStatus VARCHAR(50) NOT NULL,
position SMALLINT NOT NULL,
FOREIGN KEY (enrolmentID) REFERENCES ENROLMENT(enrolmentID));

INSERT INTO USERS (userID,email,passwordHash,role)
VALUES 
('U001','thabomokoena@gmail.com','thaboooooo009','Participant'),
('U002','leratodlamini@gmail.com','lerato2@01','Participant'),
('U003','johanvanwyk@gmail.com','mrVan@wyk','Organiser'),
('U004','ayandandlovu@gmail.com','ayaNdlovu@00','Organiser');

INSERT INTO ORGANISER (organiserID, userID, organiser_Name, phone_Number, address)
VALUES
('O001', 'U003', 'Johan van Wyk', '+27825550147', 'Stellenbosch, Western Cape'),
('O002', 'U004', 'Ayanda Ndlovu','+27834440298', 'Durban, KwaZulu-Natal');

INSERT INTO PARTICIPANT (participantID, userID, name, surname)
VALUES
('P001', 'U001', 'Thabo', 'Mokoena'),
('P002', 'U002', 'Lerato', 'Dlamini');

INSERT INTO TOWN (townID, town_Name, province, postal_Code)
VALUES
('T001', 'Stellenbosch', 'Western Cape', '7600'),
('T002', 'Durban', 'KwaZulu-Natal', '4001'),
('T003', 'Pretoria', 'Gauteng', '0002');

INSERT INTO EVENT (eventID, organiserID, townID, event_Name, description, event_Date, event_Type, venue, race_Distance)
VALUES
('E001', 'O001', 'T001', 'Stellenbosch Run', 'Community road race', '2026-10-10', 'Road Race', 'Coetzenburg Stadium', 10),
('E002', 'O002', 'T002', 'Durban Beach Run', 'Beachfront running event', '2026-11-14', 'Road Race', 'Moses Mabhida Stadium',15),
('E003', 'O001', 'T003', 'Pretoria City Challenge',	'City running event', '2026-12-05',	'Half Marathon', 'Loftus Versfeld',	'21');

INSERT INTO ROUTE (routeID, eventID, route_Name, route_Description, mapURL)
VALUES
('R001', 'E001', 'Cape Town 10K Route',	'Scenic 10 km route through Cape Town', 'https://maps.example.com/capetown10k'),
('R002', 'E002', 'Durban Beach Route',	'15 km route along the Durban beachfront', 'https://maps.example.com/durbanbeach'),
('R003', 'E003', 'Pretoria City Route',	'21 km route through central Pretoria', 'https://maps.example.com/pretoriacity');

INSERT INTO CATEGORY(categoryID, category_Name, description)
VALUES
('C001', '10 km Open', '10 kilometre category for open participants'),
('C002', '10 km Under 18', '10 kilometre category for participants under 18'),
('C003', '15 km Open', '15 kilometre category for open participants'),
('C004', '15 km Veterans', '15 kilometre category for veteran participants'),
('C005', 'Half Marathon Open', '21 kilometre category for open participants'),
('C006', 'Half Marathon Veterans', '21 kilometre category for veteran participants');

INSERT INTO EVENTCATEGORY (eventCategoryID, eventID, categoryID)
VALUES
('EC001', 'E001', 'C001'),
('EC002', 'E001', 'C002'),
('EC003', 'E002', 'C003'),
('EC004', 'E002', 'C004'),
('EC005', 'E003', 'C005'),
('EC006', 'E003', 'C006');

INSERT INTO ENROLMENT (enrolmentID, participantID, eventCategoryID, enrolment_Date)
VALUES
('EN001','P001','EC001','2026-09-01'),
('EN002','P002','EC001','2026-09-02'),
('EN003','P001','EC003','2026-09-03'),
('EN004','P002','EC005','2026-09-04');

INSERT INTO RESULT (resultID, enrolmentID, finish_Time, distance, completionStatus, position)
VALUES
('RES001','EN001','00:52:34','10','Completed','12'),
('RES002','EN002','01:04:21','10','Completed','27'),
('RES003','EN003','01:18:45','15','Completed','18'),
('RES004','EN004','01:51:32','21','Completed','31');
