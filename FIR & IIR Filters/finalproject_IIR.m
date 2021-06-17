%Shishir Khanal
%Final Project
%EE5575
% Design of Low Pass IIR Filter
%-------------------------------------
%Part-1: IIR Filter
clc;clear; close all;
frequency_pass = 100;
frequency_stop = 1000;
alpha_pass = 1;
alpha_stop = 30;

num =[394784.2];
den = [1 888.5766 394784.2];
h_lpf = tf(num,den)
%1
frequency_sampling = 2*frequency_stop;
%3
[num_z,den_z] = bilinear(num,den,frequency_sampling);
H_z = tf(num_z,den_z,frequency_sampling)
%4
figure(1)
zplane(num_z,den_z)
title('Pole-zero plot of IIR Filter')
%5
figure(2)
freqz(num_z,den_z,frequency_sampling)
[w,p] = freqz(num_z,den_z,frequency_sampling);
title('Frequency Response Plot of IIR Filter');
%6
figure(3)
imp = [zeros(10,1);1;zeros(99,1)];
response_impulse = filter(num_z,den_z,imp);
stem(response_impulse);(grid);
title('Impulse Response of IIR Filter')
%---------------------------------------------------------------

%---------------------------------------------------------------
%Part 3: Apply Filters
%1.
load('proj_signal.mat');
y = conv(x,response_impulse);
figure(4)
plot(y(1:100))
hold on
plot(x(1:100))
title('Response Plot of IIR Filter');legend('Output','Input');
hold off
%2.
figure(5)
m = [1:1024];
f = m.*frequency_sampling/length(m);
fft_x = fft(x,1024);
fft_y = fft(y,1024);
half_f = f(1:length(f)/2);
subplot(2,1,1);
plot(half_f,20*log10(abs(fft_y(1:length(f)/2))));
hold on
plot(half_f,20*log10(abs(fft_x(1:length(f)/2))));
grid;hold off;
title('Magnitude Spectra plot of IIR Filter')

subplot(2,1,2);
plot(half_f,angle(fft_y(1:length(f)/2)));
hold on
plot(half_f,angle(fft_x(1:length(f)/2)));
grid; hold off;
title('Phase Spectra plot of IIR Filter')

%---------------------------------------------------------------

%---------------------------------------------------------------