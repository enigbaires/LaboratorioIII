CREATE DATABASE Blueprint
GO
USE Blueprint
GO
CREATE TABLE TipoClientes(
  ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
  Descripcion VARCHAR(50) NOT NULL UNIQUE
)

GO
CREATE TABLE Paises(
  ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
  ISO VARCHAR(2) NOT NULL,
  Descripcion VARCHAR(100) NOT NULL
)

GO
CREATE TABLE Provincias(
  ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
  IDPais INT NOT NULL FOREIGN KEY REFERENCES Paises(ID),
  Descripcion VARCHAR(50) NOT NULL
)
GO
CREATE TABLE Localidades(
  ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
  IDProvincia INT NOT NULL FOREIGN KEY REFERENCES Provincias(ID),
  Descripcion VARCHAR(100) NOT NULL
)

GO
CREATE TABLE Clientes(
  ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
  RazonSocial VARCHAR(50) NOT NULL UNIQUE,
  IDTipoCliente INT NOT NULL FOREIGN KEY REFERENCES TipoClientes(ID),
  Cuit VARCHAR(12) NOT NULL UNIQUE,
  Email VARCHAR(100) NULL,
  TelefonoFijo VARCHAR(20) NULL,
  TelefonoMovil VARCHAR(20) NULL,
  IDLocalidad INT NULL FOREIGN KEY REFERENCES Localidades(ID)    
)

GO
CREATE TABLE Proyectos(
  ID VARCHAR(5) NOT NULL PRIMARY KEY,
  Nombre VARCHAR(100) NOT NULL,
  Descripcion VARCHAR(512) NULL,
  Costo MONEY NOT NULL CHECK (Costo > 0),
  FechaInicio DATE NOT NULL,
  FechaFin DATE NULL,
  IDCliente INT NOT NULL FOREIGN KEY REFERENCES Clientes(ID),
  Estado BIT NOT NULL DEFAULT (1)
)

GO
CREATE TABLE Modulos(
  ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
  IDProyecto VARCHAR(5) NOT NULL FOREIGN KEY REFERENCES Proyectos(ID),
  Nombre VARCHAR(100) NOT NULL,
  Descripcion VARCHAR(512) NULL,
  TiempoEstimado INT NOT NULL CHECK (TiempoEstimado > 0),
  CostoEstimado MONEY NOT NULL CHECK (CostoEstimado > 0),
  FechaFinEstimada DATE NULL,
  FechaRealInicio DATE NULL,
  FechaRealFin DATE NULL,
  CONSTRAINT FechaInicioFin CHECK (FechaRealFin >= FechaRealInicio)
)

GO
CREATE TABLE Colaboradores(
  ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
  Apellidos VARCHAR(50) NOT NULL,
  Nombres VARCHAR(50) NOT NULL,
  Sexo CHAR(1) NULL CHECK(Sexo = 'F' OR Sexo = 'M'),
  Email VARCHAR(100) NULL,
  TelefonoMovil VARCHAR(20) NULL,
  CHECK (Email IS NOT NULL OR TelefonoMovil IS NOT NULL),
  FechaNacimiento DATE NOT NULL CHECK(FechaNacimiento < GETDATE()),
  Direccion VARCHAR(100) NULL,
  IDLocalidad INT NULL FOREIGN KEY REFERENCES Localidades(ID),
  TipoColaborador CHAR(1) NULL CHECK(TipoColaborador = 'I' OR TipoColaborador = 'E')
)

GO
CREATE TABLE TipoTareas(
	ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Descripcion VARCHAR(50) NOT NULL
)

GO
CREATE TABLE Tareas(
	ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	IDModulo INT NOT NULL FOREIGN KEY REFERENCES Modulos(ID),
	IDTipoTarea INT NOT NULL FOREIGN KEY REFERENCES TipoTareas(ID),
	Precio MONEY NOT NULL CHECK (Precio > 0),
	FechaInicio DATE NULL,
	FechaFin DATE NULL,
	CONSTRAINT TareasFechaInicioFin CHECK (FechaFin >=FechaInicio),
	Estado CHAR(1) NOT NULL DEFAULT ('A') CHECK (Estado = 'A' OR Estado = 'S')
)

GO
CREATE TABLE Colaboraciones(
	IDTarea INT NOT NULL FOREIGN KEY REFERENCES Tareas(ID),
	IDColaborador INT NOT NULL FOREIGN KEY REFERENCES Colaboradores(ID),
	Tiempo INT NOT NULL,
	Precio MONEY NOT NULL CHECK (Precio > 0),
	Estado CHAR(1) NOT NULL CHECK (Estado = 'A' OR Estado = 'S'),
	PRIMARY KEY (IDTarea, IDColaborador)
)

GO
INSERT INTO Paises (ISO, Descripcion) VALUES 
	('AF','Afganist�n'),
	('AX','Islas Gland'),
	('AL','Albania'),
	('DE','Alemania'),
	('AD','Andorra'),
	('AO','Angola'),
	('AI','Anguilla'),
	('AQ','Ant�rtida'),
	('AG','Antigua y Barbuda'),
	('AN','Antillas Holandesas'),
	('SA','Arabia Saud�'),
	('DZ','Argelia'),
	('AR','Argentina'),
	('AM','Armenia'),
	('AW','Aruba'),
	('AU','Australia'),
	('AT','Austria'),
	('AZ','Azerbaiy�n'),
	('BS','Bahamas'),
	('BH','Bahr�in'),
	('BD','Bangladesh'),
	('BB','Barbados'),
	('BY','Bielorrusia'),
	('BE','B�lgica'),
	('BZ','Belice'),
	('BJ','Benin'),
	('BM','Bermudas'),
	('BT','Bhut�n'),
	('BO','Bolivia'),
	('BA','Bosnia y Herzegovina'),
	('BW','Botsuana'),
	('BV','Isla Bouvet'),
	('BR','Brasil'),
	('BN','Brun�i'),
	('BG','Bulgaria'),
	('BF','Burkina Faso'),
	('BI','Burundi'),
	('CV','Cabo Verde'),
	('KY','Islas Caim�n'),
	('KH','Camboya'),
	('CM','Camer�n'),
	('CA','Canad�'),
	('CF','Rep�blica Centroafricana'),
	('TD','Chad'),
	('CZ','Rep�blica Checa'),
	('CL','Chile'),
	('CN','China'),
	('CY','Chipre'),
	('CX','Isla de Navidad'),
	('VA','Ciudad del Vaticano'),
	('CC','Islas Cocos'),
	('CO','Colombia'),
	('KM','Comoras'),
	('CD','Rep�blica Democr�tica del Congo'),
	('CG','Congo'),
	('CK','Islas Cook'),
	('KP','Corea del Norte'),
	('KR','Corea del Sur'),
	('CI','Costa de Marfil'),
	('CR','Costa Rica'),
	('HR','Croacia'),
	('CU','Cuba'),
	('DK','Dinamarca'),
	('DM','Dominica'),
	('DO','Rep�blica Dominicana'),
	('EC','Ecuador'),
	('EG','Egipto'),
	('SV','El Salvador'),
	('AE','Emiratos �rabes Unidos'),
	('ER','Eritrea'),
	('SK','Eslovaquia'),
	('SI','Eslovenia'),
	('ES','Espa�a'),
	('UM','Islas ultramarinas de Estados Unidos'),
	('US','Estados Unidos'),
	('EE','Estonia'),
	('ET','Etiop�a'),
	('FO','Islas Feroe'),
	('PH','Filipinas'),
	('FI','Finlandia'),
	('FJ','Fiyi'),
	('FR','Francia'),
	('GA','Gab�n'),
	('GM','Gambia'),
	('GE','Georgia'),
	('GS','Islas Georgias del Sur y Sandwich del Sur'),
	('GH','Ghana'),
	('GI','Gibraltar'),
	('GD','Granada'),
	('GR','Grecia'),
	('GL','Groenlandia'),
	('GP','Guadalupe'),
	('GU','Guam'),
	('GT','Guatemala'),
	('GF','Guayana Francesa'),
	('GN','Guinea'),
	('GQ','Guinea Ecuatorial'),
	('GW','Guinea-Bissau'),
	('GY','Guyana'),
	('HT','Hait�'),
	('HM','Islas Heard y McDonald'),
	('HN','Honduras'),
	('HK','Hong Kong'),
	('HU','Hungr�a'),
	('IN','India'),
	('ID','Indonesia'),
	('IR','Ir�n'),
	('IQ','Iraq'),
	('IE','Irlanda'),
	('IS','Islandia'),
	('IL','Israel'),
	('IT','Italia'),
	('JM','Jamaica'),
	('JP','Jap�n'),
	('JO','Jordania'),
	('KZ','Kazajst�n'),
	('KE','Kenia'),
	('KG','Kirguist�n'),
	('KI','Kiribati'),
	('KW','Kuwait'),
	('LA','Laos'),
	('LS','Lesotho'),
	('LV','Letonia'),
	('LB','L�bano'),
	('LR','Liberia'),
	('LY','Libia'),
	('LI','Liechtenstein'),
	('LT','Lituania'),
	('LU','Luxemburgo'),
	('MO','Macao'),
	('MK','ARY Macedonia'),
	('MG','Madagascar'),
	('MY','Malasia'),
	('MW','Malawi'),
	('MV','Maldivas'),
	('ML','Mal�'),
	('MT','Malta'),
	('FK','Islas Malvinas'),
	('MP','Islas Marianas del Norte'),
	('MA','Marruecos'),
	('MH','Islas Marshall'),
	('MQ','Martinica'),
	('MU','Mauricio'),
	('MR','Mauritania'),
	('YT','Mayotte'),
	('MX','M�xico'),
	('FM','Micronesia'),
	('MD','Moldavia'),
	('MC','M�naco'),
	('MN','Mongolia'),
	('MS','Montserrat'),
	('MZ','Mozambique'),
	('MM','Myanmar'),
	('NA','Namibia'),
	('NR','Nauru'),
	('NP','Nepal'),
	('NI','Nicaragua'),
	('NE','N�ger'),
	('NG','Nigeria'),
	('NU','Niue'),
	('NF','Isla Norfolk'),
	('NO','Noruega'),
	('NC','Nueva Caledonia'),
	('NZ','Nueva Zelanda'),
	('OM','Om�n'),
	('NL','Pa�ses Bajos'),
	('PK','Pakist�n'),
	('PW','Palau'),
	('PS','Palestina'),
	('PA','Panam�'),
	('PG','Pap�a Nueva Guinea'),
	('PY','Paraguay'),
	('PE','Per�'),
	('PN','Islas Pitcairn'),
	('PF','Polinesia Francesa'),
	('PL','Polonia'),
	('PT','Portugal'),
	('PR','Puerto Rico'),
	('QA','Qatar'),
	('GB','Reino Unido'),
	('RE','Reuni�n'),
	('RW','Ruanda'),
	('RO','Rumania'),
	('RU','Rusia'),
	('EH','Sahara Occidental'),
	('SB','Islas Salom�n'),
	('WS','Samoa'),
	('AS','Samoa Americana'),
	('KN','San Crist�bal y Nevis'),
	('SM','San Marino'),
	('PM','San Pedro y Miquel�n'),
	('VC','San Vicente y las Granadinas'),
	('SH','Santa Helena'),
	('LC','Santa Luc�a'),
	('ST','Santo Tom� y Pr�ncipe'),
	('SN','Senegal'),
	('CS','Serbia y Montenegro'),
	('SC','Seychelles'),
	('SL','Sierra Leona'),
	('SG','Singapur'),
	('SY','Siria'),
	('SO','Somalia'),
	('LK','Sri Lanka'),
	('SZ','Suazilandia'),
	('ZA','Sud�frica'),
	('SD','Sud�n'),
	('SE','Suecia'),
	('CH','Suiza'),
	('SR','Surinam'),
	('SJ','Svalbard y Jan Mayen'),
	('TH','Tailandia'),
	('TW','Taiw�n'),
	('TZ','Tanzania'),
	('TJ','Tayikist�n'),
	('IO','Territorio Brit�nico del Oc�ano �ndico'),
	('TF','Territorios Australes Franceses'),
	('TL','Timor Oriental'),
	('TG','Togo'),
	('TK','Tokelau'),
	('TO','Tonga'),
	('TT','Trinidad y Tobago'),
	('TN','T�nez'),
	('TC','Islas Turcas y Caicos'),
	('TM','Turkmenist�n'),
	('TR','Turqu�a'),
	('TV','Tuvalu'),
	('UA','Ucrania'),
	('UG','Uganda'),
	('UY','Uruguay'),
	('UZ','Uzbekist�n'),
	('VU','Vanuatu'),
	('VE','Venezuela'),
	('VN','Vietnam'),
	('VG','Islas V�rgenes Brit�nicas'),
	('VI','Islas V�rgenes de los Estados Unidos'),
	('WF','Wallis y Futuna'),
	('YE','Yemen'),
	('DJ','Yibuti'),
	('ZM','Zambia'),
	('ZW','Zimbabue')
	
INSERT INTO Provincias (IDPais, Descripcion) VALUES
	(13, 'Buenos Aires'),
	(13, 'Buenos Aires-GBA'),
	(13, 'Capital Federal'),
	(13, 'Catamarca'),
	(13, 'Chaco'),
	(13, 'Chubut'),
	(13, 'C�rdoba'),
	(13, 'Corrientes'),
	(13, 'Entre R�os'),
	(13, 'Formosa'),
	(13, 'Jujuy'),
	(13, 'La Pampa'),
	(13, 'La Rioja'),
	(13, 'Mendoza'),
	(13, 'Misiones'),
	(13, 'Neuqu�n'),
	(13, 'R�o Negro'),
	(13, 'Salta'),
	(13, 'San Juan'),
	(13, 'San Luis'),
	(13, 'Santa Cruz'),
	(13, 'Santa Fe'),
	(13, 'Santiago del Estero'),
	(13, 'Tierra del Fuego'),
	(13, 'Tucum�n'),
	(75, 'Massachusetts'),
	(75, 'Texas'),
	(75, 'Illinois'),
	(180, 'Yorkshire and Humber'),
	(112, 'Toscana'),
	(112, 'Sicilia'),
	(112, 'Roma'),
	(229, 'Montevideo'),	
	(75, 'Michigan'),
	(75, 'Washington'),
	(180, 'Berkshire'),
	(112, 'Campania')


