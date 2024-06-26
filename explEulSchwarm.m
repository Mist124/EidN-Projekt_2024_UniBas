function [x, v] = explEulSchwarm(tspan, x0, v0, params, verlauf_speichern, fortschritt_anzeigen)
%EXPLEULSCHWARM gibt zwei 3-dimensionale Arrays zurück; 
%Die Positionen (x) und Geschwindigkeiten (v) über die Zeit des Schwarmes
%generiert durch das explizite Eulerverfahren.
%   x und v sind von der Form Nx2xT, wobei N die Anzahl von Agenten und T
%   die Anzahl Iterationen + 1 sind
%   x(:,:,1) = x0, v(:,:,1) = v0
    arguments 
        tspan (1, 3) {mustBeNumeric}
        x0 (:, 2) {mustBeNumeric}
        v0 (:, 2) {mustBeNumeric}
        params
        verlauf_speichern (1,1) logical = 0
        fortschritt_anzeigen (1,1) logical = 0
    end

    iterFktn = @(t_delta, x_init, v_init) explEulSchwarm_1Iter(t_delta, x_init, v_init, params);
    [x, v] = schwarmIterierer(iterFktn, tspan, x0, v0, verlauf_speichern, fortschritt_anzeigen);
end

