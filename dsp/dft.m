clc;
clear;

% Asking for length of sequence
n = input("Enter length of sequence : ");

x = zeros(1, n);

% Taking User input
disp("Enter values in sequence x[n]");

for i = 1:n
    x(i) = input("> ");
end

% No. of points to be included in DFT
N = input("Enter no. of points you want to include in DFT: ");

% Condition check
if N < n
    error('Operation cannot be performed!!!');
else
    x = [x zeros(1, N - n)];
end

x = x';

range = 0:N-1;

% Defining bases functions matrix
Dn = ones(N, N); 
for i = 2:N
    for k = 2:N
        Dn(i, k) = exp(-1j*2*pi*(k-1)*(i-1)/ N);
    end
end

% Calculation DFT X(k)
X = Dn * x;

% Setting a small threshold for comparison
threshold = 1e-10;
for j = 1:N
    if abs(real(X(j))) < threshold
        X(j) = complex(0, imag(X(j)));
    end
    if abs(imag(X(j))) < threshold
        X(j) = complex(real(X(j)), 0);
    end
end

% Calculating conjugation of Dn
conj_Dn = conj(Dn);

% Calculating IDFT of X(k)
new_x = (1 / N) * conj_Dn * X;

% Verification by inverse operation
inverse_Dn = inv(Dn);
new_x2 = inverse_Dn * X;

% Plotting input sequence : x[n]
figure(1)
stem(range, x,'LineWidth',1.5)
grid on;
set(gca, 'FontSize', 12);
xlabel("n--->")
ylabel("Amplitude")
title("x[n]")
xlim([min(range)-1,max(range)+1])
ylim([0, max(x)+1])

% Plotting magnitude plot for X(k)
figure(2)
subplot(2,1,1)
stem(range, abs(X),'LineWidth',1.5)
grid on;
set(gca, 'FontSize', 12);
xlabel("k--->")
ylabel("| X[k] |")
title("Magnitude Plot for X(k) ")
xlim([min(range)-1,max(range)+1])
ylim([0, max(abs(X))+1])

% Plotting phase plot for X(k)
subplot(2,1,2)
stem(range, angle(X),'LineWidth',1.5)
grid on;
set(gca, 'FontSize', 12);
xlabel("k--->")
ylabel("< X[k] ")
title("Phase Plot for X(k) ")
xlim([min(range)-1,max(range)+1])
yticks([-pi, -pi/2, 0, pi/2, pi]);
yticklabels({'-π', '-π/2', '0', 'π/2', 'π'});

% Plotting result obtained from IDFT of X(k)
figure(3)
stem(range, new_x,'LineWidth',1.5)
grid on;
set(gca, 'FontSize', 12);
xlabel("n--->")
ylabel("Amplitude")
title("IDFT")
xlim([min(range)-1,max(range)+1])
ylim([0, max(x)+1])

% Plot for verifying our result using inverse operation
figure(4)
stem(range, new_x2,'LineWidth',1.5)
grid on;
set(gca, 'FontSize', 12);
xlabel("n--->")
ylabel("Amplitude")
title("IDFT (Calculated using inverse operation)")
xlim([min(range)-1,max(range)+1])
ylim([0, max(x)+1])
