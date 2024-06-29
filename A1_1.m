close all; clear; clc;

N = 50;
x0 = (rand(N, 2) - .5) * 10;
v0 = (rand(N, 2) - .5) * 2;
params.K = 1;
params.sigma = 1;
params.beta = 1;
tspan = [0,10,0.05];
rng(212)
figure();
[xs_eul, vs_eul] = explEulSchwarm(tspan, x0, v0, params, true, true);
[xs_heun, vs_heun] = heunSchwarm(tspan, x0, v0, params, true, true);

for i = 1:8
    % t ist in tspan, mehr Werte in der Nähe vom Anfang des Zeitintervalls, da dort mehr passiert.
    t = (i/8.0)^4 * (tspan(2) - tspan(1)) + tspan(1);
    idx = my_utils.time2idx(tspan,t);
    actual_t = my_utils.idx2time(tspan, idx);

    subplot(4, 4, i);
    x = xs_eul(:,:,idx);
    v = vs_eul(:,:,idx);
    quiver(x(:, 1), x(:, 2), v(:, 1), v(:, 2), "Marker",".");
    title("Euler: $t=" + num2str(actual_t,3)+"$", "Interpreter","latex", "FontSize",12);
    axis([-7,7,-7,7]);

    subplot(4, 4, i+8);
    x = xs_heun(:,:,idx);
    v = vs_heun(:,:,idx);
    quiver(x(:, 1), x(:, 2), v(:, 1), v(:, 2), "Marker",".");
    title("Heun: $t=" + num2str(actual_t,3)+"$", "Interpreter","latex", "FontSize",12);
    axis([-7,7,-7,7]);
end

sgtitle("Schwarmsimulation mit Heun- und exp. Euler-Verf.: $K = 1, \sigma = \beta = 1, N = 50$", "interpreter", "latex", "FontSize", 15)

%% ===== Video rendern =====
% diese Sektion muss nach der ersten ausgeführt werden. 
my_utils.renderVideoOfQuiver(tspan, "videos/vergleichsVideo", [2000, 600], 10, ...
    xs_eul, vs_eul, "Euler", ...
    xs_heun, vs_heun, "Heun", ...
    (xs_heun + xs_eul)./2, vs_heun - vs_eul, "Unterschied");
