/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  Thijs Vercammen
 * Created: 3-nov-2020
 */

drop table Test purge;
drop table Contacten purge;
drop table Arts purge;
drop table Burger purge;
drop table Status purge;
drop table groepen purge;
drop table gebruikers purge;

create table Status (
    statusnr int,
    naam varchar(255),
    PRIMARY KEY(statusnr)
);

create table Burger (
    burgernr int,
    naam varchar(255),
    wachtwoord varchar(255),
    risicostatus int,
    PRIMARY KEY(burgernr),
    FOREIGN KEY (risicostatus) REFERENCES Status(statusnr)
);

create table Arts (
    artsnr int,
    naam varchar(255),
    wachtwoord varchar(255),
    PRIMARY KEY(artsnr)
);

create table Contacten (
    contactnr int,
    burgernr int,
    contact int,
    soort_contact varchar(255),
    PRIMARY KEY(contactnr),
    FOREIGN KEY(burgernr) REFERENCES Burger(burgernr),
    FOREIGN KEY(contact) REFERENCES Burger(burgernr)
);

create table Test (
    testnr int,
    gebruiker int,
    status int,
    PRIMARY KEY(testnr),
    FOREIGN KEY(gebruiker) REFERENCES Burger(burgernr),
    FOREIGN KEY(status) REFERENCES Status(statusnr)
);

insert into Status values (1, 'In uitvoering');
insert into Status values (2, 'Positief');
insert into Status values (3, 'Negatief');

insert into Burger values (1, 'John Doe', 'admin', 3);
insert into Burger values (2, 'Arno Goyvaerts', 'admin', 3);
insert into Burger values (3, 'Thijs Vercammen', 'admin', 3);

insert into Arts values (1, 'Herman Crauwels', 'admin');

-- SECURITY
create table gebruikers (
    gebruikersnaam varchar(20) primary key,
    paswoord varchar(20) 
);

create table groepen (
    gebruikersnaam varchar(20) references gebruikers primary key,
    groep varchar2(20)
);

insert into gebruikers values ('John Doe', 'admin');
insert into gebruikers values ('1111', '2222');
insert into gebruikers values ('Arno Goyvaerts', 'admin');
insert into gebruikers values ('Thijs Vercammen', 'admin');

insert into gebruikers values ('Herman Crauwels', 'admin');

insert into groepen values ('John Doe', 'Burger' );
insert into groepen values ('1111', 'Burger' );
insert into groepen values ('Arno Goyvaerts', 'Burger' );
insert into groepen values ('Thijs Vercammen', 'Burger' );
insert into groepen values ('Herman Crauwels', 'Arts' );