function dxvdt = sysDiffGlgen(x, v, params)
%SYSDIFFGLGEN Summary of this function goes here
%   Detailed explanation goes here

    [N, ~] = size(x);
    if (N ~= size(v, 1) || size(x, 2) ~= 2 || size(v, 2) ~= 2)
        error("Input arguments are of incorrect size");
    end
    % mehrere Grössenordnungen langsamer als die Funktion adjazenzMatrix()
    % eta = @(y) (params.K ./ (params.sigma^2 + y).^params.beta);
    % A_x = zeros(N);
    % for i = 1:N
    %     for j = 1:N
    %         A_x(i, j) = eta(norm(x(i,1:2) - x(j,1:2)));
    %     end
    % end
    A_x = adjacencyMatrix(x, params);
    
    D_x = diag(A_x*ones(N, 1));

    dxvdt = [v, -(D_x - A_x)*v];
    if (size(dxvdt) ~= [N, 4])
        error("something in the implementation of sysDiffGlgen is wrong");
    end
end

function A_x = adjacencyMatrix(x, params)
    %norm_2 = @(coord1, coord2) sqrt(coord1.^2 + coord2.^2);
    diff_coord1 = x(:, 1) - x(:, 1).';
    diff_coord2 = x(:, 2) - x(:, 2).';
    eta = @(y) (params.K ./ ((params.sigma^2 + y).^params.beta));
    diff = cat(3, diff_coord1, diff_coord2);
    A_x = eta(vecnorm(diff, 2, 3)); % vielleicht sollte man die Norm noch quadrieren?
    %A_x = eta(norm_2(diff_coord1, diff_coord2));
end