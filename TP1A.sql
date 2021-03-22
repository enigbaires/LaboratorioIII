CREATE DATABASE TP_1A
GO
USE TP_1A
GO
CREATE TABLE Clientes(
  DNI INT NOT NULL PRIMARY KEY,
  Apellidos VARCHAR(50) NOT NULL,
  Nombres VARCHAR(50) NOT NULL,
  Sexo CHAR(1) NOT NULL CHECK(Sexo = 'F' OR Sexo = 'M'),
  FechaAlta DATE NOT NULL,
  FechaNacimiento DATE NOT NULL,  
)
GO
CREATE TABLE Vendedores(
  DNI INT NOT NULL PRIMARY KEY,
  Legajo INT NOT NULL UNIQUE,
  Apellidos VARCHAR(50) NOT NULL,
  Nombres VARCHAR(50) NOT NULL,
  Sexo CHAR(1) NOT NULL CHECK(Sexo = 'F' OR Sexo = 'M'),
  FechaIngreso DATE NOT NULL,
  FechaNacimiento DATE NOT NULL,
  SUELDO SMALLMONEY NOT NULL
)
GO
CREATE TABLE Provincias(
  IDProvincia INT NOT NULL PRIMARY KEY,
  Descripcion VARCHAR(50) NOT NULL
)
GO
CREATE TABLE Localidades(
  CodPostal INT NOT NULL PRIMARY KEY,
  IDProvincia INT NOT NULL FOREIGN KEY REFERENCES Provincias(IDProvincia),
  Descripcion VARCHAR(50) NOT NULL
)
GO
CREATE TABLE Domicilios(
  DNI INT NOT NULL,
  Direccion VARCHAR(50) NOT NULL,
  CodPostal INT NOT NULL FOREIGN KEY REFERENCES Localidades(CodPostal),
  PRIMARY KEY(DNI, Direccion, CodPostal),
  FOREIGN KEY (DNI) REFERENCES Clientes(DNI),
  FOREIGN KEY (DNI) REFERENCES Vendedores(DNI)
)
GO
CREATE TABLE Telefonos(
  DNI INT NOT NULL,
  Telefono VARCHAR(15) NOT NULL,
  PRIMARY KEY(DNI, Telefono),
  FOREIGN KEY (DNI) REFERENCES Clientes(DNI),
  FOREIGN KEY (DNI) REFERENCES Vendedores(DNI)
)
GO
CREATE TABLE Emails(
  DNI INT NOT NULL,
  Email VARCHAR(15) NOT NULL UNIQUE,
  PRIMARY KEY(DNI),
  FOREIGN KEY (DNI) REFERENCES Clientes(DNI),
  FOREIGN KEY (DNI) REFERENCES Vendedores(DNI)
)
GO
CREATE TABLE Marcas(
  IDMarca INT NOT NULL PRIMARY KEY IDENTITY (1, 1),
  Descripcion VARCHAR(50) NOT NULL
)
GO
CREATE TABLE TipoArticulos(
  IDTipoArticulo INT NOT NULL PRIMARY KEY IDENTITY (1, 1),
  Descripcion VARCHAR(50) NOT NULL
)
GO
CREATE TABLE Articulos(
  IDArticulo VARCHAR(6) NOT NULL PRIMARY KEY,
  Descripcion VARCHAR(255) NOT NULL,
  IDMarca INT NULL FOREIGN KEY REFERENCES Marcas(IDMarca),
  IDTipoArticulo INT NOT NULL FOREIGN KEY REFERENCES TipoArticulos(IDTipoArticulo),
  PrecioVenta SMALLMONEY NOT NULL, --Se podría sacar, sería un calculo en la lísta de precios por ejemplo
  StockMinimo INT NOT NULL,
  Estado BIT NOT NULL
)
GO
CREATE TABLE FacturaEncabezado(
  CodigoFactura BIGINT NOT NULL PRIMARY KEY IDENTITY (1, 1),
  Fecha DATE NOT NULL,
  DNICliente INT NOT NULL FOREIGN KEY REFERENCES Clientes (DNI),
  DNIVendedor INT NOT NULL FOREIGN KEY REFERENCES Vendedores (DNI),
  FormaPago CHAR(1) NOT NULL CHECK (FormaPago = 'E' OR FormaPago = 'T')
)
GO
CREATE TABLE FacturaDetalle(
  CodigoFactura BIGINT NOT NULL FOREIGN KEY REFERENCES FacturaEncabezado(CodigoFactura),
  IDArticulo VARCHAR(6) NOT NULL FOREIGN KEY REFERENCES Articulos(IDArticulo),
  PrecioUnitario SMALLMONEY NOT NULL,
  Cantidad INT NOT NULL,
  PRIMARY KEY (CodigoFactura, IDArticulo)
)
GO
CREATE TABLE TipoMovimientos(
  IDTipoMovimiento INT NOT NULL PRIMARY KEY,
  Descripcion VARCHAR(50) NOT NULL
)
GO
CREATE TABLE Movimientos(
  CodigoFactura BIGINT NOT NULL FOREIGN KEY REFERENCES FacturaEncabezado(CodigoFactura),
  IDArticulo VARCHAR(6) NOT NULL FOREIGN KEY REFERENCES Articulos(IDArticulo),
  IDTipoMovimiento INT NOT NULL FOREIGN KEY REFERENCES TipoMovimientos(IDTipoMovimiento),
  Fecha DATE NOT NULL,
  Cantidad INT NOT NULL,
  PrecioUnitario SMALLMONEY NOT NULL
)
