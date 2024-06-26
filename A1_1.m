close all; clear; clc;

N = 50;
x0 = (rand(N, 2) - .5) * 10;
v0 = (rand(N, 2) - .5) * 2;
params.K = 1;
params.sigma = 1;
params.beta = 1;
tspan = [0,10,0.05];
figure();
[xs_eul, vs_eul] = explEulSchwarm(tspan, x0, v0, params, true, true);
[xs_heun, vs_heun] = heunSchwarm(tspan, x0, v0, params, true, true);

for i = 1:8
    % t ist in tspan, mehr Werte in der nähe vom Anfang des Zeitintervalls.
    t = ((i-1)/7.0)^5 * (tspan(2) - tspan(1)) + tspan(1);
    idx = my_utils.time2idx(tspan,t);

    subplot(4, 4, i);
    x = xs_eul(:,:,idx);
    v = vs_eul(:,:,idx);
    quiver(x(:, 1), x(:, 2), v(:, 1), v(:, 2), "Marker",".");
    title("Euler: t=" + num2str(t,3));
    axis([-6,6,-6,6]);

    subplot(4, 4, i+8);
    x = xs_heun(:,:,idx);
    v = vs_heun(:,:,idx);
    quiver(x(:, 1), x(:, 2), v(:, 1), v(:, 2), "Marker",".");
    title("Heun: t=" + num2str(t * tspan(2),3));
    axis([-6,6,-6,6]);
end


%% ===== Video rendern =====
% diese Sektion muss nach der ersten ausgeführt werden. 
my_utils.renderVideoOfQuiver(tspan, "videos/vergleichsVideo", [2000, 600], 30, ...
    xs_eul, vs_eul, "Euler", ...
    xs_heun, vs_heun, "Heun", ...
    (xs_heun + xs_eul)./2, vs_heun - vs_eul, "Unterschied");
