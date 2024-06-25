function y = shubert(x)
%SHUBERT Summary of this function goes here
%   Detailed explanation goes here
    s1 = 0;
    s2 = 0;
    for i = 1:5
        s1 = s1 + i .* cos((i + 1)*x(:,1) + i);
        s2 = s2 + i .* cos((i + 1)*x(:,2) + i);
    end
    y = s1 .* s2;
end

