%test noise integration

figure;
for i=1:500,
    noise = randn(10000,1);
    noise_int = cumsum(noise);
    plot(noise_int);
    if i==1, hold on; end
    drawnow;
end
noise = randn(10000,1);
noise_int = cumsum(noise);
plot(noise_int,'linewidth',4);
plot(3*sqrt(1:length(noise)),'k:','linewidth',4)
plot(-3*sqrt(1:length(noise)),'k:','linewidth',4)
hold off;

