function t = idx2time(tspan, idx)
%IDX2TIME Übersetzt von Index zu Zeit, gegeben eine Zeitspanne. 
%   Detailed explanation goes here
    arguments
        tspan (1, 3) {mustBeNumeric}
        idx (1, 1) {mustBeNumeric}
    end
    T_init = tspan(1);
    T_end = tspan(2);
    t_delta = tspan(3);
    t = (idx-1)*t_delta + T_init;
    if (t > T_end || t < T_init)
        warning("idx is outside the timespan range");
    end
end

