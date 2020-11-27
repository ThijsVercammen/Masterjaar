%Author: Simon Vandevelde
%matlab file om de invloed te onderzoeken van windowing.
%gebruikt als handleiding: https://nl.mathworks.com/help/matlab/ref/fft.html

%Gegeven wrden:
a = 625
b = 62.5
n = 64          %hoeveelheid samples
p = 1000
r = 8000
c = 250
d = 125

%Berekende waarden:
fs = r          %samplefrequentie
Ts = 1/fs       %sampletijd

T = (n-1)*Ts    %laatste samplewaarde, x(t) bestuderen tot T
t = 0:1/fs:T;   %array maken van de verschillende tijden waarop gesampled wordt
                %startwaarde:stap:eindwaarde
                
                
%De verschillende golfvormen:
%x = 1      %om de windows zonder golfvorm te tonen
                
%x = 1 * sin(2*pi*p*t)
x = 1 * sin(2*pi*(p+a)*t)
%x = 1 * sin(2*pi*p*t) + 0.05*sin(2*pi*(p+b)*t)
%x = 1 * sin(2*pi*p*t) + 0.05*sin(2*pi*(p+c)*t)
%x = 1 * sin(2*pi*(p+d)*t) + 0.05*sin(2*pi*(p+b)*t)%
%x = 1 * sin(2*pi*(p+d)*t) + 0.05*sin(2*pi*(p+c)*t)
y = fft(x);

P2 = abs(y/n);
P1 = P2(1:n/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = fs*(0:(n/2))/n;

%tekenen van de drie windows
%wvtool(boxcar(n));
%wvtool(hanning(n));
wvtool(hamming(n));


%Tekenen van discreet tijdsdomein & frequentiedomein van oorspronkelijk
%signaal
subplot(4,2,1)
stem(t,x)
title('oorspronkelijk: tijdsdomein')
xlabel('tijd in seconden')
ylabel('amplitude')

subplot(4,2,2)
stem(f,P1)
title('oorspronkelijk: frequentiedomein')
xlabel('frequentie in Hertz')
ylabel('amplitude')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Tekenen van discreet tijdsdomein & frequentiedomein van oorspronkelijk
%signaal met boxcar
xbox = x.*boxcar(n).'
ybox = fft(xbox)

P2 = abs(ybox/n);
P1 = P2(1:n/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = fs*(0:(n/2))/n;

%Tekenen van discreet tijdsdomein & frequentiedomein 
subplot(4,2,3)
stem(t,xbox)
title('boxcars')
xlabel('tijd in seconden')
ylabel('amplitude')

subplot(4,2,4)
stem(f,P1)
title('boxcars')
xlabel('frequentie in Hertz')
ylabel('amplitude')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Tekenen van discreet tijdsdomein & frequentiedomein van oorspronkelijk
%signaal met Hanning
xhann = x.*hanning(n).'
yhann = fft(xhann)

P2 = abs(yhann/n);
P1 = P2(1:n/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = fs*(0:(n/2))/n;

%Tekenen van discreet tijdsdomein & frequentiedomein 
subplot(4,2,5)
stem(t,xhann)
title('Hanning')
xlabel('tijd in seconden')
ylabel('amplitude')

subplot(4,2,6)
stem(f,P1)
title('Hanning')
xlabel('frequentie in Hertz')
ylabel('amplitude')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Tekenen van discreet tijdsdomein & frequentiedomein van oorspronkelijk
%signaal met Hamming
xhamm = x.*hamming(n).'
yhamm = fft(xhamm)

P2 = abs(yhamm/n);
P1 = P2(1:n/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = fs*(0:(n/2))/n;

%Tekenen van discreet tijdsdomein & frequentiedomein 
subplot(4,2,7)
stem(t,xhamm)
title('Hamming')
xlabel('tijd in seconden')
ylabel('amplitude')

subplot(4,2,8)
stem(f,P1)
title('Hamming')
xlabel('frequentie in Hertz')
ylabel('amplitude')
