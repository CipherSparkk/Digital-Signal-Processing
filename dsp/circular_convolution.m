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

% Calculating circular convolution using Circulant matrix method
matrix = zeros(n, n);
for j = 1:n
    for i = 1:n
        pos = mod(j - i + 1, n);
        if pos == 0
            pos = n;
        end
        matrix(j, i) = x2(pos);
    end
end

% Resulted sequence 
y1 = matrix * x1;
disp(newline);
disp("y1[n] = ");
disp(y1);

figure(1);
subplot(2,1,1)
stem(range,x1,'LineWidth',2)
grid on;
set(gca, 'FontSize', 12);
xlabel("n--->")
ylabel("Amplitude")
xlim([min(range)-1,max(range)+1])
xticks(range)
ylim([0,max(x1)+1])
title("x1 [n]")

subplot(2,1,2)
stem(range,x2,'LineWidth',2)
grid on;
set(gca, 'FontSize', 12);
xlabel("n--->")
ylabel("Amplitude")
xlim([min(range)-1,max(range)+1])
xticks(range)
ylim([0,max(x2)+1])
title("x2 [n]")

% Plotting magnitude plot for Y1(k)
figure(2)
stem(range, y1,'LineWidth',1.5)
grid on;
set(gca, 'FontSize', 12);
xlabel("n--->")
ylabel("Amplitude")
title("y1 [n]")
xlim([min(range)-1,max(range)+1])
xticks(range)
ylim([0, max(abs(y1))+1])


