close all; clc; clear;

[X, Y] = meshgrid(-10:0.05:10);
Z = arrayfun(@(x, y) shubert([x, y]), X, Y);

subplot(2, 2, 1);
h = surf(X, Y, Z);
set(h, 'EdgeAlpha',0.3)
xlabel("x_1");
ylabel("x_2");
zlabel("f(x)");
title("Shubert surf-Plot");

subplot(2, 2, 2);
contour(X, Y, Z);
xlabel("x_1");
ylabel("x_2");
title("Shubert contour-Plot");

[X, Y] = meshgrid(-5.1:0.05:5.1);
Z = arrayfun(@(x, y) levy([x, y]), X, Y);
subplot(2, 2, 3);
h = surf(X, Y, Z);
set(h, 'EdgeAlpha',0.3)
xlabel("x_1");
ylabel("x_2");
zlabel("f(x)");
title("Levy surf-Plot");

subplot(2, 2, 4);
contour(X, Y, Z);
xlabel("x_1");
ylabel("x_2");
title("Levy contour-Plot");
