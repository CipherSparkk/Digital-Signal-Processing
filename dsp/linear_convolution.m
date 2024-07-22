clc;
clear;

y1 = input("Enter no. of terms you want in sequence x[n] : ");
y2 = input("Enter no. of terms you want in sequence h[n] : ");

x = [];
h = [];

n1 = 0:y1-1;
n2 = 0:y2-1;

disp(newline);
disp("Enter values in sequence x[n] :");
for i=1 : y1
    x(i) = input("> ");
end

pos1 = input("Enter 0th index position for x[n] : ");
n1 = n1-pos1+1;

disp(newline);
disp("Enter values in sequence h[n] :");
for i=1 : y2
    h(i) = input("> ");
end

pos2 = input("Enter 0th index position for h[n] : ");
n2 = n2-pos2+1;

matrix = zeros(length(h), length(x)); 

mn = min(n1) + min(n2);
mx = max(n1) + max(n2); 
range = mn:mx;

for i=1 : length(x)
    for j=1 : length(h)
        matrix(i,j) = x(i)*h(j);
        j = j+1;
    end
    i = i+1;
end


sum_arr = [];

m=1;
for i=1: length(matrix)
    k=i;
    sum_arr(m) = 0;
    for j=1:i
        sum_arr(m) = sum_arr(m) +  matrix(k,j);
        k = k-1;
        j = j+1;
    end
    i = i+1;
    m = m+1;
end

i = length(matrix);
for j=2: length(matrix)
    new_i = i;
    sum_arr(m) = 0;
    for new_j = j : i
        sum_arr(m) = sum_arr(m) +  matrix(new_i,new_j);
        new_j = j+1;
        new_i = new_i-1;
    end
    j = j+1;
    m = m+1;
end

% Original Sequence
figure(1)
subplot(2,1,1)
stem(n1,x,'LineWidth',2)
set(gca, 'FontSize', 12);
xlabel("n--->")
ylabel("Amplitude")
title("x[n]")
xlim([min(n1)-1,max(n1)+1])
ylim([min(x)-2,max(x)+2])

subplot(2,1,2)
stem(n2,h,'LineWidth',2)
set(gca, 'FontSize', 12);
xlabel("n--->")
ylabel("Amplitude")
title("h[n]")
xlim([min(n2)-1,max(n2)+1])
ylim([min(h)-2,max(h)+2])

% Convolved Sequence
figure(2);
stem(range,sum_arr,'LineWidth',2)
set(gca, 'FontSize', 12);
xlabel("n--->")
ylabel("Amplitude")
title("y[n] = x[n] * h[n]")
xlim([min(range)-1,max(range)+1])
ylim([min(sum_arr)-2,max(sum_arr)+2])
