%Shishir Khanal
%Final Project
%EE5575
% Design of Low Pass FIR Filter
%-------------------------------------

clc;clear; close all;
frequency_pass = 100;
frequency_stop = 1000;
alpha_pass = 1;
alpha_stop = 30;
frequency_cut = 100;
wc = frequency_cut*2*pi;
frequency_sampling = 2*frequency_stop;
ws = frequency_sampling*2*pi;
%---------------------------------------
%1
n = 50;
Wn = (wc/ws)*pi;
H_n_rect = fir1(n,Wn,'low',rectwin(n+1));
%H_n_rect = fir1(50,0.2513*.5,'low',rectwin(n+1));
%a.
figure(1)
m = [1:1024];
f = m.*frequency_sampling/length(m);
H_f_rec = fft(H_n_rect,1024);
half_f = f(1:length(f)/2);
subplot(2,1,1);
plot(half_f,20*log10(abs(H_f_rec(1:length(f)/2))));
title('Magnitude Response of Rectangular Window FIR Filter');
grid;
subplot(2,1,2);
plot(half_f,angle(H_f_rec(1:length(f)/2)));
grid;
title('Phase Response of Rectangular Window FIR Filter');

%b.
figure(2)
zplane(abs(H_n_rect));grid;
title('Pole-Zero Plot of Rectangular Window FIR Filter');
%c
figure(3)
stem(H_n_rect)
title('Impulse Response of Rectangular Window FIR Filter');

%d.
filter_coeff_Rect = H_n_rect(1:10)
%-----------------------------------------

%-----------------------------------------
%2.
H_n_Hamming = fir1(n,Wn,'low');
%a.
figure(4)
H_f_ham = fft(H_n_Hamming,1024);
half_f = f(1:length(f)/2);
subplot(2,1,1);
plot(half_f,20*log10(abs(H_f_ham(1:length(f)/2))));
title('Magnitude Response of Hamming Window FIR Filter');

grid;
subplot(2,1,2);
plot(half_f,angle(H_f_ham(1:length(f)/2)));
title('Phase Response of Hamming Window FIR Filter');

grid;
%b.
figure(5)
zplane(abs(H_n_Hamming));grid;
title('Pole-Zero Plot of Hamming Window FIR Filter');

%c
figure(6)
stem(H_n_Hamming)
title('Impulse Response of Hamming Window FIR Filter');
%-----------------------------------------

%---------------------------------------------------------------
%Part 3: Apply Filters
%1.
load('proj_signal.mat');
y = conv(x,H_n_Hamming);
figure(7)
plot(y(1:100))
hold on
plot(x(1:100))
title('Response Plot of Hamming Window FIR Filter');legend('Output','Input');
hold off

%2.
figure(8)
m = 1:1024;
f = m.*frequency_sampling/length(m);
fft_x = fft(x,1024);
fft_y = fft(y,1024);
half_f = f(1:length(f)/2);
subplot(2,1,1);
plot(half_f,20*log10(abs(fft_y(1:length(f)/2))));
hold on
plot(half_f,20*log10(abs(fft_x(1:length(f)/2))));
grid;hold off;legend('Output Spectrum','Input Spectrum')
title('Magnitude Spectra plot of Hamming Window FIR Filter')

subplot(2,1,2);
plot(half_f,angle(fft_y(1:length(f)/2)));
hold on
plot(half_f,angle(fft_x(1:length(f)/2)));
grid; hold off;legend('Output Spectrum','Input Spectrum');
title('Phase Spectra plot of Hamming Window FIR Filter')

figure(9)
y_rec = conv(x,H_n_rect);
fft_yrec = fft(y_rec,1024);
subplot(2,1,1);
plot(half_f,20*log10(abs(fft_yrec(1:length(f)/2))));
hold on
plot(half_f,20*log10(abs(fft_x(1:length(f)/2))));
grid;hold off;legend('Output Spectrum','Input Spectrum')
title('Magnitude Spectra plot of Rectangular Window FIR Filter')

subplot(2,1,2);
plot(half_f,angle(fft_yrec(1:length(f)/2)));
hold on
plot(half_f,angle(fft_x(1:length(f)/2)));
grid; hold off;legend('Output Spectrum','Input Spectrum');
title('Phase Spectra plot of Rectangular Window FIR Filter')
%---------------------------------------------------------------

%---------------------------------------------------------------