INSERT INTO Localidades (IDProvincia, Descripcion) VALUES	
	(1, '25 de Mayo'),
	(1, '3 de febrero'),
	(1, 'A. Alsina'),
	(1, 'A. Gonz�les Ch�ves'),
	(1, 'Aguas Verdes'),
	(1, 'Alberti'),
	(1, 'Arrecifes'),
	(1, 'Ayacucho'),
	(1, 'Azul'),
	(1, 'Bah�a Blanca'),
	(1, 'Balcarce'),
	(1, 'Baradero'),
	(1, 'Benito Ju�rez'),
	(1, 'Berisso'),
	(1, 'Bol�var'),
	(1, 'Bragado'),
	(1, 'Brandsen'),
	(1, 'Campana'),
	(1, 'Ca�uelas'),
	(1, 'Capilla del Se�or'),
	(1, 'Capit�n Sarmiento'),
	(1, 'Carapachay'),
	(1, 'Carhue'),
	(1, 'Caril�'),
	(1, 'Carlos Casares'),
	(1, 'Carlos Tejedor'),
	(1, 'Carmen de Areco'),
	(1, 'Carmen de Patagones'),
	(1, 'Castelli'),
	(1, 'Chacabuco'),
	(1, 'Chascom�s'),
	(1, 'Chivilcoy'),
	(1, 'Col�n'),
	(1, 'Coronel Dorrego'),
	(1, 'Coronel Pringles'),
	(1, 'Coronel Rosales'),
	(1, 'Coronel Suarez'),
	(1, 'Costa Azul'),
	(1, 'Costa Chica'),
	(1, 'Costa del Este'),
	(1, 'Costa Esmeralda'),
	(1, 'Daireaux'),
	(1, 'Darregueira'),
	(1, 'Del Viso'),
	(1, 'Dolores'),
	(1, 'Don Torcuato'),
	(1, 'Ensenada'),
	(1, 'Escobar'),
	(1, 'Exaltaci�n de la Cruz'),
	(1, 'Florentino Ameghino'),
	(1, 'Gar�n'),
	(1, 'Gral. Alvarado'),
	(1, 'Gral. Alvear'),
	(1, 'Gral. Arenales'),
	(1, 'Gral. Belgrano'),
	(1, 'Gral. Guido'),
	(1, 'Gral. Lamadrid'),
	(1, 'Gral. Las Heras'),
	(1, 'Gral. Lavalle'),
	(1, 'Gral. Madariaga'),
	(1, 'Gral. Pacheco'),
	(1, 'Gral. Paz'),
	(1, 'Gral. Pinto'),
	(1, 'Gral. Pueyrred�n'),
	(1, 'Gral. Rodr�guez'),
	(1, 'Gral. Viamonte'),
	(1, 'Gral. Villegas'),
	(1, 'Guamin�'),
	(1, 'Guernica'),
	(1, 'Hip�lito Yrigoyen'),
	(1, 'Ing. Maschwitz'),
	(1, 'Jun�n'),
	(1, 'La Plata'),
	(1, 'Laprida'),
	(1, 'Las Flores'),
	(1, 'Las Toninas'),
	(1, 'Leandro N. Alem'),
	(1, 'Lincoln'),
	(1, 'Loberia'),
	(1, 'Lobos'),
	(1, 'Los Cardales'),
	(1, 'Los Toldos'),
	(1, 'Lucila del Mar'),
	(1, 'Luj�n'),
	(1, 'Magdalena'),
	(1, 'Maip�'),
	(1, 'Mar Chiquita'),
	(1, 'Mar de Aj�'),
	(1, 'Mar de las Pampas'),
	(1, 'Mar del Plata'),
	(1, 'Mar del Tuy�'),
	(1, 'Marcos Paz'),
	(1, 'Mercedes'),
	(1, 'Miramar'),
	(1, 'Monte'),
	(1, 'Monte Hermoso'),
	(1, 'Munro'),
	(1, 'Navarro'),
	(1, 'Necochea'),
	(1, 'Olavarr�a'),
	(1, 'Partido de la Costa'),
	(1, 'Pehuaj�'),
	(1, 'Pellegrini'),
	(1, 'Pergamino'),
	(1, 'Pig��'),
	(1, 'Pila'),
	(1, 'Pilar'),
	(1, 'Pinamar'),
	(1, 'Pinar del Sol'),
	(1, 'Polvorines'),
	(1, 'Pte. Per�n'),
	(1, 'Pu�n'),
	(1, 'Punta Indio'),
	(1, 'Ramallo'),
	(1, 'Rauch'),
	(1, 'Rivadavia'),
	(1, 'Rojas'),
	(1, 'Roque P�rez'),
	(1, 'Saavedra'),
	(1, 'Saladillo'),
	(1, 'Salliquel�'),
	(1, 'Salto'),
	(1, 'San Andr�s de Giles'),
	(1, 'San Antonio de Areco'),
	(1, 'San Antonio de Padua'),
	(1, 'San Bernardo'),
	(1, 'San Cayetano'),
	(1, 'San Clemente del Tuy�'),
	(1, 'San Nicol�s'),
	(1, 'San Pedro'),
	(1, 'San Vicente'),
	(1, 'Santa Teresita'),
	(1, 'Suipacha'),
	(1, 'Tandil'),
	(1, 'Tapalqu�'),
	(1, 'Tordillo'),
	(1, 'Tornquist'),
	(1, 'Trenque Lauquen'),
	(1, 'Tres Lomas'),
	(1, 'Villa Gesell'),
	(1, 'Villarino'),
	(1, 'Z�rate'),
	(2, '11 de Septiembre'),
	(2, '20 de Junio'),
	(2, '25 de Mayo'),
	(2, 'Acassuso'),
	(2, 'Adrogu�'),
	(2, 'Aldo Bonzi'),
	(2, '�rea Reserva Cintur�n Ecol�gico'),
	(2, 'Avellaneda'),
	(2, 'Banfield'),
	(2, 'Barrio Parque'),
	(2, 'Barrio Santa Teresita'),
	(2, 'Beccar'),
	(2, 'Bella Vista'),
	(2, 'Berazategui'),
	(2, 'Bernal Este'),
	(2, 'Bernal Oeste'),
	(2, 'Billinghurst'),
	(2, 'Boulogne'),
	(2, 'Burzaco'),
	(2, 'Carapachay'),
	(2, 'Caseros'),
	(2, 'Castelar'),
	(2, 'Churruca'),
	(2, 'Ciudad Evita'),
	(2, 'Ciudad Madero'),
	(2, 'Ciudadela'),
	(2, 'Claypole'),
	(2, 'Crucecita'),
	(2, 'Dock Sud'),
	(2, 'Don Bosco'),
	(2, 'Don Orione'),
	(2, 'El Jag�el'),
	(2, 'El Libertador'),
	(2, 'El Palomar'),
	(2, 'El Tala'),
	(2, 'El Tr�bol'),
	(2, 'Ezeiza'),
	(2, 'Ezpeleta'),
	(2, 'Florencio Varela'),
	(2, 'Florida'),
	(2, 'Francisco �lvarez'),
	(2, 'Gerli'),
	(2, 'Glew'),
	(2, 'Gonz�lez Cat�n'),
	(2, 'Gral. Lamadrid'),
	(2, 'Grand Bourg'),
	(2, 'Gregorio de Laferrere'),
	(2, 'Guillermo Enrique Hudson'),
	(2, 'Haedo'),
	(2, 'Hurlingham'),
	(2, 'Ing. Sourdeaux'),
	(2, 'Isidro Casanova'),
	(2, 'Ituzaing�'),
	(2, 'Jos� C. Paz'),
	(2, 'Jos� Ingenieros'),
	(2, 'Jos� Marmol'),
	(2, 'La Lucila'),
	(2, 'La Reja'),
	(2, 'La Tablada'),
	(2, 'Lan�s'),
	(2, 'Llavallol'),
	(2, 'Loma Hermosa'),
	(2, 'Lomas de Zamora'),
	(2, 'Lomas del Mill�n'),
	(2, 'Lomas del Mirador'),
	(2, 'Longchamps'),
	(2, 'Los Polvorines'),
	(2, 'Luis Guill�n'),
	(2, 'Malvinas Argentinas'),
	(2, 'Mart�n Coronado'),
	(2, 'Mart�nez'),
	(2, 'Merlo'),
	(2, 'Ministro Rivadavia'),
	(2, 'Monte Chingolo'),
	(2, 'Monte Grande'),
	(2, 'Moreno'),
	(2, 'Mor�n'),
	(2, 'Mu�iz'),
	(2, 'Olivos'),
	(2, 'Pablo Nogu�s'),
	(2, 'Pablo Podest�'),
	(2, 'Paso del Rey'),
	(2, 'Pereyra'),
	(2, 'Pi�eiro'),
	(2, 'Pl�tanos'),
	(2, 'Pontevedra'),
	(2, 'Quilmes'),
	(2, 'Rafael Calzada'),
	(2, 'Rafael Castillo'),
	(2, 'Ramos Mej�a'),
	(2, 'Ranelagh'),
	(2, 'Remedios de Escalada'),
	(2, 'S�enz Pe�a'),
	(2, 'San Antonio de Padua'),
	(2, 'San Fernando'),
	(2, 'San Francisco Solano'),
	(2, 'San Isidro'),
	(2, 'San Jos�'),
	(2, 'San Justo'),
	(2, 'San Mart�n'),
	(2, 'San Miguel'),
	(2, 'Santos Lugares'),
	(2, 'Sarand�'),
	(2, 'Sourigues'),
	(2, 'Tapiales'),
	(2, 'Temperley'),
	(2, 'Tigre'),
	(2, 'Tortuguitas'),
	(2, 'Trist�n Su�rez'),
	(2, 'Trujui'),
	(2, 'Turdera'),
	(2, 'Valent�n Alsina'),
	(2, 'Vicente L�pez'),
	(2, 'Villa Adelina'),
	(2, 'Villa Ballester'),
	(2, 'Villa Bosch'),
	(2, 'Villa Caraza'),
	(2, 'Villa Celina'),
	(2, 'Villa Centenario'),
	(2, 'Villa de Mayo'),
	(2, 'Villa Diamante'),
	(2, 'Villa Dom�nico'),
	(2, 'Villa Espa�a'),
	(2, 'Villa Fiorito'),
	(2, 'Villa Guillermina'),
	(2, 'Villa Insuperable'),
	(2, 'Villa Jos� Le�n Su�rez'),
	(2, 'Villa La Florida'),
	(2, 'Villa Luzuriaga'),
	(2, 'Villa Martelli'),
	(2, 'Villa Obrera'),
	(2, 'Villa Progreso'),
	(2, 'Villa Raffo'),
	(2, 'Villa Sarmiento'),
	(2, 'Villa Tesei'),
	(2, 'Villa Udaondo'),
	(2, 'Virrey del Pino'),
	(2, 'Wilde'),
	(2, 'William Morris'),
	(3, 'Agronom�a'),
	(3, 'Almagro'),
	(3, 'Balvanera'),
	(3, 'Barracas'),
	(3, 'Belgrano'),
	(3, 'Boca'),
	(3, 'Boedo'),
	(3, 'Caballito'),
	(3, 'Chacarita'),
	(3, 'Coghlan'),
	(3, 'Colegiales'),
	(3, 'Constituci�n'),
	(3, 'Flores'),
	(3, 'Floresta'),
	(3, 'La Paternal'),
	(3, 'Liniers'),
	(3, 'Mataderos'),
	(3, 'Monserrat'),
	(3, 'Monte Castro'),
	(3, 'Nueva Pompeya'),
	(3, 'N��ez'),
	(3, 'Palermo'),
	(3, 'Parque Avellaneda'),
	(3, 'Parque Chacabuco'),
	(3, 'Parque Chas'),
	(3, 'Parque Patricios'),
	(3, 'Puerto Madero'),
	(3, 'Recoleta'),
	(3, 'Retiro'),
	(3, 'Saavedra'),
	(3, 'San Crist�bal'),
	(3, 'San Nicol�s'),
	(3, 'San Telmo'),
	(3, 'V�lez S�rsfield'),
	(3, 'Versalles'),
	(3, 'Villa Crespo'),
	(3, 'Villa del Parque'),
	(3, 'Villa Devoto'),
	(3, 'Villa Gral. Mitre'),
	(3, 'Villa Lugano'),
	(3, 'Villa Luro'),
	(3, 'Villa Ort�zar'),
	(3, 'Villa Pueyrred�n'),
	(3, 'Villa Real'),
	(3, 'Villa Riachuelo'),
	(3, 'Villa Santa Rita'),
	(3, 'Villa Soldati'),
	(3, 'Villa Urquiza'),
	(4, 'Aconquija'),
	(4, 'Ancasti'),
	(4, 'Andalgal�'),
	(4, 'Antofagasta'),
	(4, 'Bel�n'),
	(4, 'Capay�n'),
	(4, 'Capital'),
	(4, '4'),
	(4, 'Corral Quemado'),
	(4, 'El Alto'),
	(4, 'El Rodeo'),
	(4, 'F.Mamerto Esqui�'),
	(4, 'Fiambal�'),
	(4, 'Hualf�n'),
	(4, 'Huillapima'),
	(4, 'Ica�o'),
	(4, 'La Puerta'),
	(4, 'Las Juntas'),
	(4, 'Londres'),
	(4, 'Los Altos'),
	(4, 'Los Varela'),
	(4, 'Mutqu�n'),
	(4, 'Pacl�n'),
	(4, 'Poman'),
	(4, 'Pozo de La Piedra'),
	(4, 'Puerta de Corral'),
	(4, 'Puerta San Jos�'),
	(4, 'Recreo'),
	(4, 'S.F.V de 4'),
	(4, 'San Fernando'),
	(4, 'San Fernando del Valle'),
	(4, 'San Jos�'),
	(4, 'Santa Mar�a'),
	(4, 'Santa Rosa'),
	(4, 'Saujil'),
	(4, 'Tapso'),
	(4, 'Tinogasta'),
	(4, 'Valle Viejo'),
	(4, 'Villa Vil'),
	(5, 'Avi� Tera�'),
	(5, 'Barranqueras'),
	(5, 'Basail'),
	(5, 'Campo Largo'),
	(5, 'Capital'),
	(5, 'Capit�n Solari'),
	(5, 'Charadai'),
	(5, 'Charata'),
	(5, 'Chorotis'),
	(5, 'Ciervo Petiso'),
	(5, 'Cnel. Du Graty'),
	(5, 'Col. Ben�tez'),
	(5, 'Col. Elisa'),
	(5, 'Col. Popular'),
	(5, 'Colonias Unidas'),
	(5, 'Concepci�n'),
	(5, 'Corzuela'),
	(5, 'Cote Lai'),
	(5, 'El Sauzalito'),
	(5, 'Enrique Urien'),
	(5, 'Fontana'),
	(5, 'Fte. Esperanza'),
	(5, 'Gancedo'),
	(5, 'Gral. Capdevila'),
	(5, 'Gral. Pinero'),
	(5, 'Gral. San Mart�n'),
	(5, 'Gral. Vedia'),
	(5, 'Hermoso Campo'),
	(5, 'I. del Cerrito'),
	(5, 'J.J. Castelli'),
	(5, 'La Clotilde'),
	(5, 'La Eduvigis'),
	(5, 'La Escondida'),
	(5, 'La Leonesa'),
	(5, 'La Tigra'),
	(5, 'La Verde'),
	(5, 'Laguna Blanca'),
	(5, 'Laguna Limpia'),
	(5, 'Lapachito'),
	(5, 'Las Bre�as'),
	(5, 'Las Garcitas'),
	(5, 'Las Palmas'),
	(5, 'Los Frentones'),
	(5, 'Machagai'),
	(5, 'Makall�'),
	(5, 'Margarita Bel�n'),
	(5, 'Miraflores'),
	(5, 'Misi�n N. Pompeya'),
	(5, 'Napenay'),
	(5, 'Pampa Almir�n'),
	(5, 'Pampa del Indio'),
	(5, 'Pampa del Infierno'),
	(5, 'Pdcia. de La Plaza'),
	(5, 'Pdcia. Roca'),
	(5, 'Pdcia. Roque S�enz Pe�a'),
	(5, 'Pto. Bermejo'),
	(5, 'Pto. Eva Per�n'),
	(5, 'Puero Tirol'),
	(5, 'Puerto Vilelas'),
	(5, 'Quitilipi'),
	(5, 'Resistencia'),
	(5, 'S�enz Pe�a'),
	(5, 'Samuh�'),
	(5, 'San Bernardo'),
	(5, 'Santa Sylvina'),
	(5, 'Taco Pozo'),
	(5, 'Tres Isletas'),
	(5, 'Villa �ngela'),
	(5, 'Villa Berthet'),
	(5, 'Villa R. Bermejito'),
	(6, 'Aldea Apeleg'),
	(6, 'Aldea Beleiro'),
	(6, 'Aldea Epulef'),
	(6, 'Alto R�o Sengerr'),
	(6, 'Buen Pasto'),
	(6, 'Camarones'),
	(6, 'Carrenleuf�'),
	(6, 'Cholila'),
	(6, 'Co. Centinela'),
	(6, 'Colan Conhu�'),
	(6, 'Comodoro Rivadavia'),
	(6, 'Corcovado'),
	(6, 'Cushamen'),
	(6, 'Dique F. Ameghino'),
	(6, 'Dolav�n'),
	(6, 'Dr. R. Rojas'),
	(6, 'El Hoyo'),
	(6, 'El Mait�n'),
	(6, 'Epuy�n'),
	(6, 'Esquel'),
	(6, 'Facundo'),
	(6, 'Gaim�n'),
	(6, 'Gan Gan'),
	(6, 'Gastre'),
	(6, 'Gdor. Costa'),
	(6, 'Gualjaina'),
	(6, 'J. de San Mart�n'),
	(6, 'Lago Blanco'),
	(6, 'Lago Puelo'),
	(6, 'Lagunita Salada'),
	(6, 'Las Plumas'),
	(6, 'Los Altares'),
	(6, 'Paso de los Indios'),
	(6, 'Paso del Sapo'),
	(6, 'Pto. Madryn'),
	(6, 'Pto. Pir�mides'),
	(6, 'Rada Tilly'),
	(6, 'Rawson'),
	(6, 'R�o Mayo'),
	(6, 'R�o Pico'),
	(6, 'Sarmiento'),
	(6, 'Tecka'),
	(6, 'Telsen'),
	(6, 'Trelew'),
	(6, 'Trevelin'),
	(6, 'Veintiocho de Julio'),
	(7, 'Achiras'),
	(7, 'Adelia Maria'),
	(7, 'Agua de Oro'),
	(7, 'Alcira Gigena'),
	(7, 'Aldea Santa Maria'),
	(7, 'Alejandro Roca'),
	(7, 'Alejo Ledesma'),
	(7, 'Alicia'),
	(7, 'Almafuerte'),
	(7, 'Alpa Corral'),
	(7, 'Alta Gracia'),
	(7, 'Alto Alegre'),
	(7, 'Alto de Los Quebrachos'),
	(7, 'Altos de Chipion'),
	(7, 'Amboy'),
	(7, 'Ambul'),
	(7, 'Ana Zumaran'),
	(7, 'Anisacate'),
	(7, 'Arguello'),
	(7, 'Arias'),
	(7, 'Arroyito'),
	(7, 'Arroyo Algodon'),
	(7, 'Arroyo Cabral'),
	(7, 'Arroyo Los Patos'),
	(7, 'Assunta'),
	(7, 'Atahona'),
	(7, 'Ausonia'),
	(7, 'Avellaneda'),
	(7, 'Ballesteros'),
	(7, 'Ballesteros Sud'),
	(7, 'Balnearia'),
	(7, 'Ba�ado de Soto'),
	(7, 'Bell Ville'),
	(7, 'Bengolea'),
	(7, 'Benjamin Gould'),
	(7, 'Berrotaran'),
	(7, 'Bialet Masse'),
	(7, 'Bouwer'),
	(7, 'Brinkmann'),
	(7, 'Buchardo'),
	(7, 'Bulnes'),
	(7, 'Cabalango'),
	(7, 'Calamuchita'),
	(7, 'Calchin'),
	(7, 'Calchin Oeste'),
	(7, 'Calmayo'),
	(7, 'Camilo Aldao'),
	(7, 'Caminiaga'),
	(7, 'Ca�ada de Luque'),
	(7, 'Ca�ada de Machado'),
	(7, 'Ca�ada de Rio Pinto'),
	(7, 'Ca�ada del Sauce'),
	(7, 'Canals'),
	(7, 'Candelaria Sud'),
	(7, 'Capilla de Remedios'),
	(7, 'Capilla de Siton'),
	(7, 'Capilla del Carmen'),
	(7, 'Capilla del Monte'),
	(7, 'Capital'),
	(7, 'Capitan Gral B. O�Higgins'),
	(7, 'Carnerillo'),
	(7, 'Carrilobo'),
	(7, 'Casa Grande'),
	(7, 'Cavanagh'),
	(7, 'Cerro Colorado'),
	(7, 'Chaj�n'),
	(7, 'Chalacea'),
	(7, 'Cha�ar Viejo'),
	(7, 'Chancan�'),
	(7, 'Charbonier'),
	(7, 'Charras'),
	(7, 'Chaz�n'),
	(7, 'Chilibroste'),
	(7, 'Chucul'),
	(7, 'Chu�a'),
	(7, 'Chu�a Huasi'),
	(7, 'Churqui Ca�ada'),
	(7, 'Cienaga Del Coro'),
	(7, 'Cintra'),
	(7, 'Col. Almada'),
	(7, 'Col. Anita'),
	(7, 'Col. Barge'),
	(7, 'Col. Bismark'),
	(7, 'Col. Bremen'),
	(7, 'Col. Caroya'),
	(7, 'Col. Italiana'),
	(7, 'Col. Iturraspe'),
	(7, 'Col. Las Cuatro Esquinas'),
	(7, 'Col. Las Pichanas'),
	(7, 'Col. Marina'),
	(7, 'Col. Prosperidad'),
	(7, 'Col. San Bartolome'),
	(7, 'Col. San Pedro'),
	(7, 'Col. Tirolesa'),
	(7, 'Col. Vicente Aguero'),
	(7, 'Col. Videla'),
	(7, 'Col. Vignaud'),
	(7, 'Col. Waltelina'),
	(7, 'Colazo'),
	(7, 'Comechingones'),
	(7, 'Conlara'),
	(7, 'Copacabana'),
	(7, 'Cordoba Capital'),
	(7, 'Coronel Baigorria'),
	(7, 'Coronel Moldes'),
	(7, 'Corral de Bustos'),
	(7, 'Corralito'),
	(7, 'Cosqu�n'),
	(7, 'Costa Sacate'),
	(7, 'Cruz Alta'),
	(7, 'Cruz de Ca�a'),
	(7, 'Cruz del Eje'),
	(7, 'Cuesta Blanca'),
	(7, 'Dean Funes'),
	(7, 'Del Campillo'),
	(7, 'Despe�aderos'),
	(7, 'Devoto'),
	(7, 'Diego de Rojas'),
	(7, 'Dique Chico'),
	(7, 'El Ara�ado'),
	(7, 'El Brete'),
	(7, 'El Chacho'),
	(7, 'El Crisp�n'),
	(7, 'El Fort�n'),
	(7, 'El Manzano'),
	(7, 'El Rastreador'),
	(7, 'El Rodeo'),
	(7, 'El T�o'),
	(7, 'Elena'),
	(7, 'Embalse'),
	(7, 'Esquina'),
	(7, 'Estaci�n Gral. Paz'),
	(7, 'Estaci�n Ju�rez Celman'),
	(7, 'Estancia de Guadalupe'),
	(7, 'Estancia Vieja'),
	(7, 'Etruria'),
	(7, 'Eufrasio Loza'),
	(7, 'Falda del Carmen'),
	(7, 'Freyre'),
	(7, 'Gral. Baldissera'),
	(7, 'Gral. Cabrera'),
	(7, 'Gral. Deheza'),
	(7, 'Gral. Fotheringham'),
	(7, 'Gral. Levalle'),
	(7, 'Gral. Roca'),
	(7, 'Guanaco Muerto'),
	(7, 'Guasapampa'),
	(7, 'Guatimozin'),
	(7, 'Gutenberg'),
	(7, 'Hernando'),
	(7, 'Huanchillas'),
	(7, 'Huerta Grande'),
	(7, 'Huinca Renanco'),
	(7, 'Idiazabal'),
	(7, 'Impira'),
	(7, 'Inriville'),
	(7, 'Isla Verde'),
	(7, 'Ital�'),
	(7, 'James Craik'),
	(7, 'Jes�s Mar�a'),
	(7, 'Jovita'),
	(7, 'Justiniano Posse'),
	(7, 'Km 658'),
	(7, 'L. V. Mansilla'),
	(7, 'La Batea'),
	(7, 'La Calera'),
	(7, 'La Carlota'),
	(7, 'La Carolina'),
	(7, 'La Cautiva'),
	(7, 'La Cesira'),
	(7, 'La Cruz'),
	(7, 'La Cumbre'),
	(7, 'La Cumbrecita'),
	(7, 'La Falda'),
	(7, 'La Francia'),
	(7, 'La Granja'),
	(7, 'La Higuera'),
	(7, 'La Laguna'),
	(7, 'La Paisanita'),
	(7, 'La Palestina'),
	(7, '12'),
	(7, 'La Paquita'),
	(7, 'La Para'),
	(7, 'La Paz'),
	(7, 'La Playa'),
	(7, 'La Playosa'),
	(7, 'La Poblaci�n'),
	(7, 'La Posta'),
	(7, 'La Puerta'),
	(7, 'La Quinta'),
	(7, 'La Rancherita'),
	(7, 'La Rinconada'),
	(7, 'La Serranita'),
	(7, 'La Tordilla'),
	(7, 'Laborde'),
	(7, 'Laboulaye'),
	(7, 'Laguna Larga'),
	(7, 'Las Acequias'),
	(7, 'Las Albahacas'),
	(7, 'Las Arrias'),
	(7, 'Las Bajadas'),
	(7, 'Las Caleras'),
	(7, 'Las Calles'),
	(7, 'Las Ca�adas'),
	(7, 'Las Gramillas'),
	(7, 'Las Higueras'),
	(7, 'Las Isletillas'),
	(7, 'Las Junturas'),
	(7, 'Las Palmas'),
	(7, 'Las Pe�as'),
	(7, 'Las Pe�as Sud'),
	(7, 'Las Perdices'),
	(7, 'Las Playas'),
	(7, 'Las Rabonas'),
	(7, 'Las Saladas'),
	(7, 'Las Tapias'),
	(7, 'Las Varas'),
	(7, 'Las Varillas'),
	(7, 'Las Vertientes'),
	(7, 'Leguizam�n'),
	(7, 'Leones'),
	(7, 'Los Cedros'),
	(7, 'Los Cerrillos'),
	(7, 'Los Cha�aritos (C.E)'),
	(7, 'Los Chanaritos (R.S)'),
	(7, 'Los Cisnes'),
	(7, 'Los Cocos'),
	(7, 'Los C�ndores'),
	(7, 'Los Hornillos'),
	(7, 'Los Hoyos'),
	(7, 'Los Mistoles'),
	(7, 'Los Molinos'),
	(7, 'Los Pozos'),
	(7, 'Los Reartes'),
	(7, 'Los Surgentes'),
	(7, 'Los Talares'),
	(7, 'Los Zorros'),
	(7, 'Lozada'),
	(7, 'Luca'),
	(7, 'Luque'),
	(7, 'Luyaba'),
	(7, 'Malague�o'),
	(7, 'Malena'),
	(7, 'Malvinas Argentinas'),
	(7, 'Manfredi'),
	(7, 'Maquinista Gallini'),
	(7, 'Marcos Ju�rez'),
	(7, 'Marull'),
	(7, 'Matorrales'),
	(7, 'Mattaldi'),
	(7, 'Mayu Sumaj'),
	(7, 'Media Naranja'),
	(7, 'Melo'),
	(7, 'Mendiolaza'),
	(7, 'Mi Granja'),
	(7, 'Mina Clavero'),
	(7, 'Miramar'),
	(7, 'Morrison'),
	(7, 'Morteros'),
	(7, 'Mte. Buey'),
	(7, 'Mte. Cristo'),
	(7, 'Mte. De Los Gauchos'),
	(7, 'Mte. Le�a'),
	(7, 'Mte. Ma�z'),
	(7, 'Mte. Ralo'),
	(7, 'Nicol�s Bruzone'),
	(7, 'Noetinger'),
	(7, 'Nono'),
	(7, 'Nueva 7'),
	(7, 'Obispo Trejo'),
	(7, 'Olaeta'),
	(7, 'Oliva'),
	(7, 'Olivares San Nicol�s'),
	(7, 'Onagolty'),
	(7, 'Oncativo'),
	(7, 'Ordo�ez'),
	(7, 'Pacheco De Melo'),
	(7, 'Pampayasta N.'),
	(7, 'Pampayasta S.'),
	(7, 'Panaholma'),
	(7, 'Pascanas'),
	(7, 'Pasco'),
	(7, 'Paso del Durazno'),
	(7, 'Paso Viejo'),
	(7, 'Pilar'),
	(7, 'Pinc�n'),
	(7, 'Piquill�n'),
	(7, 'Plaza de Mercedes'),
	(7, 'Plaza Luxardo'),
	(7, 'Porte�a'),
	(7, 'Potrero de Garay'),
	(7, 'Pozo del Molle'),
	(7, 'Pozo Nuevo'),
	(7, 'Pueblo Italiano'),
	(7, 'Puesto de Castro'),
	(7, 'Punta del Agua'),
	(7, 'Quebracho Herrado'),
	(7, 'Quilino'),
	(7, 'Rafael Garc�a'),
	(7, 'Ranqueles'),
	(7, 'Rayo Cortado'),
	(7, 'Reducci�n'),
	(7, 'Rinc�n'),
	(7, 'R�o Bamba'),
	(7, 'R�o Ceballos'),
	(7, 'R�o Cuarto'),
	(7, 'R�o de Los Sauces'),
	(7, 'R�o Primero'),
	(7, 'R�o Segundo'),
	(7, 'R�o Tercero'),
	(7, 'Rosales'),
	(7, 'Rosario del Saladillo'),
	(7, 'Sacanta'),
	(7, 'Sagrada Familia'),
	(7, 'Saira'),
	(7, 'Saladillo'),
	(7, 'Sald�n'),
	(7, 'Salsacate'),
	(7, 'Salsipuedes'),
	(7, 'Sampacho'),
	(7, 'San Agust�n'),
	(7, 'San Antonio de Arredondo'),
	(7, 'San Antonio de Lit�n'),
	(7, 'San Basilio'),
	(7, 'San Carlos Minas'),
	(7, 'San Clemente'),
	(7, 'San Esteban'),
	(7, 'San Francisco'),
	(7, 'San Ignacio'),
	(7, 'San Javier'),
	(7, 'San Jer�nimo'),
	(7, 'San Joaqu�n'),
	(7, 'San Jos� de La Dormida'),
	(7, 'San Jos� de Las Salinas'),
	(7, 'San Lorenzo'),
	(7, 'San Marcos Sierras'),
	(7, 'San Marcos Sud'),
	(7, 'San Pedro'),
	(7, 'San Pedro N.'),
	(7, 'San Roque'),
	(7, 'San Vicente'),
	(7, 'Santa Catalina'),
	(7, 'Santa Elena'),
	(7, 'Santa Eufemia'),
	(7, 'Santa Maria'),
	(7, 'Sarmiento'),
	(7, 'Saturnino M.Laspiur'),
	(7, 'Sauce Arriba'),
	(7, 'Sebasti�n Elcano'),
	(7, 'Seeber'),
	(7, 'Segunda Usina'),
	(7, 'Serrano'),
	(7, 'Serrezuela'),
	(7, 'Sgo. Temple'),
	(7, 'Silvio Pellico'),
	(7, 'Simbolar'),
	(7, 'Sinsacate'),
	(7, 'Sta. Rosa de Calamuchita'),
	(7, 'Sta. Rosa de R�o Primero'),
	(7, 'Suco'),
	(7, 'Tala Ca�ada'),
	(7, 'Tala Huasi'),
	(7, 'Talaini'),
	(7, 'Tancacha'),
	(7, 'Tanti'),
	(7, 'Ticino'),
	(7, 'Tinoco'),
	(7, 'T�o Pujio'),
	(7, 'Toledo'),
	(7, 'Toro Pujio'),
	(7, 'Tosno'),
	(7, 'Tosquita'),
	(7, 'Tr�nsito'),
	(7, 'Tuclame'),
	(7, 'Tutti'),
	(7, 'Ucacha'),
	(7, 'Unquillo'),
	(7, 'Valle de Anisacate'),
	(7, 'Valle Hermoso'),
	(7, 'V�lez Sarfield'),
	(7, 'Viamonte'),
	(7, 'Vicu�a Mackenna'),
	(7, 'Villa Allende'),
	(7, 'Villa Amancay'),
	(7, 'Villa Ascasubi'),
	(7, 'Villa Candelaria N.'),
	(7, 'Villa Carlos Paz'),
	(7, 'Villa Cerro Azul'),
	(7, 'Villa Ciudad de Am�rica'),
	(7, 'Villa Ciudad Pque Los Reartes'),
	(7, 'Villa Concepci�n del T�o'),
	(7, 'Villa Cura Brochero'),
	(7, 'Villa de Las Rosas'),
	(7, 'Villa de Mar�a'),
	(7, 'Villa de Pocho'),
	(7, 'Villa de Soto'),
	(7, 'Villa del Dique'),
	(7, 'Villa del Prado'),
	(7, 'Villa del Rosario'),
	(7, 'Villa del Totoral'),
	(7, 'Villa Dolores'),
	(7, 'Villa El Chancay'),
	(7, 'Villa Elisa'),
	(7, 'Villa Flor Serrana'),
	(7, 'Villa Fontana'),
	(7, 'Villa Giardino'),
	(7, 'Villa Gral. Belgrano'),
	(7, 'Villa Gutierrez'),
	(7, 'Villa Huidobro'),
	(7, 'Villa La Bolsa'),
	(7, 'Villa Los Aromos'),
	(7, 'Villa Los Patos'),
	(7, 'Villa Mar�a'),
	(7, 'Villa Nueva'),
	(7, 'Villa Pque. Santa Ana'),
	(7, 'Villa Pque. Siquiman'),
	(7, 'Villa Quillinzo'),
	(7, 'Villa Rossi'),
	(7, 'Villa Rumipal'),
	(7, 'Villa San Esteban'),
	(7, 'Villa San Isidro'),
	(7, 'Villa 21'),
	(7, 'Villa Sarmiento (G.R)'),
	(7, 'Villa Sarmiento (S.A)'),
	(7, 'Villa Tulumba'),
	(7, 'Villa Valeria'),
	(7, 'Villa Yacanto'),
	(7, 'Washington'),
	(7, 'Wenceslao Escalante'),
	(7, 'Ycho Cruz Sierras'),
	(8, 'Alvear'),
	(8, 'Bella Vista'),
	(8, 'Ber�n de Astrada'),
	(8, 'Bonpland'),
	(8, 'Ca� Cati'),
	(8, 'Capital'),
	(8, 'Chavarr�a'),
	(8, 'Col. C. Pellegrini'),
	(8, 'Col. Libertad'),
	(8, 'Col. Liebig'),
	(8, 'Col. Sta Rosa'),
	(8, 'Concepci�n'),
	(8, 'Cruz de Los Milagros'),
	(8, 'Curuz�-Cuati�'),
	(8, 'Empedrado'),
	(8, 'Esquina'),
	(8, 'Estaci�n Torrent'),
	(8, 'Felipe Yofr�'),
	(8, 'Garruchos'),
	(8, 'Gdor. Agr�nomo'),
	(8, 'Gdor. Mart�nez'),
	(8, 'Goya'),
	(8, 'Guaviravi'),
	(8, 'Herlitzka'),
	(8, 'Ita-Ibate'),
	(8, 'Itat�'),
	(8, 'Ituzaing�'),
	(8, 'Jos� Rafael G�mez'),
	(8, 'Juan Pujol'),
	(8, 'La Cruz'),
	(8, 'Lavalle'),
	(8, 'Lomas de Vallejos'),
	(8, 'Loreto'),
	(8, 'Mariano I. Loza'),
	(8, 'Mburucuy�'),
	(8, 'Mercedes'),
	(8, 'Mocoret�'),
	(8, 'Mte. Caseros'),
	(8, 'Nueve de Julio'),
	(8, 'Palmar Grande'),
	(8, 'Parada Pucheta'),
	(8, 'Paso de La Patria'),
	(8, 'Paso de Los Libres'),
	(8, 'Pedro R. Fernandez'),
	(8, 'Perugorr�a'),
	(8, 'Pueblo Libertador'),
	(8, 'Ramada Paso'),
	(8, 'Riachuelo'),
	(8, 'Saladas'),
	(8, 'San Antonio'),
	(8, 'San Carlos'),
	(8, 'San Cosme'),
	(8, 'San Lorenzo'),
	(8, '20 del Palmar'),
	(8, 'San Miguel'),
	(8, 'San Roque'),
	(8, 'Santa Ana'),
	(8, 'Santa Luc�a'),
	(8, 'Santo Tom�'),
	(8, 'Sauce'),
	(8, 'Tabay'),
	(8, 'Tapebicu�'),
	(8, 'Tatacua'),
	(8, 'Virasoro'),
	(8, 'Yapey�'),
	(8, 'Yatait� Calle'),
	(9, 'Alarc�n'),
	(9, 'Alcaraz'),
	(9, 'Alcaraz N.'),
	(9, 'Alcaraz S.'),
	(9, 'Aldea Asunci�n'),
	(9, 'Aldea Brasilera'),
	(9, 'Aldea Elgenfeld'),
	(9, 'Aldea Grapschental'),
	(9, 'Aldea Ma. Luisa'),
	(9, 'Aldea Protestante'),
	(9, 'Aldea Salto'),
	(9, 'Aldea San Antonio (G)'),
	(9, 'Aldea San Antonio (P)'),
	(9, 'Aldea 19'),
	(9, 'Aldea San Miguel'),
	(9, 'Aldea San Rafael'),
	(9, 'Aldea Spatzenkutter'),
	(9, 'Aldea Sta. Mar�a'),
	(9, 'Aldea Sta. Rosa'),
	(9, 'Aldea Valle Mar�a')
