close all; clc; clear;

[X_s, Y_s] = meshgrid(-5.1:0.05:5.1);
Z_s = arrayfun(@(x, y) shubert([x, y]), X_s, Y_s);

[X_l, Y_l] = meshgrid(-10:0.05:10);
Z_l = arrayfun(@(x, y) levy([x, y]), X_l, Y_l);
%%

subplot(2, 2, 1);
h = surf(X_s, Y_s, Z_s);
set(h, 'EdgeAlpha',0.1)
xlabel("$x_1$","Interpreter","latex","FontSize",13);
ylabel("$x_2$","Interpreter","latex","FontSize",13);
zlabel("$f(x)$","Interpreter","latex","FontSize",13);
title("Shubert surf-Plot","Interpreter","latex","FontSize",15);

subplot(2, 2, 2);
contour(X_s, Y_s, Z_s);
xlabel("$x_1$","Interpreter","latex","FontSize",13);
ylabel("$x_2$","Interpreter","latex","FontSize",13);
title("Shubert contour-Plot","Interpreter","latex","FontSize",15);

subplot(2, 2, 3);
h = surf(X_l, Y_l, Z_l);
set(h, 'EdgeAlpha',0.1)
xlabel("$x_1$","Interpreter","latex","FontSize",13);
ylabel("$x_2$","Interpreter","latex","FontSize",13);
zlabel("$f(x)$","Interpreter","latex","FontSize",13);
title("Levy surf-Plot","Interpreter","latex","FontSize",15);

subplot(2, 2, 4);
contour(X_l, Y_l, Z_l);
xlabel("$x_1$","Interpreter","latex","FontSize",13);
ylabel("$x_2$","Interpreter","latex","FontSize",13);
title("Levy contour-Plot","Interpreter","latex","FontSize",15);
