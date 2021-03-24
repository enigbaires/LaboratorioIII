CREATE DATABASE Actividad_1_a_1_Alternativa
GO
USE Actividad_1_a_1_Alternativa

-- Tengo una empresa dedicada desde hace mas de 20 años al marketing, algunos clientes hace unos años,
-- comenzaron a pedirme campañas por Instagram, ante lo cual, tuve que agregar una tabla nueva la cual
-- llamé TInstagram con los datos de acceso y así poder administrarles sus publicaciones

GO
CREATE TABLE Clientes(
  DNI INT NOT NULL,
  Apellidos VARCHAR(50),
  Nombres VARCHAR(50),
  Sexo CHAR(1),
  FechaAlta DATE
)
GO
CREATE TABLE TInstagram(
  DNI INT NOT NULL,
  DirWeb VARCHAR(100),
  Usuario VARCHAR(100),
  Contrasenia VARCHAR(100)
)

ALTER TABLE Clientes ADD PRIMARY KEY (DNI)
ALTER TABLE Clientes ALTER COLUMN Apellidos VARCHAR(50) NOT NULL
ALTER TABLE Clientes ALTER COLUMN Nombres VARCHAR(50) NOT NULL
ALTER TABLE Clientes ALTER COLUMN Sexo CHAR(1) NOT NULL
ALTER TABLE Clientes ADD CONSTRAINT Sexo CHECK(Sexo = 'F' OR Sexo = 'M')
ALTER TABLE Clientes ALTER COLUMN FechaAlta DATE NOT NULL

ALTER TABLE TInstagram ADD PRIMARY KEY (DNI)
ALTER TABLE TInstagram ADD FOREIGN KEY (DNI) REFERENCES Clientes(DNI)
ALTER TABLE TInstagram ALTER COLUMN DirWeb VARCHAR(100) NOT NULL
ALTER TABLE TInstagram ADD UNIQUE (DirWeb)
ALTER TABLE TInstagram ALTER COLUMN Usuario VARCHAR(100) NOT NULL
ALTER TABLE TInstagram ADD UNIQUE (Usuario)
ALTER TABLE TInstagram ALTER COLUMN Contrasenia VARCHAR(100) NOT NULL