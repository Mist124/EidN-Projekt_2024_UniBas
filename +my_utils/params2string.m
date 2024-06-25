function s = params2string(params, tspan)
%PARAMS2STRING Summary of this function goes here
%   Detailed explanation goes here
    arguments
        params
        tspan = []
    end
    s = "K=" + num2str(params.K, "%.2f") + ...
        ", sigma=" + num2str(params.sigma, "%.2f") + ...
        ", beta=" + num2str(params.beta, "%.2f");
    if numel(tspan) == 3
        s = s + ", tspan=" + mat2str(tspan);
end

