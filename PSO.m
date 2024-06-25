function [bestX,bestFx,xHist,bHist] = PSO(funcH,gebiet,params)
%PSO errechnet eine Annäherung zum globalen Minimum einer Funktion in 2 
%Variablen durch die Simulation eines Schwarmes. Als Output wird die 
%Position des Minimums (bestX), den Wert des Minimums (bestFx), der Verlauf
%der Positionen der Individuen (xHist) und der Verlauf der besten
%bisherigen Position (bHist). Dabei wird die Funktion gegeben durch funcH
%optimiert, mit gewissen Parametern in params, die sich auf das Verhalten
%des Schwarms auswirkt. 
%   funcH soll matrizzen von der Form [N, 2] entgegen nehmen können und der
%   Output von funcH soll die Form [N, 1] haben. 

    arguments
        funcH
        gebiet (1, 4) {mustBeNumeric}
        params {isfield(params, "omega"), ...
            isfield(params, "c_k"), ...
            isfield(params, "c_s"), ...
            isfield(params, "N"), ...
            isfield(params, "I_max")}
        % params.omega (1, 1) {mustBeInRange(params.omega, 0, 1)}
        % params.c_k (1, 1) {mustBeNumeric}
        % params.c_s (1, 1) {mustBeNumeric}
        % params.N (1, 1) {mustBePositive, mustBeInteger}
        % params.I_max (1, 1) {mustBePositive, mustBeInteger}
    end
    
    % ==== Initialisierung ====
    x1_min = gebiet(1);
    x1_max = gebiet(2);
    x2_min = gebiet(3);
    x2_max = gebiet(4);

    % gebiet: [x1_min, x1_max, x2_min, x2_max]
    % r in [0, 1] <=> r*(max - min) + min  in  [min, max]
    xs = rand(params.N, 2) .* (gebiet([2, 4]) - gebiet([1, 3])) + gebiet([1, 3]);
    % Länge des Geschwindigkeitsvektors je nach grösse des Gebietes
    % skalieren macht vielleicht Sinn..
    vs = (rand(params.N, 2) - 0.5) .* (gebiet([2, 4]) - gebiet([1, 3]));

    xHist = zeros(params.N, 2, params.I_max + 1);
    xHist(:,:,1) = xs;
    bestSoFarXs = xs;
    bHist = zeros(2, params.I_max + 1);
    
    bestSoFarFxs = funcH(xs);
    [m, m_idx] = min(bestSoFarFxs);
    bestX = xHist(m_idx, :, 1);
    bHist(:, 1) = bestX;
    bestFx = m;


    % ==== Schleife ====
    for j = 2:params.I_max+1
        r = rand(params.N, 1);
        s = rand(params.N, 1);
        vs = params.omega * vs ... 
            + params.c_k*r.*(bestSoFarXs - xHist(:,:,j-1)) ...
            + params.c_s*s.*(bestX - xHist(:,:,j-1));
        xHist(:,:,j) = xHist(:,:,j-1) + vs;

        % Punkte auf das Gebiet begrenzen
        xHist(xHist(:,1,j) > x1_max, 1, j) = x1_max;
        xHist(xHist(:,1,j) < x1_min, 1, j) = x1_min;
        xHist(xHist(:,2,j) > x2_max, 2, j) = x2_max;
        xHist(xHist(:,2,j) < x2_min, 2, j) = x2_min;
        
        newFxs = funcH(xHist(:,:,j));
        [m, idx] = min([bestSoFarFxs, newFxs], [], 2);
        bestSoFarXs = [
            bestSoFarXs(:,1) .* (idx == 1) + xHist(:,1,j) .* (idx == 2), bestSoFarXs(:,2) .* (idx == 1) + xHist(:,2,j) .* (idx == 2)
            ];
        bestSoFarFxs = m;
        
        [g, g_idx] = min(bestSoFarFxs);
        bestX = bestSoFarXs(g_idx,:);
        bestFx = g;

        bHist(:, j) = bestX;
    end
    
end