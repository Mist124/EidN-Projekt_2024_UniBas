close all; clc; clear;

[X, Y] = meshgrid(-10:0.1:10);
Z = arrayfun(@(x, y) shubert([x, y]), X, Y);
subplot(2, 2, 1);
surf(X, Y, Z);
xlabel("x_1");
ylabel("x_2");

title("Shubert Oberflächengraphen");
subplot(2, 2, 2);
contour(X, Y, Z);
xlabel("x_1");
ylabel("x_2");
title("Shubert Konturgraphen");

[X, Y] = meshgrid(-5.1:0.1:5.1);
Z = arrayfun(@(x, y) levy([x, y]), X, Y);
subplot(2, 2, 3);
surf(X, Y, Z);
xlabel("x_1");
ylabel("x_2");
title("Levy Oberflächengraphen");
subplot(2, 2, 4);
contour(X, Y, Z);
xlabel("x_1");
ylabel("x_2");
title("Levy Konturgraphen");
