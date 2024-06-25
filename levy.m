function y = levy(x)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    w = 1 + (x - 1)./4;
    y = sin(pi*w(:,1)).^2 + ...
        (w(:,1) - 1).^2 .* (1 + 10*sin(pi*w(:,1) + 1).^2) + ...
        (w(:,2) - 1).^2 .* (1 + sin(2*pi*w(:,2)).^2);
end

