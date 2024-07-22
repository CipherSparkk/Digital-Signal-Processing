clc
clear

ws = 0.4*pi;
wp = 0.6*pi;

% In dB
attentaution_ws = -80;
attentaution_wp = -3;

delta_s = 10^(attentaution_ws/20);
delta_p = 10^(attentaution_wp/20);

delta = (wp - ws)/(2*pi)
% Calculation for Order of filter by Bellander's formula
N = -2*log10(10*delta_p*delta_s)/(3*delta)

% Calculation for Order of filter by Kaiser's formula
N1 = (-20*log10(sqrt(delta_p*delta_s))-13)/(14.6*delta)

% Calculation fo for Order of filter by Bellmann's formula
delta_1 = (1-delta_p)/(1+delta_p)
delta_2 = 2*delta_s/(1+delta_p)

N2 = (-10*log10(delta_1*delta_2)-15)/(14*delta) + 1