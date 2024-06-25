function idx = time2idx(tspan, t)
%TIME2IDX Übersetzt von Zeit zu Index, gegeben eine Zeitspanne.
%   Detailed explanation goes here
    arguments
        tspan (1, 3) {mustBeNumeric}
        t (1, 1) {mustBeNumeric}
    end

    T_init = tspan(1);
    T_end = tspan(2);
    t_delta = tspan(3);
    if (t > T_end || t < T_init)
        warning("t is outside the specified timespan");
    end
    idx = int64((t - T_init)/t_delta) + 1;
end

