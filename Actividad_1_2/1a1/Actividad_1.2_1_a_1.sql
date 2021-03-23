CREATE DATABASE Actividad_1_2_1_a_1
GO
USE Actividad_1_2_1_a_1

-- Tengo una empresa dedicada desde hace mas de 20 a�os al marketing, algunos clientes hace unos a�os,
-- comenzaron a pedirme campa�as por Instagram, ante lo cual, tuve que agregar una tabla nueva la cual
-- llam� TInstagram con los datos de acceso y as� poder administrarles sus publicaciones

GO
CREATE TABLE Clientes(
  DNI INT NOT NULL PRIMARY KEY,
  Apellidos VARCHAR(50) NOT NULL,
  Nombres VARCHAR(50) NOT NULL,
  Sexo CHAR(1) NOT NULL CHECK(Sexo = 'F' OR Sexo = 'M'),
  FechaAlta DATE NOT NULL 
)
GO
CREATE TABLE TInstagram(
  DNI INT NOT NULL,
  URL VARCHAR(100) NOT NULL UNIQUE,
  Usuario VARCHAR(100) NOT NULL UNIQUE,
  Password VARCHAR(100) NOT NULL,
  PRIMARY KEY(DNI),
  FOREIGN KEY (DNI) REFERENCES Clientes(DNI)
)