INSERT INTO Localidades (IDProvincia, Descripcion) VALUES	
	(9, 'Altamirano Sur'),
	(9, 'Antelo'),
	(9, 'Antonio Tom�s'),
	(9, 'Aranguren'),
	(9, 'Arroyo Bar�'),
	(9, 'Arroyo Burgos'),
	(9, 'Arroyo Cl�'),
	(9, 'Arroyo Corralito'),
	(9, 'Arroyo del Medio'),
	(9, 'Arroyo Maturrango'),
	(9, 'Arroyo Palo Seco'),
	(9, 'Banderas'),
	(9, 'Basavilbaso'),
	(9, 'Betbeder'),
	(9, 'Bovril'),
	(9, 'Caseros'),
	(9, 'Ceibas'),
	(9, 'Cerrito'),
	(9, 'Chajar�'),
	(9, 'Chilcas'),
	(9, 'Clodomiro Ledesma'),
	(9, 'Col. Alemana'),
	(9, 'Col. Avellaneda'),
	(9, 'Col. Avigdor'),
	(9, 'Col. Ayu�'),
	(9, 'Col. Baylina'),
	(9, 'Col. Carrasco'),
	(9, 'Col. Celina'),
	(9, 'Col. Cerrito'),
	(9, 'Col. Crespo'),
	(9, 'Col. Elia'),
	(9, 'Col. Ensayo'),
	(9, 'Col. Gral. Roca'),
	(9, 'Col. La Argentina'),
	(9, 'Col. Merou'),
	(9, 'Col. Oficial N�3'),
	(9, 'Col. Oficial N�13'),
	(9, 'Col. Oficial N�14'),
	(9, 'Col. Oficial N�5'),
	(9, 'Col. Reffino'),
	(9, 'Col. Tunas'),
	(9, 'Col. Virar�'),
	(9, 'Col�n'),
	(9, 'Concepci�n del Uruguay'),
	(9, 'Concordia'),
	(9, 'Conscripto Bernardi'),
	(9, 'Costa Grande'),
	(9, 'Costa San Antonio'),
	(9, 'Costa Uruguay N.'),
	(9, 'Costa Uruguay S.'),
	(9, 'Crespo'),
	(9, 'Crucecitas 3�'),
	(9, 'Crucecitas 7�'),
	(9, 'Crucecitas 8�'),
	(9, 'Cuchilla Redonda'),
	(9, 'Curtiembre'),
	(9, 'Diamante'),
	(9, 'Distrito 6�'),
	(9, 'Distrito Cha�ar'),
	(9, 'Distrito Chiqueros'),
	(9, 'Distrito Cuarto'),
	(9, 'Distrito Diego L�pez'),
	(9, 'Distrito Pajonal'),
	(9, 'Distrito Sauce'),
	(9, 'Distrito Tala'),
	(9, 'Distrito Talitas'),
	(9, 'Don Crist�bal 1� Secci�n'),
	(9, 'Don Crist�bal 2� Secci�n'),
	(9, 'Durazno'),
	(9, 'El Cimarr�n'),
	(9, 'El Gramillal'),
	(9, 'El Palenque'),
	(9, 'El Pingo'),
	(9, 'El Quebracho'),
	(9, 'El Redom�n'),
	(9, 'El Solar'),
	(9, 'Enrique Carbo'),
	(9, '9'),
	(9, 'Espinillo N.'),
	(9, 'Estaci�n Campos'),
	(9, 'Estaci�n Escri�a'),
	(9, 'Estaci�n Lazo'),
	(9, 'Estaci�n Ra�ces'),
	(9, 'Estaci�n Yer�a'),
	(9, 'Estancia Grande'),
	(9, 'Estancia L�baros'),
	(9, 'Estancia Racedo'),
	(9, 'Estancia Sol�'),
	(9, 'Estancia Yuquer�'),
	(9, 'Estaquitas'),
	(9, 'Faustino M. Parera'),
	(9, 'Febre'),
	(9, 'Federaci�n'),
	(9, 'Federal'),
	(9, 'Gdor. Echag�e'),
	(9, 'Gdor. Mansilla'),
	(9, 'Gilbert'),
	(9, 'Gonz�lez Calder�n'),
	(9, 'Gral. Almada'),
	(9, 'Gral. Alvear'),
	(9, 'Gral. Campos'),
	(9, 'Gral. Galarza'),
	(9, 'Gral. Ram�rez'),
	(9, 'Gualeguay'),
	(9, 'Gualeguaych�'),
	(9, 'Gualeguaycito'),
	(9, 'Guardamonte'),
	(9, 'Hambis'),
	(9, 'Hasenkamp'),
	(9, 'Hernandarias'),
	(9, 'Hern�ndez'),
	(9, 'Herrera'),
	(9, 'Hinojal'),
	(9, 'Hocker'),
	(9, 'Ing. Sajaroff'),
	(9, 'Irazusta'),
	(9, 'Isletas'),
	(9, 'J.J De Urquiza'),
	(9, 'Jubileo'),
	(9, 'La Clarita'),
	(9, 'La Criolla'),
	(9, 'La Esmeralda'),
	(9, 'La Florida'),
	(9, 'La Fraternidad'),
	(9, 'La Hierra'),
	(9, 'La Ollita'),
	(9, 'La Paz'),
	(9, 'La Picada'),
	(9, 'La Providencia'),
	(9, 'La Verbena'),
	(9, 'Laguna Ben�tez'),
	(9, 'Larroque'),
	(9, 'Las Cuevas'),
	(9, 'Las Garzas'),
	(9, 'Las Guachas'),
	(9, 'Las Mercedes'),
	(9, 'Las Moscas'),
	(9, 'Las Mulitas'),
	(9, 'Las Toscas'),
	(9, 'Laurencena'),
	(9, 'Libertador San Mart�n'),
	(9, 'Loma Limpia'),
	(9, 'Los Ceibos'),
	(9, 'Los Charruas'),
	(9, 'Los Conquistadores'),
	(9, 'Lucas Gonz�lez'),
	(9, 'Lucas N.'),
	(9, 'Lucas S. 1�'),
	(9, 'Lucas S. 2�'),
	(9, 'Maci�'),
	(9, 'Mar�a Grande'),
	(9, 'Mar�a Grande 2�'),
	(9, 'M�danos'),
	(9, 'Mojones N.'),
	(9, 'Mojones S.'),
	(9, 'Molino Doll'),
	(9, 'Monte Redondo'),
	(9, 'Montoya'),
	(9, 'Mulas Grandes'),
	(9, '�ancay'),
	(9, 'Nogoy�'),
	(9, 'Nueva Escocia'),
	(9, 'Nueva Vizcaya'),
	(9, 'Omb�'),
	(9, 'Oro Verde'),
	(9, 'Paran�'),
	(9, 'Pasaje Guayaquil'),
	(9, 'Pasaje Las Tunas'),
	(9, 'Paso de La Arena'),
	(9, 'Paso de La Laguna'),
	(9, 'Paso de Las Piedras'),
	(9, 'Paso Duarte'),
	(9, 'Pastor Britos'),
	(9, 'Pedernal'),
	(9, 'Perdices'),
	(9, 'Picada Ber�n'),
	(9, 'Piedras Blancas'),
	(9, 'Primer Distrito Cuchilla'),
	(9, 'Primero de Mayo'),
	(9, 'Pronunciamiento'),
	(9, 'Pto. Algarrobo'),
	(9, 'Pto. Ibicuy'),
	(9, 'Pueblo Brugo'),
	(9, 'Pueblo Cazes'),
	(9, 'Pueblo Gral. Belgrano'),
	(9, 'Pueblo Liebig'),
	(9, 'Puerto Yeru�'),
	(9, 'Punta del Monte'),
	(9, 'Quebracho'),
	(9, 'Quinto Distrito'),
	(9, 'Raices Oeste'),
	(9, 'Rinc�n de Nogoy�'),
	(9, 'Rinc�n del Cinto'),
	(9, 'Rinc�n del Doll'),
	(9, 'Rinc�n del Gato'),
	(9, 'Rocamora'),
	(9, 'Rosario del Tala'),
	(9, 'San Benito'),
	(9, 'San Cipriano'),
	(9, 'San Ernesto'),
	(9, 'San Gustavo'),
	(9, 'San Jaime'),
	(9, 'San Jos�'),
	(9, 'San Jos� de Feliciano'),
	(9, 'San Justo'),
	(9, 'San Marcial'),
	(9, 'San Pedro'),
	(9, 'San Ram�rez'),
	(9, 'San Ram�n'),
	(9, 'San Roque'),
	(9, 'San Salvador'),
	(9, 'San V�ctor'),
	(9, 'Santa Ana'),
	(9, 'Santa Anita'),
	(9, 'Santa Elena'),
	(9, 'Santa Luc�a'),
	(9, 'Santa Luisa'),
	(9, 'Sauce de Luna'),
	(9, 'Sauce Montrull'),
	(9, 'Sauce Pinto'),
	(9, 'Sauce Sur'),
	(9, 'Segu�'),
	(9, 'Sir Leonard'),
	(9, 'Sosa'),
	(9, 'Tabossi'),
	(9, 'Tezanos Pinto'),
	(9, 'Ubajay'),
	(9, 'Urdinarrain'),
	(9, 'Veinte de Septiembre'),
	(9, 'Viale'),
	(9, 'Victoria'),
	(9, 'Villa Clara'),
	(9, 'Villa del Rosario'),
	(9, 'Villa Dom�nguez'),
	(9, 'Villa Elisa'),
	(9, 'Villa Fontana'),
	(9, 'Villa Gdor. Etchevehere'),
	(9, 'Villa Mantero'),
	(9, 'Villa Paranacito'),
	(9, 'Villa Urquiza'),
	(9, 'Villaguay'),
	(9, 'Walter Moss'),
	(9, 'Yacar�'),
	(9, 'Yeso Oeste'),
	(10, 'Buena Vista'),
	(10, 'Clorinda'),
	(10, 'Col. Pastoril'),
	(10, 'Cte. Fontana'),
	(10, 'El Colorado'),
	(10, 'El Espinillo'),
	(10, 'Estanislao Del Campo'),
	(10, '10'),
	(10, 'Fort�n Lugones'),
	(10, 'Gral. Lucio V. Mansilla'),
	(10, 'Gral. Manuel Belgrano'),
	(10, 'Gral. Mosconi'),
	(10, 'Gran Guardia'),
	(10, 'Herradura'),
	(10, 'Ibarreta'),
	(10, 'Ing. Ju�rez'),
	(10, 'Laguna Blanca'),
	(10, 'Laguna Naick Neck'),
	(10, 'Laguna Yema'),
	(10, 'Las Lomitas'),
	(10, 'Los Chiriguanos'),
	(10, 'Mayor V. Villafa�e'),
	(10, 'Misi�n San Fco.'),
	(10, 'Palo Santo'),
	(10, 'Piran�'),
	(10, 'Pozo del Maza'),
	(10, 'Riacho He-He'),
	(10, 'San Hilario'),
	(10, 'San Mart�n II'),
	(10, 'Siete Palmas'),
	(10, 'Subteniente Per�n'),
	(10, 'Tres Lagunas'),
	(10, 'Villa Dos Trece'),
	(10, 'Villa Escolar'),
	(10, 'Villa Gral. G�emes'),
	(11, 'Abdon Castro Tolay'),
	(11, 'Abra Pampa'),
	(11, 'Abralaite'),
	(11, 'Aguas Calientes'),
	(11, 'Arrayanal'),
	(11, 'Barrios'),
	(11, 'Caimancito'),
	(11, 'Calilegua'),
	(11, 'Cangrejillos'),
	(11, 'Caspala'),
	(11, 'Catu�'),
	(11, 'Cieneguillas'),
	(11, 'Coranzulli'),
	(11, 'Cusi-Cusi'),
	(11, 'El Aguilar'),
	(11, 'El Carmen'),
	(11, 'El C�ndor'),
	(11, 'El Fuerte'),
	(11, 'El Piquete'),
	(11, 'El Talar'),
	(11, 'Fraile Pintado'),
	(11, 'Hip�lito Yrigoyen'),
	(11, 'Huacalera'),
	(11, 'Humahuaca'),
	(11, 'La Esperanza'),
	(11, 'La Mendieta'),
	(11, 'La Quiaca'),
	(11, 'Ledesma'),
	(11, 'Libertador Gral. San Martin'),
	(11, 'Maimara'),
	(11, 'Mina Pirquitas'),
	(11, 'Monterrico'),
	(11, 'Palma Sola'),
	(11, 'Palpal�'),
	(11, 'Pampa Blanca'),
	(11, 'Pampichuela'),
	(11, 'Perico'),
	(11, 'Puesto del Marqu�s'),
	(11, 'Puesto Viejo'),
	(11, 'Pumahuasi'),
	(11, 'Purmamarca'),
	(11, 'Rinconada'),
	(11, 'Rodeitos'),
	(11, 'Rosario de R�o Grande'),
	(11, 'San Antonio'),
	(11, 'San Francisco'),
	(11, 'San Pedro'),
	(11, 'San Rafael'),
	(11, 'San Salvador'),
	(11, 'Santa Ana'),
	(11, 'Santa Catalina'),
	(11, 'Santa Clara'),
	(11, 'Susques'),
	(11, 'Tilcara'),
	(11, 'Tres Cruces'),
	(11, 'Tumbaya'),
	(11, 'Valle Grande'),
	(11, 'Vinalito'),
	(11, 'Volc�n'),
	(11, 'Yala'),
	(11, 'Yav�'),
	(11, 'Yuto'),
	(12, 'Abramo'),
	(12, 'Adolfo Van Praet'),
	(12, 'Agustoni'),
	(12, 'Algarrobo del Aguila'),
	(12, 'Alpachiri'),
	(12, 'Alta Italia'),
	(12, 'Anguil'),
	(12, 'Arata'),
	(12, 'Ataliva Roca'),
	(12, 'Bernardo Larroude'),
	(12, 'Bernasconi'),
	(12, 'Caleuf�'),
	(12, 'Carro Quemado'),
	(12, 'Catril�'),
	(12, 'Ceballos'),
	(12, 'Chacharramendi'),
	(12, 'Col. Bar�n'),
	(12, 'Col. Santa Mar�a'),
	(12, 'Conhelo'),
	(12, 'Coronel Hilario Lagos'),
	(12, 'Cuchillo-C�'),
	(12, 'Doblas'),
	(12, 'Dorila'),
	(12, 'Eduardo Castex'),
	(12, 'Embajador Martini'),
	(12, 'Falucho'),
	(12, 'Gral. Acha'),
	(12, 'Gral. Manuel Campos'),
	(12, 'Gral. Pico'),
	(12, 'Guatrach�'),
	(12, 'Ing. Luiggi'),
	(12, 'Intendente Alvear'),
	(12, 'Jacinto Arauz'),
	(12, 'La Adela'),
	(12, 'La Humada'),
	(12, 'La Maruja'),
	(12, '12'),
	(12, 'La Reforma'),
	(12, 'Limay Mahuida'),
	(12, 'Lonquimay'),
	(12, 'Loventuel'),
	(12, 'Luan Toro'),
	(12, 'Macach�n'),
	(12, 'Maisonnave'),
	(12, 'Mauricio Mayer'),
	(12, 'Metileo'),
	(12, 'Miguel Can�'),
	(12, 'Miguel Riglos'),
	(12, 'Monte Nievas'),
	(12, 'Parera'),
	(12, 'Per�'),
	(12, 'Pichi-Huinca'),
	(12, 'Puelches'),
	(12, 'Puel�n'),
	(12, 'Quehue'),
	(12, 'Quem� Quem�'),
	(12, 'Quetrequ�n'),
	(12, 'Rancul'),
	(12, 'Realic�'),
	(12, 'Relmo'),
	(12, 'Rol�n'),
	(12, 'Rucanelo'),
	(12, 'Sarah'),
	(12, 'Speluzzi'),
	(12, 'Sta. Isabel'),
	(12, 'Sta. Rosa'),
	(12, 'Sta. Teresa'),
	(12, 'Tel�n'),
	(12, 'Toay'),
	(12, 'Tomas M. de Anchorena'),
	(12, 'Trenel'),
	(12, 'Unanue'),
	(12, 'Uriburu'),
	(12, 'Veinticinco de Mayo'),
	(12, 'Vertiz'),
	(12, 'Victorica'),
	(12, 'Villa Mirasol'),
	(12, 'Winifreda'),
	(13, 'Arauco'),
	(13, 'Capital'),
	(13, 'Castro Barros'),
	(13, 'Chamical'),
	(13, 'Chilecito'),
	(13, 'Coronel F. Varela'),
	(13, 'Famatina'),
	(13, 'Gral. A.V.Pe�aloza'),
	(13, 'Gral. Belgrano'),
	(13, 'Gral. J.F. Quiroga'),
	(13, 'Gral. Lamadrid'),
	(13, 'Gral. Ocampo'),
	(13, 'Gral. San Mart�n'),
	(13, 'Independencia'),
	(13, 'Rosario Penaloza'),
	(13, 'San Blas de Los Sauces'),
	(13, 'Sanagasta'),
	(13, 'Vinchina'),
	(14, 'Capital'),
	(14, 'Chacras de Coria'),
	(14, 'Dorrego'),
	(14, 'Gllen'),
	(14, 'Godoy Cruz'),
	(14, 'Gral. Alvear'),
	(14, 'Guaymall�n'),
	(14, 'Jun�n'),
	(14, 'La Paz'),
	(14, 'Las Heras'),
	(14, 'Lavalle'),
	(14, 'Luj�n'),
	(14, 'Luj�n De Cuyo'),
	(14, 'Maip�'),
	(14, 'Malarg�e'),
	(14, 'Rivadavia'),
	(14, 'San Carlos'),
	(14, 'San Mart�n'),
	(14, 'San Rafael'),
	(14, 'Sta. Rosa'),
	(14, 'Tunuy�n'),
	(14, 'Tupungato'),
	(14, 'Villa Nueva'),
	(15, 'Alba Posse'),
	(15, 'Almafuerte'),
	(15, 'Ap�stoles'),
	(15, 'Arist�bulo Del Valle'),
	(15, 'Arroyo Del Medio'),
	(15, 'Azara'),
	(15, 'Bdo. De Irigoyen'),
	(15, 'Bonpland'),
	(15, 'Ca� Yari'),
	(15, 'Campo Grande'),
	(15, 'Campo Ram�n'),
	(15, 'Campo Viera'),
	(15, 'Candelaria'),
	(15, 'Capiov�'),
	(15, 'Caraguatay'),
	(15, 'Cdte. Guacurar�'),
	(15, 'Cerro Azul'),
	(15, 'Cerro Cor�'),
	(15, 'Col. Alberdi'),
	(15, 'Col. Aurora'),
	(15, 'Col. Delicia'),
	(15, 'Col. Polana'),
	(15, 'Col. Victoria'),
	(15, 'Col. Wanda'),
	(15, 'Concepci�n De La Sierra'),
	(15, 'Corpus'),
	(15, 'Dos Arroyos'),
	(15, 'Dos de Mayo'),
	(15, 'El Alc�zar'),
	(15, 'El Dorado'),
	(15, 'El Soberbio'),
	(15, 'Esperanza'),
	(15, 'F. Ameghino'),
	(15, 'Fachinal'),
	(15, 'Garuhap�'),
	(15, 'Garup�'),
	(15, 'Gdor. L�pez'),
	(15, 'Gdor. Roca'),
	(15, 'Gral. Alvear'),
	(15, 'Gral. Urquiza'),
	(15, 'Guaran�'),
	(15, 'H. Yrigoyen'),
	(15, 'Iguaz�'),
	(15, 'Itacaruar�'),
	(15, 'Jard�n Am�rica'),
	(15, 'Leandro N. Alem'),
	(15, 'Libertad'),
	(15, 'Loreto'),
	(15, 'Los Helechos'),
	(15, 'M�rtires'),
	(15, '15'),
	(15, 'Moj�n Grande'),
	(15, 'Montecarlo'),
	(15, 'Nueve de Julio'),
	(15, 'Ober�'),
	(15, 'Olegario V. Andrade'),
	(15, 'Panamb�'),
	(15, 'Posadas'),
	(15, 'Profundidad'),
	(15, 'Pto. Iguaz�'),
	(15, 'Pto. Leoni'),
	(15, 'Pto. Piray'),
	(15, 'Pto. Rico'),
	(15, 'Ruiz de Montoya'),
	(15, 'San Antonio'),
	(15, 'San Ignacio'),
	(15, 'San Javier'),
	(15, 'San Jos�'),
	(15, 'San Mart�n'),
	(15, 'San Pedro'),
	(15, 'San Vicente'),
	(15, 'Santiago De Liniers'),
	(15, 'Santo Pipo'),
	(15, 'Sta. Ana'),
	(15, 'Sta. Mar�a'),
	(15, 'Tres Capones'),
	(15, 'Veinticinco de Mayo'),
	(15, 'Wanda'),
	(16, 'Aguada San Roque'),
	(16, 'Alumin�'),
	(16, 'Andacollo'),
	(16, 'A�elo'),
	(16, 'Bajada del Agrio'),
	(16, 'Barrancas'),
	(16, 'Buta Ranquil'),
	(16, 'Capital'),
	(16, 'Caviahu�'),
	(16, 'Centenario'),
	(16, 'Chorriaca'),
	(16, 'Chos Malal'),
	(16, 'Cipolletti'),
	(16, 'Covunco Abajo'),
	(16, 'Coyuco Cochico'),
	(16, 'Cutral C�'),
	(16, 'El Cholar'),
	(16, 'El Huec�'),
	(16, 'El Sauce'),
	(16, 'Gua�acos'),
	(16, 'Huinganco'),
	(16, 'Las Coloradas'),
	(16, 'Las Lajas'),
	(16, 'Las Ovejas'),
	(16, 'Loncopu�'),
	(16, 'Los Catutos'),
	(16, 'Los Chihuidos'),
	(16, 'Los Miches'),
	(16, 'Manzano Amargo'),
	(16, '16'),
	(16, 'Octavio Pico'),
	(16, 'Paso Aguerre'),
	(16, 'Pic�n Leuf�'),
	(16, 'Piedra del Aguila'),
	(16, 'Pilo Lil'),
	(16, 'Plaza Huincul'),
	(16, 'Plottier'),
	(16, 'Quili Malal'),
	(16, 'Ram�n Castro'),
	(16, 'Rinc�n de Los Sauces'),
	(16, 'San Mart�n de Los Andes'),
	(16, 'San Patricio del Cha�ar'),
	(16, 'Santo Tom�s'),
	(16, 'Sauzal Bonito'),
	(16, 'Senillosa'),
	(16, 'Taquimil�n'),
	(16, 'Tricao Malal'),
	(16, 'Varvarco'),
	(16, 'Villa Cur� Leuvu'),
	(16, 'Villa del Nahueve'),
	(16, 'Villa del Puente Pic�n Leuv�'),
	(16, 'Villa El Choc�n'),
	(16, 'Villa La Angostura'),
	(16, 'Villa Pehuenia'),
	(16, 'Villa Traful'),
	(16, 'Vista Alegre'),
	(16, 'Zapala'),
	(17, 'Aguada Cecilio'),
	(17, 'Aguada de Guerra'),
	(17, 'All�n'),
	(17, 'Arroyo de La Ventana'),
	(17, 'Arroyo Los Berros'),
	(17, 'Bariloche'),
	(17, 'Calte. Cordero'),
	(17, 'Campo Grande'),
	(17, 'Catriel'),
	(17, 'Cerro Polic�a'),
	(17, 'Cervantes'),
	(17, 'Chelforo'),
	(17, 'Chimpay'),
	(17, 'Chinchinales'),
	(17, 'Chipauquil'),
	(17, 'Choele Choel'),
	(17, 'Cinco Saltos'),
	(17, 'Cipolletti'),
	(17, 'Clemente Onelli'),
	(17, 'Col�n Conhue'),
	(17, 'Comallo'),
	(17, 'Comic�'),
	(17, 'Cona Niyeu'),
	(17, 'Coronel Belisle'),
	(17, 'Cubanea'),
	(17, 'Darwin'),
	(17, 'Dina Huapi'),
	(17, 'El Bols�n'),
	(17, 'El Ca�n'),
	(17, 'El Manso'),
	(17, 'Gral. Conesa'),
	(17, 'Gral. Enrique Godoy'),
	(17, 'Gral. Fernandez Oro'),
	(17, 'Gral. Roca'),
	(17, 'Guardia Mitre'),
	(17, 'Ing. Huergo'),
	(17, 'Ing. Jacobacci'),
	(17, 'Laguna Blanca'),
	(17, 'Lamarque'),
	(17, 'Las Grutas'),
	(17, 'Los Menucos'),
	(17, 'Luis Beltr�n'),
	(17, 'Mainqu�'),
	(17, 'Mamuel Choique'),
	(17, 'Maquinchao'),
	(17, 'Mencu�'),
	(17, 'Mtro. Ramos Mexia'),
	(17, 'Nahuel Niyeu'),
	(17, 'Naupa Huen'),
	(17, '�orquinco'),
	(17, 'Ojos de Agua'),
	(17, 'Paso de Agua'),
	(17, 'Paso Flores'),
	(17, 'Pe�as Blancas'),
	(17, 'Pichi Mahuida'),
	(17, 'Pilcaniyeu'),
	(17, 'Pomona'),
	(17, 'Prahuaniyeu'),
	(17, 'Rinc�n Treneta'),
	(17, 'R�o Chico'),
	(17, 'R�o Colorado'),
	(17, 'Roca'),
	(17, 'San Antonio Oeste'),
	(17, 'San Javier'),
	(17, 'Sierra Colorada'),
	(17, 'Sierra Grande'),
	(17, 'Sierra Pailem�n'),
	(17, 'Valcheta'),
	(17, 'Valle Azul'),
	(17, 'Viedma'),
	(17, 'Villa Llanqu�n'),
	(17, 'Villa Mascardi'),
	(17, 'Villa Regina'),
	(17, 'Yaminu�'),
	(18, 'A. Saravia'),
	(18, 'Aguaray'),
	(18, 'Angastaco'),
	(18, 'Animan�'),
	(18, 'Cachi'),
	(18, 'Cafayate'),
	(18, 'Campo Quijano'),
	(18, 'Campo Santo'),
	(18, 'Capital'),
	(18, 'Cerrillos'),
	(18, 'Chicoana'),
	(18, 'Col. Sta. Rosa'),
	(18, 'Coronel Moldes'),
	(18, 'El Bordo'),
	(18, 'El Carril'),
	(18, 'El Galp�n'),
	(18, 'El Jard�n'),
	(18, 'El Potrero'),
	(18, 'El Quebrachal'),
	(18, 'El Tala'),
	(18, 'Embarcaci�n'),
	(18, 'Gral. Ballivian'),
	(18, 'Gral. G�emes'),
	(18, 'Gral. Mosconi'),
	(18, 'Gral. Pizarro'),
	(18, 'Guachipas'),
	(18, 'Hip�lito Yrigoyen'),
	(18, 'Iruy�'),
	(18, 'Isla De Ca�as'),
	(18, 'J. V. Gonzalez'),
	(18, 'La Caldera'),
	(18, 'La Candelaria'),
	(18, 'La Merced'),
	(18, 'La Poma'),
	(18, 'La Vi�a'),
	(18, 'Las Lajitas'),
	(18, 'Los Toldos'),
	(18, 'Met�n'),
	(18, 'Molinos'),
	(18, 'Nazareno'),
	(18, 'Or�n'),
	(18, 'Payogasta'),
	(18, 'Pichanal'),
	(18, 'Prof. S. Mazza'),
	(18, 'R�o Piedras'),
	(18, 'Rivadavia Banda Norte'),
	(18, 'Rivadavia Banda Sur'),
	(18, 'Rosario de La Frontera'),
	(18, 'Rosario de Lerma'),
	(18, 'Saclant�s'),
	(18, '18'),
	(18, 'San Antonio'),
	(18, 'San Carlos'),
	(18, 'San Jos� De Met�n'),
	(18, 'San Ram�n'),
	(18, 'Santa Victoria E.'),
	(18, 'Santa Victoria O.'),
	(18, 'Tartagal'),
	(18, 'Tolar Grande'),
	(18, 'Urundel'),
	(18, 'Vaqueros'),
	(18, 'Villa San Lorenzo'),
	(19, 'Albard�n'),
	(19, 'Angaco'),
	(19, 'Calingasta'),
	(19, 'Capital'),
	(19, 'Caucete'),
	(19, 'Chimbas'),
	(19, 'Iglesia'),
	(19, 'Jachal'),
	(19, 'Nueve de Julio'),
	(19, 'Pocito'),
	(19, 'Rawson'),
	(19, 'Rivadavia'),
	(19, '19'),
	(19, 'San Mart�n'),
	(19, 'Santa Luc�a'),
	(19, 'Sarmiento'),
	(19, 'Ullum'),
	(19, 'Valle F�rtil'),
	(19, 'Veinticinco de Mayo'),
	(19, 'Zonda'),
	(20, 'Alto Pelado'),
	(20, 'Alto Pencoso'),
	(20, 'Anchorena'),
	(20, 'Arizona'),
	(20, 'Bagual'),
	(20, 'Balde'),
	(20, 'Batavia'),
	(20, 'Beazley'),
	(20, 'Buena Esperanza'),
	(20, 'Candelaria'),
	(20, 'Capital'),
	(20, 'Carolina'),
	(20, 'Carpinter�a'),
	(20, 'Concar�n'),
	(20, 'Cortaderas'),
	(20, 'El Morro'),
	(20, 'El Trapiche'),
	(20, 'El Volc�n'),
	(20, 'Fort�n El Patria'),
	(20, 'Fortuna'),
	(20, 'Fraga'),
	(20, 'Juan Jorba'),
	(20, 'Juan Llerena'),
	(20, 'Juana Koslay'),
	(20, 'Justo Daract'),
	(20, 'La Calera'),
	(20, 'La Florida'),
	(20, 'La Punilla'),
	(20, 'La Toma'),
	(20, 'Lafinur'),
	(20, 'Las Aguadas'),
	(20, 'Las Chacras'),
	(20, 'Las Lagunas'),
	(20, 'Las Vertientes'),
	(20, 'Lavaisse'),
	(20, 'Leandro N. Alem'),
	(20, 'Los Molles'),
	(20, 'Luj�n'),
	(20, 'Mercedes'),
	(20, 'Merlo'),
	(20, 'Naschel'),
	(20, 'Navia'),
	(20, 'Nogol�'),
	(20, 'Nueva Galia'),
	(20, 'Papagayos'),
	(20, 'Paso Grande'),
	(20, 'Potrero de Los Funes'),
	(20, 'Quines'),
	(20, 'Renca'),
	(20, 'Saladillo'),
	(20, 'San Francisco'),
	(20, 'San Ger�nimo'),
	(20, 'San Mart�n'),
	(20, 'San Pablo'),
	(20, 'Santa Rosa de Conlara'),
	(20, 'Talita'),
	(20, 'Tilisarao'),
	(20, 'Uni�n'),
	(20, 'Villa de La Quebrada'),
	(20, 'Villa de Praga'),
	(20, 'Villa del Carmen'),
	(20, 'Villa Gral. Roca'),
	(20, 'Villa Larca'),
	(20, 'Villa Mercedes'),
	(20, 'Zanjitas'),
	(21, 'Calafate'),
	(21, 'Caleta Olivia'),
	(21, 'Ca�ad�n Seco'),
	(21, 'Comandante Piedrabuena'),
	(21, 'El Calafate'),
	(21, 'El Chalt�n'),
	(21, 'Gdor. Gregores'),
	(21, 'Hip�lito Yrigoyen'),
	(21, 'Jaramillo'),
	(21, 'Koluel Kaike'),
	(21, 'Las Heras'),
	(21, 'Los Antiguos'),
	(21, 'Perito Moreno'),
	(21, 'Pico Truncado'),
	(21, 'Pto. Deseado'),
	(21, 'Pto. San Juli�n'),
	(21, 'Pto. 21'),
	(21, 'R�o Cuarto'),
	(21, 'R�o Gallegos'),
	(21, 'R�o Turbio'),
	(21, 'Tres Lagos'),
	(21, 'Veintiocho De Noviembre'),
	(22, 'Aar�n Castellanos'),
	(22, 'Acebal'),
	(22, 'Aguar� Grande'),
	(22, 'Albarellos'),
	(22, 'Alcorta'),
	(22, 'Aldao'),
	(22, 'Alejandra'),
	(22, '�lvarez'),
	(22, 'Ambrosetti'),
	(22, 'Amen�bar'),
	(22, 'Ang�lica'),
	(22, 'Angeloni'),
	(22, 'Arequito'),
	(22, 'Arminda'),
	(22, 'Armstrong'),
	(22, 'Arocena'),
	(22, 'Arroyo Aguiar'),
	(22, 'Arroyo Ceibal'),
	(22, 'Arroyo Leyes'),
	(22, 'Arroyo Seco'),
	(22, 'Arruf�'),
	(22, 'Arteaga'),
	(22, 'Ataliva'),
	(22, 'Aurelia'),
	(22, 'Avellaneda'),
	(22, 'Barrancas'),
	(22, 'Bauer Y Sigel'),
	(22, 'Bella Italia'),
	(22, 'Berabev�'),
	(22, 'Berna'),
	(22, 'Bernardo de Irigoyen'),
	(22, 'Bigand'),
	(22, 'Bombal'),
	(22, 'Bouquet'),
	(22, 'Bustinza'),
	(22, 'Cabal'),
	(22, 'Cacique Ariacaiquin'),
	(22, 'Cafferata'),
	(22, 'Calchaqu�'),
	(22, 'Campo Andino'),
	(22, 'Campo Piaggio'),
	(22, 'Ca�ada de G�mez'),
	(22, 'Ca�ada del Ucle'),
	(22, 'Ca�ada Rica'),
	(22, 'Ca�ada Rosqu�n'),
	(22, 'Candioti'),
	(22, 'Capital'),
	(22, 'Capit�n Berm�dez'),
	(22, 'Capivara'),
	(22, 'Carcara��'),
	(22, 'Carlos Pellegrini'),
	(22, 'Carmen'),
	(22, 'Carmen Del Sauce'),
	(22, 'Carreras'),
	(22, 'Carrizales'),
	(22, 'Casalegno'),
	(22, 'Casas'),
	(22, 'Casilda'),
	(22, 'Castelar'),
	(22, 'Castellanos'),
	(22, 'Cayast�'),
	(22, 'Cayastacito'),
	(22, 'Centeno'),
	(22, 'Cepeda'),
	(22, 'Ceres'),
	(22, 'Chab�s'),
	(22, 'Cha�ar Ladeado'),
	(22, 'Chapuy'),
	(22, 'Chovet'),
	(22, 'Christophersen'),
	(22, 'Classon'),
	(22, 'Cnel. Arnold'),
	(22, 'Cnel. Bogado'),
	(22, 'Cnel. Dominguez'),
	(22, 'Cnel. Fraga'),
	(22, 'Col. Aldao'),
	(22, 'Col. Ana'),
	(22, 'Col. Belgrano'),
	(22, 'Col. Bicha'),
	(22, 'Col. Bigand'),
	(22, 'Col. Bossi'),
	(22, 'Col. Cavour'),
	(22, 'Col. Cello'),
	(22, 'Col. Dolores'),
	(22, 'Col. Dos Rosas'),
	(22, 'Col. Dur�n'),
	(22, 'Col. Iturraspe'),
	(22, 'Col. Margarita'),
	(22, 'Col. Mascias'),
	(22, 'Col. Raquel'),
	(22, 'Col. Rosa'),
	(22, 'Col. San Jos�'),
	(22, 'Constanza'),
	(22, 'Coronda'),
	(22, 'Correa'),
	(22, 'Crispi'),
	(22, 'Culul�'),
	(22, 'Curupayti'),
	(22, 'Desvio Arij�n'),
	(22, 'Diaz'),
	(22, 'Diego de Alvear'),
	(22, 'Egusquiza'),
	(22, 'El Araz�'),
	(22, 'El Rab�n'),
	(22, 'El Sombrerito'),
	(22, 'El Tr�bol'),
	(22, 'Elisa'),
	(22, 'Elortondo'),
	(22, 'Emilia'),
	(22, 'Empalme San Carlos'),
	(22, 'Empalme Villa Constitucion'),
	(22, 'Esmeralda'),
	(22, 'Esperanza'),
	(22, 'Estaci�n Alvear'),
	(22, 'Estacion Clucellas'),
	(22, 'Esteban Rams'),
	(22, 'Esther'),
	(22, 'Esustolia'),
	(22, 'Eusebia'),
	(22, 'Felicia'),
	(22, 'Fidela'),
	(22, 'Fighiera'),
	(22, 'Firmat'),
	(22, 'Florencia'),
	(22, 'Fort�n Olmos'),
	(22, 'Franck'),
	(22, 'Fray Luis Beltr�n'),
	(22, 'Frontera'),
	(22, 'Fuentes'),
	(22, 'Funes'),
	(22, 'Gaboto'),
	(22, 'Galisteo'),
	(22, 'G�lvez'),
	(22, 'Garabalto'),
	(22, 'Garibaldi'),
	(22, 'Gato Colorado'),
	(22, 'Gdor. Crespo'),
	(22, 'Gessler'),
	(22, 'Godoy'),
	(22, 'Golondrina'),
	(22, 'Gral. Gelly'),
	(22, 'Gral. Lagos'),
	(22, 'Granadero Baigorria'),
	(22, 'Gregoria Perez De Denis'),
	(22, 'Grutly'),
	(22, 'Guadalupe N.'),
	(22, 'G�deken'),
	(22, 'Helvecia'),
	(22, 'Hersilia'),
	(22, 'Hipat�a'),
	(22, 'Huanqueros'),
	(22, 'Hugentobler'),
	(22, 'Hughes'),
	(22, 'Humberto 1�'),
	(22, 'Humboldt'),
	(22, 'Ibarlucea'),
	(22, 'Ing. Chanourdie'),
	(22, 'Intiyaco'),
	(22, 'Ituzaing�'),
	(22, 'Jacinto L. Ar�uz'),
	(22, 'Josefina'),
	(22, 'Juan B. Molina')
