%% Thijs Vercammen
%% r0638823
%% Digitale Signaalverwerking - Labo A
%%-------------------------------------------
f = 440;
r = 4;
fs = 8192;
t = [0:1/fs:99/fs];
a = r*sin(2*pi*f*t);
b = load('handel');
c = csvread('covid19.csv');

%% 2.5 Sampling
%%----------------
%% vraag 1
%%----------------
figure(1);
t = [0:1/fs:99/fs];
plot(t,a, 'b-')
stem(t,a, 'b-')
xlabel('L[s]')
ylabel('a')
title('Eerste 100 samples')
hold on;

%% vraag 2
%%----------------
figure(2);
fsc = fs*10;
tc = [0:1/fsc:99/fs];
ac = r*sin(2*pi*f*tc);
%plot(tc,ac, 'r-')
stem(tc,ac, 'r-')
xlabel('L[s]')
ylabel('a')
title('10 * de sampleperiode')
hold on;

%% vraag 3
%%----------------
% p = audioplayer(a,fs);
% play(p);

%% vraag 4
%%----------------
figure(3)
t1 = [0:1/(100*f):99*(1/fs)];
a1 = 4*sin(2*pi*f*t1);
plot(t1,a1,'m-')
hold on;
t3 = [0:1/(4*f):99*(1/fs)];
a3 = 4*sin(2*pi*f*t3);
plot(t3,a3,'b-')
hold on;
t4 = [0:1/(2*f):99*(1/fs)];
a4 = 4*sin(2*pi*f*t4);
plot(t4,a4,'r-')
hold on;
t5 = [0:1/(f*2.5):99*(1/fs)];
a5 = 4*sin(2*pi*f*t5);
plot(t5,a5,'g-')
xlabel('L[s]')
ylabel('a')
title('Verschillende samplefrequenties')

%% 2.6 Kwantisatie
%%----------------
%% Vraag 1
%%----------------
figure(4)
q_3bit = quantizenumeric(a,1,3,0,'round');
q_5bit = quantizenumeric(a,1,5,2,'round');
q_7bit = quantizenumeric(a,1,7,4,'round');
q_3bit_fout = q_3bit - a;
q_5bit_fout = q_5bit - a;
q_7bit_fout = q_7bit - a;
plot(t,q_3bit_fout,'g-')
hold on;
plot(t,q_5bit_fout,'r-')
hold on;
plot(t,q_7bit_fout,'b-')
xlabel('L[s]')
ylabel('a')
title('Kwantisatiefout voor 3,5 en 7 bit')
hold on;
%% Vraag 2
%%----------------
figure(5)
quan_1bit = quantizenumeric(a,1,1,-2,'round');
quan_2bit = quantizenumeric(a,1,2,-1,'round');
quan_3bit = quantizenumeric(a,1,3, 0,'round');
quan_4bit = quantizenumeric(a,1,4, 1,'round');
quan_5bit = quantizenumeric(a,1,5, 2,'round');
quan_6bit = quantizenumeric(a,1,6, 3,'round');
quan_7bit = quantizenumeric(a,1,7, 4,'round');
quan_8bit = quantizenumeric(a,1,8, 5,'round');
quan_1bit_fout = quan_1bit - a;
quan_2bit_fout = quan_2bit - a;
quan_3bit_fout = quan_3bit - a;
quan_4bit_fout = quan_4bit - a;
quan_5bit_fout = quan_5bit - a;
quan_6bit_fout = quan_6bit - a;
quan_7bit_fout = quan_7bit - a;
quan_8bit_fout = quan_8bit - a;
plot(t,quan_1bit_fout)
legende1 = sprintf('1bit, rms = %d', rms(quan_1bit_fout))
hold on;
plot(t,quan_2bit_fout)
legende2 = sprintf('2bit, rms = %d', rms(quan_2bit_fout))
hold on;
plot(t,quan_3bit_fout)
legende3 = sprintf('3bit, rms = %d', rms(quan_3bit_fout))
hold on;
plot(t,quan_4bit_fout)
legende4 = sprintf('4bit, rms = %d', rms(quan_4bit_fout))
hold on;
plot(t,quan_5bit_fout)
legende5 = sprintf('5bit, rms = %d', rms(quan_5bit_fout))
hold on;
plot(t,quan_6bit_fout)
legende6 = sprintf('6bit, rms = %d', rms(quan_6bit_fout))
hold on;
plot(t,quan_7bit_fout)
legende7 = sprintf('7bit, rms = %d', rms(quan_7bit_fout))
hold on;
plot(t,quan_5bit_fout)
legende8 = sprintf('8bit, rms = %d', rms(quan_8bit_fout))
legend({legende1, legende2, legende3, legende4, legende5, legende6, legende7, legende8})
xlabel('L[s]')
ylabel('a')
title('Kwantisatiefout voor 1-8 bit')
hold on;

figure(6)
plot([1:1:8],[rms(quan_1bit_fout) rms(quan_2bit_fout) rms(quan_3bit_fout) rms(quan_4bit_fout) rms(quan_5bit_fout) rms(quan_6bit_fout) rms(quan_7bit_fout) rms(quan_8bit_fout)])
xlabel('bits')
ylabel('rms')
title('Rms waarde kwantisatiefout voor 1-8 bit')
hold on;
%% 2.7 Handel
%%----------------
%% Vraag 1
%%----------------
figure(7)
plot([4000:1:4100],b.y([4000:1:4100]))
xlabel('L[s]')
ylabel('a')
title('100 samples startend van 4000')
hold on;
%% Vraag 2
%%----------------
% p2 = audioplayer(b.y,b.Fs);
% play(p2);
%% Vraag 3
%%----------------
% p_hoger = audioplayer(b.y,b.Fs*1.5);
% play(p_hoger);
% p_lager = audioplayer(b.y,b.Fs*0.5);
% play(p_lager);
%% Vraag 4
%%----------------
% quan_1bit = quantizenumeric(b.y,1,8,4,'round');
% p_q = audioplayer(quan_1bit,b.Fs);
% play(p_q);
%% 2.8 Convolutie
%%----------------
%% Vraag 1
%%----------------
figure(8)
stap = [0 0 0 1 1 1 1 1];
f1 = [0.5 0.25 0.125];
conv1 = conv(stap,f1);
stem(conv1)
xlabel('k')
ylabel('a')
title('Convolutie met filter f1')
hold on;
%% Vraag 2
%%----------------
figure(9)
f2 = [1/3 1/3 1/3];
conv2 = conv(stap,f2);
stem(conv2)
xlabel('k')
ylabel('a')
title('Convolutie met filter f2')
hold on;
%% Vraag 3
%%----------------
figure(10)
f3 = [1 1 1 1 1 1 1 1 1]/9;
conv3 = conv(stap,f3);
stem(conv3)
xlabel('k')
ylabel('a')
title('Convolutie met filter f3')
hold on;
%% Vraag 4
%%----------------
% conv4 = conv(b.y,f2);
% p_c = audioplayer(conv4,b.Fs);
% play(p_c);
%% Vraag 5
%%----------------
figure(11)
fw = [1/7 1/7 1/7 1/7 1/7 1/7 1/7];
conv5 = conv(c(:,2),fw);
plot(conv5)
xlabel('dagen')
ylabel('besmettingen')
title('Convolutie met filter f4 en covid-19 besmettingen')
hold on;

