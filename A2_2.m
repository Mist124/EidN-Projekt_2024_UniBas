clc; close all; clear;

params.N = 100;
params.I_max = 200;
params.omega = 0.7;
params.c_k = 0.02;
params.c_s = 0.02;

gebiet = [-10 10 -10 10];

funcH = @(x) levy(x);

[bestX,bestFx,xHist,bHist] = PSO(funcH, gebiet, params);

[X, Y] = meshgrid(gebiet(1):0.1:gebiet(2), gebiet(3):0.1:gebiet(4));
Z = arrayfun(@(x, y) funcH([x, y]), X, Y);

for i = 1:9
    t = int64(i * (params.I_max/9)) + 1;
    subplot(3, 3, i);
    hold on;
    contour(X, Y, Z);
    plot(xHist(:,1,t), xHist(:,2,t), ".");
    plot(bHist(1,t), bHist(2,t), "*");

    title("t = " + num2str(t));
    hold off;
end

%axis([-5.1 5.1 -5.1 5.1]);
my_utils.renderVideoOfParticlesOnFunction("bruh", funcH, xHist, bHist, gebiet, "levy Funktion PSO");