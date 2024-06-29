clear; close all; clc;


params.N = 100;
params.I_max = 100;
params.omega = 0.7;
params.c_k = 2;
params.c_s = 2;

gebiet = [-5.1 4.8 -5.1 4.8];

seed = 2;
rng(seed)
[bestX_22, bestFx_22, xHist_22, bHist_22] = PSO(@shubert, gebiet, params);
rng(seed)
[bestX_02, bestFx_02, xHist_02, bHist_02] = PSO(@shubert, gebiet, setfield(params, "c_k", 0));
rng(seed)
[bestX_20, bestFx_20, xHist_20, bHist_20] = PSO(@shubert, gebiet, setfield(params, "c_s", 0));

[X_s, Y_s] = meshgrid(gebiet(1):0.1:gebiet(2), gebiet(3):0.1:gebiet(4));
Z_s = arrayfun(@(x, y) shubert([x, y]), X_s, Y_s);

f = figure();
for i = 1:4
    t = int64(((i-1)*params.I_max)/3)+1;

    subplot(3, 4, i);
    hold on;
    contour(X_s, Y_s, Z_s);
    plot(xHist_22(:,1,t), xHist_22(:,2,t), ".");
    plot(bHist_22(1,t), bHist_22(2,t), "*");

    title("Shubert: $c_k = c_s = 2, \, i = " + num2str(t) + "$", "Interpreter","latex", "FontSize",12);
    hold off;


    subplot(3, 4, i+4);
    hold on;
    contour(X_s, Y_s, Z_s);
    plot(xHist_02(:,1,t), xHist_02(:,2,t), ".");
    plot(bHist_02(1,t), bHist_02(2,t), "*");

    title("Shubert: $c_k = 0, \, c_s = 2, \, i = " + num2str(t) + "$", "Interpreter","latex", "FontSize",12);
    hold off;


    subplot(3, 4, i+8);
    hold on;
    contour(X_s, Y_s, Z_s);
    plot(xHist_20(:,1,t), xHist_20(:,2,t), ".");
    plot(bHist_20(1,t), bHist_20(2,t), "*");

    title("Shubert: $c_k = 2, \, c_s = 0, \, i = " + num2str(t) + "$", "Interpreter","latex", "FontSize",12);
    hold off;

end
sgtitle("PSO der Shubert-Funktion mit verschiedenen $c_k$, $c_s$ und $\omega = 0.7, \, N = 100$", "Interpreter","latex", "FontSize",15)
f.Position = [0,0,1100,700];