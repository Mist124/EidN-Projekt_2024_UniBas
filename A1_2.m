clc; close all; clear;

rng(42);
N = 20;
x0 = (rand(N, 2) - .5) * 10;
v0 = (rand(N, 2) - .5) * 2;
params.K = 1;
params.sigma = 2;
params.beta = 4;
tspan = [0,1,10^-6];% sollte [. . 10^-6] sein
[x_ref, v_ref] = heunSchwarm(tspan, x0, v0, params);

%%
close all; clc;

delta_ts = [0.1 0.05 0.01 0.005 0.001];
no_vals = length(delta_ts);
err_ExpEul = zeros(no_vals, 1);
err_Heun = err_ExpEul;
xEE = zeros([size(x_ref) no_vals]);
vEE = zeros([size(x_ref) no_vals]);
xH = zeros([size(x_ref) no_vals]);
vH = zeros([size(x_ref) no_vals]);

for i = 1:no_vals
    [x, v] = explEulSchwarm([tspan(1:2) delta_ts(i)], x0, v0, params);
    xEE(:,:,i) = x;
    vEE(:,:,i) = v;
    [x, v] = heunSchwarm([tspan(1:2) delta_ts(i)], x0, v0, params);
    xH(:,:,i) = x;
    vH(:,:,i) = v;
    err_ExpEul(i) = norm(x_ref(1,:) - xEE(1, :, i)) + norm(v_ref(1,:) - vEE(1, :, i));
    err_Heun(i)   = norm(x_ref(1,:) -  xH(1, :, i)) + norm(v_ref(1,:) -  vH(1, :, i));
end

xs_ref = 10.^([-3,-2,-1]).';

c_lin = err_ExpEul(3) / xs_ref(2) ...
    * 1.15; % <-----------------------------, dieser Faktor verhindert, dass die Vergleichsgeraden mit dem Verlauf der eigentlichen Kurven Überlappen.
c_quad = err_Heun(3) / xs_ref(2)^2 ... %   /
    * 1.15; % <---------------------------/

loglog(delta_ts, [err_ExpEul, err_Heun], "-*", xs_ref, [c_lin*xs_ref, c_quad*xs_ref.^2], "--");
title("Vergleich Explizites Euler- und Heunverfahren")
legend("Fehler ExpEul", "Fehler Heun", "vgl.Gerade dt", "vgl.Gerade dt^2", "Location", "southeast");
xlabel("dt")
ylabel("Norm des Fehlers")