INSERT INTO Localidades (IDProvincia, Descripcion) VALUES	
	(22, 'Juan de Garay'),
	(22, 'Juncal'),
	(22, 'La Brava'),
	(22, 'La Cabral'),
	(22, 'La Camila'),
	(22, 'La Chispa'),
	(22, 'La Clara'),
	(22, 'La Criolla'),
	(22, 'La Gallareta'),
	(22, 'La Lucila'),
	(22, 'La Pelada'),
	(22, 'La Penca'),
	(22, 'La Rubia'),
	(22, 'La Sarita'),
	(22, 'La Vanguardia'),
	(22, 'Labordeboy'),
	(22, 'Laguna Paiva'),
	(22, 'Landeta'),
	(22, 'Lanteri'),
	(22, 'Larrechea'),
	(22, 'Las Avispas'),
	(22, 'Las Bandurrias'),
	(22, 'Las Garzas'),
	(22, 'Las Palmeras'),
	(22, 'Las Parejas'),
	(22, 'Las Petacas'),
	(22, 'Las Rosas'),
	(22, 'Las Toscas'),
	(22, 'Las Tunas'),
	(22, 'Lazzarino'),
	(22, 'Lehmann'),
	(22, 'Llambi Campbell'),
	(22, 'Logro�o'),
	(22, 'Loma Alta'),
	(22, 'L�pez'),
	(22, 'Los Amores'),
	(22, 'Los Cardos'),
	(22, 'Los Laureles'),
	(22, 'Los Molinos'),
	(22, 'Los Quirquinchos'),
	(22, 'Lucio V. Lopez'),
	(22, 'Luis Palacios'),
	(22, 'Ma. Juana'),
	(22, 'Ma. Luisa'),
	(22, 'Ma. Susana'),
	(22, 'Ma. Teresa'),
	(22, 'Maciel'),
	(22, 'Maggiolo'),
	(22, 'Malabrigo'),
	(22, 'Marcelino Escalada'),
	(22, 'Margarita'),
	(22, 'Matilde'),
	(22, 'Mau�'),
	(22, 'M�ximo Paz'),
	(22, 'Melincu�'),
	(22, 'Miguel Torres'),
	(22, 'Mois�s Ville'),
	(22, 'Monigotes'),
	(22, 'Monje'),
	(22, 'Monte Obscuridad'),
	(22, 'Monte Vera'),
	(22, 'Montefiore'),
	(22, 'Montes de Oca'),
	(22, 'Murphy'),
	(22, '�anducita'),
	(22, 'Nar�'),
	(22, 'Nelson'),
	(22, 'Nicanor E. Molinas'),
	(22, 'Nuevo Torino'),
	(22, 'Oliveros'),
	(22, 'Palacios'),
	(22, 'Pav�n'),
	(22, 'Pav�n Arriba'),
	(22, 'Pedro G�mez Cello'),
	(22, 'P�rez'),
	(22, 'Peyrano'),
	(22, 'Piamonte'),
	(22, 'Pilar'),
	(22, 'Pi�ero'),
	(22, 'Plaza Clucellas'),
	(22, 'Portugalete'),
	(22, 'Pozo Borrado'),
	(22, 'Progreso'),
	(22, 'Providencia'),
	(22, 'Pte. Roca'),
	(22, 'Pueblo Andino'),
	(22, 'Pueblo Esther'),
	(22, 'Pueblo Gral. San Mart�n'),
	(22, 'Pueblo Irigoyen'),
	(22, 'Pueblo Marini'),
	(22, 'Pueblo Mu�oz'),
	(22, 'Pueblo Uranga'),
	(22, 'Pujato'),
	(22, 'Pujato N.'),
	(22, 'Rafaela'),
	(22, 'Ramay�n'),
	(22, 'Ramona'),
	(22, 'Reconquista'),
	(22, 'Recreo'),
	(22, 'Ricardone'),
	(22, 'Rivadavia'),
	(22, 'Rold�n'),
	(22, 'Romang'),
	(22, 'Rosario'),
	(22, 'Rueda'),
	(22, 'Rufino'),
	(22, 'Sa Pereira'),
	(22, 'Saguier'),
	(22, 'Saladero M. Cabal'),
	(22, 'Salto Grande'),
	(22, 'San Agust�n'),
	(22, 'San Antonio de Obligado'),
	(22, 'San Bernardo (N.J.)'),
	(22, 'San Bernardo (S.J.)'),
	(22, 'San Carlos Centro'),
	(22, 'San Carlos N.'),
	(22, 'San Carlos S.'),
	(22, 'San Crist�bal'),
	(22, 'San Eduardo'),
	(22, 'San Eugenio'),
	(22, 'San Fabi�n'),
	(22, 'San Fco. de Santa F�'),
	(22, 'San Genaro'),
	(22, 'San Genaro N.'),
	(22, 'San Gregorio'),
	(22, 'San Guillermo'),
	(22, 'San Javier'),
	(22, 'San Jer�nimo del Sauce'),
	(22, 'San Jer�nimo N.'),
	(22, 'San Jer�nimo S.'),
	(22, 'San Jorge'),
	(22, 'San Jos� de La Esquina'),
	(22, 'San Jos� del Rinc�n'),
	(22, 'San Justo'),
	(22, 'San Lorenzo'),
	(22, 'San Mariano'),
	(22, 'San Mart�n de Las Escobas'),
	(22, 'San Mart�n N.'),
	(22, 'San Vicente'),
	(22, 'Sancti Spititu'),
	(22, 'Sanford'),
	(22, 'Santo Domingo'),
	(22, 'Santo Tom�'),
	(22, 'Santurce'),
	(22, 'Sargento Cabral'),
	(22, 'Sarmiento'),
	(22, 'Sastre'),
	(22, 'Sauce Viejo'),
	(22, 'Serodino'),
	(22, 'Silva'),
	(22, 'Soldini'),
	(22, 'Soledad'),
	(22, 'Soutomayor'),
	(22, 'Sta. Clara de Buena Vista'),
	(22, 'Sta. Clara de Saguier'),
	(22, 'Sta. Isabel'),
	(22, 'Sta. Margarita'),
	(22, 'Sta. Maria Centro'),
	(22, 'Sta. Mar�a N.'),
	(22, 'Sta. Rosa'),
	(22, 'Sta. Teresa'),
	(22, 'Suardi'),
	(22, 'Sunchales'),
	(22, 'Susana'),
	(22, 'Tacuarend�'),
	(22, 'Tacural'),
	(22, 'Tartagal'),
	(22, 'Teodelina'),
	(22, 'Theobald'),
	(22, 'Timb�es'),
	(22, 'Toba'),
	(22, 'Tortugas'),
	(22, 'Tostado'),
	(22, 'Totoras'),
	(22, 'Traill'),
	(22, 'Venado Tuerto'),
	(22, 'Vera'),
	(22, 'Vera y Pintado'),
	(22, 'Videla'),
	(22, 'Vila'),
	(22, 'Villa Amelia'),
	(22, 'Villa Ana'),
	(22, 'Villa Ca�as'),
	(22, 'Villa Constituci�n'),
	(22, 'Villa Elo�sa'),
	(22, 'Villa Gdor. G�lvez'),
	(22, 'Villa Guillermina'),
	(22, 'Villa Minetti'),
	(22, 'Villa Mugueta'),
	(22, 'Villa Ocampo'),
	(22, 'Villa San Jos�'),
	(22, 'Villa Saralegui'),
	(22, 'Villa Trinidad'),
	(22, 'Villada'),
	(22, 'Virginia'),
	(22, 'Wheelwright'),
	(22, 'Zavalla'),
	(22, 'Zen�n Pereira'),
	(23, 'A�atuya'),
	(23, '�rraga'),
	(23, 'Bandera'),
	(23, 'Bandera Bajada'),
	(23, 'Beltr�n'),
	(23, 'Brea Pozo'),
	(23, 'Campo Gallo'),
	(23, 'Capital'),
	(23, 'Chilca Juliana'),
	(23, 'Choya'),
	(23, 'Clodomira'),
	(23, 'Col. Alpina'),
	(23, 'Col. Dora'),
	(23, 'Col. El Simbolar Robles'),
	(23, 'El Bobadal'),
	(23, 'El Charco'),
	(23, 'El Moj�n'),
	(23, 'Estaci�n Atamisqui'),
	(23, 'Estaci�n Simbolar'),
	(23, 'Fern�ndez'),
	(23, 'Fort�n Inca'),
	(23, 'Fr�as'),
	(23, 'Garza'),
	(23, 'Gramilla'),
	(23, 'Guardia Escolta'),
	(23, 'Herrera'),
	(23, 'Ica�o'),
	(23, 'Ing. Forres'),
	(23, 'La Banda'),
	(23, 'La Ca�ada'),
	(23, 'Laprida'),
	(23, 'Lavalle'),
	(23, 'Loreto'),
	(23, 'Los Jur�es'),
	(23, 'Los N��ez'),
	(23, 'Los Pirpintos'),
	(23, 'Los Quiroga'),
	(23, 'Los Telares'),
	(23, 'Lugones'),
	(23, 'Malbr�n'),
	(23, 'Matara'),
	(23, 'Medell�n'),
	(23, 'Monte Quemado'),
	(23, 'Nueva Esperanza'),
	(23, 'Nueva Francia'),
	(23, 'Palo Negro'),
	(23, 'Pampa de Los Guanacos'),
	(23, 'Pinto'),
	(23, 'Pozo Hondo'),
	(23, 'Quimil�'),
	(23, 'Real Sayana'),
	(23, 'Sachayoj'),
	(23, 'San Pedro de Guasay�n'),
	(23, 'Selva'),
	(23, 'Sol de Julio'),
	(23, 'Sumampa'),
	(23, 'Suncho Corral'),
	(23, 'Taboada'),
	(23, 'Tapso'),
	(23, 'Termas de Rio Hondo'),
	(23, 'Tintina'),
	(23, 'Tomas Young'),
	(23, 'Vilelas'),
	(23, 'Villa Atamisqui'),
	(23, 'Villa La Punta'),
	(23, 'Villa Ojo de Agua'),
	(23, 'Villa R�o Hondo'),
	(23, 'Villa Salavina'),
	(23, 'Villa Uni�n'),
	(23, 'Vilmer'),
	(23, 'Weisburd'),
	(24, 'R�o Grande'),
	(24, 'Tolhuin'),
	(24, 'Ushuaia'),
	(25, 'Acheral'),
	(25, 'Agua Dulce'),
	(25, 'Aguilares'),
	(25, 'Alderetes'),
	(25, 'Alpachiri'),
	(25, 'Alto Verde'),
	(25, 'Amaicha del Valle'),
	(25, 'Amberes'),
	(25, 'Ancajuli'),
	(25, 'Arcadia'),
	(25, 'Atahona'),
	(25, 'Banda del R�o Sali'),
	(25, 'Bella Vista'),
	(25, 'Buena Vista'),
	(25, 'Burruyac�'),
	(25, 'Capit�n C�ceres'),
	(25, 'Cevil Redondo'),
	(25, 'Choromoro'),
	(25, 'Ciudacita'),
	(25, 'Colalao del Valle'),
	(25, 'Colombres'),
	(25, 'Concepci�n'),
	(25, 'Delf�n Gallo'),
	(25, 'El Bracho'),
	(25, 'El Cadillal'),
	(25, 'El Cercado'),
	(25, 'El Cha�ar'),
	(25, 'El Manantial'),
	(25, 'El Moj�n'),
	(25, 'El Mollar'),
	(25, 'El Naranjito'),
	(25, 'El Naranjo'),
	(25, 'El Polear'),
	(25, 'El Puestito'),
	(25, 'El Sacrificio'),
	(25, 'El Timb�'),
	(25, 'Escaba'),
	(25, 'Esquina'),
	(25, 'Estaci�n Ar�oz'),
	(25, 'Famaill�'),
	(25, 'Gastone'),
	(25, 'Gdor. Garmendia'),
	(25, 'Gdor. Piedrabuena'),
	(25, 'Graneros'),
	(25, 'Huasa Pampa'),
	(25, 'J. B. Alberdi'),
	(25, 'La Cocha'),
	(25, 'La Esperanza'),
	(25, 'La Florida'),
	(25, 'La Ramada'),
	(25, 'La Trinidad'),
	(25, 'Lamadrid'),
	(25, 'Las Cejas'),
	(25, 'Las Talas'),
	(25, 'Las Talitas'),
	(25, 'Los Bulacio'),
	(25, 'Los G�mez'),
	(25, 'Los Nogales'),
	(25, 'Los Pereyra'),
	(25, 'Los P�rez'),
	(25, 'Los Puestos'),
	(25, 'Los Ralos'),
	(25, 'Los Sarmientos'),
	(25, 'Los Sosa'),
	(25, 'Lules'),
	(25, 'M. Garc�a Fern�ndez'),
	(25, 'Manuela Pedraza'),
	(25, 'Medinas'),
	(25, 'Monte Bello'),
	(25, 'Monteagudo'),
	(25, 'Monteros'),
	(25, 'Padre Monti'),
	(25, 'Pampa Mayo'),
	(25, 'Quilmes'),
	(25, 'Raco'),
	(25, 'Ranchillos'),
	(25, 'R�o Chico'),
	(25, 'R�o Colorado'),
	(25, 'R�o Seco'),
	(25, 'Rumi Punco'),
	(25, 'San Andr�s'),
	(25, 'San Felipe'),
	(25, 'San Ignacio'),
	(25, 'San Javier'),
	(25, 'San Jos�'),
	(25, 'San Miguel de 25'),
	(25, 'San Pedro'),
	(25, 'San Pedro de Colalao'),
	(25, 'Santa Rosa de Leales'),
	(25, 'Sgto. Moya'),
	(25, 'Siete de Abril'),
	(25, 'Simoca'),
	(25, 'Soldado Maldonado'),
	(25, 'Sta. Ana'),
	(25, 'Sta. Cruz'),
	(25, 'Sta. Luc�a'),
	(25, 'Taco Ralo'),
	(25, 'Taf� del Valle'),
	(25, 'Taf� Viejo'),
	(25, 'Tapia'),
	(25, 'Teniente Berdina'),
	(25, 'Trancas'),
	(25, 'Villa Belgrano'),
	(25, 'Villa Benjam�n Araoz'),
	(25, 'Villa Chiligasta'),
	(25, 'Villa de Leales'),
	(25, 'Villa Quinteros'),
	(25, 'Y�nima'),
	(25, 'Yerba Buena'),
	(25, 'Yerba Buena (S)'),
	(26, 'Boston'),
	(27, 'Austin'),
	(28, 'Chicago'),
	(29, 'Leeds'),
	(30, 'Florencia'),
	(31, 'Palermo'),
	(32, 'Roma'),
	(33, 'Montevideo'),
	(27, 'Dallas'),
	(34, 'Detroit'),	
	(35, 'Seattle'),
	(36, 'Reading'),
	(37, 'Napoles')

