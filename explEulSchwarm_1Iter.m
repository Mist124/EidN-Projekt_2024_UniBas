function [x, v] = explEulSchwarm_1Iter(t_delta, x_init, v_init, params)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    arguments
        t_delta (1, 1) {mustBeNumeric}
        x_init (:, 2) {mustBeNumeric}
        v_init (:, 2) {mustBeNumeric}
        params
    end
    
    dxvdt = sysDiffGlgen(x_init, v_init, params);
    xv = [x_init, v_init] + t_delta * dxvdt;
    x = xv(:, 1:2);
    v = xv(:, 3:4);
end

