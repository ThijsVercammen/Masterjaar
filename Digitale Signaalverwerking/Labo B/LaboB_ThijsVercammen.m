%% Thijs Vercammen
%% r0638823
%% Digitale signaalverwerking
%% Labo B
%% De hoofdstuk nummers van het verslag komen overeen met
%% de nummers in het matlab bestand.
%% =======================================================

%% 1 Fast Fourier Transform (2.9)
%% ------------------------------
%% 1.1
%% ----------------------------
f = 440;
r = 4;
n = 64;
fs1 = f;
fs2 = 2*f;
fs3 = 4*f;

t1 = [0:1/fs1:(n-1)/fs1];
t2 = [0:1/fs2:(n-1)/fs2];
t3 = [0:1/fs3:(n-1)/fs3];

a1 = r*cos(2*pi*f*t1);
a2 = r*cos(2*pi*f*t2);
a3 = r*cos(2*pi*f*t3);
figure(1)

% fs = f
P2 = abs(fft(a1)/n);
P1 = P2(1:n/2+1);
p = fs1*(0:(n/2))/n;
subplot(3,1,1);
plot(p,P1);
title('fs = f');
xlabel('f (Hz)');
ylabel('|P1(f)|');

% fs = 2*f
P2 = abs(fft(a2)/n);
P1 = P2(1:n/2+1);
p = fs1*(0:(n/2))/n;
subplot(3,1,2)
plot(p,P1);
title('fs = 2*f');
xlabel('f (Hz)');
ylabel('|P1(f)|');

% fs = 4*f
P2 = abs(fft(a3)/n);
P1 = P2(1:n/2+1);
p = fs1*(0:(n/2))/n;
subplot(3,1,3)
plot(p,P1);
title('fs = 4*f');
xlabel('f (Hz)');
ylabel('|P1(f)|');

%% 1.2
%% ---------------
fs4 = 32*f;
n2 = 100;
t4 = [0:1/fs4:(n-1)/fs4];
t5 = [0:1/fs4:(n2-1)/fs4];
a4 = r*cos(2*pi*f*t4);
a5 = r*cos(2*pi*f*t5);
fft4 = fft(a4);
fft5 = fft(a5);
fft6 = fft([a4,a5]);
figure(2)

% 64 samples
subplot(3,1,1);
plot(abs(fft4));
title('n = 64');

% 100 samples
subplot(3,1,2);
plot(abs(fft5));
title('n = 100');

% 64 en 100 samples samen gevoegd
subplot(3,1,3);
plot(abs(fft6));
title('n = 100 en n = 64');
%% 2 Windowing (2.10)
%%-------------------
%% 2.1
%% ------------------
% wvtool(hanning(72));
% wvtool(hamming(72));
% wvtool(rectwin(72));

%% 2.3
%% ----------------
han3 = abs(fft5).*hanning(n2).';
ham3 = abs(fft5).*hamming(n2).';
box3 = abs(fft5).*rectwin(n2).';
% wvtool(han3);
% wvtool(ham3);
% wvtool(box3);

%% 2.4
%% ------------
delta = 400;
f1 = 1000;
f2 = f1 + delta;
fs = 8192;
t = [0:1/fs:(n2-1)/fs];
x1 = sin(2*pi*f1*t);
x2 = 0.1*sin(2*pi*f2*t);
x = x1 + x2

xhann = x.*hanning(n2).';
xhamm = x.*hamming(n2).';
xboxc = x.*rectwin(n2).';
% wvtool(xhann);
% wvtool(xhamm);
% wvtool(xboxc);

%% 3 Ruis, Windowing en interpolatie (2.11)
%%-----------------------------------------
%% 3.2
%% ----------------------------------------
noise = randn();
xn = x1 + x2 + (0.1*noise);
xnhann = xn.*hanning(n2).';
xnhamm = xn.*hamming(n2).';
xnboxc = xn.*rectwin(n2).';
% wvtool(xnhann);
% wvtool(xnhamm);
% wvtool(xnboxc);

