clc
clear

ws = 0.4*pi;
wp = 0.6*pi;

% In dB
attenaution_ws = -80;
attenaution_wp = -3;

delta_s = 10^(attenaution_ws/20);
delta_p = 10^(attenaution_wp/20);

delta = (wp - ws)/(2*pi);     % For High Pass Filter

% Calculation for Order of filter by Bellander's formula
N = -2*log10(10*delta_p*delta_s)/(3*delta);


% We want even N
if mod(N,2) ~= 0
    N = N+1;
end

n = 0:N;
if(mod(length(n),2) == 0)
    n = 0:N+1;
end

% Hamming window
w = zeros(1,length(n));

for i=1:length(w)
    w(i) = 0.5*(1 - cos(2*pi*(i-1)/N));
end

Hd_ejw = zeros(1,length(n));

range = [-pi:2*pi/N:0, 2*pi/N:2*pi/N:pi];

% Constructing desired filter
for i = 1:length(Hd_ejw)
    if range(i) <= -wp || range(i) >= wp
        Hd_ejw(i) = 1;
    else
        Hd_ejw(i) = 0;
    end
end

h = zeros(1,length(n));
for i=1:length(h)
    num = sin(pi*(i-1-N/2)) - sin(wp*(i-1-N/2));
    den = pi*(i-1-N/2);
    h(i) = num/den;
end


% Multiplying h[n] with w[n]
h = h .* w;

% Transfer Function H(z)
H_z = '';
for i = 1:length(h)
    if i == length(h)
        H_z = H_z + string(h(i)) + "*z^" + string(1-i) + " ";
    else
        H_z = H_z + string(h(i)) + "*z^" + string(1-i) + " + ";
    end
end
    
disp("Transfer Function : H(z) = ")
disp(H_z)
    
new_range = 0:2*pi/N:2*pi;

% Calculating H(e(jw)) from hd[n]
H_ejw = fftshift(fft(h));

mag_plot = abs(H_ejw);

% Phase Calculation
phase_H_ejw = angle(H_ejw);

figure(1);
subplot(2,1,1)
stairs(range, Hd_ejw, 'LineWidth', 1.5)
xlim([-pi, pi])
ylim([-1, 2])
title('Desired Filter  :  Hd ( e(jw) )')
grid on 

subplot(2,1,2)
stem(new_range, h, 'LineWidth', 1.5)
xlim([0, 2*pi])
ylim([(min(h)-0.5), (max(h)+0.5)])
title('h[n]')
xlabel('n --->')
grid on

figure(2);
subplot(2,1,1)
stem(new_range, mag_plot, 'LineWidth', 1.5)
xlim([0, 2*pi])
ylim([(min(mag_plot)-0.5), (max(mag_plot)+0.5)])
title('Magnitude Plot for :   H ( e (jw))')
xlabel('Frequency (w) --->')
ylabel('| H ( e (jw) ) | --->')
grid on

%subplot(2,1,2)
%plot(new_range, smooth_mag_plot, 'LineWidth', 1.5)
%xlim([0, 2*pi])
%ylim([(min(smooth_mag_plot)-0.5), (max(smooth_mag_plot)+0.5)])
%title('Smooth Magnitude Plot for :   H ( e (jw))')
%xlabel('Frequency (w) --->')
%ylabel('| H ( e (jw) ) | --->')
%grid on

% Plot Phase
figure(3);
subplot(2,1,1)
plot(new_range, phase_H_ejw, 'LineWidth', 1.5)
title('Phase Plot for :   H ( e (jw))')
xlabel('Frequency (w) --->')
ylabel('Phase (ø) --->')
xlim([0, 2*pi])
grid on

subplot(2,1,2)
stem(new_range, phase_H_ejw, 'LineWidth', 1.5)
title('Phase Plot for :   H ( e (jw))')
xlabel('Frequency (w) --->')
ylabel('Phase (ø) --->')
xlim([0, 2*pi])
grid on
% Add vertical line at the center
hold on
plot([pi pi], ylim) % Vertical line at pi (center)
hold off
