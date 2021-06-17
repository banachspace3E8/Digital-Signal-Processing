%Shishir Khanal
%EE5575
%Project-1
%Matlab code to evalaute filter Order
%Information Source: Lathi Page 124, Essentials of Digital Signal
%Processing
%----------------------------------------------------------------

clc;clear;
%max passband attenuation
filter_ap = 1;
%min stopband attenuation
filter_as = 30;

%--------------------------------------------------------------
% define passband & cutoff frequencies
% LPFfp = 100;
% LPFfs = 1000;
LPFwp = 2*pi*100;
LPFws = 2*pi*1000;
LPF_K = ceil(abs(Order(LPFwp, LPFws, filter_ap, filter_as)));
LPFwc = cutoffrequency(filter_ap, filter_as,LPFwp, LPFws,LPF_K);
%Using the Normalized Transfer function to find the prototype filter
%transfer function
%Using the calibration parameter 's/4663.23' to calibrate the prototype 
%filter transfer function to actual Low Pass Filter Transfer Function

%Transfer function for the Low Pass Filter
numLP = [999200.16];
denLP = [1 1413.65 999200.16];
LPFilter = tf(numLP,denLP);
bode(LPFilter)
%-------------------------------------------------------------------

hold all
%-------------------------------------------------------------------
% define passband & cutoff frequencies
% BPF1fp = 100;
% BPF1fs = 10;
BPF1wp = 2*pi*100;
BPF1ws = 2*pi*10;
% BPF2fp = 3500;
% BPF2fs = 35000;
BPF2wp = 2*pi*3500;
BPF2ws = 2*pi*35000;
wp = 1;
% stopband frequency for the prototype low pass filter
BPFwss = abs([wp*(BPF1ws^2-BPF1wp*BPF2wp)/(BPF1ws*(BPF2wp-BPF1wp)),...
wp*(BPF2ws^2-BPF1wp*BPF2wp)/(BPF2ws*(BPF2wp-BPF1wp))]);
BPFws = min(BPFwss); 
%order of filter and cutoff frequency of Bandpass filter
BPF_K = ceil(abs(Order(wp, BPFws, filter_ap, filter_as)));
BPFwc = cutoffrequency(filter_ap, filter_as,wp, BPFws,BPF_K);
% Evaluation of Prototype Transfer function for Low pass filter
k = 1:BPF_K;
pk = (1j*BPFwc*exp(1j*pi/(2*BPF_K)*(2*k-1))); 
A = poly(pk);

% calibration of prototype filter for the band pass filter
a = 1; 
b = -pk*(BPF2wp-BPF1wp); 
c = BPF2wp*BPF1wp;
pk = [(-b+sqrt(b.^2-4*a*c))./(2*a),(-b-sqrt(b.^2-4*a*c))./(2*a)];
B = (BPFwc^BPF_K)*((BPF2wp-BPF1wp)^BPF_K)*poly(zeros(BPF_K,1));
A = round(poly(pk), 1);
BPFilter = tf(B,A);
bode(BPFilter)
%---------------------------------------------
 
%---------------------------------------------
% define passband & cutoff frequencies
% HPFfp = 3500;
% HPFfc = 350;
HPFwp = 2*pi*3500;
HPFws = 2*pi*350;
HPF_K = ceil(abs(Order(HPFwp, HPFws, filter_ap, filter_as)));
HPFwc = cutoffrequency(filter_ap, filter_as, HPFwp, HPFws,HPF_K);
%Using the Normalized Transfer function to find the prototype filter
%transfer function 
%Using the calibration parameter '(1.56E4)/s' to calibrate the prototype 
%filter transfer function to actual Low Pass Filter Transfer Function

numHP = [1 0 0];
denHP = [1 2.21E4 2.43E8];
HPFilter = tf(numHP,denHP);
bode(HPFilter)
%---------------------------------------------

%---------------------------------------------
%function to evaluate order of filter 'K'
function [K] = Order(wp, ws,attpass, attstop)
    term1 = 10^(attstop/10)-1;
    term2 = 10^(attpass/10)-1; 
    term3 = term1/term2;
    term4 = ws/wp;
    K = log(term3)/(2*log(term4));
end

%Function to evaluate cutoff frequency
function wc = cutoffrequency(ap, as, wp, ws,k)
wc1 = wp / (10^(ap/10) - 1)^(1/(2*k));
wc2 = ws / (10^(as/10) - 1)^(1/(2*k));
% fprintf("%d ",wc1)
% fprintf("%d ",wc2)
wc = (wc1+wc2)/2;
end
%----------------------------------------------