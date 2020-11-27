/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  Thijs Vercammen
 * Created: 9-nov-2020
 */

drop table groepen purge;
drop table gebruikers purge;

create table gebruikers (
gebruikersnaam varchar2(20) primary key,
paswoord varchar2(20) );

create table groepen (
gebruikersnaam varchar2(20) references gebruikers primary key,
groep varchar2(20) );

insert into gebruikers values ('10000', '10000');
insert into gebruikers values ('10001', '10001');
insert into gebruikers values ('10002', '10002');
insert into gebruikers values ('00001', '00001');
insert into gebruikers values ('00002', '00002');
insert into gebruikers values ('90001', '90001');

insert into groepen values ('10000', 'klanten' );
insert into groepen values ('10001', 'klanten' );
insert into groepen values ('10002', 'klanten' );
insert into groepen values ('00001', 'VIPklanten' );
insert into groepen values ('00002', 'VIPklanten' );
insert into groepen values ('90001', 'beheerders' );