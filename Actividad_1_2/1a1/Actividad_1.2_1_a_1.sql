CREATE DATABASE Actividad_1_2_1_a_1
GO
USE Actividad_1_2_1_a_1

-- Tengo una empresa dedicada desde hace mas de 20 años al marketing, algunos clientes hace unos años,
-- comenzaron a pedirme campañas por Instagram, ante lo cual, tuve que agregar una tabla nueva la cual
-- llamé TInstagram con los datos de acceso y así poder administrarles sus publicaciones

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