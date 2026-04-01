CREATE TABLE Users (
UserID   INTEGER AUTO_INCREMENT PRIMARY KEY,
UserName TEXT NOT NULL,
UserPassword  TEXT NOT NULL,
UserFirstName TEXT NOT NULL,
UserLastName TEXT, 
UserRole TEXT,
Email TEXT,
Mobile TEXT
);

CREATE TABLE TeamInfo (
TeamID   INTEGER AUTO_INCREMENT PRIMARY KEY,
TeamName TEXT NOT NULL,
Country  TEXT NOT NULL,
NumOfMatchesPlayed INTEGER NOT NULL,
MatchesWon INTEGER, 
MatchesLost INTEGER,
MatchesTie INTEGER,
TotalGoalsScored INTEGER,
ManagerID INTEGER,
CONSTRAINT FK_ManagerID FOREIGN KEY (ManagerID)
    REFERENCES Users(UserID)
);

CREATE TABLE MatchInfo (
MatchID  INTEGER AUTO_INCREMENT PRIMARY KEY,
MatchName TEXT NOT NULL,
Venue TEXT NOT NULL,
MatchDate DATE 
);

CREATE TABLE MatchHistory (
ID INTEGER AUTO_INCREMENT PRIMARY KEY,
MatchID  INTEGER, 
TeamID INTEGER,
PlayedAgainst INTEGER,
MatchResult TEXT,
CONSTRAINT FK_MatchID FOREIGN KEY (MatchID)
    REFERENCES MatchInfo(MatchID),
    CONSTRAINT FK_TeamID FOREIGN KEY (TeamID)
    REFERENCES TeamInfo(TeamID),
       CONSTRAINT FK_PlayedAgainst FOREIGN KEY (PlayedAgainst)
    REFERENCES TeamInfo(TeamID)
);

CREATE TABLE PlayerInfo (
PlayerID INTEGER AUTO_INCREMENT PRIMARY KEY,
PlayerName  TEXT, 
Age INTEGER,
DOB Date,
Gender TEXT,
TotalGoalsScored INTEGER
);

CREATE TABLE TeamPlayers (
ID INTEGER AUTO_INCREMENT PRIMARY KEY,
TeamID INTEGER,
PlayerID  INTEGER, 
 CONSTRAINT FK_TeamID_TeamPlayers FOREIGN KEY (TeamID)
    REFERENCES TeamInfo(TeamID),
 CONSTRAINT FK_PlayerID_TeamPlayers FOREIGN KEY (PlayerID)
    REFERENCES PlayerInfo(PlayerID)
);


CREATE TABLE TeamAwards (
ID INTEGER AUTO_INCREMENT PRIMARY KEY,
TeamID INTEGER,
MatchID INTEGER,
PlayerID  INTEGER,
AwardName TEXT,
DateofAward DATE,
 CONSTRAINT FK_MatchID_TeamAwards FOREIGN KEY (MatchID)
    REFERENCES MatchInfo(MatchID),
 CONSTRAINT FK_PlayerID_TeamAwards FOREIGN KEY (PlayerID)
    REFERENCES PlayerInfo(PlayerID),
CONSTRAINT FK_TeamID_TeamAwards FOREIGN KEY (TeamID)
    REFERENCES TeamInfo(TeamID)
);

CREATE TABLE PlayerAwards (
ID INTEGER AUTO_INCREMENT PRIMARY KEY,
MatchID INTEGER,
PlayerID  INTEGER,
TeamID INTEGER,
AwardName TEXT,
DateofAward DATE,
 CONSTRAINT FK_MatchID_PlayerAwards FOREIGN KEY (MatchID)
    REFERENCES MatchInfo(MatchID),
 CONSTRAINT FK_PlayerID_PlayerAwards FOREIGN KEY (PlayerID)
    REFERENCES PlayerInfo(PlayerID),
 CONSTRAINT FK_TeamID_PlayerAwards FOREIGN KEY (TeamID)
    REFERENCES TeamInfo(TeamID)
);


CREATE TABLE TeamHistory (
ID INTEGER AUTO_INCREMENT PRIMARY KEY,
MatchID INTEGER,
TeamID INTEGER,
PlayedAgainst INTEGER,
MatchDate DATE,
MatchResult TEXT,
GoalsScored INTEGER,
 CONSTRAINT FK_MatchID_TeamHistory FOREIGN KEY (MatchID)
    REFERENCES MatchInfo(MatchID),
 CONSTRAINT FK_PlayedAgainst_TeamHistory FOREIGN KEY (PlayedAgainst)
    REFERENCES TeamInfo(TeamID),
 CONSTRAINT FK_TeamID_TeamHistory FOREIGN KEY (TeamID)
    REFERENCES TeamInfo(TeamID)
);


CREATE TABLE PlayerHistory (
ID INTEGER AUTO_INCREMENT PRIMARY KEY,
PlayerID INTEGER,
MatchID INTEGER,
TeamID INTEGER,
PlayedAgainst INTEGER,
MatchDate DATE,
MatchResult TEXT,
GoalsScored INTEGER,
 CONSTRAINT FK_MatchID_PlayerHistory FOREIGN KEY (MatchID)
    REFERENCES MatchInfo(MatchID),
 CONSTRAINT FK_PlayedAgainst_PlayerHistory FOREIGN KEY (PlayedAgainst)
    REFERENCES TeamInfo(TeamID),
 CONSTRAINT FK_TeamID_PlayerHistory FOREIGN KEY (TeamID)
    REFERENCES TeamInfo(TeamID),
 CONSTRAINT FK_PlayerID_PlayerHistory FOREIGN KEY (PlayerID)
    REFERENCES PlayerInfo(PlayerID)
);

INSERT INTO PlayerInfo (PlayerID, PlayerName, Age, DOB, Gender, TotalGoalsScored) VALUES
(1, 'Cristiano Ronaldo', 39, '1985-02-05', 'Male', 128),         -- as of March 2025
(2, 'Lionel Messi', 37, '1987-06-24', 'Male', 106),				 -- Winger / Forward
(3, 'Neymar Jr', 33, '1992-02-05', 'Male', 79),					 -- Winger / Forward
(4, 'Kylian Mbappé', 26, '1998-12-20', 'Male', 46),				 -- Winger / Forward
(5, 'Robert Lewandowski', 36, '1988-08-21', 'Male', 82),		 -- Winger / Forward
(6, 'Harry Kane', 31, '1993-07-28', 'Male', 63),				 -- Winger / Forward
(7, 'Erling Haaland', 24, '2000-07-21', 'Male', 31),			 -- Winger / Forward
(8, 'Mohamed Salah', 32, '1992-06-15', 'Male', 55),				 -- Winger / Forward
(9, 'Kevin De Bruyne', 33, '1991-06-28', 'Male', 27),			 -- AM (Attacking Midfield)
(10, 'Luka Modrić', 39, '1985-09-09', 'Male', 25),				 -- Midfield
(11, 'Sergio Ramos', 38, '1986-03-30', 'Male', 23),				 -- CB (Centre Back)
(12, 'Virgil van Dijk', 33, '1991-07-08', 'Male', 9),			 -- CB
(13, 'Karim Benzema', 37, '1987-12-19', 'Male', 37),			 -- Winger / Forward	
(14, 'Antoine Griezmann', 34, '1991-03-21', 'Male', 44),		 -- Winger / Forward
(15, 'Toni Kroos', 35, '1990-01-04', 'Male', 17),				 -- Midfield
(16, 'Eden Hazard', 34, '1991-01-07', 'Male', 33),				 -- Winger / Forward
(17, 'Raheem Sterling', 30, '1995-12-08', 'Male', 20),			 -- Winger / Forward
(18, 'Paulo Dybala', 31, '1993-11-15', 'Male', 9),				 -- Winger / Forward
(19, 'Zlatan Ibrahimović', 43, '1981-10-03', 'Male', 62),		 -- Winger / Forward
(20, 'Manuel Neuer', 39, '1986-03-27', 'Male', 0),  -- Goalkeeper
(21, 'Bukayo Saka', 23, '2001-09-05', 'Male', 12),				 -- Winger / Forward
(22, 'Phil Foden', 24, '2000-05-28', 'Male', 10),				 -- Winger / Forward
(23, 'Jude Bellingham', 21, '2003-06-29', 'Male', 10),			 -- AM
(24, 'João Félix', 25, '1999-11-10', 'Male', 7),				 -- Winger / Forward
(25, 'Kai Havertz', 25, '1999-06-11', 'Male', 13),				 -- Winger / Forward
(26, 'Mason Mount', 26, '1999-01-10', 'Male', 7),				 -- Winger / Forward
(27, 'Pedri', 22, '2002-11-25', 'Male', 5),						 -- Midfield
(28, 'Gavi', 20, '2004-08-05', 'Male', 3),						 -- Midfield
(29, 'Rodri', 28, '1997-06-22', 'Male', 7),						 -- Midfield
(30, 'Declan Rice', 26, '1999-01-14', 'Male', 4),				 -- Midfield
(31, 'Joshua Kimmich', 30, '1995-02-08', 'Male', 6),			 -- Midfield
(32, 'Federico Valverde', 26, '1998-07-22', 'Male', 5),			 -- AM
(33, 'Aurélien Tchouaméni', 25, '2000-01-27', 'Male', 2),		 -- Midfield
(34, 'Alphonso Davies', 24, '2000-11-02', 'Male', 12),			 -- Defense
(35, 'Achraf Hakimi', 26, '1998-11-04', 'Male', 9),				 -- Defense
(36, 'Theo Hernández', 27, '1997-10-06', 'Male', 7),			 -- Defense
(37, 'Trent Alexander-Arnold', 26, '1998-10-07', 'Male', 4),	 -- Defense
(38, 'Reece James', 25, '1999-12-08', 'Male', 3),				 -- Defense / Midefield
(39, 'Rúben Dias', 27, '1997-05-14', 'Male', 2),				 -- CB
(40, 'Marquinhos', 30, '1994-05-14', 'Male', 7),				 -- CB
(41, 'Aymeric Laporte', 30, '1994-05-27', 'Male', 3),			 -- CB
(42, 'Alisson Becker', 32, '1992-10-02', 'Male', 0),	   -- Goalie
(43, 'Thibaut Courtois', 32, '1992-05-11', 'Male', 0),	   -- Goalie
(44, 'Gianluigi Donnarumma', 26, '1999-02-25', 'Male', 0), -- Goalie
(45, 'Marc-André ter Stegen', 33, '1992-04-30', 'Male', 0), -- Goalie
(46, 'Ederson Moraes', 31, '1993-08-17', 'Male', 0),	-- Goalie
(47, 'Lautaro Martínez', 27, '1997-08-22', 'Male', 22), -- Winger / Forward
(48, 'Olivier Giroud', 38, '1986-09-30', 'Male', 57),	-- Winger / Forward
(49, 'Álvaro Morata', 32, '1992-10-23', 'Male', 34),	-- Winger / Forward
(50, 'Christian Pulisic', 26, '1998-09-18', 'Male', 28); -- Winger / Forward

INSERT INTO PlayerInfo (PlayerID, PlayerName, Age, DOB, Gender, TotalGoalsScored) VALUES 
(51, 'Heung-Min Son', 32, '1992-07-08', 'Male', 41),
(52, 'Christian Eriksen', 33, '1992-02-14', 'Male', 39),
(53, 'Luka Jović', 27, '1997-12-23', 'Male', 15),
(54, 'Hirving Lozano', 29, '1995-07-30', 'Male', 18),
(55, 'Keylor Navas', 38, '1986-12-15', 'Male', 0),
(56, 'Takumi Minamino', 30, '1995-01-16', 'Male', 19),
(57, 'Sardar Azmoun', 30, '1995-01-01', 'Male', 44),
(58, 'Teemu Pukki', 35, '1990-03-29', 'Male', 38),
(59, 'Jan Oblak', 32, '1992-01-07', 'Male', 0),
(60, 'Ermir Lenjani', 35, '1989-08-05', 'Male', 5);

select * from playerinfo;


select * from TeamInfo;


SET SQL_SAFE_UPDATES = 0;
delete from Users;

INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (1, 'user1', 'pass1@2025', 'Roberto', 'Martínez', 'Manager', 'user1@example.com', '+10000000001');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (2, 'user2', 'pass2@2025', 'Lionel', 'Scaloni', 'Manager', 'user2@example.com', '+10000000002');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (3, 'user3', 'pass3@2025', 'Dorival', 'Júnior', 'Manager', 'user3@example.com', '+10000000003');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (4, 'user4', 'pass4@2025', 'Didier', 'Deschamps', 'Manager', 'user4@example.com', '+10000000004');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (5, 'user5', 'pass5@2025', 'Michał', 'Probierz', 'Manager', 'user5@example.com', '+10000000005');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (6, 'user6', 'pass6@2025', 'Gareth', 'Southgate', 'Manager', 'user6@example.com', '+10000000006');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (7, 'user7', 'pass7@2025', 'Ståle', 'Solbakken', 'Manager', 'user7@example.com', '+10000000007');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (8, 'user8', 'pass8@2025', 'Rui', 'Vitória', 'Manager', 'user8@example.com', '+10000000008');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (9, 'user9', 'pass9@2025', 'Domenico', 'Tedesco', 'Manager', 'user9@example.com', '+10000000009');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (10, 'user10', 'pass10@2025', 'Zlatko', 'Dalić', 'Manager', 'user10@example.com', '+10000000010');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (11, 'user11', 'pass11@2025', 'Luis', 'de la Fuente', 'Manager', 'user11@example.com', '+10000000011');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (12, 'user12', 'pass12@2025', 'Julian', 'Nagelsmann', 'Manager', 'user12@example.com', '+10000000012');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (13, 'user13', 'pass13@2025', 'Ronald', 'Koeman', 'Manager', 'user13@example.com', '+10000000013');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (14, 'user14', 'pass14@2025', 'Mauro', 'Biello', 'Manager', 'user14@example.com', '+10000000014');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (15, 'user15', 'pass15@2025', 'Walid', 'Regragui', 'Manager', 'user15@example.com', '+10000000015');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (16, 'user16', 'pass16@2025', 'Luciano', 'Spalletti', 'Manager', 'user16@example.com', '+10000000016');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (17, 'user17', 'pass17@2025', 'Gregg', 'Berhalter', 'Manager', 'user17@example.com', '+10000000017');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (18, 'user18', 'pass18@2025', 'Marcelo', 'Bielsa', 'Manager', 'user18@example.com', '+10000000018');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (19, 'user19', 'pass19@2025', 'Janne', 'Andersson', 'Manager', 'user19@example.com', '+10000000019');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (20, 'user20', 'pass20@2025', 'Thibaut', 'Petit', 'Manager', 'user20@example.com', '+10000000020');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (21, 'user21', 'pass21@2025', 'Jean', 'Martin', 'Manager', 'user21@example.com', '+10000000021');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (22, 'user22', 'pass22@2025', 'Jürgen', 'Klinsmann', 'Manager', 'user22@example.com', '+10000000022');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (23, 'user23', 'pass23@2025', 'Kasper', 'Hjulmand', 'Manager', 'user23@example.com', '+10000000023');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (24, 'user24', 'pass24@2025', 'Dragan', 'Stojković', 'Manager', 'user24@example.com', '+10000000024');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (25, 'user25', 'pass25@2025', 'Jaime', 'Lozano', 'Manager', 'user25@example.com', '+10000000025');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (26, 'user26', 'pass26@2025', 'Luis', 'Fernando', 'Manager', 'user26@example.com', '+10000000026');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (27, 'user27', 'pass27@2025', 'Hajime', 'Moriyasu', 'Manager', 'user27@example.com', '+10000000027');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (28, 'user28', 'pass28@2025', 'Amir', 'Ghalenoei', 'Manager', 'user28@example.com', '+10000000028');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (29, 'user29', 'pass29@2025', 'Markku', 'Kanerva', 'Manager', 'user29@example.com', '+10000000029');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (30, 'user30', 'pass30@2025', 'Matjaž', 'Kek', 'Manager', 'user30@example.com', '+10000000030');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (31, 'user31', 'pass31@2025', 'Sylvinho', 'Barbosa', 'Manager', 'user31@example.com', '+10000000031');

select * from Users;

select * from PlayerInfo;


-- Start a transaction to ensure all updates succeed or none do.
START TRANSACTION;

-- Temporarily disable the foreign key checks.
SET FOREIGN_KEY_CHECKS=0;

-- First, update the child table (TeamInfo) so the managers point to their future IDs.
UPDATE TeamInfo
SET ManagerID = ManagerID + 66
WHERE ManagerID BETWEEN 1 AND 31;

-- Now, update the parent table (Users) with the new primary key IDs.
UPDATE Users
SET
    UserName = CONCAT('user', UserID + 66),
    UserPassword = CONCAT('pass', UserID + 66, '@2025'),
    Email = CONCAT('user', UserID + 66, '@example.com'),
    Mobile = CONCAT('+100000000', UserID + 66),
    UserID = UserID + 66
WHERE
    UserID BETWEEN 1 AND 31;

-- Re-enable the foreign key checks.
SET FOREIGN_KEY_CHECKS=1;

-- Commit the changes to make them permanent. If any step failed, you would use ROLLBACK.
COMMIT;

select * from playerinfo;
select * from teaminfo;
select * from users;

delete from Users where UserID > 97;

INSERT INTO Users (UserID, UserFirstName, UserLastName, UserName, UserPassword, UserRole, Email, Mobile)
SELECT
	PlayerID,
    -- Extracts the first word as the first name
    SUBSTRING_INDEX(PlayerName, ' ', 1) AS UserFirstName,
    
    -- Extracts the last word as the last name, or NULL if there's only one word
    IF(LOCATE(' ', PlayerName) > 0, SUBSTRING_INDEX(PlayerName, ' ', -1), NULL) AS UserLastName,
    
    -- Creates a username, e.g., 'cristianoronaldo'
    LOWER(REPLACE(PlayerName, ' ', '')) AS UserName,
    
    -- Creates a placeholder password, e.g., 'pass_cristianoronaldo'
    CONCAT('pass_', PlayerID) AS UserPassword,
    
    -- Assigns a default role of 'Player'
    'Player' AS UserRole,
    
    -- Creates a placeholder email, e.g., 'cristianoronaldo@example.com'
    CONCAT(LOWER(REPLACE(PlayerName, ' ', '')), '@example.com') AS Email,
    
    -- Creates a placeholder mobile number
    CONCAT('+199900', LPAD(PlayerID, 4, '0')) AS Mobile
FROM
    PlayerInfo;

UPDATE TeamInfo
SET
ManagerID = 67
WHERE ManagerID = 1;

UPDATE Users
SET
    UserName = CONCAT('user', UserID + 66),
    UserPassword = CONCAT('pass', UserID + 66, '@2025'),
    Email = CONCAT('user', UserID + 66, '@example.com'),
    Mobile = CONCAT('+100000000', UserID + 66),
    UserID = UserID + 66
WHERE
    UserID BETWEEN 1 AND 31;

UPDATE TeamInfo SET ManagerID = 1 WHERE TeamID = 1;   -- Roberto Martínez (Portugal FC)
UPDATE TeamInfo SET ManagerID = 2 WHERE TeamID = 2;   -- Lionel Scaloni (Argentina FC)
UPDATE TeamInfo SET ManagerID = 3 WHERE TeamID = 3;   -- Dorival Júnior (Brazil FC)
UPDATE TeamInfo SET ManagerID = 4 WHERE TeamID = 4;   -- Didier Deschamps (France FC)
UPDATE TeamInfo SET ManagerID = 5 WHERE TeamID = 5;   -- Michał Probierz (Poland FC)
UPDATE TeamInfo SET ManagerID = 6 WHERE TeamID = 6;   -- Gareth Southgate (England FC)
UPDATE TeamInfo SET ManagerID = 7 WHERE TeamID = 7;   -- Ståle Solbakken (Norway FC)
UPDATE TeamInfo SET ManagerID = 8 WHERE TeamID = 8;   -- Rui Vitória (Egypt FC)
UPDATE TeamInfo SET ManagerID = 9 WHERE TeamID = 9;   -- Domenico Tedesco (Belgium FC)
UPDATE TeamInfo SET ManagerID = 10 WHERE TeamID = 10; -- Zlatko Dalić (Croatia FC)
UPDATE TeamInfo SET ManagerID = 11 WHERE TeamID = 11; -- Luis de la Fuente (Spain FC)
UPDATE TeamInfo SET ManagerID = 12 WHERE TeamID = 12; -- Julian Nagelsmann (Germany FC)
UPDATE TeamInfo SET ManagerID = 13 WHERE TeamID = 13; -- Ronald Koeman (Netherlands FC)
UPDATE TeamInfo SET ManagerID = 14 WHERE TeamID = 14; -- Mauro Biello (Canada FC)
UPDATE TeamInfo SET ManagerID = 15 WHERE TeamID = 15; -- Walid Regragui (Morocco FC)
UPDATE TeamInfo SET ManagerID = 16 WHERE TeamID = 16; -- Luciano Spalletti (Italy FC)
UPDATE TeamInfo SET ManagerID = 17 WHERE TeamID = 17; -- Gregg Berhalter (USA FC)
UPDATE TeamInfo SET ManagerID = 18 WHERE TeamID = 18; -- Marcelo Bielsa (Uruguay FC)
UPDATE TeamInfo SET ManagerID = 19 WHERE TeamID = 19; -- Janne Andersson (Sweden FC)
UPDATE TeamInfo SET ManagerID = 20 WHERE TeamID = 20; -- Thibaut Petit (Belgium B FC)
UPDATE TeamInfo SET ManagerID = 21 WHERE TeamID = 21; -- Jean Martin (France B FC)
UPDATE TeamInfo SET ManagerID = 22 WHERE TeamID = 22; -- Jürgen Klinsmann (South Korea FC)
UPDATE TeamInfo SET ManagerID = 23 WHERE TeamID = 23; -- Kasper Hjulmand (Denmark FC)
UPDATE TeamInfo SET ManagerID = 24 WHERE TeamID = 24; -- Dragan Stojković (Serbia FC)
UPDATE TeamInfo SET ManagerID = 25 WHERE TeamID = 25; -- Jaime Lozano (Mexico FC)
UPDATE TeamInfo SET ManagerID = 26 WHERE TeamID = 26; -- Luis Fernando (Costa Rica FC)
UPDATE TeamInfo SET ManagerID = 27 WHERE TeamID = 27; -- Hajime Moriyasu (Japan FC)
UPDATE TeamInfo SET ManagerID = 28 WHERE TeamID = 28; -- Amir Ghalenoei (Iran FC)
UPDATE TeamInfo SET ManagerID = 29 WHERE TeamID = 29; -- Markku Kanerva (Finland FC)
UPDATE TeamInfo SET ManagerID = 30 WHERE TeamID = 30; -- Matjaž Kek (Slovenia FC)
UPDATE TeamInfo SET ManagerID = 31 WHERE TeamID = 31; -- Sylvinho Barbosa (Albania FC)



UPDATE TeamInfo SET ManagerID = 1 WHERE TeamID = 1;   -- Roberto Martínez (Portugal FC)
UPDATE TeamInfo SET ManagerID = 2 WHERE TeamID = 2;   -- Lionel Scaloni (Argentina FC)
UPDATE TeamInfo SET ManagerID = 3 WHERE TeamID = 3;   -- Dorival Júnior (Brazil FC)
UPDATE TeamInfo SET ManagerID = 4 WHERE TeamID = 4;   -- Didier Deschamps (France FC)
UPDATE TeamInfo SET ManagerID = 5 WHERE TeamID = 5;   -- Michał Probierz (Poland FC)
UPDATE TeamInfo SET ManagerID = 6 WHERE TeamID = 6;   -- Gareth Southgate (England FC)
UPDATE TeamInfo SET ManagerID = 7 WHERE TeamID = 7;   -- Ståle Solbakken (Norway FC)
UPDATE TeamInfo SET ManagerID = 8 WHERE TeamID = 8;   -- Rui Vitória (Egypt FC)
UPDATE TeamInfo SET ManagerID = 9 WHERE TeamID = 9;   -- Domenico Tedesco (Belgium FC)
UPDATE TeamInfo SET ManagerID = 10 WHERE TeamID = 10; -- Zlatko Dalić (Croatia FC)
UPDATE TeamInfo SET ManagerID = 11 WHERE TeamID = 11; -- Luis de la Fuente (Spain FC)
UPDATE TeamInfo SET ManagerID = 12 WHERE TeamID = 12; -- Julian Nagelsmann (Germany FC)
UPDATE TeamInfo SET ManagerID = 13 WHERE TeamID = 13; -- Ronald Koeman (Netherlands FC)
UPDATE TeamInfo SET ManagerID = 14 WHERE TeamID = 14; -- Mauro Biello (Canada FC)
UPDATE TeamInfo SET ManagerID = 15 WHERE TeamID = 15; -- Walid Regragui (Morocco FC)
UPDATE TeamInfo SET ManagerID = 16 WHERE TeamID = 16; -- Luciano Spalletti (Italy FC)
UPDATE TeamInfo SET ManagerID = 17 WHERE TeamID = 17; -- Gregg Berhalter (USA FC)
UPDATE TeamInfo SET ManagerID = 18 WHERE TeamID = 18; -- Marcelo Bielsa (Uruguay FC)
UPDATE TeamInfo SET ManagerID = 19 WHERE TeamID = 19; -- Janne Andersson (Sweden FC)
UPDATE TeamInfo SET ManagerID = 20 WHERE TeamID = 20; -- Thibaut Petit (Belgium B FC)
UPDATE TeamInfo SET ManagerID = 21 WHERE TeamID = 21; -- Jean Martin (France B FC)
UPDATE TeamInfo SET ManagerID = 22 WHERE TeamID = 22; -- Jürgen Klinsmann (South Korea FC)
UPDATE TeamInfo SET ManagerID = 23 WHERE TeamID = 23; -- Kasper Hjulmand (Denmark FC)
UPDATE TeamInfo SET ManagerID = 24 WHERE TeamID = 24; -- Dragan Stojković (Serbia FC)
UPDATE TeamInfo SET ManagerID = 25 WHERE TeamID = 25; -- Jaime Lozano (Mexico FC)
UPDATE TeamInfo SET ManagerID = 26 WHERE TeamID = 26; -- Luis Fernando (Costa Rica FC)
UPDATE TeamInfo SET ManagerID = 27 WHERE TeamID = 27; -- Hajime Moriyasu (Japan FC)
UPDATE TeamInfo SET ManagerID = 28 WHERE TeamID = 28; -- Amir Ghalenoei (Iran FC)
UPDATE TeamInfo SET ManagerID = 29 WHERE TeamID = 29; -- Markku Kanerva (Finland FC)
UPDATE TeamInfo SET ManagerID = 30 WHERE TeamID = 30; -- Matjaž Kek (Slovenia FC)
UPDATE TeamInfo SET ManagerID = 31 WHERE TeamID = 31; -- Sylvinho Barbosa (Albania FC)

select * from TeamInfo;

INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (1, 1, 1);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (2, 2, 2);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (3, 3, 3);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (4, 4, 4);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (5, 5, 5);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (6, 6, 6);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (7, 7, 7);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (8, 8, 8);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (9, 9, 9);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (10, 10, 10);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (11, 11, 11);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (12, 12, 12);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (13, 13, 13);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (14, 14, 14);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (15, 15, 15);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (16, 16, 16);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (17, 17, 17);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (18, 18, 18);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (19, 19, 19);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (20, 20, 20);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (21, 21, 21);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (22, 1, 22);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (23, 2, 23);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (24, 3, 24);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (25, 4, 25);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (26, 5, 26);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (27, 6, 27);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (28, 7, 28);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (29, 8, 29);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (30, 9, 30);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (31, 10, 31);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (32, 11, 32);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (33, 12, 33);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (34, 13, 34);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (35, 14, 35);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (36, 15, 36);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (37, 16, 37);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (38, 17, 38);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (39, 18, 39);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (40, 19, 40);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (41, 20, 41);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (42, 21, 42);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (43, 1, 43);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (44, 2, 44);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (45, 3, 45);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (46, 4, 46);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (47, 5, 47);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (48, 6, 48);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (49, 7, 49);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (50, 8, 50);

-- New players (PlayerID 51–60) → TeamID 22–31
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (51, 22, 51);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (52, 23, 52);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (53, 24, 53);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (54, 25, 54);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (55, 26, 55);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (56, 27, 56);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (57, 28, 57);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (58, 29, 58);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (59, 30, 59);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (60, 31, 60);

select * from TeamPlayers;
select * from playerinfo;
select * from teaminfo;
select * from users;
select * from playerinfo;


INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (1, 'Portugal FC', 'Portugal', 195, 117, 45, 33, 360, 1);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (2, 'Argentina FC', 'Argentina', 225, 135, 50, 40, 420, 2);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (3, 'Brazil FC', 'Brazil', 250, 160, 45, 45, 500, 3);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (4, 'France FC', 'France', 230, 145, 50, 35, 460, 4);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (5, 'Poland FC', 'Poland', 180, 95, 55, 30, 290, 5);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (6, 'England FC', 'England', 240, 150, 50, 40, 470, 6);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (7, 'Norway FC', 'Norway', 160, 85, 50, 25, 220, 7);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (8, 'Egypt FC', 'Egypt', 210, 125, 55, 30, 350, 8);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (9, 'Belgium FC', 'Belgium', 220, 140, 45, 35, 440, 9);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (10, 'Croatia FC', 'Croatia', 190, 110, 45, 35, 320, 10);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (11, 'Spain FC', 'Spain', 235, 145, 50, 40, 460, 11);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (12, 'Germany FC', 'Germany', 260, 165, 55, 40, 510, 12);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (13, 'Netherlands FC', 'Netherlands', 210, 130, 50, 30, 390, 13);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (14, 'Canada FC', 'Canada', 140, 80, 40, 20, 200, 14);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (15, 'Morocco FC', 'Morocco', 190, 110, 50, 30, 310, 15);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (16, 'Italy FC', 'Italy', 250, 155, 55, 40, 480, 16);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (17, 'USA FC', 'USA', 200, 120, 50, 30, 340, 17);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (18, 'Uruguay FC', 'Uruguay', 215, 130, 55, 30, 370, 18);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (19, 'Sweden FC', 'Sweden', 195, 115, 50, 30, 330, 19);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (20, 'Belgium FC', 'Belgium', 85, 50, 20, 15, 125, 20);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (21, 'France FC', 'France', 95, 55, 25, 15, 130, 21);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (22, 'South Korea FC', 'South Korea', 210, 120, 60, 30, 350, 22);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (23, 'Denmark FC', 'Denmark', 205, 115, 55, 35, 340, 23);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (24, 'Serbia FC', 'Serbia', 180, 95, 60, 25, 310, 24);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (25, 'Mexico FC', 'Mexico', 225, 135, 55, 35, 400, 25);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (26, 'Costa Rica FC', 'Costa Rica', 175, 100, 50, 25, 280, 26);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (27, 'Japan FC', 'Japan', 230, 140, 60, 30, 390, 27);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (28, 'Iran FC', 'Iran', 190, 105, 60, 25, 320, 28);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (29, 'Finland FC', 'Finland', 160, 85, 50, 25, 240, 29);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (30, 'Slovenia FC', 'Slovenia', 150, 80, 45, 25, 220, 30);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (31, 'Albania FC', 'Albania', 140, 75, 45, 20, 210, 31);

-- checking for duplicates if at all you executed insertion statements twice by mistake
-- Tip: replace table name and table attributes in the from and group by clauses.
SELECT *, COUNT(*)
FROM users
GROUP BY UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile
HAVING COUNT(*) > 1;

select *  from teaminfo;

INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (1, 'Portugal FC vs Argentina FC', 'Old Trafford, Manchester', '2014-11-18');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (2, 'Portugal FC vs Brazil FC', 'Moses Mabhida Stadium, Durban', '2010-06-25');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (3, 'Portugal FC vs France FC', 'Stade de France, Saint-Denis', '2016-07-10');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (4, 'Portugal FC vs Poland FC', 'Silesian Stadium, Chorzów', '2018-10-11');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (5, 'Portugal FC vs England FC', 'Gelsenkirchen', '2006-07-01');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (6, 'Portugal FC vs Norway FC', 'Estádio da Luz, Lisbon', '2011-06-04');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (7, 'Portugal FC vs Egypt FC', 'Letzigrund, Zurich', '2018-03-23');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (8, 'Portugal FC vs Belgium FC', 'La Cartuja, Seville', '2021-06-27');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (9, 'Portugal FC vs Croatia FC', 'Poljud Stadium, Split', '2020-11-17');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (10, 'Portugal FC vs Spain FC', 'Fisht Olympic Stadium, Sochi', '2018-06-15');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (11, 'Portugal FC vs Germany FC', 'Allianz Arena, Munich', '2021-06-19');

INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (12, 'Portugal FC vs Croatia FC', 'Estádio do SL Benfica, Lisbon', '2024-09-05');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (13, 'Portugal FC vs Scotland FC', 'Estádio do SL Benfica, Lisbon', '2024-09-08');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (14, 'Portugal FC vs Poland FC', 'PGE Narodowy, Warsaw', '2024-10-12');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (15, 'Portugal FC vs Slovenia FC', 'Waldstadion, Frankfurt', '2024-07-01');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (16, 'Portugal FC vs France FC', 'Volksparkstadion, Hamburg', '2024-07-05');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (17, 'Portugal FC vs Ghana FC', 'Stadium 974, Doha', '2022-11-24');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (18, 'Portugal FC vs Uruguay FC', 'Lusail Stadium, Lusail', '2022-11-28');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (19, 'Portugal FC vs Switzerland FC', 'Lusail Stadium, Lusail', '2022-12-06');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (20, 'Portugal FC vs Morocco FC', 'Al Thumama Stadium, Doha', '2022-12-10');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (21, 'Portugal FC vs Spain FC', 'Estádio Municipal de Braga, Braga', '2022-09-27');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (22, 'Portugal FC vs Czech Republic FC', 'Estádio José Alvalade, Lisbon', '2022-06-09');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (23, 'Portugal FC vs Switzerland FC', 'Estádio José Alvalade, Lisbon', '2022-06-05');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (24, 'Portugal FC vs Turkey FC', 'Estádio do Dragão, Porto', '2022-03-24');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (25, 'Portugal FC vs North Macedonia FC', 'Estádio do Dragão, Porto', '2022-03-29');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (26, 'Portugal FC vs Ireland FC', 'Aviva Stadium, Dublin', '2021-11-11');

select * from matchinfo; 

INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (1, 1, 1, 2, '1-0 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (2, 2, 1, 3, '0-0 - Draw');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (3, 3, 1, 4, '1-0 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (4, 4, 1, 5, '3-2 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (5, 5, 1, 6, '0-0 (3-1 pens) - Draw');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (6, 6, 1, 7, '1-0 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (7, 7, 1, 8, '2-1 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (8, 8, 1, 9, '0-1 - Loss');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (9, 9, 1, 10, '3-2 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (10, 10, 1, 11, '3-3 - Draw');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (11, 11, 1, 12, '2-4 - Loss');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (12, 12, 1, 10, '2-1 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (13, 13, 1, 23, '2-1 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (14, 14, 1, 5, '3-1 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (15, 15, 1, 30, '0-0 (5-3 pens) - Draw');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (16, 16, 1, 4, '0-1 - Loss');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (17, 17, 1, 15, '3-2 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (18, 18, 1, 18, '2-0 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (19, 19, 1, 9, '6-1 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (20, 20, 1, 15, '0-1 - Loss');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (21, 21, 1, 11, '0-1 - Loss');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (22, 22, 1, 23, '2-0 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (23, 23, 1, 9, '4-0 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (24, 24, 1, 24, '3-1 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (25, 25, 1, 31, '2-0 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (26, 26, 1, 17, '0-0 - Draw');

select * from matchhistory;


-- delete from matchhistory;

INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (1, 1, 1, 1, 2, '2014-01-01', '0-0 - Draw', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (2, 2, 1, 1, 2, '2014-01-01', '0-0 - Draw', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (3, 2, 2, 1, 3, '2014-06-30', '2-3 - Loss', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (4, 3, 2, 1, 3, '2014-06-30', '2-3 - Loss', 3);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (5, 3, 3, 1, 4, '2014-12-27', '0-2 - Loss', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (6, 4, 3, 1, 4, '2014-12-27', '0-2 - Loss', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (7, 4, 4, 1, 5, '2015-06-25', '2-1 - Win', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (8, 5, 4, 1, 5, '2015-06-25', '2-1 - Win', 1);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (9, 5, 5, 1, 6, '2015-12-22', '0-0 - Draw', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (10, 6, 5, 1, 6, '2015-12-22', '0-0 - Draw', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (11, 6, 6, 1, 7, '2016-06-19', '2-3 - Loss', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (12, 7, 6, 1, 7, '2016-06-19', '2-3 - Loss', 3);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (13, 7, 7, 1, 8, '2016-12-16', '0-2 - Loss', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (14, 8, 7, 1, 8, '2016-12-16', '0-2 - Loss', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (15, 8, 8, 1, 9, '2017-06-14', '2-1 - Win', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (16, 9, 8, 1, 9, '2017-06-14', '2-1 - Win', 1);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (17, 9, 9, 1, 10, '2017-12-11', '0-0 - Draw', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (18, 10, 9, 1, 10, '2017-12-11', '0-0 - Draw', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (19, 10, 10, 1, 11, '2018-06-09', '2-3 - Loss', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (20, 11, 10, 1, 11, '2018-06-09', '2-3 - Loss', 3);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (21, 11, 11, 1, 12, '2018-12-06', '0-2 - Loss', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (22, 12, 11, 1, 12, '2018-12-06', '0-2 - Loss', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (23, 12, 12, 1, 13, '2019-06-04', '2-1 - Win', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (24, 13, 12, 1, 13, '2019-06-04', '2-1 - Win', 1);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (25, 13, 13, 1, 14, '2019-12-01', '0-0 - Draw', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (26, 14, 13, 1, 14, '2019-12-01', '0-0 - Draw', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (27, 14, 14, 1, 15, '2020-05-29', '2-3 - Loss', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (28, 15, 14, 1, 15, '2020-05-29', '2-3 - Loss', 3);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (29, 15, 15, 1, 16, '2020-11-25', '0-2 - Loss', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (30, 16, 15, 1, 16, '2020-11-25', '0-2 - Loss', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (31, 16, 16, 1, 17, '2021-05-24', '2-1 - Win', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (32, 17, 16, 1, 17, '2021-05-24', '2-1 - Win', 1);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (33, 17, 17, 1, 18, '2021-11-20', '0-0 - Draw', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (34, 18, 17, 1, 18, '2021-11-20', '0-0 - Draw', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (35, 18, 18, 1, 19, '2022-05-19', '2-3 - Loss', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (36, 19, 18, 1, 19, '2022-05-19', '2-3 - Loss', 3);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (37, 19, 19, 1, 20, '2022-11-15', '0-2 - Loss', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (38, 20, 19, 1, 20, '2022-11-15', '0-2 - Loss', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (39, 20, 20, 1, 21, '2023-05-14', '2-1 - Win', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (40, 21, 20, 1, 21, '2023-05-14', '2-1 - Win', 1);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (41, 21, 21, 1, 22, '2023-11-10', '0-0 - Draw', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (42, 22, 21, 1, 22, '2023-11-10', '0-0 - Draw', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (43, 22, 22, 1, 23, '2024-05-08', '2-3 - Loss', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (44, 23, 22, 1, 23, '2024-05-08', '2-3 - Loss', 3);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (45, 23, 23, 1, 24, '2024-11-04', '0-2 - Loss', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (46, 24, 23, 1, 24, '2024-11-04', '0-2 - Loss', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (47, 24, 24, 1, 25, '2025-05-03', '2-1 - Win', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (48, 25, 24, 1, 25, '2025-05-03', '2-1 - Win', 1);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (49, 25, 25, 1, 26, '2025-10-30', '0-0 - Draw', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (50, 26, 25, 1, 26, '2025-10-30', '0-0 - Draw', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (51, 26, 26, 1, 27, '2026-04-28', '2-3 - Loss', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (52, 27, 26, 1, 27, '2026-04-28', '2-3 - Loss', 3);

select * from playerhistory;

INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (1, 1, 1, 2, '2014-01-01', 'Draw', 0);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (2, 2, 1, 3, '2014-06-30', 'Loss', 2);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (3, 3, 1, 4, '2014-12-27', 'Loss', 0);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (4, 4, 1, 5, '2015-06-25', 'Win', 2);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (5, 5, 1, 6, '2015-12-22', 'Draw', 0);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (6, 6, 1, 7, '2016-06-19', 'Loss', 2);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (7, 7, 1, 8, '2016-12-16', 'Loss', 0);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (8, 8, 1, 9, '2017-06-14', 'Win', 2);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (9, 9, 1, 10, '2017-12-11', 'Draw', 0);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (10, 10, 1, 11, '2018-06-09', 'Loss', 2);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (11, 11, 1, 12, '2018-12-06', 'Loss', 0);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (12, 12, 1, 13, '2019-06-04', 'Win', 2);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (13, 13, 1, 14, '2019-12-01', 'Draw', 0);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (14, 14, 1, 15, '2020-05-29', 'Loss', 2);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (15, 15, 1, 16, '2020-11-25', 'Loss', 0);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (16, 16, 1, 17, '2021-05-24', 'Win', 2);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (17, 17, 1, 18, '2021-11-20', 'Draw', 0);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (18, 18, 1, 19, '2022-05-19', 'Loss', 2);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (19, 19, 1, 20, '2022-11-15', 'Loss', 0);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (20, 20, 1, 21, '2023-05-14', 'Win', 2);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (21, 21, 1, 22, '2023-11-10', 'Draw', 0);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (22, 22, 1, 23, '2024-05-08', 'Loss', 2);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (23, 23, 1, 24, '2024-11-04', 'Loss', 0);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (24, 24, 1, 25, '2025-05-03', 'Win', 2);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (25, 25, 1, 26, '2025-10-30', 'Draw', 0);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (26, 26, 1, 27, '2026-04-28', 'Loss', 2);

select * from teamhistory;

INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (1, 1, 1, 1, 'Best Team Performance', '2015-01-01');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (2, 1, 2, 4, 'Most Disciplined', '2015-08-29');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (3, 1, 3, 7, 'Best Strategy', '2016-04-25');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (4, 1, 4, 10, 'Team Spirit', '2016-12-21');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (5, 1, 5, 13, 'Fair Play', '2017-08-18');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (6, 1, 6, 16, 'Strongest Defense', '2018-04-15');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (7, 1, 7, 19, 'Most Aggressive', '2018-12-11');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (8, 1, 8, 22, 'Crowd Favorite', '2019-08-08');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (9, 1, 9, 25, 'Top Scoring Team', '2020-04-04');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (10, 1, 10, 28, 'Comeback Kings', '2020-11-30');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (11, 1, 11, 31, 'Best Passing Accuracy', '2021-07-28');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (12, 1, 12, 34, 'Most Possession', '2022-03-25');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (13, 1, 13, 37, 'Best Pressing', '2022-11-20');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (14, 1, 14, 40, 'Most Goals in a Match', '2023-07-18');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (15, 1, 15, 43, 'Flawless Win', '2024-03-14');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (16, 1, 6, 6, 'Historic Win', '2022-01-01');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (17, 1, 7, 13, 'Strong Second Half', '2022-04-01');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (18, 1, 8, 20, 'Clean Sheet', '2022-06-30');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (19, 1, 9, 27, 'Dominant Midfield', '2022-09-28');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (20, 1, 10, 34, 'Captain’s Leadership', '2022-12-27');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (21, 1, 11, 41, 'Smart Substitutions', '2023-03-27');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (22, 1, 12, 48, 'Solid Finishing', '2023-06-25');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (23, 1, 13, 55, 'Most Fouls Drawn', '2023-09-23');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (24, 1, 14, 2, 'Fan Favorite Squad', '2023-12-22');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (25, 1, 15, 9, 'Highest Pass Completion', '2024-03-21');

select * from teamawards;

INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (1, 1, 4, 1, 'Man of the Match', '2016-01-01');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (2, 2, 8, 1, 'Golden Boot', '2016-06-29');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (3, 3, 12, 1, 'Assist King', '2016-12-26');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (4, 4, 16, 1, 'Match Saver', '2017-06-24');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (5, 5, 20, 1, 'Top Sprinter', '2017-12-21');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (6, 6, 24, 1, 'Smartest Play', '2018-06-19');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (7, 7, 28, 1, 'Finisher Extraordinaire', '2018-12-16');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (8, 8, 32, 1, 'Game Changer', '2019-06-14');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (9, 9, 36, 1, 'Defensive Wall', '2019-12-11');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (10, 10, 40, 1, 'Midfield Maestro', '2020-06-08');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (11, 11, 44, 1, 'Fan Favorite', '2020-12-05');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (12, 12, 48, 1, 'Best Dribbler', '2021-06-03');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (13, 13, 52, 1, 'Most Valuable Player', '2021-11-30');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (14, 14, 56, 1, 'Clutch Performer', '2022-05-29');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (15, 15, 60, 1, 'Breakthrough Star', '2022-11-25');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (16, 11, 8, 1, 'Sharp Shooter', '2021-01-01');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (17, 12, 13, 1, 'Best Captain', '2021-05-01');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (18, 13, 18, 1, 'Penalty Specialist', '2021-08-29');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (19, 14, 23, 1, 'First Goal Scorer', '2021-12-27');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (20, 15, 28, 1, 'Energy Tank', '2022-04-26');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (21, 16, 33, 1, 'Veteran Performance', '2022-08-24');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (22, 17, 38, 1, 'Young Star', '2022-12-22');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (23, 18, 43, 1, 'Tactical Genius', '2023-04-21');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (24, 19, 48, 1, 'Wall of Steel', '2023-08-19');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (25, 20, 53, 1, 'Clutch Goal', '2023-12-17');

select * from playerawards;

select * from playerinfo;
select * from playerhistory;
select * from playerawards;
select * from users;
select * from teaminfo;
select * from teamplayers;
select * from teamhistory;
select * from teamawards;
select * from matchinfo;
select * from matchhistory;

-- Usecases (Subqueries, Stored Procedures)

-- Players Who Scored More Goals Than Average
SELECT PlayerName, TotalGoalsScored
FROM PlayerInfo
WHERE TotalGoalsScored > (
    SELECT AVG(TotalGoalsScored)
    FROM PlayerInfo
);

-- Teams Who Have Won More Than Their Average Matches
SELECT TeamName, MatchesWon
FROM TeamInfo
WHERE MatchesWon > (
    SELECT AVG(MatchesWon)
    FROM TeamInfo
);

-- Players Who Won an Award Named "Man of the Match"
SELECT PlayerName
FROM PlayerInfo
WHERE PlayerID IN (
    SELECT PlayerID
    FROM PlayerAwards
    WHERE AwardName = 'Man of the Match'
);

-- Teams That Had a Match in the Same Venue as 'Old Trafford, Manchester'
SELECT DISTINCT TeamName
FROM TeamInfo
WHERE TeamID IN (
    SELECT TeamID
    FROM MatchHistory
    WHERE MatchID IN (
        SELECT MatchID
        FROM MatchInfo
        WHERE Venue = 'Old Trafford, Manchester'));

-- Stored Procedures (SP)

-- SP to Find All Awards Won by a Player
DELIMITER //
CREATE PROCEDURE GetPlayerAwards(IN player_name TEXT)
BEGIN
    SELECT pa.AwardName, pa.DateofAward
    FROM PlayerAwards pa
    JOIN PlayerInfo pi ON pa.PlayerID = pi.PlayerID
    WHERE pi.PlayerName = player_name;
END //
DELIMITER ;
CALL GetPlayerAwards('Kylian Mbappe');

-- SP to List Matches a Team Played

DELIMITER // CREATE PROCEDURE GetTeamMatches(IN team_name TEXT)
BEGIN
    SELECT mi.MatchName, mi.Venue, mi.MatchDate
    FROM MatchInfo mi
    JOIN MatchHistory mh ON mi.MatchID = mh.MatchID
    JOIN TeamInfo ti ON mh.TeamID = ti.TeamID
    WHERE ti.TeamName = team_name;
END //
DELIMITER ;
CALL GetTeamMatches('Portugal FC');

-- SP to Get Top 'N' Players by Goals
DELIMITER //
CREATE PROCEDURE GetTopPlayers(IN top_n INT)
BEGIN
    SELECT PlayerName, TotalGoalsScored
    FROM PlayerInfo
    ORDER BY TotalGoalsScored DESC
    LIMIT top_n;
END //
DELIMITER ;
CALL GetTopPlayers(5);

-- SP to Get All Players of a Team

DELIMITER // CREATE PROCEDURE GetTeamPlayers(IN team_name TEXT)
BEGIN SELECT pi.PlayerName, pi.Age
    FROM PlayerInfo pi
    JOIN TeamPlayers tp ON pi.PlayerID = tp.PlayerID
    JOIN TeamInfo ti ON tp.TeamID = ti.TeamID
    WHERE ti.TeamName = team_name;
END // DELIMITER ;
CALL GetTeamPlayers('Brazil FC');


show databases;

SELECT * FROM playerinfo where PlayerName LIKE '%Yashas%';


select * from teaminfo;

select * from users;

show tables;

SET GLOBAL local_infile = 1;

CREATE TABLE Stage_WC_Matches (
    home_team VARCHAR(100),
    away_team VARCHAR(100),
    home_score INT,
    away_score INT,
    year INT,
    hosts VARCHAR(100),
    stadium VARCHAR(255),
    match_date VARCHAR(50) -- Text format allows the procedure to handle date conversion
);

ALTER TABLE Stage_WC_Matches 
ADD COLUMN home_xg DECIMAL(5,2),
ADD COLUMN home_penalty DECIMAL(5,2),
ADD COLUMN away_xg DECIMAL(5,2),
ADD COLUMN away_penalty DECIMAL(5,2),
ADD COLUMN home_manager VARCHAR(255),
ADD COLUMN home_captain VARCHAR(255),
ADD COLUMN away_manager VARCHAR(255),
ADD COLUMN away_captain VARCHAR(255),
ADD COLUMN Attendance INT,
ADD COLUMN Officials TEXT,
ADD COLUMN Round VARCHAR(100),
ADD COLUMN Score VARCHAR(50),
ADD COLUMN Referee VARCHAR(255),
ADD COLUMN Notes TEXT,
ADD COLUMN home_goal TEXT,
ADD COLUMN away_goal TEXT,
ADD COLUMN home_goal_long TEXT,
ADD COLUMN away_goal_long TEXT,
ADD COLUMN home_own_goal TEXT,
ADD COLUMN away_own_goal TEXT,
ADD COLUMN home_penalty_goal TEXT,
ADD COLUMN away_penalty_goal TEXT,
ADD COLUMN home_penalty_miss_long TEXT,
ADD COLUMN away_penalty_miss_long TEXT,
ADD COLUMN home_penalty_shootout_goal_long TEXT,
ADD COLUMN away_penalty_shootout_goal_long TEXT,
ADD COLUMN home_penalty_shootout_miss_long TEXT,
ADD COLUMN away_penalty_shootout_miss_long TEXT,
ADD COLUMN home_red_card TEXT,
ADD COLUMN away_red_card TEXT,
ADD COLUMN home_yellow_red_card TEXT,
ADD COLUMN away_yellow_red_card TEXT,
ADD COLUMN home_yellow_card_long TEXT,
ADD COLUMN away_yellow_card_long TEXT,
ADD COLUMN home_substitute_in_long TEXT,
ADD COLUMN away_substitute_in_long TEXT;

LOAD DATA LOCAL INFILE 'C:/Dev/FIFA_WC/matches_1930_2022.csv'
INTO TABLE Stage_WC_Matches
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
 home_team, away_team, home_score, home_xg, home_penalty, 
 away_score, away_xg, away_penalty, home_manager, home_captain, 
 away_manager, away_captain, Attendance, @stadium, Officials, 
 Round, @match_date, Score, Referee, Notes, 
 @hosts, @year, home_goal, away_goal, home_goal_long, 
 away_goal_long, home_own_goal, away_own_goal, home_penalty_goal, away_penalty_goal, 
 home_penalty_miss_long, away_penalty_miss_long, home_penalty_shootout_goal_long, away_penalty_shootout_goal_long, home_penalty_shootout_miss_long, 
 away_penalty_shootout_miss_long, home_red_card, away_red_card, home_yellow_red_card, away_yellow_red_card, 
 home_yellow_card_long, away_yellow_card_long, home_substitute_in_long, away_substitute_in_long
)
SET 
 stadium = @stadium,
 match_date = @match_date,
 hosts = @hosts,
 year = @year;

TRUNCATE TABLE Stage_WC_Matches;

LOAD DATA LOCAL INFILE 'C:/Dev/FIFA_WC/matches_1930_2022.csv'
INTO TABLE Stage_WC_Matches
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
 home_team, away_team, home_score, @v_home_xg, @v_home_penalty, 
 away_score, @v_away_xg, @v_away_penalty, home_manager, home_captain, 
 away_manager, away_captain, @v_Attendance, @stadium, Officials, 
 Round, @match_date, Score, Referee, Notes, 
 @hosts, @year, home_goal, away_goal, home_goal_long, 
 away_goal_long, home_own_goal, away_own_goal, home_penalty_goal, away_penalty_goal, 
 home_penalty_miss_long, away_penalty_miss_long, home_penalty_shootout_goal_long, away_penalty_shootout_goal_long, home_penalty_shootout_miss_long, 
 away_penalty_shootout_miss_long, home_red_card, away_red_card, home_yellow_red_card, away_yellow_red_card, 
 home_yellow_card_long, away_yellow_card_long, home_substitute_in_long, away_substitute_in_long
)
SET 
 -- Convert empty strings to NULL for numeric/decimal columns
 home_xg = NULLIF(@v_home_xg, ''),
 home_penalty = NULLIF(@v_home_penalty, ''),
 away_xg = NULLIF(@v_away_xg, ''),
 away_penalty = NULLIF(@v_away_penalty, ''),
 Attendance = NULLIF(@v_Attendance, ''),
 -- Standard mapping for existing columns
 stadium = @stadium,
 match_date = @match_date,
 hosts = @hosts,
 year = @year;
 
select * from stage_wc_matches;

select * from teamawards; --
select * from teamhistory; --
select * from teaminfo; --
select * from teamplayers; --
select * from playerawards; --
select * from playerhistory; --
select * from playerinfo; --
select * from matchhistory; --
select * from matchinfo; --
select * from users; --











/* Deleting Synthetic data from all tables, Updating real data from the FIFA WC Dataset. */

-- ============================================================
-- STEP 1: Delete child/history tables first (no FK dependencies)
-- ============================================================

-- 1.1 Player Awards (no FK references to it)
DELETE FROM PlayerAwards;

-- 1.2 Team Awards (no FK references to it)
DELETE FROM TeamAwards;

-- 1.3 Player History (no FK references to it)
DELETE FROM PlayerHistory;

-- 1.4 Team History (no FK references to it)
DELETE FROM TeamHistory;

-- 1.5 Match History (referenced by nothing)
DELETE FROM MatchHistory;


-- ============================================================
-- STEP 2: Delete junction tables
-- ============================================================

-- 2.1 Team Players (junction between TeamInfo and PlayerInfo)
DELETE FROM TeamPlayers;

-- ============================================================
-- STEP 3: Delete core entity tables
-- ============================================================

-- 3.1 Match Info (parent of MatchHistory - already cleared)
DELETE FROM MatchInfo;

-- 3.2 Player Info (parent of TeamPlayers, PlayerHistory, PlayerAwards - all cleared)
DELETE FROM PlayerInfo;

-- 3.3 Team Info (parent of TeamPlayers, MatchHistory, TeamHistory, TeamAwards - all cleared)
-- Note: ManagerID FK to Users will be handled in Step 4
DELETE FROM TeamInfo;

-- ============================================================
-- STEP 4: Delete Users (root of hierarchy)
-- ============================================================

-- 4.1 Delete all users (preserving none since all are synthetic)
DELETE FROM Users;

-- ============================================================
-- STEP 5: Reset auto-increment counters (optional but recommended)
-- ============================================================

ALTER TABLE Users AUTO_INCREMENT = 1;
ALTER TABLE TeamInfo AUTO_INCREMENT = 1;
ALTER TABLE PlayerInfo AUTO_INCREMENT = 1;
ALTER TABLE MatchInfo AUTO_INCREMENT = 1;
ALTER TABLE MatchHistory AUTO_INCREMENT = 1;
ALTER TABLE PlayerHistory AUTO_INCREMENT = 1;
ALTER TABLE TeamHistory AUTO_INCREMENT = 1;
ALTER TABLE TeamAwards AUTO_INCREMENT = 1;
ALTER TABLE PlayerAwards AUTO_INCREMENT = 1;
ALTER TABLE TeamPlayers AUTO_INCREMENT = 1;

-- Confirm all tables are empty
SELECT 'Users' as TableName, COUNT(*) as RowCount FROM Users
UNION ALL SELECT 'TeamInfo', COUNT(*) FROM TeamInfo
UNION ALL SELECT 'PlayerInfo', COUNT(*) FROM PlayerInfo
UNION ALL SELECT 'MatchInfo', COUNT(*) FROM MatchInfo
UNION ALL SELECT 'MatchHistory', COUNT(*) FROM MatchHistory
UNION ALL SELECT 'TeamPlayers', COUNT(*) FROM TeamPlayers
UNION ALL SELECT 'PlayerHistory', COUNT(*) FROM PlayerHistory
UNION ALL SELECT 'TeamHistory', COUNT(*) FROM TeamHistory
UNION ALL SELECT 'TeamAwards', COUNT(*) FROM TeamAwards
UNION ALL SELECT 'PlayerAwards', COUNT(*) FROM PlayerAwards
UNION ALL SELECT 'Stage_WC_Matches', COUNT(*) FROM Stage_WC_Matches; -- Should still have data

-- Check what you actually have
SELECT 
    COUNT(DISTINCT home_team) as unique_home_teams,
    COUNT(DISTINCT away_team) as unique_away_teams,
    MIN(year) as earliest_wc,
    MAX(year) as latest_wc,
    COUNT(DISTINCT year) as total_tournaments
FROM Stage_WC_Matches;

-- Preview sample matches
SELECT home_team, away_team, home_score, away_score, year, Round, match_date
FROM Stage_WC_Matches 
WHERE year = 2022
LIMIT 5;


DELIMITER //

CREATE PROCEDURE ImportWorldCupData_V2()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    START TRANSACTION;

    -- 1. Default Manager for historical data
    INSERT IGNORE INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole)
    VALUES (999, 'fifa_admin', 'historical_pwd', 'FIFA', 'Archive', 'Manager');

    -- 2. Insert all unique teams from WC history
    INSERT IGNORE INTO TeamInfo (TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID)
    SELECT TeamName, TeamName, 0, 0, 0, 0, 0, 999
    FROM (
        SELECT DISTINCT home_team AS TeamName FROM Stage_WC_Matches
        UNION
        SELECT DISTINCT away_team AS TeamName FROM Stage_WC_Matches
    ) AS UniqueTeams;

    -- 3. Insert matches
    INSERT INTO MatchInfo (MatchName, Venue, MatchDate)
    SELECT CONCAT(home_team, ' vs ', away_team), stadium, match_date
    FROM Stage_WC_Matches;

    -- 4. Populate MatchHistory with scores
    INSERT INTO MatchHistory (MatchID, TeamID, PlayedAgainst, MatchResult)
    SELECT 
        m.MatchID, 
        t1.TeamID, 
        t2.TeamID, 
        CONCAT(s.home_score, '-', s.away_score, ' - ',
            CASE 
                WHEN s.home_score > s.away_score THEN 'Win'
                WHEN s.home_score < s.away_score THEN 'Loss'
                ELSE 'Draw'
            END
        )
    FROM Stage_WC_Matches s
    JOIN MatchInfo m ON m.MatchName = CONCAT(s.home_team, ' vs ', s.away_team) 
        AND m.MatchDate = s.match_date
        AND m.Venue = s.stadium
    JOIN TeamInfo t1 ON s.home_team = t1.TeamName
    JOIN TeamInfo t2 ON s.away_team = t2.TeamName;

    -- 5. Update Home Team Stats (with W/L/T breakdown)
    UPDATE TeamInfo t
    INNER JOIN (
        SELECT 
            home_team, 
            COUNT(*) as games, 
            SUM(home_score) as goals,
            SUM(CASE WHEN home_score > away_score THEN 1 ELSE 0 END) as wins,
            SUM(CASE WHEN home_score < away_score THEN 1 ELSE 0 END) as losses,
            SUM(CASE WHEN home_score = away_score THEN 1 ELSE 0 END) as ties
        FROM Stage_WC_Matches 
        GROUP BY home_team
    ) src ON t.TeamName = src.home_team
    SET 
        t.NumOfMatchesPlayed = t.NumOfMatchesPlayed + src.games,
        t.TotalGoalsScored = t.TotalGoalsScored + src.goals,
        t.MatchesWon = t.MatchesWon + src.wins,
        t.MatchesLost = t.MatchesLost + src.losses,
        t.MatchesTie = t.MatchesTie + src.ties;

    -- 6. Update Away Team Stats (mirror)
    UPDATE TeamInfo t
    INNER JOIN (
        SELECT 
            away_team, 
            COUNT(*) as games, 
            SUM(away_score) as goals,
            SUM(CASE WHEN away_score > home_score THEN 1 ELSE 0 END) as wins,
            SUM(CASE WHEN away_score < home_score THEN 1 ELSE 0 END) as losses,
            SUM(CASE WHEN away_score = home_score THEN 1 ELSE 0 END) as ties
        FROM Stage_WC_Matches 
        GROUP BY away_team
    ) src ON t.TeamName = src.away_team
    SET 
        t.NumOfMatchesPlayed = t.NumOfMatchesPlayed + src.games,
        t.TotalGoalsScored = t.TotalGoalsScored + src.goals,
        t.MatchesWon = t.MatchesWon + src.wins,
        t.MatchesLost = t.MatchesLost + src.losses,
        t.MatchesTie = t.MatchesTie + src.ties;

    COMMIT;
END //

DELIMITER ;

CALL ImportWorldCupData_V2();

-- Check team count (should be ~80-100)
SELECT COUNT(*) as total_teams FROM TeamInfo;

-- Check match count (should be 964)
SELECT COUNT(*) as total_matches FROM MatchInfo;

-- Sample team statistics
SELECT TeamName, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored
FROM TeamInfo 
WHERE TeamName IN ('Brazil', 'Germany', 'Argentina', 'Italy', 'France')
ORDER BY NumOfMatchesPlayed DESC;

-- Verify match results look correct
SELECT mh.MatchResult, mi.MatchName, mi.MatchDate
FROM MatchHistory mh
JOIN MatchInfo mi ON mh.MatchID = mi.MatchID
WHERE mi.MatchDate LIKE '%2022%'
LIMIT 10;

-- Check if Germany is split
SELECT TeamName, NumOfMatchesPlayed 
FROM TeamInfo 
WHERE TeamName LIKE '%Germany%' 
   OR TeamName LIKE '%West Germany%'
   OR TeamName LIKE '%East Germany%';

-- Step 1: Merge West Germany into Germany
UPDATE TeamInfo 
SET 
    NumOfMatchesPlayed = NumOfMatchesPlayed + 
        (SELECT NumOfMatchesPlayed FROM TeamInfo WHERE TeamName = 'West Germany'),
    MatchesWon = MatchesWon + 
        (SELECT MatchesWon FROM TeamInfo WHERE TeamName = 'West Germany'),
    MatchesLost = MatchesLost + 
        (SELECT MatchesLost FROM TeamInfo WHERE TeamName = 'West Germany'),
    MatchesTie = MatchesTie + 
        (SELECT MatchesTie FROM TeamInfo WHERE TeamName = 'West Germany'),
    TotalGoalsScored = TotalGoalsScored + 
        (SELECT TotalGoalsScored FROM TeamInfo WHERE TeamName = 'West Germany')
WHERE TeamName = 'Germany';

-- Step 2: Merge East Germany (Germany DR) into Germany
UPDATE TeamInfo 
SET 
    NumOfMatchesPlayed = NumOfMatchesPlayed + 
        (SELECT NumOfMatchesPlayed FROM TeamInfo WHERE TeamName = 'Germany DR'),
    MatchesWon = MatchesWon + 
        (SELECT MatchesWon FROM TeamInfo WHERE TeamName = 'Germany DR'),
    MatchesLost = MatchesLost + 
        (SELECT MatchesLost FROM TeamInfo WHERE TeamName = 'Germany DR'),
    MatchesTie = MatchesTie + 
        (SELECT MatchesTie FROM TeamInfo WHERE TeamName = 'Germany DR'),
    TotalGoalsScored = TotalGoalsScored + 
        (SELECT TotalGoalsScored FROM TeamInfo WHERE TeamName = 'Germany DR')
WHERE TeamName = 'Germany';

-- Step 3: Delete the now-redundant entries
DELETE FROM TeamInfo WHERE TeamName IN ('West Germany', 'Germany DR');

-- Step 4: Verify
SELECT TeamName, NumOfMatchesPlayed, MatchesWon, TotalGoalsScored
FROM TeamInfo 
WHERE TeamName = 'Germany';

/* 18:28:27	UPDATE TeamInfo  SET      NumOfMatchesPlayed = NumOfMatchesPlayed +          (SELECT NumOfMatchesPlayed FROM TeamInfo WHERE TeamName = 'West Germany'),     MatchesWon = MatchesWon +          (SELECT MatchesWon FROM TeamInfo WHERE TeamName = 'West Germany'),     MatchesLost = MatchesLost +          (SELECT MatchesLost FROM TeamInfo WHERE TeamName = 'West Germany'),     MatchesTie = MatchesTie +          (SELECT MatchesTie FROM TeamInfo WHERE TeamName = 'West Germany'),     TotalGoalsScored = TotalGoalsScored +          (SELECT TotalGoalsScored FROM TeamInfo WHERE TeamName = 'West Germany') WHERE TeamName = 'Germany'	Error Code: 1093. You can't specify target table 'TeamInfo' for update in FROM clause	0.063 sec


18:28:27	UPDATE TeamInfo  SET      NumOfMatchesPlayed = NumOfMatchesPlayed +          (SELECT NumOfMatchesPlayed FROM TeamInfo WHERE TeamName = 'Germany DR'),     MatchesWon = MatchesWon +          (SELECT MatchesWon FROM TeamInfo WHERE TeamName = 'Germany DR'),     MatchesLost = MatchesLost +          (SELECT MatchesLost FROM TeamInfo WHERE TeamName = 'Germany DR'),     MatchesTie = MatchesTie +          (SELECT MatchesTie FROM TeamInfo WHERE TeamName = 'Germany DR'),     TotalGoalsScored = TotalGoalsScored +          (SELECT TotalGoalsScored FROM TeamInfo WHERE TeamName = 'Germany DR') WHERE TeamName = 'Germany'	Error Code: 1093. You can't specify target table 'TeamInfo' for update in FROM clause	0.000 sec


18:28:27	DELETE FROM TeamInfo WHERE TeamName IN ('West Germany', 'Germany DR')	Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`sportsdb`.`matchhistory`, CONSTRAINT `FK_PlayedAgainst` FOREIGN KEY (`PlayedAgainst`) REFERENCES `teaminfo` (`TeamID`))	0.031 sec

18:28:27	SELECT TeamName, NumOfMatchesPlayed, MatchesWon, TotalGoalsScored FROM TeamInfo  WHERE TeamName = 'Germany' LIMIT 0, 1000	1 row(s) returned	0.000 sec / 0.000 sec

I got these errors and this output:
Germany	56	37	126
*/

-- Step 1: Get West Germany stats into variables
SET @wg_matches = (SELECT NumOfMatchesPlayed FROM TeamInfo WHERE TeamName = 'West Germany');
SET @wg_wins = (SELECT MatchesWon FROM TeamInfo WHERE TeamName = 'West Germany');
SET @wg_losses = (SELECT MatchesLost FROM TeamInfo WHERE TeamName = 'West Germany');
SET @wg_ties = (SELECT MatchesTie FROM TeamInfo WHERE TeamName = 'West Germany');
SET @wg_goals = (SELECT TotalGoalsScored FROM TeamInfo WHERE TeamName = 'West Germany');

-- Step 2: Get Germany DR stats into variables
SET @gdr_matches = (SELECT NumOfMatchesPlayed FROM TeamInfo WHERE TeamName = 'Germany DR');
SET @gdr_wins = (SELECT MatchesWon FROM TeamInfo WHERE TeamName = 'Germany DR');
SET @gdr_losses = (SELECT MatchesLost FROM TeamInfo WHERE TeamName = 'Germany DR');
SET @gdr_ties = (SELECT MatchesTie FROM TeamInfo WHERE TeamName = 'Germany DR');
SET @gdr_goals = (SELECT TotalGoalsScored FROM TeamInfo WHERE TeamName = 'Germany DR');

-- Step 3: Merge West Germany into Germany
UPDATE TeamInfo 
SET 
    NumOfMatchesPlayed = NumOfMatchesPlayed + @wg_matches,
    MatchesWon = MatchesWon + @wg_wins,
    MatchesLost = MatchesLost + @wg_losses,
    MatchesTie = MatchesTie + @wg_ties,
    TotalGoalsScored = TotalGoalsScored + @wg_goals
WHERE TeamName = 'Germany';

-- Step 4: Merge Germany DR into Germany
UPDATE TeamInfo 
SET 
    NumOfMatchesPlayed = NumOfMatchesPlayed + @gdr_matches,
    MatchesWon = MatchesWon + @gdr_wins,
    MatchesLost = MatchesLost + @gdr_losses,
    MatchesTie = MatchesTie + @gdr_ties,
    TotalGoalsScored = TotalGoalsScored + @gdr_goals
WHERE TeamName = 'Germany';

-- Step 5: Update MatchHistory to point Germany references to main Germany entry
-- First, get the TeamIDs
SET @germany_id = (SELECT TeamID FROM TeamInfo WHERE TeamName = 'Germany');
SET @wg_id = (SELECT TeamID FROM TeamInfo WHERE TeamName = 'West Germany');
SET @gdr_id = (SELECT TeamID FROM TeamInfo WHERE TeamName = 'Germany DR');

-- Update MatchHistory where West Germany/Germany DR is the main team
UPDATE MatchHistory SET TeamID = @germany_id WHERE TeamID IN (@wg_id, @gdr_id);

-- Update MatchHistory where West Germany/Germany DR is the opponent
UPDATE MatchHistory SET PlayedAgainst = @germany_id WHERE PlayedAgainst IN (@wg_id, @gdr_id);

-- Step 6: Now safe to delete the merged teams
DELETE FROM TeamInfo WHERE TeamName IN ('West Germany', 'Germany DR');

-- Step 7: Verify
SELECT TeamName, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored
FROM TeamInfo 
WHERE TeamName = 'Germany';

-- Post Merge Verification Query
-- Top 5 all-time by matches played
SELECT TeamName, NumOfMatchesPlayed, MatchesWon,
       ROUND(MatchesWon*100.0/NumOfMatchesPlayed, 1) as WinPct
FROM TeamInfo 
ORDER BY NumOfMatchesPlayed DESC
LIMIT 5;

-- Check if any other split nations exist
SELECT TeamName, NumOfMatchesPlayed 
FROM TeamInfo 
WHERE TeamName LIKE '%Yugoslavia%' 
   OR TeamName LIKE '%Soviet%'
   OR TeamName LIKE '%Czech%'
   OR TeamName LIKE '%Russia%'
ORDER BY TeamName;

-- Compare with official FIFA all-time table (should match closely)
SELECT 
    TeamName,
    NumOfMatchesPlayed as P,
    MatchesWon as W,
    MatchesTie as D,
    MatchesLost as L,
    TotalGoalsScored as GF
FROM TeamInfo 
WHERE NumOfMatchesPlayed > 50
ORDER BY NumOfMatchesPlayed DESC
LIMIT 10;

select * from playerawards; --
select * from playerhistory; --
select * from playerinfo; --
select * from matchhistory; --
select * from matchinfo; --
select * from teamawards; --
select * from teamhistory; --
select * from teaminfo; --
select * from teamplayers; --

Truncate table matchinfo;
truncate table teaminfo;

SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE PlayerAwards;
TRUNCATE TABLE TeamAwards;

TRUNCATE TABLE PlayerHistory;
TRUNCATE TABLE TeamHistory;

TRUNCATE TABLE TeamPlayers;

TRUNCATE TABLE MatchHistory;

TRUNCATE TABLE MatchInfo;
TRUNCATE TABLE TeamInfo;

-- Optional: also reset staging if you want a full reload
-- TRUNCATE TABLE Stage_WC_Matches;

SET FOREIGN_KEY_CHECKS = 1;

-- Real Data insertion for Team Info Table 
INSERT INTO TeamInfo
(TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID)
SELECT DISTINCT s.home_team, s.home_team, 0, 0, 0, 0, 0, NULL
FROM Stage_WC_Matches s
LEFT JOIN TeamInfo t ON t.TeamName = s.home_team
WHERE s.home_team IS NOT NULL AND s.home_team <> ''
  AND t.TeamName IS NULL

UNION

SELECT DISTINCT s.away_team, s.away_team, 0, 0, 0, 0, 0, NULL
FROM Stage_WC_Matches s
LEFT JOIN TeamInfo t ON t.TeamName = s.away_team
WHERE s.away_team IS NOT NULL AND s.away_team <> ''
  AND t.TeamName IS NULL;

-- Real Data Insertion for MatchInfo Table
INSERT INTO MatchInfo (MatchName, Venue, MatchDate)
SELECT 
CONCAT(home_team,' vs ',away_team,' - ',year),
COALESCE(stadium,'Unknown'),
match_date
FROM Stage_WC_Matches;

-- Real Data Insertion for Match History table

-- Home Team Result
INSERT INTO MatchHistory (MatchID, TeamID, PlayedAgainst, MatchResult)
SELECT 
m.MatchID,
t1.TeamID,
t2.TeamID,
CASE
 WHEN s.home_score > s.away_score THEN 'Won'
 WHEN s.home_score < s.away_score THEN 'Lost'
 ELSE 'Tie'
END
FROM Stage_WC_Matches s
JOIN MatchInfo m 
 ON m.MatchDate = s.match_date
JOIN TeamInfo t1 ON t1.TeamName = s.home_team
JOIN TeamInfo t2 ON t2.TeamName = s.away_team;

-- Away Team Result
INSERT INTO MatchHistory (MatchID, TeamID, PlayedAgainst, MatchResult)
SELECT 
m.MatchID,
t2.TeamID,
t1.TeamID,
CASE
 WHEN s.away_score > s.home_score THEN 'Won'
 WHEN s.away_score < s.home_score THEN 'Lost'
 ELSE 'Tie'
END
FROM Stage_WC_Matches s
JOIN MatchInfo m 
 ON m.MatchDate = s.match_date
JOIN TeamInfo t1 ON t1.TeamName = s.home_team
JOIN TeamInfo t2 ON t2.TeamName = s.away_team;

-- Updating Team Info Stats

-- Matches played / wins / losses / ties
UPDATE TeamInfo t
JOIN (
    SELECT 
        TeamID,
        COUNT(*) AS NumOfMatchesPlayed,
        SUM(MatchResult = 'Won')  AS MatchesWon,
        SUM(MatchResult = 'Lost') AS MatchesLost,
        SUM(MatchResult = 'Tie')  AS MatchesTie
    FROM MatchHistory
    GROUP BY TeamID
) x 
ON x.TeamID = t.TeamID
SET 
    t.NumOfMatchesPlayed = x.NumOfMatchesPlayed,
    t.MatchesWon = x.MatchesWon,
    t.MatchesLost = x.MatchesLost,
    t.MatchesTie = x.MatchesTie;

-- Goals Scored
UPDATE TeamInfo t
JOIN (
 SELECT TeamName, SUM(goals) TotalGoals
 FROM (
  SELECT home_team TeamName, SUM(home_score) goals
  FROM Stage_WC_Matches
  GROUP BY home_team

  UNION ALL

  SELECT away_team TeamName, SUM(away_score) goals
  FROM Stage_WC_Matches
  GROUP BY away_team
 ) g
 GROUP BY TeamName
) s ON s.TeamName = t.TeamName
SET t.TotalGoalsScored = s.TotalGoals;

-- Real Data Insertion for Match History Table
INSERT INTO TeamHistory
(MatchID, TeamID, PlayedAgainst, MatchDate, GoalsScored)

SELECT
m.MatchID,
t1.TeamID,
t2.TeamID,
s.match_date,
s.home_score
FROM Stage_WC_Matches s
JOIN MatchInfo m ON m.MatchDate = s.match_date
JOIN TeamInfo t1 ON t1.TeamName = s.home_team
JOIN TeamInfo t2 ON t2.TeamName = s.away_team;

-- Away Team Perspective Insertion in Match History Table
INSERT INTO TeamHistory
(MatchID, TeamID, PlayedAgainst, MatchDate, GoalsScored)

SELECT
m.MatchID,
t2.TeamID,
t1.TeamID,
s.match_date,
s.away_score
FROM Stage_WC_Matches s
JOIN MatchInfo m ON m.MatchDate = s.match_date
JOIN TeamInfo t1 ON t1.TeamName = s.home_team
JOIN TeamInfo t2 ON t2.TeamName = s.away_team;

SELECT COUNT(*) FROM TeamInfo;
SELECT COUNT(*) FROM MatchInfo;
SELECT COUNT(*) FROM MatchHistory;
SELECT COUNT(*) FROM Users;

describe playerinfo;
describe playerhistory;

-- Staging Remaining Tables

DROP TABLE IF EXISTS Stage_FJ_Players;
CREATE TABLE Stage_FJ_Players (
  key_id VARCHAR(50),
  player_id VARCHAR(50),
  family_name VARCHAR(150),
  given_name VARCHAR(150),
  birth_date DATE NULL,
  female TINYINT NULL,
  goal_keeper TINYINT NULL,
  defender TINYINT NULL,
  midfielder TINYINT NULL,
  forward TINYINT NULL,
  count_tournaments INT NULL,
  list_tournaments TEXT,
  player_wikipedia_link TEXT
);

DROP TABLE IF EXISTS Stage_FJ_Squads;
CREATE TABLE Stage_FJ_Squads (
  key_id VARCHAR(50),
  tournament_id VARCHAR(50),
  tournament_name VARCHAR(150),
  team_id VARCHAR(50),
  team_name VARCHAR(150),
  team_code VARCHAR(20),
  player_id VARCHAR(50),
  family_name VARCHAR(150),
  given_name VARCHAR(150),
  shirt_number INT NULL,
  position_name VARCHAR(100),
  position_code VARCHAR(20)
);

DROP TABLE IF EXISTS Stage_FJ_Matches;
CREATE TABLE Stage_FJ_Matches (
  key_id VARCHAR(50),
  tournament_id VARCHAR(50),
  tournament_name VARCHAR(150),
  match_id VARCHAR(50),
  match_name VARCHAR(200),
  stage_name VARCHAR(100),
  group_name VARCHAR(100),
  group_stage TINYINT NULL,
  knockout_stage TINYINT NULL,
  replayed TINYINT NULL,
  replay TINYINT NULL,
  match_date DATE NULL,
  match_time VARCHAR(20),
  stadium_id VARCHAR(50),
  stadium_name VARCHAR(150),
  city_name VARCHAR(100),
  country_name VARCHAR(100),
  home_team_id VARCHAR(50),
  home_team_name VARCHAR(150),
  home_team_code VARCHAR(20),
  away_team_id VARCHAR(50),
  away_team_name VARCHAR(150),
  away_team_code VARCHAR(20),
  score VARCHAR(50),
  home_team_score INT NULL,
  away_team_score INT NULL,
  home_team_score_margin INT NULL,
  away_team_score_margin INT NULL,
  extra_time TINYINT NULL,
  penalty_shootout TINYINT NULL,
  score_penalties VARCHAR(50),
  home_team_score_penalties INT NULL,
  away_team_score_penalties INT NULL,
  result VARCHAR(20),
  home_team_win TINYINT NULL,
  away_team_win TINYINT NULL,
  draw TINYINT NULL
);

DROP TABLE IF EXISTS Stage_FJ_Goals;
CREATE TABLE Stage_FJ_Goals (
  key_id VARCHAR(50),
  goal_id VARCHAR(50),
  tournament_id VARCHAR(50),
  tournament_name VARCHAR(150),
  match_id VARCHAR(50),
  match_name VARCHAR(200),
  match_date DATE NULL,
  stage_name VARCHAR(100),
  group_name VARCHAR(100),
  team_id VARCHAR(50),
  team_name VARCHAR(150),
  team_code VARCHAR(20),
  home_team VARCHAR(150),
  away_team VARCHAR(150),
  player_id VARCHAR(50),
  family_name VARCHAR(150),
  given_name VARCHAR(150),
  shirt_number INT NULL,
  player_team_id VARCHAR(50),
  player_team_name VARCHAR(150),
  player_team_code VARCHAR(20),
  minute_label VARCHAR(20),
  minute_regulation INT NULL,
  minute_stoppage INT NULL,
  match_period VARCHAR(30),
  own_goal TINYINT NULL,
  penalty TINYINT NULL
);

DROP TABLE IF EXISTS Stage_FJ_AwardWinners;
CREATE TABLE Stage_FJ_AwardWinners (
  key_id VARCHAR(50),
  tournament_id VARCHAR(50),
  tournament_name VARCHAR(150),
  award_id VARCHAR(50),
  award_name VARCHAR(150),
  shared TINYINT NULL,
  player_id VARCHAR(50),
  family_name VARCHAR(150),
  given_name VARCHAR(150),
  team_id VARCHAR(50),
  team_name VARCHAR(150),
  team_code VARCHAR(20)
);

DROP TABLE IF EXISTS Stage_FJ_Tournaments;
CREATE TABLE Stage_FJ_Tournaments (
  key_id VARCHAR(50),
  tournament_id VARCHAR(50),
  tournament_name VARCHAR(150),
  year INT NULL,
  start_date DATE NULL,
  end_date DATE NULL,
  host_country VARCHAR(100),
  winner VARCHAR(150),
  host_won TINYINT NULL,
  count_teams INT NULL,
  group_stage TINYINT NULL,
  second_group_stage TINYINT NULL,
  final_round TINYINT NULL,
  round_of_16 TINYINT NULL,
  quarter_finals TINYINT NULL,
  semi_finals TINYINT NULL,
  third_place_match TINYINT NULL,
  final TINYINT NULL
);

DROP TABLE IF EXISTS Stage_FJ_TournamentStandings;
CREATE TABLE Stage_FJ_TournamentStandings (
  key_id VARCHAR(50),
  tournament_id VARCHAR(50),
  tournament_name VARCHAR(150),
  position INT NULL,
  team_id VARCHAR(50),
  team_name VARCHAR(150),
  team_code VARCHAR(20)
);

-- Extracting Data using LOAD DATA LOCAL INFILE Statements
-- Datasets are also present in this location: C:\Dev\SportsAnalytics\Backend\Database\Dataset

SET GLOBAL local_infile = 1;

-- Data from players.csv
LOAD DATA LOCAL INFILE 'C:/Dev/FIFA_WC/players.csv'
INTO TABLE Stage_FJ_Players
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
  @key_id, @player_id, @family_name, @given_name, @birth_date, @female,
  @goal_keeper, @defender, @midfielder, @forward, @count_tournaments,
  @list_tournaments, @player_wikipedia_link
)
SET
  key_id = TRIM(@key_id),
  player_id = TRIM(@player_id),
  family_name = NULLIF(TRIM(@family_name), ''),
  given_name = NULLIF(TRIM(@given_name), ''),
  birth_date = NULLIF(TRIM(@birth_date), ''),
  female = NULLIF(TRIM(@female), ''),
  goal_keeper = NULLIF(TRIM(@goal_keeper), ''),
  defender = NULLIF(TRIM(@defender), ''),
  midfielder = NULLIF(TRIM(@midfielder), ''),
  forward = NULLIF(TRIM(@forward), ''),
  count_tournaments = NULLIF(TRIM(@count_tournaments), ''),
  list_tournaments = NULLIF(TRIM(@list_tournaments), ''),
  player_wikipedia_link = NULLIF(TRIM(@player_wikipedia_link), '');

-- Data from squads.csv
LOAD DATA LOCAL INFILE 'C:/Dev/FIFA_WC/squads.csv'
INTO TABLE Stage_FJ_Squads
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
  @key_id, @tournament_id, @tournament_name, @team_id, @team_name, @team_code,
  @player_id, @family_name, @given_name, @shirt_number, @position_name, @position_code
)
SET
  key_id = TRIM(@key_id),
  tournament_id = TRIM(@tournament_id),
  tournament_name = NULLIF(TRIM(@tournament_name), ''),
  team_id = TRIM(@team_id),
  team_name = NULLIF(TRIM(@team_name), ''),
  team_code = NULLIF(TRIM(TRAILING '.' FROM @team_code), ''),
  player_id = TRIM(@player_id),
  family_name = NULLIF(TRIM(@family_name), ''),
  given_name = NULLIF(TRIM(@given_name), ''),
  shirt_number = NULLIF(TRIM(@shirt_number), ''),
  position_name = NULLIF(TRIM(@position_name), ''),
  position_code = NULLIF(TRIM(TRAILING '.' FROM @position_code), '');

-- Data from matches.csv
LOAD DATA LOCAL INFILE 'C:/Dev/FIFA_WC/matches.csv'
INTO TABLE Stage_FJ_Matches
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
  @key_id, @tournament_id, @tournament_name, @match_id, @match_name, @stage_name,
  @group_name, @group_stage, @knockout_stage, @replayed, @replay, @match_date,
  @match_time, @stadium_id, @stadium_name, @city_name, @country_name,
  @home_team_id, @home_team_name, @home_team_code, @away_team_id, @away_team_name,
  @away_team_code, @score, @home_team_score, @away_team_score,
  @home_team_score_margin, @away_team_score_margin, @extra_time, @penalty_shootout,
  @score_penalties, @home_team_score_penalties, @away_team_score_penalties,
  @result, @home_team_win, @away_team_win, @draw
)
SET
  key_id = TRIM(@key_id),
  tournament_id = TRIM(@tournament_id),
  tournament_name = NULLIF(TRIM(@tournament_name), ''),
  match_id = TRIM(@match_id),
  match_name = NULLIF(TRIM(@match_name), ''),
  stage_name = NULLIF(TRIM(@stage_name), ''),
  group_name = NULLIF(TRIM(@group_name), ''),
  group_stage = NULLIF(TRIM(@group_stage), ''),
  knockout_stage = NULLIF(TRIM(@knockout_stage), ''),
  replayed = NULLIF(TRIM(@replayed), ''),
  replay = NULLIF(TRIM(@replay), ''),
  match_date = NULLIF(TRIM(@match_date), ''),
  match_time = NULLIF(TRIM(@match_time), ''),
  stadium_id = NULLIF(TRIM(@stadium_id), ''),
  stadium_name = NULLIF(TRIM(@stadium_name), ''),
  city_name = NULLIF(TRIM(@city_name), ''),
  country_name = NULLIF(TRIM(@country_name), ''),
  home_team_id = NULLIF(TRIM(@home_team_id), ''),
  home_team_name = NULLIF(TRIM(@home_team_name), ''),
  home_team_code = NULLIF(TRIM(@home_team_code), ''),
  away_team_id = NULLIF(TRIM(@away_team_id), ''),
  away_team_name = NULLIF(TRIM(@away_team_name), ''),
  away_team_code = NULLIF(TRIM(@away_team_code), ''),
  score = NULLIF(TRIM(@score), ''),
  home_team_score = NULLIF(TRIM(@home_team_score), ''),
  away_team_score = NULLIF(TRIM(@away_team_score), ''),
  home_team_score_margin = NULLIF(TRIM(@home_team_score_margin), ''),
  away_team_score_margin = NULLIF(TRIM(@away_team_score_margin), ''),
  extra_time = NULLIF(TRIM(@extra_time), ''),
  penalty_shootout = NULLIF(TRIM(@penalty_shootout), ''),
  score_penalties = NULLIF(TRIM(@score_penalties), ''),
  home_team_score_penalties = NULLIF(TRIM(@home_team_score_penalties), ''),
  away_team_score_penalties = NULLIF(TRIM(@away_team_score_penalties), ''),
  result = NULLIF(TRIM(@result), ''),
  home_team_win = NULLIF(TRIM(@home_team_win), ''),
  away_team_win = NULLIF(TRIM(@away_team_win), ''),
  draw = NULLIF(TRIM(TRAILING '.' FROM @draw), '');

-- Data from goals.csv
LOAD DATA LOCAL INFILE 'C:/Dev/FIFA_WC/goals.csv'
INTO TABLE Stage_FJ_Goals
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
  @key_id, @goal_id, @tournament_id, @tournament_name, @match_id, @match_name,
  @match_date, @stage_name, @group_name, @team_id, @team_name, @team_code,
  @home_team, @away_team, @player_id, @family_name, @given_name, @shirt_number,
  @player_team_id, @player_team_name, @player_team_code, @minute_label,
  @minute_regulation, @minute_stoppage, @match_period, @own_goal, @penalty
)
SET
  key_id = TRIM(@key_id),
  goal_id = TRIM(@goal_id),
  tournament_id = TRIM(@tournament_id),
  tournament_name = NULLIF(TRIM(@tournament_name), ''),
  match_id = TRIM(@match_id),
  match_name = NULLIF(TRIM(@match_name), ''),
  match_date = NULLIF(TRIM(@match_date), ''),
  stage_name = NULLIF(TRIM(@stage_name), ''),
  group_name = NULLIF(TRIM(@group_name), ''),
  team_id = NULLIF(TRIM(@team_id), ''),
  team_name = NULLIF(TRIM(@team_name), ''),
  team_code = NULLIF(TRIM(@team_code), ''),
  home_team = NULLIF(TRIM(@home_team), ''),
  away_team = NULLIF(TRIM(@away_team), ''),
  player_id = NULLIF(TRIM(@player_id), ''),
  family_name = NULLIF(TRIM(@family_name), ''),
  given_name = NULLIF(TRIM(@given_name), ''),
  shirt_number = NULLIF(TRIM(@shirt_number), ''),
  player_team_id = NULLIF(TRIM(@player_team_id), ''),
  player_team_name = NULLIF(TRIM(@player_team_name), ''),
  player_team_code = NULLIF(TRIM(@player_team_code), ''),
  minute_label = NULLIF(TRIM(@minute_label), ''),
  minute_regulation = NULLIF(TRIM(@minute_regulation), ''),
  minute_stoppage = NULLIF(TRIM(@minute_stoppage), ''),
  match_period = NULLIF(TRIM(@match_period), ''),
  own_goal = NULLIF(TRIM(@own_goal), ''),
  penalty = NULLIF(TRIM(TRAILING '.' FROM @penalty), '');

-- Data from award_winners.csv
LOAD DATA LOCAL INFILE 'C:/Dev/FIFA_WC/award_winners.csv'
INTO TABLE Stage_FJ_AwardWinners
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
  @key_id, @tournament_id, @tournament_name, @award_id, @award_name, @shared,
  @player_id, @family_name, @given_name, @team_id, @team_name, @team_code
)
SET
  key_id = TRIM(@key_id),
  tournament_id = TRIM(@tournament_id),
  tournament_name = NULLIF(TRIM(@tournament_name), ''),
  award_id = TRIM(@award_id),
  award_name = NULLIF(TRIM(@award_name), ''),
  shared = NULLIF(TRIM(@shared), ''),
  player_id = NULLIF(TRIM(@player_id), ''),
  family_name = NULLIF(TRIM(@family_name), ''),
  given_name = NULLIF(TRIM(@given_name), ''),
  team_id = NULLIF(TRIM(@team_id), ''),
  team_name = NULLIF(TRIM(@team_name), ''),
  team_code = NULLIF(TRIM(TRAILING '.' FROM @team_code), '');

-- Data from tournaments.csv
LOAD DATA LOCAL INFILE 'C:/Dev/FIFA_WC/tournaments.csv'
INTO TABLE Stage_FJ_Tournaments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
  @key_id, @tournament_id, @tournament_name, @year, @start_date, @end_date,
  @host_country, @winner, @host_won, @count_teams, @group_stage, @second_group_stage,
  @final_round, @round_of_16, @quarter_finals, @semi_finals, @third_place_match, @final
)
SET
  key_id = TRIM(@key_id),
  tournament_id = TRIM(@tournament_id),
  tournament_name = NULLIF(TRIM(@tournament_name), ''),
  year = NULLIF(TRIM(@year), ''),
  start_date = NULLIF(TRIM(@start_date), ''),
  end_date = NULLIF(TRIM(@end_date), ''),
  host_country = NULLIF(TRIM(@host_country), ''),
  winner = NULLIF(TRIM(@winner), ''),
  host_won = NULLIF(TRIM(@host_won), ''),
  count_teams = NULLIF(TRIM(@count_teams), ''),
  group_stage = NULLIF(TRIM(@group_stage), ''),
  second_group_stage = NULLIF(TRIM(@second_group_stage), ''),
  final_round = NULLIF(TRIM(@final_round), ''),
  round_of_16 = NULLIF(TRIM(@round_of_16), ''),
  quarter_finals = NULLIF(TRIM(@quarter_finals), ''),
  semi_finals = NULLIF(TRIM(@semi_finals), ''),
  third_place_match = NULLIF(TRIM(@third_place_match), ''),
  final = NULLIF(TRIM(TRAILING '.' FROM @final), '');

-- Data from tournament_standings.csv
LOAD DATA LOCAL INFILE 'C:/Dev/FIFA_WC/tournament_standings.csv'
INTO TABLE Stage_FJ_TournamentStandings
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
  @key_id, @tournament_id, @tournament_name, @position, @team_id, @team_name, @team_code
)
SET
  key_id = TRIM(@key_id),
  tournament_id = TRIM(@tournament_id),
  tournament_name = NULLIF(TRIM(@tournament_name), ''),
  position = NULLIF(TRIM(@position), ''),
  team_id = NULLIF(TRIM(@team_id), ''),
  team_name = NULLIF(TRIM(@team_name), ''),
  team_code = NULLIF(TRIM(@team_code), '');

-- Quick validation after Loading Data
SELECT COUNT(*) FROM Stage_FJ_Players;
SELECT COUNT(*) FROM Stage_FJ_Squads;
SELECT COUNT(*) FROM Stage_FJ_Matches;
SELECT COUNT(*) FROM Stage_FJ_Goals;
SELECT COUNT(*) FROM Stage_FJ_AwardWinners;
SELECT COUNT(*) FROM Stage_FJ_Tournaments;
SELECT COUNT(*) FROM Stage_FJ_TournamentStandings;

-- Inspecting few rows
SELECT * FROM Stage_FJ_Players LIMIT 5;
SELECT * FROM Stage_FJ_Squads LIMIT 5;
SELECT * FROM Stage_FJ_Matches LIMIT 5;
SELECT * FROM Stage_FJ_Goals LIMIT 5;

SHOW VARIABLES LIKE 'foreign_key_checks';

-- Playerinfo table
ALTER TABLE PlayerInfo
ADD UNIQUE (PlayerName);

-- Change PlayerName from TEXT → VARCHAR.
-- Player names do not need TEXT; VARCHAR(255) is standard.
ALTER TABLE PlayerInfo
MODIFY PlayerName VARCHAR(255);
-- Then create the unique constraint
ALTER TABLE PlayerInfo
ADD CONSTRAINT uq_player_name UNIQUE (PlayerName);

DESCRIBE PlayerInfo;

-- Change the staging column to TEXT
ALTER TABLE Stage_FJ_Players
MODIFY birth_date VARCHAR(20);

SELECT COUNT(*)
FROM Stage_FJ_Players
WHERE birth_date='0000-00-00';

ALTER TABLE PlayerInfo DROP INDEX uq_player_name;
ALTER TABLE PlayerInfo ADD COLUMN SourcePlayerID VARCHAR(50) NULL;
ALTER TABLE PlayerInfo ADD CONSTRAINT uq_player_source UNIQUE (SourcePlayerID);

-- Inserting data into playerinfo table
INSERT INTO PlayerInfo (SourcePlayerID, PlayerName, Age, DOB, Gender, TotalGoalsScored)
SELECT
  p.player_id AS SourcePlayerID,
  CASE
    WHEN LOWER(TRIM(COALESCE(p.family_name,''))) = 'not applicable'
         AND TRIM(COALESCE(p.given_name,'')) <> ''
      THEN TRIM(p.given_name)
    WHEN LOWER(TRIM(COALESCE(p.given_name,''))) = 'not applicable'
         AND TRIM(COALESCE(p.family_name,'')) <> ''
      THEN TRIM(p.family_name)
    ELSE TRIM(CONCAT(COALESCE(p.given_name,''), ' ', COALESCE(p.family_name,'')))
  END AS PlayerName,
  NULL AS Age,
  CASE
    WHEN p.birth_date = '0000-00-00' OR p.birth_date IS NULL THEN NULL
    ELSE STR_TO_DATE(p.birth_date, '%Y-%m-%d')
  END AS DOB,
  CASE WHEN COALESCE(p.female,0) = 1 THEN 'Female' ELSE 'Male' END AS Gender,
  0 AS TotalGoalsScored
FROM Stage_FJ_Players p
LEFT JOIN PlayerInfo pi
  ON pi.SourcePlayerID = p.player_id
WHERE pi.PlayerID IS NULL
  AND p.player_id IS NOT NULL
  AND TRIM(p.player_id) <> '';

-- TeamPlayers Table
-- use SourcePlayerID
INSERT INTO TeamPlayers (TeamID, PlayerID)
SELECT
  t.TeamID,
  p.PlayerID
FROM Stage_FJ_Squads s
JOIN TeamInfo t
  ON t.TeamName = s.team_name
JOIN PlayerInfo p
  ON p.SourcePlayerID = s.player_id
LEFT JOIN TeamPlayers tp
  ON tp.TeamID = t.TeamID AND tp.PlayerID = p.PlayerID
WHERE tp.TeamID IS NULL;

-- Inserting into playerhistory table
-- use player_id
-- Have to execute this. Got an error.
-- Error: 19:35:16	INSERT INTO PlayerHistory (PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) SELECT   p.PlayerID,   mm.MatchID,   t_scoring.TeamID,   t_opp.TeamID,   mm.match_date,   CASE     WHEN (g.team_name = sw.home_team AND sw.home_score > sw.away_score)       OR (g.team_name = sw.away_team AND sw.away_score > sw.home_score) THEN 'Won'     WHEN sw.home_score = sw.away_score THEN 'Tie'     ELSE 'Lost'   END AS MatchResult,   SUM(CASE WHEN g.own_goal = 1 THEN 0 ELSE 1 END) AS GoalsScored FROM Stage_FJ_Goals g JOIN Stage_Match_Map mm   ON mm.fj_match_id = g.match_id JOIN Stage_WC_Matches sw   ON sw.match_date = mm.match_date  AND sw.home_team = mm.home_team_name  AND sw.away_team = mm.away_team_name JOIN PlayerInfo p   ON p.SourcePlayerID = g.player_id JOIN TeamInfo t_scoring   ON t_scoring.TeamName = g.team_name JOIN TeamInfo t_opp   ON t_opp.TeamName = CASE     WHEN g.team_name = mm.home_team_name THEN mm.away_team_name     ELSE mm.home_team_name   END GROUP BY   p.PlayerID, mm.MatchID, t_scoring.TeamID, t_opp.TeamID, mm.match_date	Error Code: 1146. Table 'sportsdb.stage_match_map' doesn't exist	0.000 sec
 
INSERT INTO PlayerHistory
(PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored)
SELECT
  p.PlayerID,
  mm.MatchID,
  t_scoring.TeamID,
  t_opp.TeamID,
  mm.match_date,
  CASE
    WHEN (g.team_name = sw.home_team AND sw.home_score > sw.away_score)
      OR (g.team_name = sw.away_team AND sw.away_score > sw.home_score) THEN 'Won'
    WHEN sw.home_score = sw.away_score THEN 'Tie'
    ELSE 'Lost'
  END AS MatchResult,
  SUM(CASE WHEN g.own_goal = 1 THEN 0 ELSE 1 END) AS GoalsScored
FROM Stage_FJ_Goals g
JOIN Stage_Match_Map mm
  ON mm.fj_match_id = g.match_id
JOIN Stage_WC_Matches sw
  ON sw.match_date = mm.match_date
 AND sw.home_team = mm.home_team_name
 AND sw.away_team = mm.away_team_name
JOIN PlayerInfo p
  ON p.SourcePlayerID = g.player_id
JOIN TeamInfo t_scoring
  ON t_scoring.TeamName = g.team_name
JOIN TeamInfo t_opp
  ON t_opp.TeamName = CASE
    WHEN g.team_name = mm.home_team_name THEN mm.away_team_name
    ELSE mm.home_team_name
  END
GROUP BY
  p.PlayerID, mm.MatchID, t_scoring.TeamID, t_opp.TeamID, mm.match_date;

DROP TABLE IF EXISTS Stage_Match_Map;
CREATE TABLE Stage_Match_Map AS
SELECT
  fm.match_id AS fj_match_id,
  mi.MatchID,
  fm.match_date,
  fm.home_team_name,
  fm.away_team_name
FROM Stage_FJ_Matches fm
JOIN MatchInfo mi
  ON mi.MatchDate = fm.match_date
 AND mi.MatchName LIKE CONCAT(fm.home_team_name, ' vs ', fm.away_team_name, '%');

-- checking whether the data is populated or not
SELECT COUNT(*) AS mapped_matches
FROM Stage_Match_Map;

SELECT *
FROM Stage_Match_Map
LIMIT 20;


-- PlayerHistory Table 
INSERT INTO PlayerHistory
(PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored)
SELECT
  x.PlayerID,
  x.MatchID,
  x.TeamID,
  x.PlayedAgainst,
  x.MatchDate,
  CASE
    WHEN (x.TeamName = sw.home_team AND sw.home_score > sw.away_score)
      OR (x.TeamName = sw.away_team AND sw.away_score > sw.home_score) THEN 'Won'
    WHEN sw.home_score = sw.away_score THEN 'Tie'
    ELSE 'Lost'
  END AS MatchResult,
  x.GoalsScored
FROM (
    SELECT
      p.PlayerID,
      mm.MatchID,
      t_scoring.TeamID,
      t_opp.TeamID AS PlayedAgainst,
      mm.match_date AS MatchDate,
      g.team_name AS TeamName,
      CASE
        WHEN g.team_name = mm.home_team_name THEN mm.away_team_name
        ELSE mm.home_team_name
      END AS OpponentName,
      SUM(CASE WHEN g.own_goal = 1 THEN 0 ELSE 1 END) AS GoalsScored
    FROM Stage_FJ_Goals g
    JOIN Stage_Match_Map mm
      ON mm.fj_match_id = g.match_id
    JOIN PlayerInfo p
      ON p.SourcePlayerID = g.player_id
    JOIN TeamInfo t_scoring
      ON t_scoring.TeamName = g.team_name
    JOIN TeamInfo t_opp
      ON t_opp.TeamName = CASE
        WHEN g.team_name = mm.home_team_name THEN mm.away_team_name
        ELSE mm.home_team_name
      END
    LEFT JOIN PlayerHistory ph
      ON ph.PlayerID = p.PlayerID
     AND ph.MatchID = mm.MatchID
     AND ph.TeamID = t_scoring.TeamID
    WHERE ph.PlayerID IS NULL
    GROUP BY
      p.PlayerID,
      mm.MatchID,
      t_scoring.TeamID,
      t_opp.TeamID,
      mm.match_date,
      g.team_name,
      CASE
        WHEN g.team_name = mm.home_team_name THEN mm.away_team_name
        ELSE mm.home_team_name
      END
) x
JOIN Stage_WC_Matches sw
  ON sw.match_date = x.MatchDate
 AND sw.home_team = CASE WHEN x.TeamName = sw.home_team THEN x.TeamName ELSE x.OpponentName END
 AND sw.away_team = CASE WHEN x.TeamName = sw.home_team THEN x.OpponentName ELSE x.TeamName END;

SELECT COUNT(*) AS playerhistory_rows FROM PlayerHistory;
SELECT * FROM PlayerHistory LIMIT 20;

-- Updating total goals in PlayerInfo
UPDATE PlayerInfo p
JOIN (
  SELECT PlayerID, SUM(GoalsScored) AS TotalGoals
  FROM PlayerHistory
  GROUP BY PlayerID
) x
  ON x.PlayerID = p.PlayerID
SET p.TotalGoalsScored = x.TotalGoals;

-- Verifying
SELECT PlayerName, TotalGoalsScored
FROM PlayerInfo
ORDER BY TotalGoalsScored DESC, PlayerName
LIMIT 20;

-- Populating teamplayers table
INSERT INTO TeamPlayers (TeamID, PlayerID)
SELECT
  t.TeamID,
  p.PlayerID
FROM Stage_FJ_Squads s
JOIN TeamInfo t
  ON t.TeamName = s.team_name
JOIN PlayerInfo p
  ON p.SourcePlayerID = s.player_id
LEFT JOIN TeamPlayers tp
  ON tp.TeamID = t.TeamID
 AND tp.PlayerID = p.PlayerID
WHERE tp.TeamID IS NULL;

-- Verifying
SELECT COUNT(*) AS teamplayers_rows FROM TeamPlayers;
SELECT * FROM TeamPlayers LIMIT 20;

-- Inserting Data into playerawards table
INSERT INTO PlayerAwards (MatchID, PlayerID, TeamID, AwardName, DateofAward)
SELECT
  NULL,
  p.PlayerID,
  t.TeamID,
  aw.award_name,
  tr.end_date
FROM Stage_FJ_AwardWinners aw
JOIN Stage_FJ_Tournaments tr
  ON tr.tournament_id = aw.tournament_id
JOIN PlayerInfo p
  ON p.SourcePlayerID = aw.player_id
JOIN TeamInfo t
  ON t.TeamName = aw.team_name
LEFT JOIN PlayerAwards pa
  ON pa.PlayerID = p.PlayerID
 AND pa.TeamID = t.TeamID
 AND pa.AwardName = aw.award_name
 AND pa.DateofAward = tr.end_date
WHERE pa.PlayerID IS NULL;

-- Verifying
SELECT COUNT(*) AS playerawards_rows FROM PlayerAwards;
SELECT * FROM PlayerAwards LIMIT 20;

-- Inserting Data into TeamAwards table
INSERT INTO TeamAwards (TeamID, MatchID, PlayerID, AwardName, DateofAward)
SELECT
  t.TeamID,
  NULL,
  NULL,
  CASE
    WHEN s.position = 1 THEN 'World Cup Champion'
    WHEN s.position = 2 THEN 'World Cup Runner-up'
    WHEN s.position = 3 THEN 'World Cup Third Place'
  END,
  tr.end_date
FROM Stage_FJ_TournamentStandings s
JOIN Stage_FJ_Tournaments tr
  ON tr.tournament_id = s.tournament_id
JOIN TeamInfo t
  ON t.TeamName = s.team_name
LEFT JOIN TeamAwards ta
  ON ta.TeamID = t.TeamID
 AND ta.AwardName = CASE
    WHEN s.position = 1 THEN 'World Cup Champion'
    WHEN s.position = 2 THEN 'World Cup Runner-up'
    WHEN s.position = 3 THEN 'World Cup Third Place'
  END
 AND ta.DateofAward = tr.end_date
WHERE s.position IN (1,2,3)
  AND ta.TeamID IS NULL;

-- Verifying
SELECT COUNT(*) AS teamawards_rows FROM TeamAwards;
SELECT * FROM TeamAwards LIMIT 20;

-- Final Check of all tables
SELECT 'Users' AS TableName, COUNT(*) AS RowCount FROM Users
UNION ALL
SELECT 'TeamInfo', COUNT(*) FROM TeamInfo
UNION ALL
SELECT 'PlayerInfo', COUNT(*) FROM PlayerInfo
UNION ALL
SELECT 'MatchInfo', COUNT(*) FROM MatchInfo
UNION ALL
SELECT 'MatchHistory', COUNT(*) FROM MatchHistory
UNION ALL
SELECT 'TeamPlayers', COUNT(*) FROM TeamPlayers
UNION ALL
SELECT 'PlayerHistory', COUNT(*) FROM PlayerHistory
UNION ALL
SELECT 'TeamHistory', COUNT(*) FROM TeamHistory
UNION ALL
SELECT 'TeamAwards', COUNT(*) FROM TeamAwards
UNION ALL
SELECT 'PlayerAwards', COUNT(*) FROM PlayerAwards
UNION ALL
SELECT 'Stage_WC_Matches', COUNT(*) FROM Stage_WC_Matches;

-- Top Scorers
SELECT PlayerName, TotalGoalsScored
FROM PlayerInfo
WHERE TotalGoalsScored > 0
ORDER BY TotalGoalsScored DESC, PlayerName
LIMIT 10;

-- Teams with most wins
SELECT TeamName, MatchesWon, NumOfMatchesPlayed
FROM TeamInfo
ORDER BY MatchesWon DESC, NumOfMatchesPlayed DESC
LIMIT 10; 

-- Awards by player
SELECT p.PlayerName, pa.AwardName, pa.DateofAward
FROM PlayerAwards pa
JOIN PlayerInfo p ON p.PlayerID = pa.PlayerID
ORDER BY pa.DateofAward DESC, p.PlayerName
LIMIT 20;

select database();

select * from users;





