GO
INSERT INTO TipoClientes(Descripcion) VALUES('Cliente muy importante')
INSERT INTO TipoClientes(Descripcion) VALUES('Educativo p�blico')
INSERT INTO TipoClientes(Descripcion) VALUES('Extranjero')
INSERT INTO TipoClientes(Descripcion) VALUES('Nacional')
INSERT INTO TipoClientes(Descripcion) VALUES('Sin fines de lucro')
INSERT INTO TipoClientes(Descripcion) VALUES('Unicornio')

GO
INSERT INTO Clientes (RazonSocial, IDTipoCliente, Cuit, Email, TelefonoFijo, TelefonoMovil, IDLocalidad) VALUES ('Brian Lara', 1, '11-111111-1', 'hola@brianlara.com.ar', '45656643', '1128473829', 2391)
INSERT INTO Clientes (RazonSocial, IDTipoCliente, Cuit, Email, TelefonoFijo, TelefonoMovil, IDLocalidad) VALUES ('Legna Nomis', 6, '44-44444-4', 'hola@legnanomis.com.ar', NULL, NULL, 2394)
INSERT INTO Clientes (RazonSocial, IDTipoCliente, Cuit, Email, TelefonoFijo, TelefonoMovil, IDLocalidad) VALUES ('Kloster Inc', 3, '99', NULL, '(49) 08363362115', NULL, 2395)
INSERT INTO Clientes (RazonSocial, IDTipoCliente, Cuit, Email, TelefonoFijo, TelefonoMovil, IDLocalidad) VALUES ('UTN', 2, '22-222222-2', 'info@utn.edu.ar', '11456567', NULL, 249)
INSERT INTO Clientes (RazonSocial, IDTipoCliente, Cuit, Email, TelefonoFijo, TelefonoMovil, IDLocalidad) VALUES ('World Animal Protection', 5, '98', 'wap@wap.org', '44233423', NULL, 2392)
INSERT INTO Clientes (RazonSocial, IDTipoCliente, Cuit, Email, TelefonoFijo, TelefonoMovil, IDLocalidad) VALUES ('Clifton Goldney Inc', 3, '33-333333-3', 'clifton@goldney.com.ar', NULL, NULL, 2393)
INSERT INTO Clientes (RazonSocial, IDTipoCliente, Cuit, Email, TelefonoFijo, TelefonoMovil, IDLocalidad) VALUES ('Strebern Ich', 3, '55-555555-5', NULL, NULL, NULL, 2387)
INSERT INTO Clientes (RazonSocial, IDTipoCliente, Cuit, Email, TelefonoFijo, TelefonoMovil, IDLocalidad) VALUES ('Vaca SA', 4, '66-666666-6', 'info@alancow.com.ar', NULL, '1147483934', 287)
INSERT INTO Clientes (RazonSocial, IDTipoCliente, Cuit, Email, TelefonoFijo, TelefonoMovil, IDLocalidad) VALUES ('Hugo Gomez', 6, '77-777777-7', 'hola@hugo.com.ar', NULL, NULL, 287)
INSERT INTO Clientes (RazonSocial, IDTipoCliente, Cuit, Email, TelefonoFijo, TelefonoMovil, IDLocalidad) VALUES ('Adducci', 4, '88-888888-8', 'adducci@gmail.com', '114838992', '1148383438', NULL)
INSERT INTO Clientes (RazonSocial, IDTipoCliente, Cuit, Email, TelefonoFijo, TelefonoMovil, IDLocalidad) VALUES ('Estudio Contable Arevalo y C�a', 4, '99-999999-9', 'arevalo@yahoo.com.ar', '114838385', NULL, 429)
INSERT INTO Clientes (RazonSocial, IDTipoCliente, Cuit, Email, TelefonoFijo, TelefonoMovil, IDLocalidad) VALUES ('White SA', 4, '11-0000000-1', 'nazarenwhite@hotmail.com', NULL, NULL, 1166)

