clc; close all; clear;

params.N = 100;
params.I_max = 200;
params.omega = 0.7;
params.c_k = 2;
params.c_s = 2;

gebiet_l = [-10 10 -10 10];
gebiet_s = [-5 4 -5 4];

[bestX_l, bestFx_l, xHist_l, bHist_l] = PSO(@levy, gebiet_l, params);
[bestX_s, bestFx_s, xHist_s, bHist_s] = PSO(@shubert, gebiet_s, params);

[X_l, Y_l] = meshgrid(gebiet_l(1):0.1:gebiet_l(2), gebiet_l(3):0.1:gebiet_l(4));
Z_l = arrayfun(@(x, y) levy([x, y]), X_l, Y_l);
[X_s, Y_s] = meshgrid(gebiet_s(1):0.1:gebiet_s(2), gebiet_s(3):0.1:gebiet_s(4));
Z_s = arrayfun(@(x, y) shubert([x, y]), X_s, Y_s);

figure();
for i = 1:16
    t = int64(((i-1)*params.I_max)/15)+1;
    subplot(4, 4, i);
    hold on;
    contour(X_l, Y_l, Z_l);
    plot(xHist_l(:,1,t), xHist_l(:,2,t), ".");
    plot(bHist_l(1,t), bHist_l(2,t), "*");

    title("i = " + num2str(t));
    hold off;
end

figure();
for i = 1:16
    t = int64(((i-1)*params.I_max)/15)+1;
    subplot(4, 4, i);
    hold on;
    contour(X_s, Y_s, Z_s);
    plot(xHist_s(:,1,t), xHist_s(:,2,t), ".");
    plot(bHist_s(1,t), bHist_s(2,t), "*");

    title("i = " + num2str(t));
    hold off;
end




%%
my_utils.renderVideoOfParticlesOnFunction("PSO", funcH, xHist, bHist, gebiet, "levy Funktion PSO");