-- Use HotelReservations database
USE HotelReservations
GO

-- 1) Write a query that returns a list of reservations 
-- that end in July 2023, including the name of the guest, 
-- the room number(s), and the reservation dates.
SELECT
	Guest.FirstName,
	Guest.LastName,
	Room.RoomNumber,
	Convert(nvarchar(30), Reservation.StartDate, 101) StartDate,
	Reservation.EndDate
FROM 
	Guest
INNER JOIN
	Reservation
ON Guest.GuestPk = Reservation.GuestPk
INNER JOIN
	RoomReservation
ON Reservation.ReservationPk = RoomReservation.ReservationPk
INNER JOIN
	Room
ON RoomReservation.RoomPk = Room.RoomPk
WHERE Reservation.EndDate BETWEEN '2023-7-01' AND '2023-07-31'

/* 
FirstName	LastName	RoomNumber	StartDate	EndDate
Evan		Tyo			205			2023-06-28	2023-07-02
Walter		Holaway		204			2023-07-13	2023-07-14
Wilfred		Vise		401			2023-07-18	2023-07-21
Bettyann	Seery		303			2023-07-28	2023-07-29
*/

-- 2) Write a query that returns a list of all reservations 
-- for rooms with a jacuzzi, displaying the guest's name, 
-- the room number, and the dates of the reservation.
SELECT
	Guest.FirstName,
	Guest.LastName,
	Room.RoomNumber,
	Reservation.StartDate,
	Reservation.EndDate
FROM 
	Guest
INNER JOIN
	Reservation
ON Guest.GuestPk = Reservation.GuestPk
INNER JOIN
	RoomReservation
ON Reservation.ReservationPk = RoomReservation.ReservationPk
INNER JOIN
	Room
ON RoomReservation.RoomPk = Room.RoomPk
INNER JOIN
	RoomAmenities
ON Room.RoomPk = RoomAmenities.RoomPk
INNER JOIN
	Amenities
ON RoomAmenities.AmenitiesPk = Amenities.AmenitiesPk
WHERE Amenities.Name = 'Jacuzzi'

/*
FirstName	LastName	RoomNumber	StartDate	EndDate
Bettyann	Seery		203			2023-02-05	2023-02-10
Duane		Cullison	305			2023-02-22	2023-02-24
Karie		Yang		201			2023-03-06	2023-03-07
Evan		Tyo			307			2023-03-17	2023-03-20
Walter		Holaway		301			2023-04-09	2023-04-13
Wilfred		Vise		207			2023-04-23	2023-04-24
Evan		Tyo			205			2023-06-28	2023-07-02
Bettyann	Seery		303			2023-07-28	2023-07-29
Bettyann	Seery		305			2023-08-30	2023-09-01
Karie		Yang		203			2023-09-13	2023-09-15
Mack		Simmer		301			2023-11-22	2023-11-25
*/

-- 3) Write a query that returns all the rooms reserved for a 
-- specific guest, including the guest's name, the room(s) 
-- reserved, the starting date of the reservation, and how many 
-- people were included in the reservation. 
-- (Choose a guest's name from the existing data.)
SELECT
	Guest.FirstName,
	Guest.LastName,
	Room.RoomNumber,
	Reservation.StartDate,
	Reservation.EndDate,
	Reservation.Adults,
	Reservation.Children,
	Reservation.Adults + Reservation.Children AS TotalGuests
FROM 
	Guest
INNER JOIN
	Reservation
ON Guest.GuestPk = Reservation.GuestPk
INNER JOIN
	RoomReservation
ON Reservation.ReservationPk = RoomReservation.ReservationPk
INNER JOIN
	Room
ON RoomReservation.RoomPk = Room.RoomPk
WHERE Guest.FirstName = 'Mack'
	AND Guest.LastName = 'Simmer'

/*
FirstName	LastName	RoomNumber	StartDate	EndDate		Adults	Children	TotalGuests
Mack		Simmer		308			2023-02-02	2023-02-04	1		0			1
Mack		Simmer		208			2023-09-16	2023-09-17	2		0			2
Mack		Simmer		206			2023-11-22	2023-11-25	2		0			2
Mack		Simmer		301			2023-11-22	2023-11-25	2		2			4
*/

-- 4) Write a query that returns a list of rooms, reservation ID, 
-- and per-room cost for each reservation. The results should 
-- include all rooms, whether or not there is a reservation 
-- associated with the room.
SELECT
	Room.RoomNumber,
	Reservation.ReservationPk AS ReservationID,
	RoomType.BasePrice AS RoomBaseCost,
	ISNULL(Reservation.TotalRoomCost, 0.00) TotalRoomCost
FROM
	Reservation
INNER JOIN
	RoomReservation
ON Reservation.ReservationPk = RoomReservation.ReservationPk
RIGHT OUTER JOIN
	Room
ON RoomReservation.RoomPk = Room.RoomPk
INNER JOIN
	RoomType