GO
INSERT INTO Proyectos(ID, Nombre, Descripcion, Costo, FechaInicio, FechaFin, IDCliente, Estado) VALUES('A100', 'Scholar', 'Aplicaci�n que permitir� gestionar tu establecimiento educativo', 400000, '2020-5-14', NULL, 1, 1)
INSERT INTO Proyectos(ID, Nombre, Descripcion, Costo, FechaInicio, FechaFin, IDCliente, Estado) VALUES('B125', 'Mailer', 'Servicio de env�o de mail masivo.', 125000, '2019-7-21', NULL, 2, 1)
INSERT INTO Proyectos(ID, Nombre, Descripcion, Costo, FechaInicio, FechaFin, IDCliente, Estado) VALUES('CC45', 'Sales manager', 'Gestor de ventas.', 800000, '2019-12-8', NULL, 1, 1)
INSERT INTO Proyectos(ID, Nombre, Descripcion, Costo, FechaInicio, FechaFin, IDCliente, Estado) VALUES('CC46', 'Seals manager', 'Gestor de focas.', 950000, '2020-3-13', NULL, 5, 1)
INSERT INTO Proyectos(ID, Nombre, Descripcion, Costo, FechaInicio, FechaFin, IDCliente, Estado) VALUES('A120', 'Monkey Doctor', 'Juego muy popular de preguntas y respuestas', 1000000, '2014-11-4', '2015-12-10', 1, 0)
INSERT INTO Proyectos(ID, Nombre, Descripcion, Costo, FechaInicio, FechaFin, IDCliente, Estado) VALUES('A113', 'Goto Game Jam Winner Randomizer', NULL, 50000, '2020-12-12', '2020-12-20', 1, 0)
INSERT INTO Proyectos(ID, Nombre, Descripcion, Costo, FechaInicio, FechaFin, IDCliente, Estado) VALUES('B99', 'UTN Bot', 'Un corrector de ex�menes para LAB1, LAB2 y LAB3', 450000, '2020-3-11', NULL, 2, 1)
INSERT INTO Proyectos(ID, Nombre, Descripcion, Costo, FechaInicio, FechaFin, IDCliente, Estado) VALUES('B100', 'PetApp', 'Aplicaci�n que permite encontrar adoptantes a mascotas abandonadas', 100000, '2018-10-10', '2019-4-15', 5, 0)
INSERT INTO Proyectos(ID, Nombre, Descripcion, Costo, FechaInicio, FechaFin, IDCliente, Estado) VALUES('D134', 'GetApp', 'Aplicaci�n m�vil tipo Alarma que te despierta o llama a la polic�a', 400000, '2021-5-25', NULL, 1, 1)
INSERT INTO Proyectos(ID, Nombre, Descripcion, Costo, FechaInicio, FechaFin, IDCliente, Estado) VALUES('E1444', 'Wine', 'Emulador de aplicaciones de Windows en Linux', 5450000, '2005-5-8', NULL, 10, 1)
INSERT INTO Proyectos(ID, Nombre, Descripcion, Costo, FechaInicio, FechaFin, IDCliente, Estado) VALUES('F45', 'PlagiApp', 'Aplicaci�n que compara ex�menes y te sugiere cuales sospechosamente parecidos.', 675000, '2018-5-14', NULL, 2, 1)
INSERT INTO Proyectos(ID, Nombre, Descripcion, Costo, FechaInicio, FechaFin, IDCliente, Estado) VALUES('Z111', 'Zoomba', 'Clases de baile online', 450000, '2021-9-30', NULL, 8, 1)
INSERT INTO Proyectos(ID, Nombre, Descripcion, Costo, FechaInicio, FechaFin, IDCliente, Estado) VALUES('C40', 'Faker', 'Aplicaci�n para inventar datos en las bases de datos', 50000, '2000-12-31', '2001-2-5', 2, 0)
INSERT INTO Proyectos(ID, Nombre, Descripcion, Costo, FechaInicio, FechaFin, IDCliente, Estado) VALUES('A33', 'Moodler', 'Gestor de Campus Virtual Moodle', 120500, '2000-3-15', '2000-3-30', 4, 0)
INSERT INTO Proyectos(ID, Nombre, Descripcion, Costo, FechaInicio, FechaFin, IDCliente, Estado) VALUES('D33', 'Gentesss', NULL, 140000, '2021-6-27', NULL, 3, 1)
INSERT INTO Proyectos(ID, Nombre, Descripcion, Costo, FechaInicio, FechaFin, IDCliente, Estado) VALUES('F23', 'ColourAdvisor', 'Aplicaci�n que recomienda paletas de colores para tu aplicaci�n', 78000, '2020-6-13', '2020-6-25', 9, 0)

GO
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('A100', 'Login', 'Login de usuarios', 111, 100000, '2020-9-1', '2020-5-18', '2020-5-22')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('A100', 'Staff', 'Docentes y no docentes', 170, 200000, '2020-6-16', '2020-5-22', '2020-10-13')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('A100', 'Estudiantes', 'Estudiantes del sistema', 125, 200000, '2020-7-2', '2020-5-15', '2020-9-1')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('A100', 'Calificaciones', 'Calificaciones de estudiantes', 155, 400000, '2020-7-11', '2020-5-18', '2020-9-13')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('A100', 'Pagos', 'Pagos de cuotas', 65, 80000, '2020-7-31', '2020-5-23', '2020-9-11')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('B100', 'Sistema de mail', 'Sistema de mail', 88, 20000, '2019-1-2', '2018-10-19', '2018-12-22')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('B100', 'Proveedores', 'Subsistema de proveedores', 111, 50000, '2018-11-20', '2018-10-11', '2019-2-3')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('B100', 'Pagos', 'Subsistema de pagos', 158, 25000, '2019-1-27', '2018-10-20', '2019-1-22')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('B100', 'Clientes', 'Subsistema de clientes', 153, 50000, '2018-12-17', '2018-10-11', '2019-2-14')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('B100', 'Productos', 'Subsistema de productos', 112, 50000, '2018-12-3', '2018-10-13', '2018-11-21')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('B100', 'Ventas', 'Subsistema de ventas', 53, 25000, '2019-1-12', '2018-10-14', '2019-3-2')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('B100', 'Animales', 'Registro de animales de la organizaci�n', 67, 20000, '2018-11-15', '2018-10-11', '2018-11-19')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('B100', 'Stock de comida', 'Registro de alimento de los animales', 64, 20000, '2018-12-15', '2018-10-15', '2019-1-18')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('B100', 'Stock de vacunas', 'Registro de vacunas', 144, 33333.33, '2019-1-3', '2018-10-17', '2019-1-3')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('A100', 'Mec�nicas', 'Mec�nicas del juego', 86, 200000, '2020-8-21', '2020-5-15', '2020-8-16')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('A100', 'Sistema', 'M�dulo general de la aplicaci�n', 88, 80000, '2020-6-19', '2020-5-21', '2020-9-10')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('B100', 'Corrector', 'M�dulo general de la aplicaci�n', 99, 25000, '2019-1-21', '2018-10-12', '2019-1-11')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('B100', 'Adoptantes', 'M�dulo que registra informaci�n completa de los adoptantes', 132, 25000, '2018-11-30', '2018-10-18', '2019-3-8')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('B100', 'Mascotas', 'M�dulo que registra informci�n de las mascotas', 111, 100000, '2019-1-31', '2018-10-17', '2018-12-14')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('B100', 'Adopciones', 'M�dulo que registra adopciones', 84, 33333.33, '2019-1-17', '2018-10-19', '2018-12-24')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('B100', 'Monetizaci�n', 'M�dulo de publicidad', 166, 50000, '2018-12-24', '2018-10-17', '2018-11-29')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('D134', 'Sistema', 'Sistema de alarma', 81, 133333.33, NULL, NULL, NULL)
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('D134', 'Monetizaci�n', 'M�dulo de publicidad y monetizaci�n', 58, 133333.33, NULL, NULL, NULL)
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('E1444', 'Sistema', 'Sistema general del emulador', 172, 2725000, '2005-7-20', '2005-5-18', '2005-7-17')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('E1444', 'Reportes de fallos', 'M�dulo de reportes de fallos', 107, 2725000, '2005-6-23', '2005-5-13', '2005-5-26')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('E1444', 'Log', 'M�dulo de registro de errores', 74, 1362500, '2005-8-29', '2005-5-14', '2005-6-11')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('F45', 'Sistema', 'Sistema general del detector de plagios', 155, 337500, '2018-8-17', '2018-5-18', '2018-10-15')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('F45', 'Reportes de fallos', 'M�dulo de reportes de fallos', 131, 168750, '2018-6-7', '2018-5-24', '2018-10-7')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('F23', 'Login', 'Login de usuarios', 100, 15600, '2020-8-9', '2020-6-23', '2020-11-1')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('F23', 'Instructores', 'Registro de instructores', 114, 39000, '2020-9-6', '2020-6-18', '2020-10-8')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('F23', 'Clases', 'Streaming de clases', 165, 78000, '2020-8-26', '2020-6-18', '2020-8-24')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('B100', 'Faker', 'Generador de datos al azar', 134, 33333.33, '2019-2-1', '2018-10-19', '2018-10-21')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('A100', 'Acceso', 'Acesso al sistema', 98, 133333.33, '2020-8-6', '2020-5-18', '2020-9-22')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('A100', 'Cursos', 'M�dulo de cursos y actividades', 171, 80000, '2020-6-21', '2020-5-17', '2020-6-1')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('A100', 'Usuarios', 'M�dulo de usuarios y permisos', 109, 100000, '2020-7-23', '2020-5-19', '2020-10-13')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('A100', 'Calificaciones', 'M�dulo de calificaciones', 115, 200000, '2020-6-15', '2020-5-22', '2020-8-21')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('D134', 'Sistema', 'Sistema general', 54, 133333.33, NULL, NULL, NULL)
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('E1444', 'Colorizr', 'Sistema recomendador de colores', 107, 2725000, '2005-7-4', '2005-5-14', '2005-10-9')
INSERT INTO Modulos(IDProyecto, Nombre, Descripcion, TiempoEstimado, CostoEstimado, FechaFinEstimada, FechaRealInicio, FechaRealFin) VALUES ('E1444', 'Daltonic', 'Subsistema que evita paletas no recomendadas para gente con daltonismo', 47, 1362500, '2005-7-12', '2005-5-13', '2005-10-9')

