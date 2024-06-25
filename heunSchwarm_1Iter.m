function [x, v] = heunSchwarm_1Iter(t_delta, x_init, v_init, params)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    arguments
        t_delta (1, 1) {mustBeNumeric}
        x_init (:, 2) {mustBeNumeric}
        v_init (:, 2) {mustBeNumeric}
        params
    end
    
    dxvdt = sysDiffGlgen(x_init(:,:), v_init(:,:), params);
    [x_tilde, v_tilde] = explEulSchwarm_1Iter(t_delta, x_init(:,:), v_init(:,:), params);
    dxvdt_tilde = sysDiffGlgen(x_tilde, v_tilde, params);
    
    xv = [x_init(:,:), v_init(:,:)] + 0.5 * t_delta * (dxvdt + dxvdt_tilde);
    x = xv(:, 1:2);
    v = xv(:, 3:4);
end

