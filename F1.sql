-----Criando a base de dados-----

-- Database: F1

-- DROP DATABASE "F1";

--CREATE DATABASE "F1"
--    WITH 
--    OWNER = postgres
--    ENCODING = 'UTF8'
--    LC_COLLATE = 'Portuguese_Brazil.1252'
--    LC_CTYPE = 'Portuguese_Brazil.1252'
--    TABLESPACE = pg_default
--    CONNECTION LIMIT = -1;

-----Funções-----

CREATE FUNCTION Novo_Patrocinador (patrocinador varchar, fk varchar)
	RETURNS void
	LANGUAGE plpgsql
	as
$$
	DECLARE
	ID integer DEFAULT 0;
	
	begin
		select count(*) into ID from Patrocinador;
		insert into Patrocinador values (ID+1, patrocinador, fk);
	end;
$$

-----Criando Tabelas-----

CREATE TABLE Unidade_de_potência (
Nome varchar(60),
Fornecedor varchar(20) PRIMARY KEY,
Valor int
);

CREATE TABLE Equipe (
Nome_Fantasia varchar(20) PRIMARY KEY,
Combustível varchar(20),
Pontuação smallint,
Orçamento int,
Nome varchar(45),
Títulos smallint,
Site_Oficial varchar(60),
FK_Motor varchar(20)
);

CREATE TABLE Piloto (
Nome varchar(60),
Número smallint PRIMARY KEY,
Corridas_iniciadas smallint,
Títulos_mundiais smallint,
Vitórias smallint,
Pódios smallserial,
Pole_Positions smallserial,
Pontuação smallint,
Nacionalidade varchar(20),
Data_de_nascimento date,
Salário int,
FK_Equipe varchar(20)
);

CREATE TABLE Equipamento (
Peça varchar(20),
Valor int,
FK_Equipe varchar(20)
);

CREATE TABLE Funcionario (
ID serial PRIMARY KEY,
Nome varchar(60),
Idade smallint,
Salario int,
Cargo varchar(30),
FK_Equipe varchar(20)
);

CREATE TABLE Patrocinador (
ID serial PRIMARY KEY,
Patrocinador varchar(60),
FK_Equipe varchar(20)
);

ALTER TABLE Equipe ADD FOREIGN KEY(FK_Motor) REFERENCES Unidade_de_potência (Fornecedor);
ALTER TABLE Piloto ADD FOREIGN KEY(FK_Equipe) REFERENCES Equipe (Nome_Fantasia);
ALTER TABLE Equipamento ADD FOREIGN KEY(FK_Equipe) REFERENCES Equipe (Nome_Fantasia);
ALTER TABLE Funcionario ADD FOREIGN KEY(FK_Equipe) REFERENCES Equipe (Nome_Fantasia);
ALTER TABLE Patrocinador ADD FOREIGN KEY(FK_Equipe) REFERENCES Equipe (Nome_Fantasia);

-----Populando as tabelas-----

insert into Unidade_de_potência values ('Mercedes-AMG F1 M12 E Performance 1.6 V6 Turbo Híbrido', 'Mercedes-AMG', 19755000);
insert into Unidade_de_potência values ('RA621H 1.6 V6 Turbo híbrido', 'Honda', 18385000);
insert into Unidade_de_potência values ('Renault E-Tech 20 1.6 V6 Turbo híbrido', 'Renault', 19132000);
insert into Unidade_de_potência values ('Ferrari 065 1.6 V6 Turbo híbrido', 'Ferrari', 19507000);

insert into Equipe values ('Mercedes', 'Petronas Primax', 303, 123000000, 'Mercedes-AMG Petronas Formula One Team', 7, 'http://www.mercedesamgf1.com/', 'Mercedes-AMG');
insert into Equipe values ('RBR', 'Esso/Mobil Synergy', 291, 123000000, 'Red Bull Racing Honda', 4, 'http://redbullracing.redbull.com/', 'Honda');
insert into Equipe values ('McLaren', 'BP Ultimate', 163, 123000000, 'McLaren F1 Team', 8, 'https://www.mclaren.com/formula1/', 'Mercedes-AMG');
insert into Equipe values ('Aston Martin', 'Petronas Primax', 48, 123000000, 'Aston Martin Cognizant Formula One Team', 0, 'https://www.astonmartin.com/en/our-world/AMF1', 'Mercedes-AMG');
insert into Equipe values ('Alpine', 'BP Ultimate', 77, 123000000, 'Alpine F1 Team', 0, 'https://www.alpinecars.com/fr/formule-1/actualites/', 'Renault');
insert into Equipe values ('AlphaTauri', 'Mobil 1', 68, 123000000, 'Scuderia AlphaTauri Honda', 0, 'https://www.scuderiaalphatauri.com/', 'Honda');
insert into Equipe values ('Ferrari', 'Shell V-Power', 163, 123000000, 'Scuderia Mission Winnow Ferrari', 16, 'https://www.ferrari.com/', 'Ferrari');
insert into Equipe values ('Alfa Romeo', 'Shell V-Power', 3, 123000000, 'Alfa Romeo Racing Orlen', 0, 'http://alfaromeo.com/alfa-romeo-racing', 'Ferrari');
insert into Equipe values ('Haas', 'Shell V-Power', 0, 123000000, 'Uralkali Haas F1 Team', 0, 'https://www.haasf1team.com/', 'Ferrari');
insert into Equipe values ('Williams', 'Petronas Primax', 10, 123000000, 'Williams Racing', 9, 'http://www.williamsf1.com/', 'Mercedes-AMG');

insert into Piloto values ('Lewis Hamilton', 44, 277, 7, 99, 173, 101, 195, 'Inglaterra', '07-01-1985', 27000000, 'Mercedes');
insert into Piloto values ('Valtteri Bottas', 77, 168, 0, 9, 62, 17, 108, 'Finlândia', '28/08/1989', 9100000, 'Mercedes');
insert into Piloto values ('Max Verstappen', 33, 131, 0, 15, 50, 9, 187, 'Bélgica', '30-09-1997', 22700000, 'RBR');
insert into Piloto values ('Sergio Pérez', 11, 204, 0, 2, 12, 0, 104, 'Mexico', '26-01-1990', 7300000, 'RBR');
insert into Piloto values ('Daniel Ricciardo', 3, 200, 0, 7, 31, 3, 50, 'Austrália', '01-07-1989', 13600000, 'McLaren');
insert into Piloto values ('Lando Norris', 4, 50, 0, 0, 4, 0, 113, 'Inglaterra', '13-11-1999', 4500000, 'McLaren');
insert into Piloto values ('Lance Stroll', 18, 90, 0, 0, 3, 1, 30, 'Canadá', '29-10-1998', 9100000, 'Aston Martin');
insert into Piloto values ('Sebastian Vettel', 5, 270, 4, 53, 122, 57, 18, 'Alemanha', '03-07-1987', 13600000, 'Aston Martin');
insert into Piloto values ('Fernando Alonso', 14, 326, 2, 32, 97, 22, 38, 'Espanha', '29-07-1981', 18700000, 'Alpine');
insert into Piloto values ('Esteban Occon', 31, 79, 0, 1, 2, 0, 39, 'Normândia', '17-09-1996', 2300000, 'Alpine');
insert into Piloto values ('Yuki Tsunoda', 22, 12, 0, 0, 0, 0, 18, 'Japão', '11-05-2000', 44000000, 'AlphaTauri');
insert into Piloto values ('Pierre Gasly', 10, 76, 0, 1, 3, 0, 50, 'França', '07-02-1996', 4500000, 'AlphaTauri');
insert into Piloto values ('Charles Leclerc', 16, 71, 0, 2, 13, 9, 80, 'Monaco', '16-10-1997', 10900000, 'Ferrari');
insert into Piloto values ('Carlos Sainz Jr.', 55, 131, 0, 0, 4, 0, 83, 'Espanha', '01-09-1994', 9100000, 'Ferrari');
insert into Piloto values ('Kimi Räikkönen', 7, 344, 1, 21, 103, 18, 2, 'Finlândia', '17-10-1979', 9100000, 'Alfa Romeo');
insert into Piloto values ('Antonio Giovinazzi', 99, 19, 0, 0, 0, 0, 1, 'Itália', '14-12-1993', 900000, 'Alfa Romeo');
insert into Piloto values ('Nikita Mazepin', 9, 12, 0, 0, 0, 0, 0, 'Rússia', '02-03-1999', 90000000, 'Haas');
insert into Piloto values ('Mick Schumacher', 47, 12, 0, 0, 0, 0, 0, 'Suíça', '22-03-1999', 90000000, 'Haas');
insert into Piloto values ('George Russell', 63, 50, 0, 0, 0, 0, 4, 'Inglaterra', '15-02-1998', 90000000, 'Williams');
insert into Piloto values ('Nicholas Latifi', 6, 29, 0, 0, 0, 0, 6, 'Canadá', '29-06-1995', 90000000, 'Williams');