GO
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Achaval Duria', 'Joaquin', NULL, '(387) 962-2847', '1968-5-3', 'Obispo Lagorio 3548', 587, 'I')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Alpuin Schunk', 'Leonardo Ezequiel', 'lalpuin@notmyrealmail.com', NULL, '1993-1-31', 'Teniente De Amos 1067', 587, 'I')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Arostegui', 'Isidoro', 'iarostegui@nasa.gov', '(695) 920-0076', '1999-1-12', 'Virrey Kloster 9440', 249, 'I')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Ayala', 'Elizabeth Carolina', 'eayala@google.com', NULL, '1972-8-28', NULL, NULL, 'I')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Badano', 'Alejandro Agustin', NULL, '(357) 874-7957', '1996-10-25', 'Doctor Carrasquero 8513', 1166, 'I')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Barrios', 'Paola Elizabeth', 'pneighborhood@me.dev', '(946) 907-8987', '1988-12-22', 'Doctora Alberti 2622', 287, 'I')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Crucci', 'Lucas', 'lcrucci@hotmail.com.pe', '(389) 615-9729', '1966-6-4', 'Presidente Carrasquero 9910', 587, 'I')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Del Pino', 'Emiliano', 'efromthepine@notmyrealmail.com', '(368) 886-5181', '1977-12-31', 'Villa Laurentino Goncalves 48', 2387, 'E')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Di Fulvio', 'Federico Damian', 'fdifulvio@gmail.com', NULL, '1978-6-9', 'Doctora Fahler 2288', 1166, 'I')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Fahler', 'Matias Andres', NULL, '(186) 828-6592', '1985-4-24', 'Virrey Gazzo 2281', 2388, 'E')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Ferrante', 'Bruno Alexis', 'bferrante@hotmail.com.pe', '(926) 973-5945', '1981-8-21', 'Cabo Dirube 828', 429, 'I')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Figueira', 'Alexis Damian', 'afigueira@hotmail.com.uy', NULL, '1994-4-22', 'Cabo Laino 9194', 2389, 'E')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Galarza', 'Cecilia Ver�nica', 'cgalarza@utn.edu.ar', NULL, '1989-2-7', 'General Alberti 7067', 249, 'I')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Gazzo', 'Alejandro Matias', 'agazzo@notmyrealmail.com', NULL, '1990-3-12', 'Brigadier Barrios 8517', 287, 'I')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Godoy', 'Nahuel Alejandro', 'ngodoy@google.com', NULL, '1971-12-28', 'Brigadier Clifton Goldney 9023', 287, 'I')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Gonzalez', 'Edgardo Simon', 'egonzalez@fakemail.com', NULL, '1967-1-2', NULL, NULL, 'E')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Ibazeta', 'Pablo Agust�n', 'pibazeta@google.com', '(578) 581-0349', '1982-7-1', 'Doctora Galarza 4188', 249, 'I')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Larroca', 'Javier Agustin', 'jlarroca@hotmail.com.ar', '(723) 346-3332', '1983-11-3', 'Virrey Martinez 1648', 2390, 'E')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Laurentino Goncalves', 'Yesica Regina', 'ylaurentino@independiente.com', '(101) 716-0947', '1997-4-15', 'Cabo Flori 1649', 1166, 'I')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Mar Cardozo', 'Zair Andres', 'zmar@hotmail.com.uy', '(203) 991-1918', '1971-9-19', 'Cabo Crucci 986', 2383, 'E')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Martinez', 'Jonathan Daniel', NULL, '(328) 853-6797', '1973-7-25', 'Presidente Simon 5842', 587, 'I')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Mena', 'German Emanuel', NULL, '(859) 564-9626', '1984-9-1', 'General Clifton Goldney 474', 249, 'I')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Miranda', 'Maximiliano Guillermo', 'mmiranda@hotmail.com.ar', '(346) 791-8453', '1979-7-7', 'Virrey Barreto Hernandez 310', 1166, 'I')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Molteni', 'Bruno Mauricio', 'bmolteni@hotmail.com.uy', NULL, '1974-11-2', 'General Ayala 6956', 287, 'I')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Petrignani Castro', 'Ignacio', 'ipetrignani@notmyrealmail.com', '(558) 813-4402', '1989-2-6', NULL, NULL, 'I')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Plaza', 'Valentin', 'vplaza@notmyrealmail.com', '(779) 742-0557', '1966-8-3', 'Obispo Dominguez 9081', 2384, 'E')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Popp', 'Alexander Alberto', 'apopp@google.com', '(488) 244-5467', '1994-8-24', 'Villa Blanco 8985', 249, 'I')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Quintana Soria', 'Matias Joel', 'mquintana@hotmail.com.pe', '(669) 213-0345', '1989-1-31', 'Presidente Ciccarelli 8343', 1518, 'E')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Rasjido', 'Adriel Elian', 'arasjido@frgp.utn.edu.ar', NULL, '1998-4-27', 'Teniente Lara 1971', 2386, 'E')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Robles', 'Agustin Lautaro', 'arobles@hotmail.com.ar', '(970) 885-0929', '1972-1-30', NULL, NULL, 'E')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Sanchez Villar', 'Matias', 'msanchez@fakemail.com', '(533) 285-8591', '1971-2-20', 'Doctor Barea 721', 2385, 'E')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Scalesi', 'Leonardo Martin', NULL, '(806) 630-4551', '1999-5-3', 'Virrey Ciccarelli 2899', 429, 'I')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Scutti', 'Tomas', 'tscutti@notmyrealmail.com', '(169) 249-0460', '1994-12-6', 'Virrey Lagorio 40', 249, 'I')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Stamm', 'Walter Emmanuel', 'wstamm@argentina.ar', NULL, '1971-11-16', NULL, NULL, 'I')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Tejeda', 'Mathias Leandro', 'mtejeda@hotmail.com', '(963) 306-5247', '1987-7-11', 'Doctora Barrios 1948', 429, 'I')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Trunso', 'Daniel Alejandro', NULL, '(977) 335-7032', '1971-9-18', 'Cabo Figueira 3473', 1166, 'I')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Vasquez Quispe', 'Elmer Dennis', NULL, '(324) 635-0486', '1975-6-18', NULL, NULL, 'I')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Vigliaccio', 'Sofia Noemi', 'svigliaccio@frgp.utn.edu.ar', '(564) 377-2363', '1969-10-22', 'General Lagorio 5572', 587, 'I')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Virasoro', 'Alejandro', 'avirasoro@hotmail.com.ar', NULL, '1987-2-13', 'Doctor Fahler 1936', 2385, 'E')
INSERT INTO Colaboradores(Apellidos, Nombres, Email, TelefonoMovil, FechaNacimiento, Direccion, IDLocalidad, TipoColaborador) VALUES ('Yomayel', 'Luciano Federico', 'lyomayel@hotmail.com', '(625) 229-4746', '1992-3-21', 'General Brizzi 6443', 249, 'I')

GO
INSERT INTO TipoTareas (Descripcion) VALUES ('Analisis de requerimientos')
INSERT INTO TipoTareas (Descripcion) VALUES ('Configuracion de ambientes de programacion')
INSERT INTO TipoTareas (Descripcion) VALUES ('Disenio de base de datos')
INSERT INTO TipoTareas (Descripcion) VALUES ('Disenio de experiencia del usuario')
INSERT INTO TipoTareas (Descripcion) VALUES ('Disenio de interfaz UI')
INSERT INTO TipoTareas (Descripcion) VALUES ('Instalacion y configuracion')
INSERT INTO TipoTareas (Descripcion) VALUES ('Programacion en C#')
INSERT INTO TipoTareas (Descripcion) VALUES ('Programacion en C++')
INSERT INTO TipoTareas (Descripcion) VALUES ('Programacion en Javascript')
INSERT INTO TipoTareas (Descripcion) VALUES ('Programacion en PHP')
INSERT INTO TipoTareas (Descripcion) VALUES ('Reingenieria de procesos')
INSERT INTO TipoTareas (Descripcion) VALUES ('Soporte de bugs')
INSERT INTO TipoTareas (Descripcion) VALUES ('Testing de integracion')
INSERT INTO TipoTareas (Descripcion) VALUES ('Testing unitario')

GO
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (1, 1, 4500, '2020-5-23', '2020-8-18')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (1, 3, 4000, '2020-5-28', '2020-8-17')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (1, 5, 4000, '2020-5-20', '2020-8-26')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (1, 7, 3000, '2020-5-24', '2020-8-28')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (1, 9, 3000, '2020-5-20', '2020-8-17')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (1, 10, 2500, '2020-5-22', '2020-8-17')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (1, 14, 2000, '2020-5-27', '2020-8-12')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (1, 13, 2000, '2020-5-27', '2020-8-19')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (1, 6, 1500, '2020-5-25', '2020-8-15')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (1, 12, 3000, '2020-5-28', '2020-8-30')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (1, 11, 8000, '2020-5-19', '2020-8-12')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (2, 3, 4000, '2020-5-27', '2020-6-1')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (2, 4, 4000, '2020-5-25', '2020-6-11')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (2, 2, 3500, '2020-5-26', '2020-6-13')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (2, 8, 3000, '2020-5-23', '2020-5-30')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (2, 7, 3000, '2020-5-25', '2020-5-31')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (2, 9, 3000, '2020-5-29', '2020-6-12')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (2, 10, 2500, '2020-5-23', '2020-5-29')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (2, 14, 2000, '2020-5-25', '2020-6-5')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (2, 13, 2000, '2020-6-1', '2020-6-13')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (2, 6, 1500, '2020-5-26', '2020-5-27')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (3, 7, 3000, '2020-5-25', '2020-6-25')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (3, 9, 3000, '2020-5-22', '2020-6-16')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (3, 14, 2000, '2020-5-21', '2020-6-17')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (3, 13, 2000, '2020-5-20', '2020-6-19')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (3, 12, 3000, '2020-5-16', '2020-6-20')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (3, 11, 8000, '2020-5-24', '2020-6-21')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (4, 4, 4000, '2020-5-27', '2020-6-22')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (4, 7, 3000, '2020-5-27', '2020-7-4')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (4, 9, 3000, '2020-5-23', '2020-7-4')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (4, 10, 2500, '2020-5-28', '2020-6-27')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (4, 13, 2000, '2020-5-20', '2020-6-23')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (4, 6, 1500, '2020-5-25', '2020-7-2')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (4, 12, 3000, '2020-5-24', '2020-7-3')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (5, 1, 4500, '2020-5-30', '2020-7-29')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (5, 10, 2500, '2020-5-27', '2020-7-30')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (6, 1, 4500, '2018-10-24', '2018-12-16')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (6, 3, 4000, '2018-10-21', '2018-12-13')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (6, 5, 4000, '2018-10-29', '2018-12-27')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (6, 2, 3500, '2018-10-26', '2018-12-19')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (6, 8, 3000, '2018-10-21', '2018-12-18')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (6, 10, 2500, '2018-10-22', '2018-12-13')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (6, 14, 2000, '2018-10-22', '2018-12-22')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (6, 13, 2000, '2018-10-24', '2018-12-17')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (6, 6, 1500, '2018-10-27', '2018-12-24')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (6, 12, 3000, '2018-10-28', '2018-12-16')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (7, 5, 4000, '2018-10-13', '2018-11-2')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (7, 2, 3500, '2018-10-15', '2018-11-18')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (7, 7, 3000, '2018-10-20', '2018-11-9')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (7, 13, 2000, '2018-10-17', '2018-11-15')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (7, 6, 1500, '2018-10-13', '2018-11-6')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (7, 12, 3000, '2018-10-19', '2018-11-19')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (8, 1, 4500, '2018-10-21', '2019-1-17')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (8, 3, 4000, '2018-10-23', '2019-1-10')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (8, 5, 4000, '2018-10-29', '2019-1-19')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (8, 4, 4000, '2018-10-24', '2019-1-21')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (8, 2, 3500, '2018-10-21', '2019-1-18')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (8, 8, 3000, '2018-10-30', '2019-1-15')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (8, 7, 3000, '2018-10-29', '2019-1-12')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (8, 9, 3000, '2018-10-29', '2019-1-26')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (8, 10, 2500, '2018-10-26', '2019-1-8')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (8, 12, 3000, '2018-10-25', '2019-1-21')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (9, 1, 4500, '2018-10-12', '2018-12-16')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (9, 3, 4000, '2018-10-20', '2018-12-9')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (9, 5, 4000, '2018-10-14', '2018-12-2')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (9, 2, 3500, '2018-10-14', '2018-12-6')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (9, 7, 3000, '2018-10-21', '2018-11-29')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (9, 14, 2000, '2018-10-16', '2018-11-28')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (9, 13, 2000, '2018-10-12', '2018-12-6')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (9, 6, 1500, '2018-10-16', '2018-11-28')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (9, 12, 3000, '2018-10-17', '2018-12-3')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (10, 1, 4500, '2018-10-15', '2018-11-17')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (10, 5, 4000, '2018-10-16', '2018-12-2')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (10, 4, 4000, '2018-10-20', '2018-11-26')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (10, 7, 3000, '2018-10-18', '2018-11-24')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (10, 9, 3000, '2018-10-20', '2018-12-2')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (10, 10, 2500, '2018-10-18', '2018-11-15')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (10, 14, 2000, '2018-10-21', '2018-11-30')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (11, 4, 4000, '2018-10-17', '2018-12-23')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (11, 9, 3000, '2018-10-19', '2019-1-2')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (11, 10, 2500, '2018-10-19', '2019-1-5')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (11, 6, 1500, '2018-10-18', '2019-1-11')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (12, 1, 4500, '2018-10-16', '2018-11-9')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (12, 3, 4000, '2018-10-15', '2018-11-14')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (12, 5, 4000, '2018-10-12', '2018-10-27')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (12, 4, 4000, '2018-10-19', '2018-11-14')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (12, 8, 3000, '2018-10-18', '2018-11-9')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (12, 7, 3000, '2018-10-13', '2018-11-6')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (12, 9, 3000, '2018-10-20', '2018-11-12')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (12, 10, 2500, '2018-10-21', '2018-11-3')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (12, 14, 2000, '2018-10-14', '2018-10-31')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (12, 12, 3000, '2018-10-17', '2018-11-14')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (12, 11, 8000, '2018-10-21', '2018-11-6')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (13, 3, 4000, '2018-10-21', '2018-12-8')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (13, 4, 4000, '2018-10-17', '2018-12-14')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (13, 8, 3000, '2018-10-16', '2018-11-29')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (13, 14, 2000, '2018-10-19', '2018-12-14')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (13, 13, 2000, '2018-10-20', '2018-12-11')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (14, 5, 4000, '2018-10-23', '2018-12-24')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (14, 6, 1500, '2018-10-25', '2018-12-16')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (14, 12, 3000, '2018-10-23', '2018-12-28')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (14, 11, 8000, '2018-10-23', '2019-1-1')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (15, 1, 4500, '2020-5-16', '2020-8-6')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (15, 3, 4000, '2020-5-21', '2020-8-11')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (15, 4, 4000, '2020-5-16', '2020-8-9')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (15, 2, 3500, '2020-5-20', '2020-8-6')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (15, 8, 3000, '2020-5-18', '2020-8-1')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (15, 6, 1500, '2020-5-18', '2020-8-2')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (17, 1, 4500, '2018-10-17', '2019-1-3')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (17, 9, 3000, '2018-10-15', '2019-1-10')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (18, 1, 4500, '2018-10-23', '2018-11-14')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (18, 3, 4000, '2018-10-19', '2018-11-22')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (18, 5, 4000, '2018-10-20', '2018-11-21')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (18, 4, 4000, '2018-10-23', '2018-11-26')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (18, 4, 4000, '2018-10-22', '2018-11-17')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (18, 2, 3500, '2018-10-25', '2018-11-18')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (18, 8, 3000, '2018-10-22', '2018-11-22')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (18, 7, 3000, '2018-10-26', '2018-11-11')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (18, 9, 3000, '2018-10-24', '2018-11-27')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (18, 6, 1500, '2018-10-19', '2018-11-16')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (18, 12, 3000, '2018-10-27', '2018-11-25')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (19, 3, 4000, '2018-10-24', '2019-1-14')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (19, 5, 4000, '2018-10-23', '2019-1-23')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (19, 7, 3000, '2018-10-26', '2019-1-12')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (19, 9, 3000, '2018-10-26', '2019-1-19')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (19, 10, 2500, '2018-10-18', '2019-1-23')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (19, 6, 1500, '2018-10-24', '2019-1-15')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (19, 12, 3000, '2018-10-24', '2019-1-12')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (20, 1, 4500, '2018-10-22', '2019-1-6')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (20, 3, 4000, '2018-10-24', '2019-1-1')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (20, 5, 4000, '2018-10-28', '2019-1-12')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (20, 4, 4000, '2018-10-21', '2019-1-14')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (20, 8, 3000, '2018-10-20', '2019-1-1')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (20, 7, 3000, '2018-10-23', '2018-12-31')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (21, 1, 4500, '2018-10-24', '2018-12-7')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (21, 3, 4000, '2018-10-23', '2018-12-14')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (21, 8, 3000, '2018-10-27', '2018-12-13')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (21, 14, 2000, '2018-10-21', '2018-12-11')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (21, 13, 2000, '2018-10-22', '2018-12-16')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (21, 6, 1500, '2018-10-27', '2018-12-16')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (24, 3, 4000, '2005-5-28', '2005-7-16')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (24, 5, 4000, '2005-5-25', '2005-7-17')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (24, 4, 4000, '2005-5-19', '2005-7-14')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (24, 8, 3000, '2005-5-21', '2005-7-4')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (24, 14, 2000, '2005-5-24', '2005-7-3')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (24, 13, 2000, '2005-5-19', '2005-7-7')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (24, 6, 1500, '2005-5-19', '2005-7-2')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (24, 12, 3000, '2005-5-23', '2005-7-1')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (25, 3, 4000, '2005-5-20', '2005-6-20')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (25, 5, 4000, '2005-5-17', '2005-6-9')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (25, 2, 3500, '2005-5-17', '2005-6-6')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (25, 8, 3000, '2005-5-14', '2005-6-21')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (25, 14, 2000, '2005-5-18', '2005-6-4')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (26, 1, 4500, '2005-5-18', '2005-8-13')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (26, 3, 4000, '2005-5-21', '2005-8-22')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (26, 8, 3000, '2005-5-19', '2005-8-25')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (26, 7, 3000, '2005-5-15', '2005-8-9')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (26, 9, 3000, '2005-5-16', '2005-8-26')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (26, 10, 2500, '2005-5-20', '2005-8-21')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (26, 14, 2000, '2005-5-17', '2005-8-14')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (26, 13, 2000, '2005-5-22', '2005-8-14')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (26, 6, 1500, '2005-5-24', '2005-8-26')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (27, 1, 4500, '2018-5-25', '2018-8-13')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (27, 3, 4000, '2018-5-26', '2018-8-9')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (27, 5, 4000, '2018-5-26', '2018-8-7')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (27, 4, 4000, '2018-5-26', '2018-8-11')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (27, 8, 3000, '2018-5-22', '2018-8-4')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (27, 9, 3000, '2018-5-21', '2018-8-10')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (27, 6, 1500, '2018-5-23', '2018-8-13')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (28, 1, 4500, '2018-5-24', '2018-5-27')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (28, 5, 4000, '2018-5-25', '2018-6-7')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (28, 4, 4000, '2018-5-26', '2018-6-6')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (28, 10, 2500, '2018-5-25', '2018-5-30')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (28, 14, 2000, '2018-5-26', '2018-6-3')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (28, 6, 1500, '2018-6-1', '2018-6-6')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (29, 3, 4000, '2020-6-27', '2020-7-20')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (29, 5, 4000, '2020-6-25', '2020-7-23')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (29, 9, 3000, '2020-6-28', '2020-8-7')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (30, 1, 4500, '2020-6-20', '2020-8-24')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (30, 3, 4000, '2020-6-27', '2020-8-28')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (31, 1, 4500, '2020-6-24', '2020-8-15')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (31, 3, 4000, '2020-6-19', '2020-8-10')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (31, 8, 3000, '2020-6-22', '2020-8-19')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (31, 7, 3000, '2020-6-20', '2020-8-12')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (31, 14, 2000, '2020-6-23', '2020-8-19')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (31, 6, 1500, '2020-6-21', '2020-8-11')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (32, 1, 4500, '2018-10-20', '2019-1-28')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (32, 3, 4000, '2018-10-27', '2019-1-14')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (32, 5, 4000, '2018-10-26', '2019-1-18')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (32, 4, 4000, '2018-10-22', '2019-1-15')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (32, 2, 3500, '2018-10-24', '2019-1-25')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (32, 8, 3000, '2018-10-23', '2019-1-26')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (32, 7, 3000, '2018-10-20', '2019-1-18')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (32, 9, 3000, '2018-10-21', '2019-1-29')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (32, 10, 2500, '2018-10-24', '2019-1-17')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (32, 14, 2000, '2018-10-29', '2019-1-23')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (32, 13, 2000, '2018-10-24', '2019-1-17')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (32, 6, 1500, '2018-10-26', '2019-1-29')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (33, 5, 4000, '2020-5-21', '2020-8-1')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (33, 7, 3000, '2020-5-22', '2020-7-26')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (33, 13, 2000, '2020-5-25', '2020-7-24')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (34, 1, 4500, '2020-5-19', '2020-6-2')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (34, 8, 3000, '2020-5-19', '2020-6-7')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (34, 7, 3000, '2020-5-25', '2020-6-9')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (34, 13, 2000, '2020-5-23', '2020-6-11')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (34, 6, 1500, '2020-5-22', '2020-6-18')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (35, 2, 3500, '2020-5-26', '2020-7-22')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (35, 7, 3000, '2020-5-23', '2020-7-7')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (35, 10, 2500, '2020-5-23', '2020-7-18')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (35, 14, 2000, '2020-5-25', '2020-7-19')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (35, 13, 2000, '2020-5-22', '2020-7-12')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (35, 12, 3000, '2020-5-29', '2020-7-6')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (35, 11, 8000, '2020-5-20', '2020-7-3')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (36, 1, 4500, '2020-5-23', '2020-6-3')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (36, 5, 4000, '2020-5-30', '2020-6-6')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (36, 4, 4000, '2020-5-27', '2020-6-2')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (36, 2, 3500, '2020-5-23', '2020-6-11')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (36, 7, 3000, '2020-5-24', '2020-6-2')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (36, 9, 3000, '2020-5-30', '2020-5-30')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (36, 10, 2500, '2020-5-23', '2020-6-1')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (36, 13, 2000, '2020-6-1', '2020-6-14')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (36, 12, 3000, '2020-5-26', '2020-6-2')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (38, 5, 4000, '2005-5-19', '2005-6-30')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (38, 4, 4000, '2005-5-15', '2005-6-22')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (38, 2, 3500, '2005-5-18', '2005-6-25')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (38, 10, 2500, '2005-5-18', '2005-6-23')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (38, 6, 1500, '2005-5-24', '2005-6-14')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (38, 12, 3000, '2005-5-20', '2005-6-24')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (39, 4, 4000, '2005-5-17', '2005-6-22')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (39, 2, 3500, '2005-5-14', '2005-7-6')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (39, 7, 3000, '2005-5-17', '2005-7-5')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (39, 9, 3000, '2005-5-21', '2005-7-7')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (39, 6, 1500, '2005-5-18', '2005-7-9')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (39, 12, 3000, '2005-5-21', '2005-7-4')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (39, 11, 8000, '2005-5-18', '2005-6-30')
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (22, 1, 4500, NULL, NULL)
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (22, 3, 4000, NULL, NULL)
INSERT INTO Tareas (IDModulo, IDTipoTarea, Precio, FechaInicio, FechaFin) VALUES (23, 1, 4500, NULL, NULL)

