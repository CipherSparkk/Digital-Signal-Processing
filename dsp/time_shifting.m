y = input("Enter no. of terms in sequence: ");
n = 0:y-1;

x = [];

disp("Enter values in sequence: ");
for i=1 : length(n)
    x(i) = input("> ");
end

pos = input("Enter position for 0th index in x[n]: ");

new_n = n-pos+1;

shifted_n = input("Enter position by which you want to shift (k) in x[n+k] : ");
shifted_n = new_n + shifted_n;

figure(1);
subplot(2,1,1)
stem(new_n,x,'LineWidth',2)
xlabel("n--->")
ylabel("Amplitude")
xlim([min(new_n)-1,max(new_n)+1])
ylim([min(x)-2,max(x)+2])
title("Original Sequence : x[n]")

subplot(2,1,2)
stem(shifted_n,x,'LineWidth',2)
xlabel("n--->")
ylabel("Amplitude")
xlim([min(shifted_n)-1,max(shifted_n)+1])
ylim([min(x)-2,max(x)+2])
title("Shifted Sequence : y[n]")