insert into Equipamento values ('Caixa de câmbio', 456000, 'Mercedes');
insert into Equipamento values ('ECU', 169000, 'Mercedes');
insert into Equipamento values ('Asa dianteira', 146000, 'Mercedes');
insert into Equipamento values ('Asa traseira', 94000, 'Mercedes');
insert into Equipamento values ('Tanque', 135000, 'Mercedes');
insert into Equipamento values ('Volante', 67000, 'Mercedes');
insert into Equipamento values ('Halo', 25000, 'Mercedes');
insert into Equipamento values ('Jogo de pneus', 3000, 'Mercedes');
insert into Equipamento values ('Caixa de câmbio', 458000, 'RBR');
insert into Equipamento values ('ECU', 165000, 'RBR');
insert into Equipamento values ('Asa dianteira', 149000, 'RBR');
insert into Equipamento values ('Asa traseira', 93000, 'RBR');
insert into Equipamento values ('Tanque', 135000, 'RBR');
insert into Equipamento values ('Volante', 68000, 'RBR');
insert into Equipamento values ('Halo', 24000, 'RBR');
insert into Equipamento values ('Jogo de pneus', 3000, 'RBR');
insert into Equipamento values ('Caixa de câmbio', 455000, 'McLaren');
insert into Equipamento values ('ECU', 164000, 'McLaren');
insert into Equipamento values ('Asa dianteira', 145000, 'McLaren');
insert into Equipamento values ('Asa traseira', 90000, 'McLaren');
insert into Equipamento values ('Tanque', 132000, 'McLaren');
insert into Equipamento values ('Volante', 65000, 'McLaren');
insert into Equipamento values ('Halo', 24000, 'McLaren');
insert into Equipamento values ('Jogo de pneus', 2800, 'McLaren');
insert into Equipamento values ('Caixa de câmbio', 453000, 'Aston Martin');
insert into Equipamento values ('ECU', 162000, 'Aston Martin');
insert into Equipamento values ('Asa dianteira', 140000, 'Aston Martin');
insert into Equipamento values ('Asa traseira', 90000, 'Aston Martin');
insert into Equipamento values ('Tanque', 127000, 'Aston Martin');
insert into Equipamento values ('Volante', 58000, 'Aston Martin');
insert into Equipamento values ('Halo', 22000, 'Aston Martin');
insert into Equipamento values ('Jogo de pneus', 2700, 'Aston Martin');
insert into Equipamento values ('Caixa de câmbio', 452000, 'Alpine');
insert into Equipamento values ('ECU', 159000, 'Alpine');
insert into Equipamento values ('Asa dianteira', 139000, 'Alpine');
insert into Equipamento values ('Asa traseira', 90000, 'Alpine');
insert into Equipamento values ('Tanque', 125000, 'Alpine');
insert into Equipamento values ('Volante', 58000, 'Alpine');
insert into Equipamento values ('Halo', 22000, 'Alpine');
insert into Equipamento values ('Jogo de pneus', 2700, 'Alpine');
insert into Equipamento values ('Caixa de câmbio', 450000, 'AlphaTauri');
insert into Equipamento values ('ECU', 158000, 'AlphaTauri');
insert into Equipamento values ('Asa dianteira', 139000, 'AlphaTauri');
insert into Equipamento values ('Asa traseira', 92000, 'AlphaTauri');
insert into Equipamento values ('Tanque', 127000, 'AlphaTauri');
insert into Equipamento values ('Volante', 56000, 'AlphaTauri');
insert into Equipamento values ('Halo', 21000, 'AlphaTauri');
insert into Equipamento values ('Jogo de pneus', 2700, 'AlphaTauri');
insert into Equipamento values ('Caixa de câmbio', 455000, 'Ferrari');
insert into Equipamento values ('ECU', 163000, 'Ferrari');
insert into Equipamento values ('Asa dianteira', 142000, 'Ferrari');
insert into Equipamento values ('Asa traseira', 92000, 'Ferrari');
insert into Equipamento values ('Tanque', 132000, 'Ferrari');
insert into Equipamento values ('Volante', 66000, 'Ferrari');
insert into Equipamento values ('Halo', 23000, 'Ferrari');
insert into Equipamento values ('Jogo de pneus', 2900, 'Ferrari');
insert into Equipamento values ('Caixa de câmbio', 448000, 'Alfa Romeo');
insert into Equipamento values ('ECU', 157000, 'Alfa Romeo');
insert into Equipamento values ('Asa dianteira', 138000, 'Alfa Romeo');
insert into Equipamento values ('Asa traseira', 80000, 'Alfa Romeo');
insert into Equipamento values ('Tanque', 123000, 'Alfa Romeo');
insert into Equipamento values ('Volante', 54000, 'Alfa Romeo');
insert into Equipamento values ('Halo', 17000, 'Alfa Romeo');
insert into Equipamento values ('Jogo de pneus', 2600, 'Alfa Romeo');
insert into Equipamento values ('Caixa de câmbio', 442000, 'Haas');
insert into Equipamento values ('ECU', 152000, 'Haas');
insert into Equipamento values ('Asa dianteira', 135000, 'Haas');
insert into Equipamento values ('Asa traseira', 80000, 'Haas');
insert into Equipamento values ('Tanque', 115000, 'Haas');
insert into Equipamento values ('Volante', 52000, 'Haas');
insert into Equipamento values ('Halo', 15000, 'Haas');
insert into Equipamento values ('Jogo de pneus', 2400, 'Haas');
insert into Equipamento values ('Caixa de câmbio', 447000, 'Williams');
insert into Equipamento values ('ECU', 156000, 'Williams');
insert into Equipamento values ('Asa dianteira', 136000, 'Williams');
insert into Equipamento values ('Asa traseira', 77000, 'Williams');
insert into Equipamento values ('Tanque', 123000, 'Williams');
insert into Equipamento values ('Volante', 55000, 'Williams');
insert into Equipamento values ('Halo', 17000, 'Williams');
insert into Equipamento values ('Jogo de pneus', 2700, 'Williams');

