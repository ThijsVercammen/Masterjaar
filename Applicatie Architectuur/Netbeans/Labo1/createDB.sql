/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  r0638823
 * Created: 12-okt-2020
 */
drop table Reservaties purge;
drop table Locaties purge;
drop table Wagens purge;
drop table Klanten purge;

create table Klanten (
    knr int,
    postcode int,
    knaam varchar2(255),
    adres varchar2(255),
    gemeente varchar2(255),
    PRIMARY KEY(knr)
);

create table Wagens (
    wnr int,
    wnaam varchar2(255),
    prijs int,
    PRIMARY KEY(wnr)
);

create table Locaties (
    lnr int,
    lnaam varchar2(255),
    PRIMARY KEY(lnr)
);

create table Reservaties (
    mr int,
    knr int,
    dagen int,
    wnr int,
    lnrVan int,
    lnrNaar int,
    datumvan date,
    datumres date,
    PRIMARY KEY(mr),
    FOREIGN KEY(knr) REFERENCES Klanten(knr),
    FOREIGN KEY(lnrVan) REFERENCES Locaties(lnr),
    FOREIGN KEY(lnrNaar) REFERENCES Locaties(lnr),
    FOREIGN KEY(wnr) REFERENCES Wagens(wnr)
);

INSERT INTO Klanten 
VALUES (100, 2550, 'Thijs Vercammen', 'Herseltsesteenweg', 'Herselt');

INSERT INTO Wagens 
VALUES (1, 'BMW 5', 500);

INSERT INTO Wagens 
VALUES (0, 'Opel Corsa', 1500);

INSERT INTO Wagens 
VALUES (3, 'Audi A3', 5000);

INSERT INTO Locaties
VALUES (0,'Aarschot');

INSERT INTO Locaties
VALUES (1,'Leuven');

INSERT INTO Locaties
VALUES (2,'Antwerpen');