%% 3.3
%% --------------
t = [0:1/fs:(512-1)/fs];
padding = zeros(1,512-n2);
y1 = [xn.*hanning(n2).',padding];
y2 = [xn.*hamming(n2).',padding];
y3 = [xn.*rectwin(n2).',padding];
% wvtool(y1);
% wvtool(y2);
% wvtool(y3);
%% 4 Eerste orde IIR filter (3.4)
%%-------------------------------
%% 4.5
%% ------------------------------
x = ones(1,200);
a1 = 0.1;
a2 = 0.9;
a3 = 1;
a4 = 1.1;
teller = 1;
figure(18)

%berekenen filter a1:
noemer1 = [1 a1];
y = filter(teller,noemer1,x);
subplot(4,1,1)
plot(y)
title('coeff = a1');

%berekenen filter a2:
noemer2 = [1 a2];
y = filter(teller,noemer2,x);
subplot(4,1,2)
plot(y)
title('coeff = a2');

%berekenen filter a3:
noemer3 = [1 a3];
y = filter(teller,noemer3,x);
subplot(4,1,3)
plot(y)
title('coeff = a3');

%berekenen filter a4:
noemer4 = [1 a4];
y = filter(teller,noemer4,x);
subplot(4,1,4)
plot(y)
title('coeff = a4');

%% 4.6
%% --------------------------
fs = 1000;
p = 20;
t = [0:1/fs:1];
n = randn(1,fs+1);
x = sin(2*pi*p*t) + n;
figure(19)

%berekenen filter a1:
y = filter(1, noemer1,x);
subplot(4,1,1)
plot(t,y)
title('coeff = a1');

%berekenen filter a2:
y = filter(1, noemer2,x);
subplot(4,1,2)
plot(t,y)
title('coeff = a2');

%berekenen filter a3:
y = filter(1, noemer3,x);
subplot(4,1,3)
plot(t,y)
title('coeff = a3');

%berekenen filter a4:
y = filter(1, noemer4,x);
subplot(4,1,4)
plot(t,y)
title('coeff = a4');
%% 4.8
%% --------------
% figure(20)
% zplane(1,noemer1)
% figure(21)
% zplane(1,noemer2)
% figure(23)
% zplane(1,noemer3)
% figure(24)
% zplane(1,noemer4)
% figure(25)
% freqz(1,noemer1)
% figure(26)
% freqz(1,noemer2)
% figure(27)
% freqz(1,noemer3)
% figure(28)
% freqz(1,noemer4)

%% 5 Tweede orde IIR filter (3.5)
%% ---------------------------
a1 = -0.96;
a2 = 0.25;

teller = [1 0 0];
noemer = [1 a1 a2];

%% 5.1
%% -----------------------
% polen 2de orde IIR filter
p_f = roots(noemer)

%% 5.2
%% -----------------------
% frequentie weergave 2de orde IIR filter
figure(29)
freqz(teller,noemer)

%% 5.3
%% -----------------------
%beeld polen/zeros af in het z vlak
figure(30)
zplane(teller,noemer)

%% 5.9
%% -----------------------
% r laten evolueren naar 1
r1 = 0.9; 
r2 = 0.99;
theta = 0.2838 %26.16 graden in radialen

% frequentie weergave r = 0.9
z1 = r1*exp(j*theta)
z2 = conj(z1)
noemer = poly([z1,z2])
figure(31)
freqz(1,noemer);
title('r is 0.9');

% frequentie weergave r = 0.99
z1 = r2*exp(j*theta)
z2 = conj(z1)
noemer = poly([z1,z2])
figure(32)
freqz(1,noemer);
title('r is 0.99');

%% 5.10
%% -----------------------
% theta laten evolueren naar 180 graden
theta1 = 0;
theta2 = pi/2;
theta3 = pi;
r = 0.5;

% frequentie weergave theta = 0
z1 = r*exp(j*theta1)
z2 = conj(z1)
noemer = poly([z1,z2])
figure(33)
freqz(1,noemer);
title('theta is 0 graden');

% frequentie weergave theta = 90 graden
z1 = r*exp(j*theta2)
z2 = conj(z1)
noemer = poly([z1,z2])
figure(34)
freqz(1,noemer);
title('theta is 90 graden');

% frequentie weergave theta = 180 graden
z1 = r*exp(j*theta3)
z2 = conj(z1)
noemer = poly([z1,z2])
figure(35)
freqz(1,noemer);
title('theta is 180 graden');

%% 5.11
%% -----------------------
% stap en impulsrespontie 2de orde IIR-netwerk
b1= 0.5;
b2= 0.25;
noemer = [1 b1 b2];

figure(36)
dstep(1,noemer);
title('Stapresponsie van IIR')
figure(37)
dimpulse(1,noemer);
title('Impulsresponsie van IIR')

%% 6 Tweede orde FIR filter (3.6)
%% ---------------------------
b1= 0.5;
b2= 0.25;

teller = [1 b1 b2];
noemer = [1 0 0];

% polen 2de orde FIR filter
z_f = roots(teller)

%% 6.1
%% -----------------------
% frequentie weergave 2de orde FIR filter
figure(38)
freqz(teller,noemer)

% beeld polen/zeros af in het z vlak
figure(39)
zplane(teller,noemer)

%% 6.5
%% -----------------------
% r laten evolueren naar 1
r1 = 0.9; 
r2 = 0.99;
theta = 1.0472 %26.16 graden in radialen

% frequentie weergave r = 0.9
z1 = r1*exp(j*theta)
z2 = conj(z1)
teller = poly([z1,z2])
figure(40)
freqz(teller,noemer);
title('r is 0.9');

% frequentie weergave r = 0.99
z1 = r2*exp(j*theta)
z2 = conj(z1)
teller = poly([z1,z2])
figure(41)
freqz(teller,noemer);
title('r is 0.99');

%% 6.6
%% -----------------------
% theta laten evolueren naar 180 graden
theta1 = 0;
theta2 = pi/2;
theta3 = pi;
r = 0.5;

% frequentie weergave theta = 0
z1 = r*exp(j*theta1)
z2 = conj(z1)
teller = poly([z1,z2])
figure(42)
freqz(teller,noemer);
title('theta is 0 graden');

% frequentie weergave theta = 90 graden
z1 = r*exp(j*theta2)
z2 = conj(z1)
teller = poly([z1,z2])
figure(43)
freqz(teller,noemer);
title('theta is 90 graden');

% frequentie weergave theta = 180 graden
z1 = r*exp(j*theta3)
z2 = conj(z1)
teller = poly([z1,z2])
figure(44)
freqz(teller,noemer);
title('theta is 180 graden');

%% 6.7
%% -----------------------
% stap en impulsrespontie 2de orde IIR-netwerk
teller = [1 b1 b2];
noemer = [1 0 0];

figure(45)
dstep(teller,noemer);
title('Stapresponsie van FIR')
figure(46)
dimpulse(teller,noemer);
title('Impulsresponsie van FIR')