GO
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (1, 6, 16, 4545, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (1, 19, 40, 4572, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (1, 33, 35, 5081, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (1, 35, 96, 5170, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (2, 15, 114, 4725, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (2, 17, 33, 4144, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (2, 29, 73, 4186, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (3, 2, 90, 4008, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (4, 10, 76, 3374, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (5, 4, 67, 3447, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (5, 29, 86, 3520, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (5, 35, 94, 3513, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (5, 36, 103, 3521, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (6, 28, 50, 3072, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (6, 35, 34, 2721, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (6, 39, 94, 3356, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (8, 12, 106, 2094, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (8, 18, 52, 2005, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (8, 23, 21, 2209, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (8, 28, 64, 2385, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (8, 38, 106, 2417, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (9, 16, 13, 1879, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (9, 23, 102, 2047, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (10, 13, 45, 3976, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (10, 30, 105, 3311, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (10, 35, 119, 3840, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (10, 38, 110, 3837, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (11, 21, 110, 8795, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (11, 25, 117, 8458, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (11, 31, 11, 8377, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (12, 4, 34, 4797, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (12, 23, 107, 4652, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (13, 3, 58, 4591, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (13, 13, 58, 4579, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (14, 12, 13, 4366, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (15, 3, 73, 3350, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (15, 22, 84, 3115, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (15, 31, 86, 3158, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (15, 34, 35, 3360, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (16, 8, 79, 3675, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (16, 13, 118, 3210, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (16, 34, 58, 3021, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (17, 6, 117, 3961, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (17, 21, 68, 3630, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (17, 28, 118, 3578, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (18, 10, 100, 2502, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (18, 27, 88, 3048, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (18, 28, 15, 3425, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (18, 31, 37, 2827, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (20, 5, 40, 2267, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (20, 11, 109, 2836, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (21, 17, 81, 2445, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (21, 30, 54, 2051, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (21, 40, 44, 2417, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (23, 3, 117, 3445, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (23, 12, 105, 3334, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (27, 7, 79, 8686, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (27, 12, 53, 8597, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (27, 15, 66, 8086, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (27, 38, 53, 8737, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (28, 18, 46, 4189, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (28, 31, 32, 4649, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (30, 9, 74, 3857, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (30, 11, 118, 3665, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (30, 13, 72, 3081, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (30, 15, 49, 3023, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (30, 16, 111, 3021, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (30, 19, 95, 3793, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (31, 4, 117, 2874, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (31, 20, 48, 3364, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (31, 24, 45, 2706, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (32, 1, 20, 2654, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (32, 28, 97, 2980, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (32, 38, 97, 2313, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (33, 30, 50, 1633, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (36, 19, 16, 2994, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (36, 23, 60, 2512, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (36, 38, 38, 2661, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (37, 25, 111, 4559, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (37, 30, 90, 5019, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (37, 31, 43, 4642, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (38, 11, 23, 4363, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (38, 22, 112, 4085, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (38, 38, 88, 4607, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (39, 12, 36, 4522, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (39, 15, 24, 4156, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (39, 32, 92, 4688, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (40, 15, 107, 3972, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (40, 23, 10, 4442, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (40, 33, 72, 4480, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (41, 7, 109, 3901, 'S')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (41, 38, 107, 3822, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (42, 31, 108, 2823, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (43, 4, 33, 2921, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (43, 33, 47, 2002, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (43, 36, 111, 2786, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (44, 37, 81, 2254, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (45, 22, 112, 1732, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (46, 3, 82, 3664, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (47, 6, 102, 4222, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (48, 32, 73, 4082, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (48, 33, 42, 3708, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (49, 16, 17, 3897, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (50, 4, 89, 2685, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (50, 5, 35, 2494, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (50, 25, 98, 2981, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (50, 34, 86, 2780, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (51, 9, 41, 2207, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (51, 31, 27, 1525, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (52, 11, 26, 3364, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (53, 5, 83, 5402, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (53, 10, 109, 4690, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (53, 37, 58, 4928, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (54, 3, 119, 4710, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (54, 4, 54, 4548, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (54, 29, 20, 4980, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (54, 38, 39, 4533, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (55, 3, 50, 4570, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (55, 4, 59, 4706, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (55, 21, 78, 4019, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (55, 24, 107, 4133, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (56, 27, 17, 4970, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (56, 39, 112, 4362, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (57, 4, 46, 4491, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (57, 11, 44, 3659, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (57, 29, 74, 4174, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (57, 37, 50, 4163, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (57, 39, 50, 3878, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (58, 20, 56, 3481, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (58, 35, 48, 3561, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (59, 21, 103, 3505, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (59, 29, 71, 3945, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (59, 33, 73, 3746, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (61, 11, 75, 2650, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (61, 15, 13, 3179, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (61, 40, 111, 2973, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (63, 5, 35, 4672, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (63, 11, 72, 5191, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (64, 40, 32, 4483, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (65, 34, 24, 4518, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (66, 19, 70, 4160, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (66, 20, 56, 4228, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (66, 23, 47, 3620, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (66, 25, 19, 3910, 'S')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (68, 2, 115, 2022, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (68, 27, 94, 2917, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (69, 24, 12, 2756, 'S')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (69, 34, 35, 2493, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (70, 37, 8, 2054, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (71, 6, 104, 3782, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (71, 16, 61, 3638, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (71, 39, 89, 3893, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (72, 4, 11, 5162, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (72, 6, 113, 5241, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (72, 9, 118, 5254, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (72, 36, 34, 5495, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (73, 1, 109, 4428, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (73, 26, 17, 4283, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (73, 30, 8, 4652, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (73, 40, 29, 4224, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (74, 3, 49, 4956, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (74, 34, 12, 4928, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (75, 22, 60, 3548, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (75, 23, 82, 3451, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (75, 32, 99, 3453, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (76, 14, 80, 3301, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (76, 25, 54, 3998, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (78, 29, 110, 2993, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (78, 35, 34, 2753, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (79, 9, 16, 4910, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (79, 25, 90, 4586, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (80, 13, 46, 3608, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (80, 32, 106, 3949, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (81, 3, 44, 3473, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (81, 37, 79, 2754, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (84, 14, 66, 4137, 'S')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (84, 36, 23, 4789, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (85, 3, 68, 4860, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (85, 14, 35, 4299, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (85, 18, 39, 4282, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (85, 26, 117, 4588, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (85, 29, 77, 4319, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (85, 35, 55, 4695, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (86, 22, 77, 4656, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (86, 32, 43, 4107, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (87, 1, 70, 3504, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (87, 10, 59, 3664, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (87, 17, 18, 3689, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (87, 31, 20, 3749, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (87, 37, 66, 3326, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (88, 10, 79, 3336, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (90, 9, 93, 3382, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (90, 29, 51, 2771, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (91, 1, 13, 2829, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (91, 19, 81, 2500, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (93, 13, 8, 8855, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (93, 15, 103, 8841, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (93, 38, 77, 8465, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (94, 30, 108, 4743, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (95, 23, 51, 4303, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (95, 30, 25, 4862, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (96, 38, 84, 3308, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (96, 40, 115, 3403, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (97, 7, 42, 2752, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (97, 40, 29, 2037, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (98, 9, 78, 2931, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (98, 21, 61, 2050, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (98, 25, 68, 2451, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (98, 33, 36, 2614, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (99, 2, 87, 4737, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (99, 38, 49, 4484, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (101, 6, 8, 3359, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (101, 22, 117, 3133, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (101, 29, 76, 3281, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (101, 33, 109, 3255, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (101, 36, 21, 3074, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (102, 18, 102, 8490, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (102, 30, 94, 8218, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (103, 8, 107, 5339, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (103, 10, 10, 4813, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (103, 29, 25, 4940, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (104, 6, 42, 4642, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (104, 34, 109, 4397, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (104, 35, 80, 4426, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (105, 1, 94, 4827, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (105, 6, 109, 4517, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (105, 24, 62, 4724, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (105, 40, 74, 4527, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (106, 14, 40, 4361, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (106, 38, 83, 3826, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (107, 9, 35, 3510, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (107, 13, 11, 3367, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (107, 32, 33, 3935, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (107, 38, 115, 3350, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (109, 36, 22, 5481, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (109, 40, 42, 4542, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (110, 11, 84, 3766, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (111, 12, 111, 4689, 'S')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (117, 9, 87, 3428, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (117, 25, 49, 3793, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (117, 33, 44, 3781, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (118, 1, 85, 3386, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (118, 22, 30, 3917, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (119, 3, 70, 3743, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (120, 16, 60, 1521, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (121, 10, 37, 3970, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (121, 39, 59, 3568, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (122, 32, 37, 4296, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (122, 33, 98, 4592, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (122, 40, 96, 4926, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (123, 33, 34, 4585, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (124, 19, 64, 3052, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (124, 27, 55, 3417, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (124, 29, 88, 3564, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (125, 14, 58, 3577, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (125, 36, 116, 3213, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (126, 33, 55, 2838, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (127, 12, 112, 2056, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (128, 21, 18, 3992, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (128, 39, 71, 3873, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (129, 1, 30, 5494, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (129, 21, 48, 4639, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (129, 23, 60, 4756, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (130, 3, 26, 4502, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (130, 10, 11, 4594, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (130, 30, 84, 4051, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (130, 38, 99, 4859, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (131, 2, 59, 4548, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (131, 3, 89, 4762, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (131, 5, 80, 4688, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (131, 17, 27, 4877, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (132, 1, 23, 4362, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (132, 15, 46, 4372, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (132, 19, 16, 4198, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (133, 36, 55, 3638, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (133, 39, 88, 3742, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (134, 5, 119, 3390, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (134, 9, 55, 3648, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (134, 21, 105, 3129, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (134, 36, 77, 3542, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (135, 15, 59, 5455, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (136, 5, 71, 4922, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (136, 8, 80, 4066, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (136, 31, 28, 4810, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (136, 37, 22, 5000, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (136, 40, 10, 4928, 'S')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (137, 7, 64, 3788, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (137, 15, 59, 3667, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (137, 30, 53, 3548, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (138, 34, 30, 2940, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (139, 11, 35, 2612, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (139, 16, 10, 2743, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (140, 5, 56, 1695, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (140, 11, 46, 1856, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (140, 26, 42, 2088, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (140, 27, 47, 2433, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (140, 32, 29, 1654, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (141, 6, 91, 4271, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (142, 13, 48, 4464, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (142, 14, 109, 4742, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (143, 8, 27, 4480, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (143, 29, 39, 4588, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (143, 34, 63, 4648, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (144, 9, 36, 3642, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (145, 24, 58, 2785, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (146, 15, 34, 2953, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (147, 21, 8, 1782, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (147, 26, 92, 1846, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (148, 12, 13, 3016, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (148, 24, 32, 3867, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (149, 6, 38, 4334, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (149, 16, 74, 4380, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (149, 24, 110, 4380, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (149, 32, 56, 4439, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (149, 39, 79, 4422, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (150, 6, 115, 4338, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (150, 20, 100, 4435, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (150, 24, 35, 4211, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (150, 29, 25, 4310, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (150, 34, 44, 4866, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (151, 18, 13, 3841, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (151, 21, 51, 3718, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (151, 26, 63, 3620, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (152, 8, 102, 3930, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (152, 10, 83, 3601, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (153, 14, 78, 2263, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (153, 26, 99, 2466, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (154, 2, 19, 5048, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (154, 10, 105, 4994, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (154, 40, 64, 4883, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (156, 7, 48, 3140, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (156, 18, 50, 3748, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (156, 20, 107, 3607, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (157, 19, 38, 3817, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (157, 37, 38, 3260, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (157, 38, 99, 3563, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (158, 40, 49, 3184, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (159, 27, 26, 3014, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (159, 32, 97, 2935, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (159, 40, 119, 3034, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (160, 15, 36, 2510, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (161, 14, 90, 2928, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (161, 20, 34, 2728, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (161, 37, 111, 2246, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (162, 19, 75, 1548, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (163, 11, 10, 4935, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (163, 20, 44, 5294, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (163, 29, 120, 4824, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (164, 32, 81, 4849, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (165, 6, 72, 4069, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (165, 19, 25, 4214, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (165, 35, 94, 4311, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (165, 36, 20, 4569, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (165, 39, 35, 4369, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (166, 3, 48, 4830, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (166, 7, 120, 4954, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (166, 12, 12, 4700, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (166, 23, 53, 4867, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (167, 32, 70, 3676, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (167, 40, 37, 3725, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (168, 31, 25, 3485, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (168, 33, 14, 3458, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (169, 2, 114, 2014, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (169, 7, 83, 2284, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (170, 19, 108, 4843, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (171, 40, 84, 4380, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (172, 11, 8, 4378, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (172, 25, 67, 4634, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (172, 32, 20, 4614, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (173, 3, 58, 3066, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (173, 14, 118, 2924, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (173, 19, 106, 2636, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (173, 25, 62, 2841, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (173, 38, 85, 3070, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (173, 39, 36, 2969, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (174, 14, 46, 2159, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (174, 18, 68, 2102, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (175, 21, 31, 2149, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (175, 29, 51, 1968, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (176, 4, 73, 4061, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (177, 5, 40, 4225, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (177, 9, 81, 4389, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (177, 39, 88, 4171, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (178, 6, 34, 3200, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (178, 8, 80, 3967, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (179, 38, 53, 5070, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (180, 3, 91, 4251, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (180, 6, 10, 4720, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (180, 7, 43, 4083, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (181, 3, 44, 4804, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (181, 38, 63, 4805, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (182, 9, 34, 4565, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (182, 25, 77, 4073, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (183, 28, 75, 3903, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (184, 35, 63, 3637, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (185, 7, 93, 2404, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (185, 12, 16, 2605, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (185, 24, 106, 2715, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (185, 25, 120, 2136, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (186, 15, 89, 1579, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (186, 23, 96, 1628, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (186, 34, 94, 2307, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (187, 16, 118, 4533, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (187, 40, 79, 5150, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (188, 24, 17, 4067, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (188, 37, 19, 4636, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (189, 17, 91, 4993, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (189, 18, 58, 4723, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (190, 11, 77, 4455, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (190, 12, 120, 4997, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (190, 14, 96, 4080, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (190, 16, 42, 4423, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (190, 29, 13, 4540, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (190, 35, 69, 4586, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (190, 36, 15, 4713, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (193, 11, 100, 3416, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (193, 19, 86, 3503, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (194, 11, 58, 3870, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (194, 24, 60, 3362, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (195, 12, 71, 2864, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (196, 5, 79, 2117, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (196, 20, 54, 2785, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (197, 14, 34, 2066, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (197, 39, 91, 2459, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (198, 19, 100, 1954, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (198, 20, 47, 2305, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (198, 40, 18, 2203, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (199, 1, 45, 4867, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (200, 33, 97, 3500, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (201, 2, 115, 2184, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (201, 6, 27, 2074, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (201, 9, 41, 2763, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (202, 31, 14, 5108, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (203, 12, 58, 3183, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (203, 29, 107, 3374, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (203, 22, 81, 3534, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (204, 25, 8, 3881, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (205, 18, 88, 2936, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (205, 5, 23, 2879, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (206, 19, 24, 1551, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (207, 24, 49, 3943, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (208, 6, 53, 3477, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (208, 38, 119, 3969, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (210, 36, 88, 2230, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (211, 12, 38, 2320, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (213, 1, 61, 8015, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (213, 2, 47, 8278, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (213, 3, 26, 8950, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (213, 30, 72, 8480, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (214, 36, 70, 5330, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (215, 1, 61, 4218, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (215, 2, 34, 4608, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (215, 4, 94, 4441, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (215, 11, 111, 4788, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (215, 18, 93, 4122, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (216, 1, 117, 4092, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (217, 15, 35, 3759, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (217, 20, 15, 3759, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (217, 31, 39, 4428, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (218, 1, 116, 3051, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (218, 3, 92, 3102, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (219, 15, 98, 3858, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (219, 30, 62, 3053, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (220, 8, 48, 3258, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (220, 10, 43, 2996, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (220, 18, 88, 2906, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (220, 26, 26, 3093, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (221, 19, 13, 2700, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (221, 29, 15, 2781, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (221, 33, 17, 2734, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (222, 39, 72, 3053, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (222, 40, 113, 3224, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (223, 6, 60, 4178, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (223, 23, 23, 4482, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (223, 35, 53, 4563, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (224, 24, 67, 4586, 'S')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (224, 37, 78, 4694, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (225, 10, 110, 3974, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (225, 37, 27, 4196, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (226, 19, 16, 2724, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (226, 34, 76, 3261, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (227, 12, 41, 2177, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (227, 29, 100, 1576, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (228, 2, 22, 3272, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (228, 9, 70, 3851, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (228, 25, 106, 3599, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (228, 37, 76, 3955, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (229, 24, 24, 4363, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (229, 29, 23, 4969, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (230, 12, 79, 4257, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (230, 23, 42, 4166, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (231, 40, 84, 3844, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (233, 11, 49, 1903, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (234, 2, 37, 3379, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (234, 4, 86, 3809, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (234, 14, 20, 3998, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (234, 29, 75, 3642, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (234, 37, 46, 3444, 'A')
INSERT INTO Colaboraciones (IDTarea, IDColaborador, Tiempo, Precio, Estado) VALUES (235, 34, 108, 8729, 'A')

