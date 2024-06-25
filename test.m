clc;
A = [1 2; 3 4; 9 8];
[m, idx] = min(A,[],2)
xsPrev = [2 3; 4 5; 6 7];
xs = [8 9; 10 11; 12 13];

x1s = [xsPrev(:,1) .* (idx == 1) + xs(:,1) .* (idx == 2)]
x2s = [xsPrev(:,2) .* (idx == 1) + xs(:,2) .* (idx == 2)]
res = [x1s,x2s]
%%
clc;
dts = [0.1, 0.05, 0.01, 0.005, 0.001, 10^-6];
for dt = dts
    iters = 0;
    time = 0;
    while time <= 1
        time = time + dt;
        iters = iters + 1;
    end
    disp("durchgeführte iterationen: " + num2str(iters));
    disp("sollten sein: " + num2str(1/dt));
end