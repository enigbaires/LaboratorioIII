create database actividad11
GO
use actividad11
GO
create table Carreras(
    ID varchar(4) not null primary key,
    Nombre varchar(30) not null,
	"Fecha creacion" date not null check ("Fecha creacion" <= getdate()),
	Mail varchar(100) not null,
    Nivel varchar(11) not null check (Nivel = 'Diplomatura' or Nivel = 'Pregrado' or Nivel = 'Grado' or Nivel = 'Posgrado')    
)
GO
create table Alumnos(
    Legajo int not null primary key identity(1000, 1),
    IDCarrera varchar(4) not null foreign key references Carreras(ID),
    Apellidos varchar(100) not null,
    Nombres varchar(100) not null,
    "Fecha de nacimiento" date not null check ("Fecha de nacimiento" <= getdate()),
	Mail varchar(100) not null unique,
    Telefono varchar(20) null
)
GO
create table Materias(
    ID int not null primary key identity(1, 1),
    IDCarrera varchar(4) not null foreign key references Carreras(ID),
    Nombre varchar(100) not null,
    "Carga Horaria" int not null check ("Carga Horaria" > 0)
)