-----Gerador de dados (http://www.generatedata.com/)-----
INSERT INTO Funcionario (ID,Nome,Idade,Salario) VALUES (1,'Tarik Riley',34,32310),(2,'Ahmed Mclaughlin',31,44780),(3,'Akeem Jensen',40,30458),(4,'Lyle Charles',41,33627),(5,'Francis Barron',26,48531),(6,'Chaim Camacho',21,40080),(7,'Peter Carroll',24,36794),(8,'Anthony Christian',40,49172),(9,'Devin Mullins',41,37354),(10,'Macaulay Barron',43,36534),(11,'Derek Pierce',39,37132),(12,'Brady Hart',32,39355),(13,'Fitzgerald Koch',27,28844),(14,'Chandler Potter',21,36385),(15,'Aquila Nguyen',25,49718),(16,'Quamar Campos',27,49799),(17,'Rigel Decker',25,32288),(18,'Sebastian Velez',36,48047),(19,'Slade Donaldson',31,38723),(20,'Justin Kennedy',31,31772),(21,'Wang Abbott',44,47143),(22,'Garrett House',29,35501),(23,'Fritz Nash',34,49363),(24,'Xander Moses',39,36093),(25,'Adam Romero',36,37303),(26,'Julian Simon',33,32822),(27,'Troy Hamilton',43,45241),(28,'Dustin Rivera',33,36422),(29,'Herrod Hunter',22,49174),(30,'Brennan Spencer',44,40246),(31,'Patrick Taylor',30,49151),(32,'Myles Mcdowell',37,46870),(33,'Lawrence Castillo',44,38520),(34,'Xanthus Cole',37,29785),(35,'Samson Lamb',25,25925),(36,'Keefe Wise',29,45452),(37,'Mason Shepherd',42,32627),(38,'Ross Robbins',30,25987),(39,'Dylan Riggs',42,39639),(40,'Allen Haney',43,25729),(41,'Colorado Mccray',29,42941),(42,'Hu Bowen',28,28232),(43,'Lester Melton',29,41580),(44,'Paki Whitney',21,49279),(45,'Damon Henson',22,34216),(46,'Arden Solomon',20,26625),(47,'Drew Vance',28,37394),(48,'Tiger Carney',45,47060),(49,'Palmer Scott',33,37488),(50,'Grant Sims',37,49111),(51,'Brett Mack',27,29121),(52,'Felix Sanders',39,29306),(53,'Ross Adkins',37,37231),(54,'Thor Park',34,35549),(55,'Mohammad Logan',31,36426),(56,'Chaim Wood',23,48410),(57,'Luke Maddox',32,36172),(58,'Uriah Strong',44,32752),(59,'Edward Ashley',34,39221),(60,'Marvin Mueller',25,47399),(61,'Malik Silva',27,31729),(62,'Walter Neal',36,25363),(63,'Oscar Whitaker',20,27950),(64,'Hoyt Pennington',37,49405),(65,'Nasim Ramos',28,46038),(66,'Elmo Yates',26,37564),(67,'Kane Barnett',40,42858),(68,'Brandon Lancaster',39,28045),(69,'Keith Browning',30,27923),(70,'Quinlan Herring',27,40944),(71,'Amir Sellers',31,44999),(72,'Stuart Peters',44,38767),(73,'Reed Alford',30,29053),(74,'Paul Medina',21,45085),(75,'Joshua Fischer',37,35239),(76,'Colt Farley',26,37798),(77,'Jasper Fernandez',31,45176),(78,'Hall Anderson',44,47369),(79,'Hamilton Goodwin',27,37769),(80,'Gareth Osborne',43,29058),(81,'Dominic Hood',29,41061),(82,'Christopher Moreno',33,42322),(83,'Trevor Macias',23,37063),(84,'Tarik Moon',32,39276),(85,'Micah Norman',42,29442),(86,'Vladimir Beard',24,38106),(87,'Zephania Pittman',29,25773),(88,'Uriah Reeves',37,28348),(89,'Burke Dale',30,38794),(90,'Peter Wilson',34,25383),(91,'Donovan Joyner',35,39974),(92,'Perry Mcdaniel',37,29658),(93,'Preston Mcmahon',21,30445),(94,'Jonah Graham',31,27984),(95,'Declan Clements',21,29624),(96,'Jesse Dillon',30,35822),(97,'Stuart Alford',26,31970),(98,'Dillon Barnett',41,38184),(99,'Theodore Kennedy',20,31962),(100,'Cedric Chapman',23,32675);
INSERT INTO Funcionario (ID,Nome,Idade,Salario) VALUES (101,'Porter Mcpherson',25,45397),(102,'Brennan Terry',37,44814),(103,'Jackson Cruz',37,27306),(104,'Oscar Bentley',32,45641),(105,'Russell Pope',38,27983),(106,'Keefe Torres',45,44112),(107,'Odysseus Brooks',25,45080),(108,'Keith Maxwell',39,34758),(109,'Alden Henson',23,28354),(110,'Gabriel Fitzpatrick',24,49960),(111,'Duncan Shaw',27,29175),(112,'Gavin Valencia',39,33499),(113,'Fritz Wiggins',37,38881),(114,'Allistair Harmon',32,30280),(115,'Dane Terrell',24,34853),(116,'Melvin Reid',43,36702),(117,'Aladdin Salazar',42,34879),(118,'Colin Holloway',37,35827),(119,'Amos Hamilton',26,29609),(120,'Cullen Juarez',35,35685),(121,'Justin Reese',24,43634),(122,'Neil Lyons',28,41447),(123,'Troy Tran',44,34266),(124,'Hamish Nelson',21,42017),(125,'Wade Lane',32,39148),(126,'Keith Moses',36,40533),(127,'Deacon Hartman',42,37514),(128,'Keaton Salas',26,30468),(129,'Jakeem Raymond',43,45807),(130,'Caleb Gilmore',38,36606),(131,'August Phillips',25,46099),(132,'Dale Hill',31,37472),(133,'Aladdin Witt',32,40372),(134,'Zahir Bass',35,32669),(135,'Hamish Armstrong',36,32608),(136,'Amery Allen',42,30982),(137,'Vernon Turner',34,27659),(138,'Hall Noel',32,37271),(139,'Keegan Malone',36,40616),(140,'Nolan Holden',30,36089),(141,'Jamal Kramer',22,29003),(142,'Keefe Lambert',28,37167),(143,'Hamish Obrien',36,42083),(144,'Wylie Bruce',43,49101),(145,'Walker Heath',33,40671),(146,'Colton Gordon',25,35415),(147,'Vernon Mcmahon',20,31783),(148,'Colorado Dickerson',30,49653),(149,'Thor Morales',20,37671),(150,'Trevor Alston',42,26374),(151,'Hu Rowland',26,36429),(152,'Wayne Stanton',43,39822),(153,'Raja Jacobson',22,48914),(154,'Nicholas Cook',37,43629),(155,'Warren Holloway',26,43788),(156,'Aaron Franklin',42,46143),(157,'Craig Golden',40,33158),(158,'Gregory Garcia',30,31725),(159,'Vernon Marks',24,42393),(160,'Kaseem Franklin',27,28907),(161,'Samson Holland',22,25548),(162,'August Hess',35,42702),(163,'Leonard Booth',35,27535),(164,'Emmanuel Lancaster',28,33558),(165,'Jacob Salinas',30,47323),(166,'Wing Irwin',31,36435),(167,'Elliott Grimes',24,28257),(168,'Thomas Finch',36,49622),(169,'Ishmael Nelson',24,32493),(170,'Warren Burns',38,31187),(171,'Craig Faulkner',28,35410),(172,'Hoyt Sutton',43,36771),(173,'Hall Wheeler',39,41309),(174,'Harper Nunez',31,48298),(175,'Thane Andrews',25,38327),(176,'Hamish Daniel',41,47018),(177,'Ashton Mayer',39,44238),(178,'Ishmael Fischer',26,34525),(179,'Ashton Howard',38,46154),(180,'Denton Saunders',37,44207),(181,'Merritt Rogers',38,48568),(182,'Abel Johnston',23,46826),(183,'Craig Burnett',33,27621),(184,'Hammett Bowman',22,26225),(185,'Victor Tucker',31,33321),(186,'Noah Weiss',26,48365),(187,'Griffin Patel',32,37895),(188,'Galvin Bishop',21,41301),(189,'Nehru Powers',23,43307),(190,'Caesar Watkins',38,41765),(191,'Oliver Wilcox',22,39327),(192,'Connor Kline',41,29043),(193,'Ivan Thornton',35,48669),(194,'Mannix Mckay',37,28741),(195,'Brent Ryan',45,34601),(196,'Gregory Guerra',39,32600),(197,'Hop Beck',33,47055),(198,'Kermit Richardson',41,25711),(199,'Gage Kent',38,26080),(200,'Isaac Holloway',45,41000);
INSERT INTO Funcionario (ID,Nome,Idade,Salario) VALUES (201,'Addison Patterson',45,26318),(202,'Harrison Ellis',28,30468),(203,'Cameron Waller',33,38655),(204,'Gage Salinas',28,44281),(205,'Emery Good',32,32649),(206,'Carl Britt',36,43666),(207,'Oren Gallagher',23,38249),(208,'Giacomo Buck',37,39071),(209,'Paul Gilmore',27,49979),(210,'Judah Simmons',40,34236),(211,'Lars Jenkins',32,27126),(212,'Drake Pearson',41,44967),(213,'Hop Hopkins',31,26613),(214,'Stewart Gardner',33,40906),(215,'Marvin Jensen',42,40377),(216,'Mannix Collins',40,44209),(217,'Asher Glover',27,27537),(218,'Price Hardin',26,32005),(219,'Mufutau Page',41,43568),(220,'Dennis Wooten',29,34541),(221,'Noah Stark',31,30017),(222,'Alfonso Stewart',33,49468),(223,'Philip Hinton',44,38187),(224,'Nasim Atkinson',35,31568),(225,'Stewart Pittman',32,49545),(226,'Ronan Hodge',45,42692),(227,'Stuart Hester',34,48776),(228,'Raphael Strong',33,43270),(229,'Kenyon Baker',36,34127),(230,'Judah Palmer',39,32267),(231,'Salvador Morton',43,33347),(232,'Hall Simmons',41,35036),(233,'Abdul Morrow',42,40854),(234,'Odysseus Branch',28,32584),(235,'Tucker Harrell',32,46964),(236,'Lev Campos',38,43055),(237,'Lucius Haynes',25,46404),(238,'Ferris Roach',29,33324),(239,'Tyrone Roth',24,28559),(240,'Abbot Phelps',28,25583),(241,'Cameron Mullins',23,39140),(242,'Kato Grimes',41,35781),(243,'Shad Rodgers',34,27327),(244,'Barry Decker',22,46360),(245,'Christopher Foley',35,46170),(246,'Malachi Weiss',44,48161),(247,'Lionel Buchanan',22,39938),(248,'Jelani Bullock',27,25497),(249,'Clayton Phelps',38,27245),(250,'Cedric Knox',24,25517),(251,'Yasir Herring',21,49587),(252,'Jack Frederick',29,25022),(253,'Ashton Wallace',22,41579),(254,'Hoyt Petty',31,32604),(255,'Marshall Marks',45,40752),(256,'Hedley Porter',39,31564),(257,'Robert Eaton',28,28340),(258,'Nash Chavez',30,47509),(259,'Dexter Grimes',27,25853),(260,'Chaim Guy',26,27786),(261,'Hamish Simpson',28,46893),(262,'Bruce Coleman',31,34010),(263,'Travis Marks',39,44912),(264,'Kelly Henderson',29,42477),(265,'Joel Yang',30,35198),(266,'Garth Moses',22,34003),(267,'Orlando Terry',44,26788),(268,'Tyler Simmons',30,27891),(269,'Ulric Torres',44,35133),(270,'Xanthus Hays',42,40999),(271,'Lars Mays',35,42609),(272,'Kennan Nielsen',28,49985),(273,'Chadwick Black',43,25488),(274,'Stone Valenzuela',30,43782),(275,'Benedict Lane',44,45059),(276,'Rahim Mathews',44,26421),(277,'Brock Mille',44,40788),(278,'Zeus Franco',22,42459),(279,'Jameson Oliver',34,29808),(280,'Chadwick Herrera',43,36465),(281,'Chaim Petersen',43,38239),(282,'Brandon Johns',26,44386),(283,'Kadeem Hubbard',33,46386),(284,'Price Weaver',36,42417),(285,'Tiger Harrison',22,35576),(286,'Paul Mcneil',43,48865),(287,'Orlando Wagner',39,37017),(288,'Adam Burt',40,26562),(289,'Keegan Alexander',25,43865),(290,'Vincent Mcintosh',35,26713),(291,'Elliott Camacho',42,29373),(292,'Erich Holder',33,41949),(293,'Vincent Flynn',38,33869),(294,'Branden Hamilton',34,37231),(295,'Nathan Bishop',41,40950),(296,'Fritz Morin',31,29512),(297,'Beck Garza',36,46932),(298,'Raymond Day',35,33922),(299,'Charles Carey',27,43827),(300,'Fuller Whitaker',22,41443);
INSERT INTO Funcionario (ID,Nome,Idade,Salario) VALUES (301,'Thaddeus Meyer',44,41812),(302,'Vaughan Hahn',36,31989),(303,'Jasper Maddox',33,29472),(304,'Hall Sykes',23,36925),(305,'Francis Gates',23,36820),(306,'Carson Reilly',25,47647),(307,'Beck Buchanan',39,49668),(308,'Chaney Boone',45,32521),(309,'Hamish Jones',41,37965),(310,'Grant Murray',28,31017),(311,'Ian Bernard',27,41837),(312,'Oleg Hampton',33,46734),(313,'Keefe Johnston',32,47912),(314,'Connor Cline',32,37825),(315,'Hakeem Kim',33,29927),(316,'Ulysses Decker',44,26051),(317,'Wayne Payne',42,48358),(318,'Armand Trevino',23,25583),(319,'Stewart Sparks',38,43287),(320,'Kenneth Fulton',36,43916),(321,'Eaton Reynolds',24,37862),(322,'Igor Wiley',37,47867),(323,'Acton Serrano',26,32087),(324,'Zeus Cash',41,45092),(325,'Levi Hughes',22,28482),(326,'Oliver Abbott',39,47802),(327,'Elvis Vasquez',38,38323),(328,'Yuli Calderon',38,31308),(329,'Chaney House',23,39384),(330,'Ali Clements',26,32672),(331,'Eric Goodwin',35,47787),(332,'Boris Santiago',42,35564),(333,'Valentine Olsen',21,32201),(334,'Bruno Mcleod',31,48934),(335,'Holmes Lancaster',41,28386),(336,'Zachery Wood',39,45083),(337,'Edan Dean',27,40363),(338,'Randall Collins',38,47969),(339,'Rooney Knox',21,27975),(340,'Yasir Joseph',35,32825),(341,'Jackson Wiley',23,42368),(342,'Lucius Gallegos',43,31460),(343,'Judah Potter',29,41462),(344,'Cruz Hardin',31,42593),(345,'Baxter Rice',32,49452),(346,'Amos Ware',33,34605),(347,'Thor Carson',28,46664),(348,'Brennan Booker',41,39354),(349,'Dolan Barber',32,43164),(350,'Addison Compton',41,43624),(351,'Lawrence Kaufman',24,32113),(352,'Norman Pierce',34,43177),(353,'Octavius Knowles',31,30830),(354,'Scott Burks',38,25934),(355,'Mohammad Cruz',40,41526),(356,'Joseph Sexton',43,25203),(357,'Uriel Hahn',36,36048),(358,'Camden Hart',42,26278),(359,'Jacob Cotton',38,37323),(360,'Tucker Church',30,28906),(361,'Yuli Hamilton',33,32408),(362,'Amos Mcpherson',20,43129),(363,'Jonah Hines',20,44555),(364,'Merrill Lott',38,34387),(365,'Garth Bush',28,28526),(366,'Kato Short',21,35121),(367,'Isaiah Kelley',33,30197),(368,'Thor Freeman',44,43734),(369,'Colby Bright',40,42906),(370,'Oleg Bell',24,45466),(371,'Abel Lindsay',25,30487),(372,'Jermaine Solomon',44,38643),(373,'Coby Mejia',43,37790),(374,'Akeem Gilliam',41,47035),(375,'Jonas Castro',23,27285),(376,'Jackson Lynn',23,36180),(377,'Abraham Moreno',31,28025),(378,'Ryder Benson',39,39678),(379,'Dorian Cameron',32,43562),(380,'Wing Good',33,43649),(381,'Barclay Whitehead',45,47845),(382,'Vaughan Lopez',36,40138),(383,'Ferdinand Wilkerson',23,41029),(384,'Ivor Chandler',33,43964),(385,'Dennis Travis',45,29926),(386,'Maxwell Flowers',44,32222),(387,'Nicholas Obrien',42,33067),(388,'Adam Andrews',41,45125),(389,'Nathan Hale',26,28025),(390,'Drew Carpenter',29,29000),(391,'Lewis May',35,49606),(392,'Donovan Jordan',33,44717),(393,'Mohammad Nicholson',32,49750),(394,'Ezekiel Cole',29,48002),(395,'Carlos Johnson',29,41500),(396,'Castor Rogers',39,48996),(397,'Nash Day',37,43832),(398,'Zephania Howe',28,39658),(399,'Wesley Diaz',37,28611),(400,'Bert Ramsey',41,30134);
INSERT INTO Funcionario (ID,Nome,Idade,Salario) VALUES (401,'Orson Moore',45,32368),(402,'Francis Macias',25,26490),(403,'Rudyard Lynch',44,49730),(404,'Cooper Cohen',22,26785),(405,'Julian Mercer',20,46839),(406,'Richard Mason',23,36242),(407,'Allen Hubbard',41,43854),(408,'Owen Hood',37,38579),(409,'Beck Moody',21,31584),(410,'Darius Aguilar',40,42672),(411,'Arden Singleton',26,27559),(412,'Trevor Harris',21,26535),(413,'Ali Marshall',20,47214),(414,'Zeph Underwood',30,48988),(415,'Prescott Sawyer',35,38093),(416,'Amos Alexander',30,28172),(417,'Jonas Russell',27,31062),(418,'Mason Case',24,31604),(419,'Abel Snyder',35,45600),(420,'Gregory Gentry',44,36356),(421,'Bernard Mason',44,38390),(422,'Howard Wiley',40,39332),(423,'Ashton Martinez',27,27558),(424,'Dane Barr',20,25169),(425,'Harrison Hickman',22,32007),(426,'Felix Tucker',29,29577),(427,'Hakeem Kirkland',25,31124),(428,'Vernon Bonner',34,28942),(429,'Akeem Wagner',23,37241),(430,'Samson Becker',40,46590),(431,'Honorato Ratliff',20,45714),(432,'Howard Dale',43,45863),(433,'Ali Emerson',33,30753),(434,'Arden May',34,28317),(435,'Brett Ramos',39,38217),(436,'Nicholas Petersen',34,37527),(437,'Stephen Goodman',23,45401),(438,'Ethan Melendez',36,44180),(439,'Clarke Carlson',20,27787),(440,'Yardley Schmidt',25,25059),(441,'Erasmus Morin',25,30959),(442,'Asher Hooper',28,35787),(443,'Charles Justice',24,37866),(444,'Brian Nixon',31,35985),(445,'Lars Calderon',43,44332),(446,'Richard Lambert',37,47355),(447,'Colby Ferguson',28,43864),(448,'Ignatius Clemons',23,39573),(449,'Samuel Walter',29,27769),(450,'Ezra Gentry',26,44056),(451,'Kieran Baird',28,37780),(452,'Stone Miller',44,45371),(453,'Abraham Frazier',23,43320),(454,'Emerson Valdez',31,46378),(455,'Jarrod Richards',45,33532),(456,'Channing Horn',39,33657),(457,'Sylvester Steele',27,40884),(458,'Harper Steele',36,45419),(459,'Anthony Battle',44,39819),(460,'Wayne Lopez',38,38543),(461,'Clarke Doyle',41,32854),(462,'Elliott Diaz',41,44698),(463,'Kirk Walsh',27,34883),(464,'Stewart Erickson',27,46249),(465,'Peter Boyd',38,29702),(466,'Jack Molina',44,32964),(467,'Ivor Irwin',40,49060),(468,'Christian Holt',24,49138),(469,'Barclay Mendoza',37,34888),(470,'Thaddeus Wood',22,28594),(471,'Keefe Huff',36,36904),(472,'Raphael Paul',26,30723),(473,'Alec Holland',27,47333),(474,'Anthony Parrish',45,43004),(475,'Chase Talley',44,35065),(476,'Kevin Mills',30,44879),(477,'Tiger Roberson',24,39857),(478,'Abel Cantu',23,43881),(479,'Lewis Charles',24,39992),(480,'Anthony Mcbride',20,47074),(481,'Chadwick Avery',21,34943),(482,'Chancellor Cannon',34,28915),(483,'Zachary Hardy',32,31585),(484,'Hu Huber',42,31889),(485,'Zane Flynn',41,44064),(486,'Elmo Mathis',20,39860),(487,'Abel Vazquez',42,44006),(488,'Keane Harding',42,34230),(489,'Hammett Parker',24,25294),(490,'Abraham Terry',21,27213),(491,'Aidan Knox',36,47512),(492,'Finn Ramirez',24,34375),(493,'Jonas Little',38,45827),(494,'Lucian Santos',33,43529),(495,'Merritt Lancaster',40,27239),(496,'Wyatt George',41,42161),(497,'Justin Hinton',45,43453),(498,'Allen Vargas',29,38154),(499,'Kasimir Bartlett',38,39066),(500,'Derek Mayer',20,26902);
INSERT INTO Funcionario (ID,Nome,Idade,Salario) VALUES (501,'Dana Donaldson',31,36563),(502,'Shafira Wilkins',41,28529),(503,'Iona Guthrie',37,47186),(504,'Gail Woodward',38,30748),(505,'Wyoming Lamb',41,29954),(506,'Rose Holloway',25,39442),(507,'Angela Holloway',35,34540),(508,'Hadley Mcfadden',33,28404),(509,'Amber Barker',37,47180),(510,'Marah Espinoza',40,46618),(511,'Rachel Cantrell',36,25911),(512,'Amy Clements',33,48936),(513,'Ginger Valdez',30,46935),(514,'Zoe Peck',32,46174),(515,'Kirsten Coleman',31,33919),(516,'Cailin Huffman',33,49649),(517,'Hyacinth Reed',36,44272),(518,'Maisie Norman',40,36070),(519,'Brenda Ballard',38,43191),(520,'Portia Rocha',37,48634),(521,'Zorita Randolph',44,26469),(522,'Kyla Pruitt',37,26080),(523,'Serina Bryant',20,41035),(524,'Aretha Rodriquez',21,33499),(525,'Alice Potts',24,42836),(526,'Xyla Holcomb',32,32509),(527,'Roary Frost',45,42341),(528,'Quail Nielsen',27,28303),(529,'Shelby Thomas',37,43530),(530,'Kalia Rivers',35,42158),(531,'Halee Garrison',22,31587),(532,'Karen Juarez',27,43852),(533,'Keely James',22,29043),(534,'Justine Glenn',41,26858),(535,'Sasha Curtis',29,46817),(536,'April Meyer',29,43775),(537,'Vielka Frost',42,38310),(538,'Regina Buchanan',35,42778),(539,'Lysandra Kidd',35,44636),(540,'Lila Mcgowan',23,27449),(541,'Cheryl Brooks',21,49987),(542,'Destiny Chang',40,29239),(543,'Kelly Good',33,29328),(544,'Aimee Boone',24,33233),(545,'Kaden Mayer',28,49665),(546,'Abra Mcintyre',33,32159),(547,'Hermione Newman',23,42240),(548,'Brynne Tyson',33,36650),(549,'Karyn Flynn',20,27754),(550,'Donna Bryan',20,36436),(551,'Kaye Norton',44,37332),(552,'Eleanor Delacruz',45,40464),(553,'Melyssa Roach',29,31748),(554,'Zelda Holland',26,46529),(555,'Dawn Page',39,33520),(556,'Sage Santos',20,46857),(557,'Savannah Olsen',32,41274),(558,'Indigo Blanchard',43,48994),(559,'Tasha Jackson',22,40266),(560,'Jescie Fuller',42,48050),(561,'Ivory Greer',32,44648),(562,'Jolie Morris',34,42600),(563,'Winifred Weber',29,38928),(564,'Dakota Jefferson',34,25917),(565,'Adara Gilliam',42,40592),(566,'Emma Buchanan',27,37569),(567,'Kim Hatfield',24,41580),(568,'Shaine Phillips',32,33438),(569,'Mia Henderson',21,26451),(570,'Sharon Pope',21,40091),(571,'Cecilia Love',31,42403),(572,'Ursula Cross',24,31396),(573,'Lillian Moon',20,39502),(574,'Sybil Ruiz',32,48838),(575,'Anastasia Mcintosh',22,31198),(576,'Heidi Graves',20,40494),(577,'Kirestin Oliver',33,47002),(578,'Kerry Jackson',28,32025),(579,'Aurelia Dalton',43,43605),(580,'Nora Holman',20,34914),(581,'Cassandra Frost',40,46319),(582,'Meredith Mcfadden',34,36304),(583,'Xena Delaney',45,44106),(584,'Molly Hood',24,46064),(585,'Dana Cook',30,45794),(586,'Lacota Dickson',42,35267),(587,'Janna Callahan',45,47392),(588,'Uma Payne',40,40649),(589,'Quail Wiggins',41,43018),(590,'Azalia Eaton',39,41507),(591,'Indigo Thompson',20,46589),(592,'Ramona Cannon',37,33635),(593,'Anastasia Davis',39,34006),(594,'Kendall Joseph',40,27100),(595,'Lael Rosa',22,44664),(596,'Lillian Blair',43,33078),(597,'Virginia Bowman',30,47096),(598,'Megan Joyner',34,33254),(599,'Madeline Cervantes',37,32534),(600,'Ulla Dillon',34,33278);
INSERT INTO Funcionario (ID,Nome,Idade,Salario) VALUES (601,'Cleo Daugherty',39,34420),(602,'Piper Yates',29,41678),(603,'Rama Ramsey',23,25753),(604,'Rana Tyler',38,49832),(605,'Molly Wells',41,33763),(606,'Michelle Cherry',42,29079),(607,'Gisela Franks',23,36156),(608,'Pascale Franks',45,34744),(609,'Linda Becker',37,33704),(610,'Leigh Kane',28,38455),(611,'Martha Ochoa',23,40315),(612,'Maile Ramirez',29,36190),(613,'Carla Byrd',20,25744),(614,'Shoshana Patterson',39,40523),(615,'Joy Fry',38,40740),(616,'Miriam Whitfield',22,46337),(617,'Katelyn Spencer',27,37049),(618,'Abigail Woodard',23,49835),(619,'Kaden Marsh',42,44444),(620,'Anika Watts',27,36297),(621,'Dai Klein',20,42947),(622,'Susan Decker',24,42955),(623,'Robin Willis',44,33434),(624,'Maisie Kane',28,43871),(625,'Brielle Kent',36,45193),(626,'Eliana House',41,45559),(627,'Kaden Hines',27,48051),(628,'Hedwig Ward',27,26552),(629,'Robin Cruz',30,40821),(630,'Stacy Pratt',20,48378),(631,'Renee Livingston',35,34741),(632,'Quemby Haley',37,43025),(633,'Fay Randolph',36,28135),(634,'Kiona Boyle',38,28048),(635,'Kiona Vang',21,41976),(636,'Elizabeth Mcguire',34,36814),(637,'Tamekah Weeks',22,25950),(638,'Marny Oneil',21,49251),(639,'Gay Odonnell',36,49927),(640,'Cleo Chapman',28,41544),(641,'May Brennan',34,47023),(642,'Jolene Morton',42,35828),(643,'Kiayada Hanson',45,40479),(644,'Jorden Tran',43,46784),(645,'Urielle Horne',40,40259),(646,'Yen Wyatt',23,42032),(647,'Bell Russo',22,37084),(648,'Eleanor Melton',39,38538),(649,'Genevieve Armstrong',30,35100),(650,'Bryar David',40,29218),(651,'Indira Black',29,44681),(652,'Mallory Russell',39,41631),(653,'Kelly Kerr',36,29190),(654,'Gretchen Bean',28,45283),(655,'Charde Knight',24,26084),(656,'Dominique Nixon',25,35774),(657,'Candice Velasquez',44,31840),(658,'Justina Solis',23,49132),(659,'Emma Mills',34,43884),(660,'Pascale Morgan',27,30676),(661,'Maris Tate',24,34259),(662,'Sybil Randolph',23,30501),(663,'Calista Sampson',43,41032),(664,'Iola Dotson',35,40772),(665,'Yeo Maldonado',31,42345),(666,'Angelica Elliott',29,47234),(667,'Xantha Richardson',27,46891),(668,'Quemby Rutledge',35,34206),(669,'TaShya Holloway',40,38306),(670,'Katell Bradford',45,35972),(671,'Ella Logan',33,36459),(672,'Aiko Clements',25,44425),(673,'Savannah Byers',30,45849),(674,'Rinah Monroe',36,40148),(675,'Madaline Rocha',42,28919),(676,'Vivian Strickland',20,34240),(677,'Kaye Gentry',22,47097),(678,'Oprah David',42,36628),(679,'Rylee Christian',22,43836),(680,'Haley Ramsey',32,36852),(681,'Moana Dixon',38,47146),(682,'Rhoda George',25,29632),(683,'Hanae Witt',25,28375),(684,'Blair Roth',22,39363),(685,'Wynter Alston',45,36088),(686,'Aspen Blake',41,47464),(687,'Faith Nunez',20,28701),(688,'Clio Blevins',20,30692),(689,'Rama Harvey',20,39092),(690,'Eugenia Bowman',30,45640),(691,'Aiko Bullock',20,40618),(692,'Noelle Delacruz',34,34806),(693,'Quyn Gentry',21,26169),(694,'Michelle Randolph',24,26638),(695,'Dorothy Madden',32,34905),(696,'McKenzie Lindsey',23,45564),(697,'Alexa Cruz',25,46105),(698,'Kyla Alford',28,37686),(699,'Whitney Kramer',38,36323),(700,'Serina Contreras',37,37973);
INSERT INTO Funcionario (ID,Nome,Idade,Salario) VALUES (701,'Dora Maddox',26,35916),(702,'Nyssa Weaver',38,39445),(703,'Nevada Jimenez',30,43642),(704,'Christen Mercer',26,29143),(705,'Galena Yates',45,39192),(706,'Amena Clark',43,30838),(707,'Illana Garrison',33,47431),(708,'Jordan Fernandez',32,34727),(709,'Lila Carr',40,32507),(710,'Delilah Larsen',44,40309),(711,'Kiona Sims',30,48144),(712,'Cassady Olsen',37,44036),(713,'Destiny Walker',27,41623),(714,'Emma Wiley',38,25418),(715,'Mollie Mcmahon',35,33951),(716,'Shaine Kinney',40,47617),(717,'Deirdre Salinas',39,46005),(718,'Veda Nash',44,28928),(719,'Kiona Pacheco',20,36613),(720,'Macey Carpenter',40,38997),(721,'Germane Mcdowell',20,31941),(722,'Aretha Gonzalez',33,32683),(723,'Geraldine Chaney',24,44487),(724,'Caryn Rivera',37,32584),(725,'Quemby Case',31,34056),(726,'Dara Morgan',34,40767),(727,'Geraldine Myers',33,38292),(728,'Xaviera Mills',30,34436),(729,'Libby Hendricks',36,37852),(730,'Genevieve Stein',29,40193),(731,'Shannon Mcfarland',44,29115),(732,'Gloria Mcdaniel',24,44073),(733,'Joelle Chandler',31,40497),(734,'Rhiannon Fischer',33,27426),(735,'Zenia Logan',25,44502),(736,'Savannah Burks',39,41687),(737,'Remedios Holloway',33,28804),(738,'Hedwig Warren',45,46670),(739,'Alea Trujillo',37,45006),(740,'Ima Young',23,36299),(741,'Oprah Chaney',28,45367),(742,'Lacey Small',37,41180),(743,'Sara Davidson',40,28995),(744,'Hollee Schneider',31,33901),(745,'Brenda Mcintyre',32,29073),(746,'Tamara Bell',36,47120),(747,'Aurora Jarvis',36,33989),(748,'Madeline Lee',21,34375),(749,'Roanna Garrison',37,38109),(750,'Ciara Buchanan',30,35695),(751,'Carolyn Kerr',20,25934),(752,'Quon Marquez',45,27274),(753,'Ivy Bradley',26,40970),(754,'Natalie Kerr',25,25861),(755,'Eugenia Frederick',30,42917),(756,'Lee Carrillo',34,49653),(757,'Xena Barron',43,49047),(758,'Emily Banks',36,39087),(759,'Fredericka Garner',20,43268),(760,'Maya Reilly',41,29219),(761,'Miranda Hubbard',27,29981),(762,'Rowan Gray',20,26746),(763,'Macey Battle',22,36426),(764,'Miranda Fowler',36,26906),(765,'Piper Moody',22,49672),(766,'Giselle Wilson',28,42468),(767,'Mechelle Stein',38,25974),(768,'Jade Howell',27,36488),(769,'Madison Patel',38,41606),(770,'Tamara Rhodes',32,49557),(771,'Cally Santos',41,48655),(772,'Dawn Hopkins',22,41077),(773,'Serena Byrd',44,45100),(774,'Meghan Hopkins',23,44533),(775,'Sonya Miles',33,34401),(776,'Portia Moses',34,30067),(777,'Helen Jefferson',21,48999),(778,'Daria Lester',31,43220),(779,'Jade Sullivan',25,33687),(780,'Kathleen Moran',29,30747),(781,'Irene Blevins',43,34582),(782,'Miriam Cervantes',27,41737),(783,'Kameko Larsen',21,36836),(784,'Stacey Sparks',28,40126),(785,'Macey Mack',45,46148),(786,'Zelda Flores',22,31891),(787,'Chelsea Monroe',37,45953),(788,'Rose Bond',30,36881),(789,'Guinevere Davidson',32,33321),(790,'Charlotte Robbins',26,40020),(791,'Sophia Fields',26,44925),(792,'Nola Johnston',36,36360),(793,'Jescie Schroeder',28,36458),(794,'Michelle Waller',28,35046),(795,'Darryl Dorsey',40,45709),(796,'Lois Marquez',32,26560),(797,'Ruby Chandler',39,33171),(798,'Gail Weeks',21,40901),(799,'Sopoline Craft',22,40017),(800,'Ciara Buckley',36,34140);
INSERT INTO Funcionario (ID,Nome,Idade,Salario) VALUES (801,'Leah Carlson',43,34390),(802,'Kelsey Owens',21,41725),(803,'Mikayla Marshall',39,28548),(804,'Zenaida Goodman',29,36474),(805,'Catherine Emerson',44,33259),(806,'Blythe Huber',21,42998),(807,'Kaitlin Petty',43,25890),(808,'Bell Ramirez',33,33151),(809,'Flavia Sargent',39,29901),(810,'Breanna Woodward',36,46101),(811,'Denise Conley',23,48556),(812,'Ifeoma Whitney',30,42004),(813,'Cassady Bauer',29,36585),(814,'Quynn Lane',27,35979),(815,'Xena Hull',33,35592),(816,'Taylor King',32,44444),(817,'Doris Wells',21,41700),(818,'Deborah Jennings',30,27435),(819,'Catherine Hoover',40,35868),(820,'Lynn Hyde',44,32924),(821,'Lana Patel',31,28930),(822,'Gwendolyn Shelton',39,47178),(823,'Hedwig Sanders',44,31118),(824,'Jessica Clark',31,37643),(825,'Quintessa Christensen',43,49498),(826,'Iona Barrera',34,43058),(827,'Renee Barlow',34,35017),(828,'Sophia Richardson',35,41769),(829,'Lois Conrad',23,38913),(830,'Kyla Sharpe',25,28697),(831,'Lucy Moss',29,28437),(832,'Chantale Bradshaw',36,31602),(833,'Ruby House',36,32389),(834,'Freya Sloan',33,48668),(835,'Tasha Mcdaniel',28,30558),(836,'Ursula Hartman',24,44043),(837,'Marny Collins',24,45040),(838,'TaShya Roberts',38,40203),(839,'Shafira Chandler',43,31549),(840,'Yoshi England',22,32825),(841,'Jescie Key',22,44185),(842,'Rinah Alston',22,47667),(843,'Yeo Butler',21,49639),(844,'Charlotte Gonzalez',29,48169),(845,'Emerald Erickson',32,46251),(846,'Violet Allison',34,32857),(847,'Galena Lara',40,48154),(848,'Tatiana Banks',39,45101),(849,'Hermione Craft',23,43258),(850,'Mia Kirkland',29,26975),(851,'Jael Ferrell',45,44122),(852,'Dominique Little',38,41396),(853,'Ifeoma Woodward',45,34735),(854,'Mary Sharp',25,27357),(855,'Brenna Kelly',38,43893),(856,'Karleigh Farrell',35,35977),(857,'Irma Matthews',26,39807),(858,'Danielle Melendez',26,34524),(859,'Summer Roth',33,48519),(860,'Aubrey Rogers',32,35620),(861,'Audrey Richardson',34,38654),(862,'Sopoline Copeland',42,46223),(863,'Gloria Bailey',40,45827),(864,'Olivia Delgado',30,45163),(865,'Jennifer Rodriguez',30,28636),(866,'Debra Mack',38,36821),(867,'Hanna Russo',29,33369),(868,'Zephr Zamora',23,30721),(869,'Rebecca Bradford',23,31130),(870,'Ariana Stewart',22,46838),(871,'Madeson Stephens',38,48321),(872,'Lacota Crane',22,47491),(873,'Melinda Sharp',32,38214),(874,'Kerry Frank',32,35981),(875,'Meghan Gregory',35,43783),(876,'Geraldine Solis',38,27023),(877,'Briar Joyce',38,36055),(878,'Regina Sampson',42,49584),(879,'Megan Martinez',39,39231),(880,'Wynter Santiago',25,26680),(881,'Chanda House',32,49458),(882,'Zia Hamilton',35,31185),(883,'Rana Schneider',33,37147),(884,'Rachel Weaver',35,28535),(885,'Dara Cohen',29,47911),(886,'Jemima Hudson',38,29722),(887,'Shannon Glover',31,35928),(888,'MacKenzie Emerson',30,46782),(889,'Macy Osborne',32,42490),(890,'Aline Cash',34,48136),(891,'Molly Meyers',35,39739),(892,'Zia Carter',45,26885),(893,'Vivien Oconnor',35,43001),(894,'Candice Pitts',44,42670),(895,'Mollie Frank',27,34121),(896,'Hollee Ramirez',26,48425),(897,'Regan Cobb',20,31484),(898,'Ariana Mason',29,36924),(899,'Melanie Duncan',28,46551),(900,'Jane Mcgee',21,37608);
INSERT INTO Funcionario (ID,Nome,Idade,Salario) VALUES (901,'Keiko Gillespie',42,31613),(902,'Taylor Riggs',32,43589),(903,'Cora Rosa',29,29521),(904,'Wynter Matthews',28,44495),(905,'Karly Roberts',26,44374),(906,'Blaine Hess',44,45572),(907,'Rosalyn Buchanan',29,33301),(908,'Dominique Abbott',25,36645),(909,'Sasha Padilla',21,35638),(910,'Gretchen Camacho',35,41020),(911,'Venus Houston',43,41044),(912,'Whilemina Barrett',24,44871),(913,'Ariana Fox',21,31337),(914,'Maggie Livingston',38,47584),(915,'Jolie Rice',21,35983),(916,'Joan Buckner',29,43423),(917,'Lydia Frank',23,39661),(918,'Amela Benson',29,33595),(919,'Mollie Stephenson',35,49716),(920,'Kylie Jarvis',22,31088),(921,'April Woodward',41,33849),(922,'Uta Abbott',20,42263),(923,'Dominique Osborn',31,37044),(924,'Abigail House',33,40056),(925,'Daryl Dyer',40,33724),(926,'Aimee Newman',31,38500),(927,'Carly Harmon',45,41431),(928,'Yvonne Bryan',32,29477),(929,'Mona Bender',21,35809),(930,'Nyssa Graham',44,29119),(931,'Tashya Cameron',23,26000),(932,'Buffy Petersen',25,44130),(933,'Phyllis Stanton',42,44816),(934,'Kirestin Campos',39,45415),(935,'Lana Mcmahon',39,43147),(936,'Tanya Moses',22,45352),(937,'Rose May',20,44276),(938,'Cathleen Woodward',26,47405),(939,'Cameron Fisher',30,29773),(940,'Ignacia Cleveland',43,35775),(941,'Orli Hewitt',38,30176),(942,'Michelle Hogan',24,45385),(943,'Christine Duke',24,39177),(944,'Raya Sears',23,44352),(945,'Dakota Patterson',45,32745),(946,'Kirestin Petty',42,26026),(947,'Delilah Murray',43,44398),(948,'Jaden Livingston',29,34451),(949,'Chava Burris',35,36873),(950,'Jessica Stevens',31,35397),(951,'Eden Albert',35,41308),(952,'Keelie Mcmahon',33,28771),(953,'Belle Justice',21,27082),(954,'Karyn Battle',44,44958),(955,'Shaine Walter',28,34333),(956,'Rhiannon Norris',31,37407),(957,'Marah Maddox',28,36685),(958,'Uta Rush',21,35307),(959,'Heidi Murphy',38,32153),(960,'Indigo Boone',42,40953),(961,'McKenzie Sherman',24,48914),(962,'Clementine Flowers',21,42427),(963,'Libby Puckett',26,32870),(964,'Bethany Mcguire',22,36664),(965,'Quail Cantu',40,40655),(966,'Yoko Ortega',21,48711),(967,'MacKenzie Nguyen',21,39539),(968,'Mariko Gray',22,37104),(969,'Mechelle Coffey',43,35772),(970,'Kristen Barrett',28,30849),(971,'Rhonda Warner',22,48806),(972,'Renee Craft',32,38569),(973,'Whitney Koch',21,36689),(974,'Belle Duffy',35,42123),(975,'Zelda Houston',38,44472),(976,'Celeste Battle',20,34509),(977,'Jemima Battle',29,30369),(978,'Sonya Reeves',38,49976),(979,'Dawn Franklin',23,29847),(980,'Lani Michael',30,46431),(981,'Delilah Chan',45,41759),(982,'Lareina Mcknight',24,29106),(983,'Aretha Conrad',43,27972),(984,'Aurelia Gutierrez',30,47064),(985,'Orli Briggs',40,49052),(986,'Daryl Johns',41,33530),(987,'Kyla Nunez',28,47863),(988,'Rebecca Morrow',32,30587),(989,'Jessica Gordon',30,31505),(990,'Tanisha Arnold',34,39113),(991,'Alexandra Valentine',42,46149),(992,'Lynn Holden',39,35334),(993,'Carly Diaz',32,27881),(994,'Raven Miller',34,28852),(995,'Katelyn Carver',35,35019),(996,'Martha Hicks',35,36644),(997,'Libby George',20,35219),(998,'Cheyenne Castaneda',44,43559),(999,'Lavinia Becker',41,36989),(1000,'Belle Sandoval',25,33025);
---------------------------------------------------------

update Funcionario set Cargo = 'Engenheiro' where ID<=1000;
update Funcionario set FK_Equipe = 'Mercedes' where ID<=100;
update Funcionario set FK_Equipe = 'RBR' where ID>100 and ID<=200;
update Funcionario set FK_Equipe = 'McLaren' where ID>200 and ID<=300;
update Funcionario set FK_Equipe = 'Aston Martin' where ID>300 and ID<=400;
update Funcionario set FK_Equipe = 'Alpine' where ID>400 and ID<=500;
update Funcionario set FK_Equipe = 'AlphaTauri' where ID>500 and ID<=600;
update Funcionario set FK_Equipe = 'Ferrari' where ID>600 and ID<=700;
update Funcionario set FK_Equipe = 'Alfa Romeo' where ID>700 and ID<=800;
update Funcionario set FK_Equipe = 'Haas' where ID>800 and ID<=900;
update Funcionario set FK_Equipe = 'Williams' where ID>900 and ID<=1000;

insert into Funcionario values (1001, 'Hywel Thomas', 55, 100000, 'Diretor', 'Mercedes');
insert into Funcionario values (1002, 'Mike Elliott', 46, 100000, 'Diretor', 'Mercedes');
insert into Funcionario values (1003, 'Pierre Waché', 46, 100000, 'Diretor', 'RBR');
insert into Funcionario values (1004, 'Adrian Newey', 62, 100000, 'Diretor', 'RBR');
insert into Funcionario values (1005, 'Helmut Marko', 78, 100000, 'Diretor', 'RBR');
insert into Funcionario values (1006, 'James Key', 48, 100000, 'Diretor', 'McLaren');
insert into Funcionario values (1007, 'Andrea Stella', 49, 100000, 'Diretor', 'McLaren');
insert into Funcionario values (1008,  'Zak Brown', 49, 100000, 'Diretor', 'McLaren');
insert into Funcionario values (1009, 'Andrew Green', 55, 100000, 'Diretor', 'Aston Martin');
insert into Funcionario values (1010, 'Lawrence Stroll', 61, 100000, 'Diretor', 'Aston Martin');
insert into Funcionario values (1011, 'Davide Brivio', 56, 100000, 'Diretor', 'Alpine');
insert into Funcionario values (1012, 'Ted Toleman', 56, 100000, 'Diretor', 'Alpine');
insert into Funcionario values (1013, 'Jody Egginton', 46, 100000, 'Diretor', 'AlphaTauri');
insert into Funcionario values (1014, 'Graham Watson', 53, 100000, 'Diretor', 'AlphaTauri');
insert into Funcionario values (1015, 'Enrico Cardile', 45, 100000, 'Diretor', 'Ferrari');
insert into Funcionario values (1016, 'Jan Monchaux', 42, 100000, 'Diretor', 'Alfa Romeo');
insert into Funcionario values (1017, 'Axel Kruse', 62, 100000, 'Diretor', 'Alfa Romeo');
insert into Funcionario values (1018, 'Ben Agathangelou', 49, 100000, 'Diretor', 'Haas');
insert into Funcionario values (1019, 'Rob Taylor', 61, 100000, 'Diretor', 'Haas');
insert into Funcionario values (1020, 'Simone Resta', 50, 100000, 'Diretor', 'Haas');
insert into Funcionario values (1021, 'Joe Custer', 55, 100000, 'Diretor', 'Haas');
insert into Funcionario values (1022, 'Gene Haas', 68, 100000, 'Diretor', 'Haas');
insert into Funcionario values (1023, 'François-Xavier Demaison', 47, 100000, 'Diretor', 'Williams');
insert into Funcionario values (1024, 'Toto Wolff', 48, 350000, 'Chefe de equipe', 'Mercedes');
insert into Funcionario values (1025, 'Christian Horner', 47, 350000, 'Chefe de equipe', 'RBR');
insert into Funcionario values (1026, 'Andrea Siedl', 44, 350000, 'Chefe de equipe', 'McLaren');
insert into Funcionario values (1027, 'Otmar Szafnauer', 56, 350000, 'Chefe de equipe', 'Aston Martin');
insert into Funcionario values (1028, 'Laurent Rossi', 45, 350000, 'Chefe de equipe', 'Alpine');
insert into Funcionario values (1029, 'Franz Tost', 64, 350000, 'Chefe de equipe', 'AlphaTauri');
insert into Funcionario values (1030, 'Mattia Binotto', 51, 350000, 'Chefe de equipe', 'Ferrari');
insert into Funcionario values (1032, 'Günther Steiner', 56, 350000, 'Chefe de equipe', 'Haas');
insert into Funcionario values (1033, 'Jost Capito', 62, 350000, 'Chefe de equipe', 'Williams');

-----ESSA PARTE NÃO TA FUNFANDO-----

insert into Patrocinador (Patrocinador, FK_Equipe) values ('Petronas', 'Mercedes'), ('INEOS', 'Mercedes'), ('UBS', 'Mercedes'), ('Epson', 'Mercedes'), ('Bose', 'Mercedes'), ('Tommy Hilfiger', 'Mercedes'), ('IWC', 'Mercedes'), ('Hewlett Packard', 'Mercedes'), ('The Ritz-Carlton', 'Mercedes'), ('Monster Energy', 'Mercedes'), ('Pure Storage', 'Mercedes'), ('CrowdStrike', 'Mercedes'), ('TIBCO', 'Mercedes'), ('AMD', 'Mercedes'), ('Puma', 'Mercedes'), ('Police', 'Mercedes'), ('OZ Racing', 'Mercedes'), ('Endless', 'Mercedes'), ('Axalta', 'Mercedes'), ('Belstaff', 'Mercedes'), ('Marriott Bonvoy', 'Mercedes'), ('TeamViewer', 'Mercedes'), ('Pirelli', 'Mercedes');
insert into Patrocinador (Patrocinador, FK_Equipe) values ('Rauch', 'RBR'), ('Honda', 'RBR'), ('Mobil 1 Esso', 'RBR'), ('Puma', 'RBR'), ('Tag Heuer', 'RBR'), ('Citrix', 'RBR'), ('Siemens', 'RBR'), ('AT&T', 'RBR'), ('Inter', 'RBR'), ('Hewlett Packard', 'RBR'), ('Telcel', 'RBR'), ('Iris', 'RBR'), ('AlphaTauri', 'RBR'), ('Hexagon', 'RBR'), ('DMG Mori', 'RBR'), ('Ansys', 'RBR'), ('Sabelt', 'RBR'), ('OZ Racing', 'RBR'), ('PWR', 'RBR'), ('Gold Standard', 'RBR'), ('PRECOR', 'RBR'), ('Oura', 'RBR'), ('Claro', 'RBR'), ('America Movil', 'RBR'), ('Therabody', 'RBR'), ('Oracle', 'RBR'), ('Walmart', 'RBR'), ('Pirelli', 'RBR');
insert into Patrocinador (Patrocinador, FK_Equipe) values ('British-American Tobacco', 'McLaren'), ('Splunk', 'McLaren'), ('DarkTrace', 'McLaren'), ('Dell', 'McLaren'), ('Huski Chocolate', 'McLaren'), ('Gulf', 'McLaren'), ('Arrow', 'McLaren'), ('Richard Mille', 'McLaren'), ('Hilton', 'McLaren'), ('Coca Cola', 'McLaren'), ('Unilever', 'McLaren'), ('FxPro', 'McLaren'), ('Deloitte', 'McLaren'), ('TUMI', 'McLaren'), ('Iqoniq', 'McLaren'), ('Mind', 'McLaren'), ('CNBC', 'McLaren'), ('Klipsch', 'McLaren'), ('Sparco', 'McLaren'), ('Volvo trucks', 'McLaren'), ('Enkei', 'McLaren'), ('Mazak', 'McLaren'), ('Marelli', 'McLaren'), ('Ashurst', 'McLaren'), ('Stratasys', 'McLaren'), ('Kaust', 'McLaren'), ('Hookit', 'McLaren'), ('Alienware', 'McLaren'), ('Veloce Esports', 'McLaren'), ('Ultimotive', 'McLaren'), ('NEW ERA', 'McLaren'), ('FAI Aviation Group', 'McLaren'), ('Buzz & Co', 'McLaren'), ('Cisco Webex', 'McLaren'), ('Miory Steel', 'McLaren'), ('Garena', 'McLaren'), ('AkzoNobel-Sikkens', 'McLaren'), ('Logitech G', 'McLaren'), ('QNTMPAY', 'McLaren'), ('Bitci.com', 'McLaren'), ('Pirelli', 'McLaren');
insert into Patrocinador (Patrocinador, FK_Equipe) values ('Cognizant', 'Aston Martin'), ('Crypto.com', 'Aston Martin'), ('NetApp', 'Aston Martin'), ('SentinelOne', 'Aston Martin'), ('Bombardier', 'Aston Martin'), ('Girard-Perregaux', 'Aston Martin'), ('Peroni', 'Aston Martin'), ('BWT', 'Aston Martin'), ('REPLAY', 'Aston Martin'), ('Ravenol', 'Aston Martin'), ('EPOS', 'Aston Martin'), ('JCB', 'Aston Martin'), ('EBB3', 'Aston Martin'), ('UPS Direct', 'Aston Martin'), ('STL', 'Aston Martin'), ('Pelmark', 'Aston Martin'), ('Voip Unlimited', 'Aston Martin'), ('Condeco', 'Aston Martin'), ('IFS', 'Aston Martin'), ('Schuberth', 'Aston Martin'), ('Hackett London', 'Aston Martin'), ('AlpineStars', 'Aston Martin'), ('Oakley', 'Aston Martin'), ('Pirelli', 'Aston Martin');
insert into Patrocinador (Patrocinador, FK_Equipe) values ('Castrol', 'Alpine'), ('RCi', 'Alpine'), ('MAPFRE', 'Alpine'), ('bp Ultimate', 'Alpine'), ('Dupont', 'Alpine'), ('Microsoft', 'Alpine'), ('Bell & Ross', 'Alpine'), ('Eurodatacar', 'Alpine'), ('Pirelli', 'Alpine'), ('GENII', 'Alpine'), ('Renault E-Tech', 'Alpine'), ('Yahoo!', 'Alpine'), ('3D Systems', 'Alpine'), ('Hewlett-Packard', 'Alpine'), ('PerkinElmer', 'Alpine'), ('Le coq Sportif', 'Alpine'), ('GF Matching Solutions', 'Alpine'), ('Siemens', 'Alpine'), ('Alpinestars', 'Alpine'), ('Boeing', 'Alpine'), ('Elysium', 'Alpine'), ('GCAPS', 'Alpine'), ('Hexis', 'Alpine'), ('Jabil', 'Alpine'), ('Linde', 'Alpine'), ('MATRIX', 'Alpine'), ('Roland', 'Alpine'), ('Trak Racer', 'Alpine'), ('Volume Graphics', 'Alpine');
insert into Patrocinador (Patrocinador, FK_Equipe) values ('myWorld', 'AlphaTauri'), ('Edifice Casio', 'AlphaTauri'), ('AlphaTauri', 'AlphaTauri'), ('Honda', 'AlphaTauri'), ('Randstad', 'AlphaTauri'), ('Pirelli', 'AlphaTauri'), ('RDS', 'AlphaTauri'), ('Riedel', 'AlphaTauri'), ('Siemens', 'AlphaTauri'), ('DAZN', 'AlphaTauri');
insert into Patrocinador (Patrocinador, FK_Equipe) values ('Mission Winnow', 'Ferrari'), ('Ray-Ban', 'Ferrari'), ('Richard Mille', 'Ferrari'), ('Kaspersky', 'Ferrari'), ('UPS', 'Ferrari'), ('Weichai', 'Ferrari'), ('Estrella Galicia 0,0', 'Ferrari'), ('OMR', 'Ferrari'), ('MAHLE', 'Ferrari'), ('Pirelli', 'Ferrari'), ('Puma', 'Ferrari'), ('Radiobook', 'Ferrari'), ('SKF', 'Ferrari'), ('Vistajet', 'Ferrari'), ('Marelli', 'Ferrari'), ('NGK Spark Plugs', 'Ferrari'), ('Brembo', 'Ferrari'), ('Experis', 'Ferrari'), ('Riedel', 'Ferrari'), ('Iveco', 'Ferrari'), ('Palantir', 'Ferrari'), ('Bell', 'Ferrari'), ('Technogym', 'Ferrari'), ('Alfa Romeo', 'Ferrari'), ('Garrett', 'Ferrari'), ('Shell', 'Ferrari'), ('Giorgio Armani', 'Ferrari'), ('Sabelt', 'Ferrari');
insert into Patrocinador (Patrocinador, FK_Equipe) values ('Alfa Romeo', 'Alfa Romeo'), ('PKN Orlen', 'Alfa Romeo'), ('Adler Pelzer Group', 'Alfa Romeo'), ('Acer', 'Alfa Romeo'), ('Built for Athletes', 'Alfa Romeo'), ('Carrera', 'Alfa Romeo'), ('Singha', 'Alfa Romeo'), ('Additive Industries', 'Alfa Romeo'), ('IQONIQ', 'Alfa Romeo'), ('Iveco', 'Alfa Romeo'), ('Livinguard', 'Alfa Romeo'), ('Marelli', 'Alfa Romeo'), ('Mitsubishi Electric', 'Alfa Romeo'), ('Pirelli', 'Alfa Romeo'), ('Save the Children', 'Alfa Romeo'), ('Sparco', 'Alfa Romeo'), ('Walter Meier', 'Alfa Romeo'), ('Zadara', 'Alfa Romeo'), ('AB Dynamics', 'Alfa Romeo'), ('Brutsch-Ruegger', 'Alfa Romeo'), ('Riedel', 'Alfa Romeo');
insert into Patrocinador (Patrocinador, FK_Equipe) values ('Uralkali', 'Haas'), ('1&1', 'Haas'), ('Alpinestars', 'Haas'), ('Pirelli', 'Haas'), ('Schuberth', 'Haas'), ('Stichd', 'Haas'), ('Haas Automation', 'Haas'), ('Ionos', 'Haas'), ('Under Armour', 'Haas');
insert into Patrocinador (Patrocinador, FK_Equipe) values ('Sofina', 'Williams'), ('Lavazza', 'Williams'), ('Acronis', 'Williams'), ('Versa', 'Williams'), ('Financial Times', 'Williams'), ('PONOS', 'Williams'), ('Symantec', 'Williams'), ('IQONIQ', 'Williams'), ('Pirelli', 'Williams'), ('Umbro', 'Williams'), ('PPG', 'Williams'), ('Thales', 'Williams'), ('Precision Hydration', 'Williams'), ('Crew Clothing', 'Williams'), ('U-Earth', 'Williams'), ('Life Fitness', 'Williams'), ('Spinal Injuries Association (sia)', 'Williams'), ('Honibe', 'Williams'), ('Bremont', 'Williams'), ('Zeiss', 'Williams'), ('KX', 'Williams'), ('DTEX', 'Williams'), ('B&R', 'Williams'), ('Nexa 3D', 'Williams'), ('OMP', 'Williams');

select * from Equipe
alter table Funcionario alter column Salario set int
select count(*) from Patrocinador where FK_Equipe 'Mercedes'
count ID
delete from Unidade_de_Potência
drop table Unidade_de_Potência
