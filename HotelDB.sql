-- Use master for HotelReservations database creation
USE [master]
GO

-- Check if HotelReservations database exists, if so drop it
IF EXISTS (SELECT * FROM sys.databases WHERE NAME = N'HotelReservations')
BEGIN
	EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'HotelReservations';
	ALTER DATABASE HotelReservations SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE HotelReservations;
END

-- Create HotelReservations database
CREATE DATABASE HotelReservations
GO

-- Use HotelReservations database to create tables
USE HotelReservations
GO

-- Room Type information
CREATE TABLE [RoomType] (
	RoomTypePk INT PRIMARY KEY IDENTITY(1, 1),
	[Type] VARCHAR(10) NOT NULL,
	StandardOccupancy INT NOT NULL,
	MaximumOccupancy INT NOT NULL,
	BasePrice DECIMAL NOT NULL,
	ExtraPersonPrice DECIMAL NULL,
)
GO

-- Room information
CREATE TABLE [Room] (
	RoomPk INT PRIMARY KEY IDENTITY(1, 1),
	RoomNumber INT NOT NULL,
	RoomTypePk INT NOT NULL,
	AdaAccessible CHAR(3),
	CONSTRAINT FK_Room_RoomTypePk
		FOREIGN KEY (RoomTypePk)
		REFERENCES RoomType(RoomTypePk)
)
GO

-- Room Amenities information
CREATE TABLE [Amenities] (
	AmenitiesPk INT PRIMARY KEY IDENTITY(1, 1),
	[Name] VARCHAR(30) NOT NULL,
	ExtraCost INT NULL
)
GO

-- Bridge between Room and Amenities
CREATE TABLE [RoomAmenities] (
	RoomPk INT NOT NULL,
	AmenitiesPk INT NOT NULL,
	CONSTRAINT FK_RoomAmenities_RoomPk 
		FOREIGN KEY (RoomPk)
		REFERENCES Room(RoomPk),
	CONSTRAINT FK_RoomAmenities_AmenitiesPK 
		FOREIGN KEY (AmenitiesPk)
		REFERENCES Amenities(AmenitiesPk)
)
GO

-- Guest information
CREATE TABLE [Guest] (
	GuestPk INT PRIMARY KEY IDENTITY(1, 1),
	FirstName VARCHAR(100) NOT NULL,
	LastName VARCHAR(100) NOT NULL,
	[Address] VARCHAR (200) NOT NULL,
	City VARCHAR(100) NOT NULL,
	[State] CHAR(2) NOT NULL,
	Zip VARCHAR(20) NOT NULL,
	Phone VARCHAR(20) NOT NULL
)
GO

-- Reservation information
CREATE TABLE [Reservation] (
	ReservationPk INT PRIMARY KEY IDENTITY(1, 1),
	GuestPk INT NOT NULL,
	Adults INT NOT NULL,
	Children INT NOT NULL,
	StartDate DATE NOT NULL,
	EndDate DATE NOT NULL,
	TotalRoomCost DECIMAL NOT NULL,
	CONSTRAINT FK_Reservation_GuestPk 
		FOREIGN KEY (GuestPk)
		REFERENCES Guest(GuestPk)
)
GO

-- Bridge between Room and Reservation
CREATE TABLE [RoomReservation] (
	ReservationPk INT NOT NULL,
	RoomPk INT NOT NULL,
	CONSTRAINT FK_RoomReservation_ReservationPk 
		FOREIGN KEY (ReservationPk)
		REFERENCES Reservation(ReservationPk),
			CONSTRAINT FK_RoomReservation_RoomPk 
		FOREIGN KEY (RoomPk)
		REFERENCES Room(RoomPk)
)
GO