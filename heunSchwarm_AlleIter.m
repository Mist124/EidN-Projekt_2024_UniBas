function [x, v] = heunSchwarm_AlleIter(tspan, x0, v0, params)
%HEUNSCHWARM gibt zwei 3-dimensionale Arrays zurück; 
%Die Positionen (x) und Geschwindigkeiten (v) über die Zeit des Schwarmes
%generiert durch das Heunverfahren.
%   x und v sind von der Form Nx2xT, wobei N die Anzahl von Agenten und T
%   die Anzahl Iterationen + 1 sind
%   x(:,:,1) = x0, v(:,:,1) = v0

    arguments
        tspan (1, 3) {mustBeNumeric}
        x0 (:, 2) {mustBeNumeric}
        v0 (:, 2) {mustBeNumeric}
        params
    end

    T_init = tspan(1);
    T_end = tspan(2);
    t_delta = tspan(3);
    iters = my_utils.time2idx(tspan, T_end)-1;
    x = zeros([size(x0), iters + 1]);
    v = x;
    x(:,:,1) = x0;
    v(:,:,1) = v0;
    
    for i = 1:iters
        dxvdt = sysDiffGlgen(x(:,:,i), v(:,:,i), params);
        [x_tilde, v_tilde] = explEulSchwarm_1Iter(t_delta, x(:,:,i), v(:,:,i), params);
        dxvdt_tilde = sysDiffGlgen(x_tilde, v_tilde, params);
        
        xv = [x(:,:,i), v(:,:,i)] + 0.5 * t_delta * (dxvdt + dxvdt_tilde);
        x(:,:,i+1) = xv(:, 1:2);
        v(:,:,i+1) = xv(:, 3:4);
    end
end