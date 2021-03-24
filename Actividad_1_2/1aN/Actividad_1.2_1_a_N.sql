CREATE DATABASE Actividad_1_2_1_a_N
GO
USE Actividad_1_2_1_a_N

-- El cliente tiene la necesidad de poseer varias direcciones, por ejemplo Direccion de facturación, de entrega, etc

GO
create table Clientes(
    IdCliente int not null primary key identity(1,1),
    Apellidos varchar(100) not null,
    Nombres varchar(100) not null,
	Nacimiento date not null check (Nacimiento <= getdate()),
	Mail varchar(100) not null unique,
    Telefono varchar(20) null
)
GO
	create table TipoDomicilios(
    IDTipoDomicilio int primary key identity(1,1),
	Descripcion varchar(30) not null unique
)
GO
	create table Domicilios(
    IdCliente int not null foreign key references Clientes(IdCliente),
	IDTipoDomicilio int not null foreign key references TipoDomicilios(IDTipoDomicilio),
    Domicilio varchar(30) not null unique
)
