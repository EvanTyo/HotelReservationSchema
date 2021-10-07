-- Use HotelReservations database
USE HotelReservations
GO

-- Insert data for RoomType Table
SET IDENTITY_INSERT RoomType ON;
INSERT INTO RoomType (RoomTypePk, [Type], StandardOccupancy, MaximumOccupancy, BasePrice, ExtraPersonPrice) VALUES
	(1, 'Single', 2, 2, 149.99, NULL),
	(2, 'Double', 2, 4, 174.99, 10),
	(3, 'Suite', 3, 8, 399.99, 20);
SET IDENTITY_INSERT RoomType OFF;

-- Insert data for Room Table
SET IDENTITY_INSERT Room ON;
INSERT INTO Room (RoomPk, RoomNumber, RoomTypePk, AdaAccessible) VALUES
	(1, 201, 2, 'No'),
	(2, 202, 2, 'Yes'),
	(3, 203, 2, 'No'),
	(4, 204, 2, 'Yes'),
	(5, 205, 1, 'No'),
	(6, 206, 1, 'Yes'),
	(7, 207, 1, 'No'),
	(8, 208, 1, 'Yes'),
	(9, 301, 2, 'No'),
	(10, 302, 2, 'Yes'),
	(11, 303, 2, 'No'),
	(12, 304, 2, 'Yes'),
	(13, 305, 1, 'No'),
	(14, 306, 1, 'Yes'),
	(15, 307, 1, 'No'),
	(16, 308, 1, 'Yes'),
	(17, 401, 3, 'Yes'),
	(18, 402, 3, 'Yes');
SET IDENTITY_INSERT Room OFF;

-- Insert data for Amenities Table
SET IDENTITY_INSERT Amenities ON;
INSERT INTO Amenities (AmenitiesPk, [Name], ExtraCost) VALUES
	(1, 'Microwave', NULL),
	(2, 'Refrigerator', NULL),
	(3, 'Oven', NULL),
	(4, 'Jacuzzi', 25);
SET IDENTITY_INSERT Amenities OFF;

-- Insert data for RoomAmenities Table
INSERT INTO RoomAmenities (RoomPk, AmenitiesPk) VALUES
	(1, 1),
	(1, 4),
	(2, 2),
	(3, 1),
	(3, 4),
	(4, 2),
	(5, 1),
	(5, 2),
	(5, 4),
	(6, 1),
	(6, 2),
	(7, 1),
	(7, 2),
	(7, 4),
	(8, 1),
	(8, 2),
	(9, 1),
	(9, 4),
	(10, 2),
	(11, 1),
	(11, 4),
	(12, 2),
	(13, 1),
	(13, 2),
	(13, 4),
	(14, 1),
	(14, 2),
	(15, 1),
	(15, 2),
	(15, 4),
	(16, 1),
	(16, 2),
	(17, 1),
	(17, 2),
	(17, 3),
	(18, 1),
	(18, 2),
	(18, 3);

-- Insert data for Guest Table
SET IDENTITY_INSERT Guest ON;
INSERT INTO Guest (GuestPk, FirstName, LastName, [Address], City, [State], Zip, Phone) VALUES
	(1, 'Evan', 'Tyo', '123 Address Way', 'City', 'NY', '00000', '(555) 555-5555'),
	(2, 'Mack', 'Simmer', '379 Old Shore Street', 'Council Bluffs', 'IA', '51501', '(291) 553-0508'),
	(3, 'Bettyann', 'Seery', '750 Wintergreen Dr.', 'Wasilla', 'AK', '99654', '(478) 277-9632'),
	(4, 'Duane', 'Cullison', '9662 Foxrun Lane', 'Harlingen', 'TX', '78552', '(308) 494-0198'),
	(5, 'Karie', 'Yang', '9378 W. Augusta Ave.', 'West Deptford', 'NJ', '08096', '(214) 730-0298'),
	(6, 'Aurore', 'Lipton', '762 Wild Rose Street', 'Saginaw', 'MI', '48601', '(377) 507-0974'),
	(7, 'Zachery', 'Luechtefeld', '7 Poplar Dr.', '	Arvada', 'CO', '80003', '(814) 485-2615'),
	(8, 'Jeremiah', 'Pendergrass', '70 Oakwood St.', 'Zion', 'IL', '60099', '(279) 491-0960'),
	(9, 'Walter',  'Holaway', '7556 Arrowhead St.', 'Cumberland', 'RI', '02864', '(446) 396-6785'),
	(10, 'Wilfred', 'Vise', '77 West Surrey Street', 'Oswego', 'NY', '13126', '(834) 727-1001'),
	(11, 'Maritza', 'Tilton', '939 Linda Rd.', 'Burke', 'VA', '22015', '(446) 351-6860'),
	(12, 'Joleen', 'Tison', '87 Queen St.', 'Drexel Hill', 'PA', '19026', '(231) 893-2755');
