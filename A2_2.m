clc; close all; clear;

params.N = 100;
params.I_max = 150;
params.omega = 0.7;
params.c_k = 2;
params.c_s = 2;

gebiet_l = [-10 10 -10 10];
gebiet_s = [-5 4.8 -5 4.8];

rng(42)

[bestX_l, bestFx_l, xHist_l, bHist_l] = PSO(@levy, gebiet_l, params);
[bestX_s, bestFx_s, xHist_s, bHist_s] = PSO(@shubert, gebiet_s, params);

[X_l, Y_l] = meshgrid(gebiet_l(1):0.1:gebiet_l(2), gebiet_l(3):0.1:gebiet_l(4));
Z_l = arrayfun(@(x, y) levy([x, y]), X_l, Y_l);
[X_s, Y_s] = meshgrid(gebiet_s(1):0.1:gebiet_s(2), gebiet_s(3):0.1:gebiet_s(4));
Z_s = arrayfun(@(x, y) shubert([x, y]), X_s, Y_s);

f1 = figure();
for i = 1:8
    t = int64(((i-1)*params.I_max)/7)+1;
    subplot(4, 4, i+8);
    hold on;
    contour(X_l, Y_l, Z_l);
    plot(xHist_l(:,1,t), xHist_l(:,2,t), ".");
    plot(bHist_l(1,t), bHist_l(2,t), "*");

    title("Levy: $i = " + num2str(t) + "$", "Interpreter","latex", "FontSize",12);
    hold off;

    subplot(4, 4, i);
    hold on;
    contour(X_s, Y_s, Z_s);
    plot(xHist_s(:,1,t), xHist_s(:,2,t), ".");
    plot(bHist_s(1,t), bHist_s(2,t), "*");

    title("Shubert: $i = " + num2str(t) + "$", "Interpreter","latex", "FontSize",12);
    hold off;
end
sgtitle("Partikelschwarmoptimierung mit $N = 100,\, I_{max} = 150,\, \omega = 0.7,\, c_k = c_s = 2$", "Interpreter","latex", "FontSize", 20)
f1.Position = [0, 0, 1000, 1000];

%% ===== Beispiel für falsches globales Minimum =====
rng(1);
[bestX_s, bestFx_s, xHist_s, bHist_s] = PSO(@shubert, gebiet_s, params);
[X_s, Y_s] = meshgrid(gebiet_s(1):0.1:gebiet_s(2), gebiet_s(3):0.1:gebiet_s(4));
Z_s = arrayfun(@(x, y) shubert([x, y]), X_s, Y_s);
f2 = figure();
for i = 1:9
    t = int64(((i-1)*params.I_max)/8)+1;
    subplot(3, 3, i);
    hold on;
    contour(X_s, Y_s, Z_s);
    plot(xHist_s(:,1,t), xHist_s(:,2,t), ".");
    plot(bHist_s(1,t), bHist_s(2,t), "*");

    title("$i = " + num2str(t) + "$", "Interpreter","latex");
    hold off;
end
sgtitle("Partikelschwarmoptimierung Shubert-Funktion (falsches globales Minimum)", "Interpreter","latex", "FontSize", 20)
f2.Position = [0, 0, 1000, 1000];



%% ===== Video Rendern =====
my_utils.renderVideoOfParticlesOnFunction("PSO", @shubert, xHist_s, bHist_s, gebiet_s, "Shubert-Funktion PSO");