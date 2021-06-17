% Shishir Khanal
% EE-5575
% Project-2
% Code to plot the Convolution of:
% x[n] = u[n+3] &
% h[n] = (0.8)^n * u(n-1)
%------------------------------------------

clc;clear;
n = -10:20;
f1= (n>=-3);
subplot(3,1,1)
n1 = -10: length(f1)-10-1;
stem(n1,f1)
title('x[n]')
subplot(3,1,2)
f2 = (0.8).^n(n>=1);
n2 = 1: length(f2);
stem(n2,f2)
title('h[n]')
subplot(3,1,3)
output = conv(f1,f2);
n3 = -10: 20;
actualoutput = output(1:31);
stem(n3,actualoutput)
title('y[n]')

