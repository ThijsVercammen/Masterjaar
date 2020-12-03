%% Thijs Vercammen
%% r0638823
%% Digitale signaalverwerking
%% Labo B
%% De hoofdstuk nummers van het verslag komen overeen met
%% de nummers in het matlab bestand.
%% =======================================================

%% 1 Pole-Zero plaatsing (4.4)
%% ------------------------------
%% 1.1
%% ----------------------------
% polen duwen de frequentiekarakteristiek omhoog, zorgen voor een daling
% nulpunten trekken de frequentiekarakterisstiek naar beneden, zorgen voor
% een stijging.
teller = [1 0 0];
fs = 1000;
fc = 100;
bb = 20;
r = 1 - ((bb/fc)*pi);
theta = degtorad(36);

z1 = r*exp(j*theta);
z2 = conj(z1);
noemer = poly([z1,z2]);

figure(1)
freqz(teller,noemer,fs);

figure(2)
zplane(teller,noemer,fs);

%% 2 Cauer filter en quantisatie (4.5)
%% ------------------------------
%% 1.1
%% ----------------------------
fco = 300;
rimpel = 0.5;
fs = 4000;
sa = 50;

wn = fco/(fs/2);
[A,B] = ellip(8, rimpel, sa, wn);
figure(3)
freqz(A,B);

figure(4)
zplane(A,B)

% 8 cijfers nauwkeurigheid

t1 = round(A, 8);
n1 = round(B, 8);
figure(5)
freqz(t1,n1);

figure(6)
zplane(t1,n1)
t2 = round(A, 5);
n2 = round(B, 5);

figure(7)
freqz(t2,n2);

figure(8)
zplane(t2,n2);
