clear;
M = 4*randn([1000 1]);
T = M(1:750);
V = M(751:1000);

LL = zeros([11 1]);
sigma=[0.001 0.1 0.2 0.9 1 2 3 5 10 20 100];
p_est = zeros([250 11]);
p = zeros([250 11]);
for j=1:11
    sig=sigma(j);
    for i=1:250
        p_est(i,j) = sum(exp((-1*((V(i)-T).^2))/(2*(sig^2)))/(750*sig*sqrt(2*pi)));
        p(i,j) = exp(-1*(V(i)^2)/32)/(4*sqrt(2*pi));
    end
    LL(j) = sum(log(p_est(:,j)));
end
[M, I] = max(LL);
fprintf('Sigma for best LL value = %f\n', sigma(I));


D = sum((p-p_est).^2);
[M_d, I_d] = min(D);
fprintf('Sigma for best D value = %f\n', sigma(I_d));
fprintf('D value for sigma which yielded the best LL = %f\n', D(I));

figure; plot(log(sigma), LL); title("LL vs log(sigma)");
figure; plot(log(sigma), D); title("D vs log(sigma)");

