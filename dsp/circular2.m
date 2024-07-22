clc;
clear;

% Asking for length of sequences
len1 = input("Enter no. of terms you want in sequence x1[n] : ");
len2 = input("Enter no. of terms you want in sequence x2[n] : ");

n1 = 0:1:len1-1;
n2 = 0:1:len2-1;

x1 = [];
x2 = [];

if len1>len2
    n = len1;
else
    n = len2;
end

range = 0:1:n-1;

disp(newline);
% User input for sequence x1[n]
disp("Enter values in sequence x1[n] :");
for i=1 : length(n1)
    x1(i) = input("> ");
end

disp(newline);
% User input for sequence x2[n]
disp("Enter values in sequence x2[n] :");
for i=1 : length(n2)
    x2(i) = input("> ");
end

if len2>len1
    x1 = [x1 zeros(1,abs(len2-len1))];
end
if len1>len2
    x2 = [x2 zeros(1,abs(len1-len2))];
end

x1 = x1';
x2 = x2';

Dn = ones(n, n); 
for i = 2:n
    for k = 2:n
        Dn(i, k) = exp(-1j*2*pi*(k-1)*(i-1)/n);
    end
end

% Calculation DFT X1(k)
X1 = Dn * x1;

% Setting a small threshold for comparison
threshold = 1e-10;
for j = 1:n
    if abs(real(X1(j))) < threshold
        X1(j) = complex(0, imag(X1(j)));
    end
    if abs(imag(X1(j))) < threshold
        X1(j) = complex(real(X1(j)), 0);
    end
end

% Calculation DFT X2(k)
X2 = Dn * x2;

% Setting a small threshold for comparison
threshold = 1e-10;
for j = 1:n
    if abs(real(X2(j))) < threshold
        X2(j) = complex(0, imag(X2(j)));
    end
    if abs(imag(X2(j))) < threshold
        X2(j) = complex(real(X2(j)), 0);
    end
end

% DFT of convoluted sequence
Y2 = X1.*X2;

% Calculated IDFT to get sequence
IDFT_Y2 = inv(Dn)*Y2;

disp(newline)
disp("X1(k) = ");
disp(X1);

disp(newline)
disp("X2(k) = ");
disp(X2);

disp(newline)
disp("Y2(k) = ");
disp(Y2);

disp(newline)
disp("y2[n] = ");
disp(IDFT_Y2);