SET IDENTITY_INSERT Guest OFF;

-- Insert data for Reservation Table
SET IDENTITY_INSERT Reservation ON;
INSERT INTO Reservation (ReservationPk, GuestPk, Adults, Children, StartDate, EndDate, TotalRoomCost) VALUES
	(1, 2, 1, 0, '2023-2-2', '2023-2-4', 299.98),
	(2, 3, 2, 1, '2023-2-5', '2023-2-10', 999.95),
	(3, 4, 2, 0, '2023-2-22', '2023-2-24', 349.98),
	(4, 5, 2, 2, '2023-3-6', '2023-3-7', 199.99),
	(5, 1, 1, 1, '2023-3-17', '2023-3-20', 524.97),
	(6, 6, 3, 0, '2023-3-18', '2023-3-23', 924.95),
	(7, 7, 2, 2, '2023-3-29', '2023-3-31', 349.98),
	(8, 8, 2, 0, '2023-3-31', '2023-4-5', 874.95),
	(9, 9, 1, 0, '2023-4-9', '2023-4-13', 799.96),
	(10, 10, 1, 1, '2023-4-23', '2023-4-24', 174.99),
	(11, 11, 2, 4, '2023-5-30', '2023-6-2', 1199.97),
	(12, 12, 2, 0, '2023-6-10', '2023-6-14', 599.96),
	(13, 12, 1, 0, '2023-6-10', '2023-6-14', 599.96),
	(14, 6, 3, 0, '2023-6-17', '2023-6-18', 184.99),
	(15, 1, 2, 0, '2023-6-28', '2023-7-2', 699.96),
	(16, 9, 3, 1, '2023-7-13', '2023-7-14', 184.99),
	(17, 10, 4, 2, '2023-7-18', '2023-7-21', 1259.97),
	(18, 3, 2, 1, '2023-7-28', '2023-7-29', 199.99),
	(19, 3, 1, 0, '2023-8-30', '2023-9-1', 349.98),
	(20, 2, 2, 0, '2023-9-16', '2023-9-17', 149.99),
	(21, 5, 2, 2, '2023-9-13', '2023-9-15', 399.98),
	(22, 4, 2, 2, '2023-11-22', '2023-11-25', 1199.97),
	(23, 2, 2, 0, '2023-11-22', '2023-11-25', 449.97),
	(24, 2, 2, 2, '2023-11-22', '2023-11-25', 599.97),
	(25, 11, 2, 0, '2023-12-24', '2023-12-28', 699.96);
SET IDENTITY_INSERT Reservation OFF;

-- Insert data for RoomReservation Table
INSERT INTO RoomReservation (ReservationPk, RoomPk) VALUES
	(1, 16),
	(2, 3),
	(3, 13),
	(4, 1),
	(5, 15),
	(6, 10),
	(7, 2),
	(8, 12),
	(9, 9),
	(10, 7),
	(11, 17),
	(12, 6),
	(13, 8),
	(14, 12),
	(15, 5),
	(16, 4),
	(17, 17),
	(18, 11),
	(19, 13),
	(20, 8),
	(21, 3),
	(22, 17),
	(23, 6),
	(24, 9),
	(25, 10);


-- SQL Statements to Delete Jeremiah Pendergrass and his reservations
-- Delete the RoomReservation first
DELETE FROM
	RoomReservation
WHERE
	ReservationPk = 8;

-- Delete the Reservation second
DELETE FROM
	Reservation
WHERE
	ReservationPk = 8;

-- Delete the Guest entry last
DELETE FROM
	Guest
WHERE GuestPk = 8;