function renderVideoOfParticlesOnFunction(videoName, funcH, xHist, bHist, gebiet, titlePrefix, resolution)
%RENDERVIDEOOFPARTICLESONFUNCTION Summary of this function goes here
%   Detailed explanation goes here
    arguments
        videoName string
        funcH
        xHist (:, 2, :) {mustBeNumeric}
        bHist (2, :) {mustBeNumeric}
        gebiet (1, 4) {mustBeNumeric}
        titlePrefix string
        resolution (1, 2) {mustBeNumeric} = [1000, 800]
    end

    iters = size(xHist, 3);
    
    
    if size(bHist, 2) ~= iters
        error("bHist must have fitting dimensions to xHist: " + ...
            "currently they have sizes " + num2str(size(bHist, 2)) + ...
            " and " + num2str(iters) + ".");
    end

    
    [X, Y] = meshgrid(gebiet(1):0.1:gebiet(2), gebiet(3):0.1:gebiet(4));
    Z = arrayfun(@(x, y) funcH([x, y]), X, Y);

    
    currObj = VideoWriter(videoName ,"MPEG-4");
    currObj.FrameRate = 20;
    
    open(currObj)
    try
        fig = figure();
        fig.Position(1:2) = [0,0];
        for t = 1:iters
            clf
            fig.Position(3:4) = resolution;
            
            title(titlePrefix + " t = " + num2str(t));
            hold on;
            contour(X, Y, Z);
            plot(xHist(:,1,t), xHist(:,2,t), ".");
            plot(bHist(1,t), bHist(2,t), "*");
            hold off;
            axis(gebiet);

            frame = getframe(gcf);
            writeVideo(currObj,frame);
        end
    catch ME
        close(currObj);
        rethrow(ME);
    end

end