ON Room.RoomTypePk = RoomType.RoomTypePk
ORDER BY Room.RoomNumber

/*
RoomNumber	ReservationID	RoomBaseCost	TotalRoomCost
201			4				175				200
202			7				175				350
203			2				175				1000
203			21				175				400
204			16				175				185
205			15				150				700
206			12				150				600
206			23				150				450
207			10				150				175
208			13				150				600
208			20				150				150
301			9				175				800
301			24				175				600
302			6				175				925
302			25				175				700
303			18				175				200
304			14				175				185
305			3				150				350
305			19				150				350
306			NULL			150				NULL
307			5				150				525
308			1				150				300
401			11				400				1200
401			17				400				1260
401			22				400				1200
402			NULL			400				NULL
*/

-- 5) Write a query that returns all the rooms accommodating 
-- at least three guests and that are reserved on any 
-- date in April 2023.
SELECT
	Room.RoomNumber,
	RoomType.[Type],
	Room.AdaAccessible,
	Guest.FirstName,
	Guest.LastName,
	Reservation.Adults,
	Reservation.Children,
	Reservation.Adults + Reservation.Children AS TotalGuests,
	Reservation.StartDate,
	Reservation.EndDate
FROM
	RoomType
INNER JOIN
	Room
ON RoomType.RoomTypePk = Room.RoomTypePk
INNER JOIN
	RoomReservation
ON Room.RoomPk = RoomReservation.RoomPk
INNER JOIN
	Reservation
ON RoomReservation.ReservationPk = Reservation.ReservationPk
INNER JOIN
	Guest
ON Reservation.GuestPk = Guest.GuestPk
WHERE (Reservation.Adults + Reservation.Children) >= 3
	AND ((Reservation.StartDate BETWEEN '2023-04-01' AND '2023-04-30')
	OR (Reservation.EndDate BETWEEN '2023-04-01' AND '2023-04-30'))

/*
RoomNumber	Type	AdaAccessible	FirstName	LastName	Adults	Children	TotalGuests	StartDate	EndDate
*/

-- 6) Write a query that returns a list of all guest names 
-- and the number of reservations per guest, sorted starting 
-- with the guest with the most reservations and then by 
-- the guest's last name.
SELECT
	Guest.FirstName,
	Guest.LastName,
	COUNT(Guest.GuestPk) AS ReservationCount
FROM
	Guest
INNER JOIN
	Reservation
ON Guest.GuestPk = Reservation.GuestPk
GROUP BY
	Guest.FirstName,
	Guest.LastName
ORDER BY
	COUNT(Guest.GuestPk) DESC,
	Guest.LastName

/*
FirstName	LastName	ReservationCount
Mack		Simmer		4
Bettyann	Seery		3
Duane		Cullison	2
Walter		Holaway		2
Aurore		Lipton		2
Maritza		Tilton		2
Joleen		Tison		2
Evan		Tyo			2
Wilfred		Vise		2
Karie		Yang		2
Zachery		Luechtefeld	1
*/

-- 7) Write a query that displays the name, address, and 
-- phone number of a guest based on their phone number. 
-- (Choose a phone number from the existing data.)
SELECT
	Guest.FirstName,
	Guest.LastName,
	Guest.[Address],
	Guest.City,
	Guest.[State],
	Guest.Zip,
	Guest.Phone
FROM
	Guest
WHERE Guest.Phone = '(291) 553-0508'

/*
FirstName	LastName	Address					City			State	Zip		Phone
Mack		Simmer		379 Old Shore Street	Council Bluffs	IA		51501	(291) 553-0508
*/


-- Concatinating the amenities to one table, pretty cool!
SELECT
	R.RoomNumber,
	RT.[Type],
	STUFF((SELECT ', '+[Name]
		FROM Amenities A2
		INNER JOIN RoomAmenities RA2
		ON A2.AmenitiesPK = RA2.AmenitiesPK
        WHERE RA2.RoomPK = RA.RoomPK
        FOR XML PATH(''), TYPE).value('.', 'VARCHAR(MAX)')
        ,1,1,'') Amenities,
	--CASE WHEN R.AdaAccessible = 1 THEN 'Yes' ELSE 'No' END ADAAccess,
	RT.StandardOccupancy,
	RT.MaximumOccupancy,
	RT.BasePrice,
	ISNULL(CONVERT(NVARCHAR(6), RT.ExtraPersonPrice), 'N/A') ExtraPersonCost
FROM
	Amenities A
INNER JOIN
	RoomAmenities RA
ON A.AmenitiesPK = RA.AmenitiesPK
INNER JOIN
	ROOM R
ON RA.RoomPK = R.RoomPK
INNER JOIN
	RoomType RT
ON R.RoomTypePK = RT.RoomTypePK	
GROUP BY
	R.RoomNumber,
	RA.RoomPK,
	RT.[Type],
	R.AdaAccessible,
	RT.StandardOccupancy,
	RT.MaximumOccupancy,
	RT.BasePrice,
	RT.ExtraPersonPrice