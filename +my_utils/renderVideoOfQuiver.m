function renderVideoOfQuiver(tspan, videoName, resolution, scaling, x_vals, v_vals, titlePrefix)
%RENDERVIDEOOFQUIVER Summary of this function goes here
%   Detailed explanation goes here
    arguments
        tspan (1, 3) {mustBeNumeric}
        videoName string
        resolution (1, 2) {mustBeNumeric} = [1000, 800]
        scaling (1, 1) {mustBeNumeric} = 1
    end
    arguments (Input, Repeating)
        x_vals (:, 2, :) {mustBeNumeric}
        v_vals (:, 2, :) {mustBeNumeric}
        titlePrefix string
    end

    no_plots = numel(titlePrefix);
    sizeOfValues = size(x_vals{1});
    
    for idx = 1:no_plots
        if any(size(x_vals{idx}) ~= sizeOfValues)
            error("x_vals must all be of the same size");
        end
        if any(size(v_vals{idx}) ~= sizeOfValues)
            error("v_vals must all be of the same size");
        end
    end
    
    currObj = VideoWriter(videoName ,"MPEG-4");
    currObj.FrameRate = 20;
    
    open(currObj)
    try
        fig = figure();
        fig.Position(1:2) = [0,0];
        for i = 1:sizeOfValues(3)
            clf
            for idx = 1:no_plots
                subplot(1, no_plots, idx);
                quiver(x_vals{idx}(:,1,i), x_vals{idx}(:,2,i), v_vals{idx}(:,1,i)*scaling, v_vals{idx}(:,2,i)*scaling, 0);
                fig.Position(3:4) = resolution;
                title(titlePrefix{idx} + ", t = " + num2str(my_utils.idx2time(tspan,i), '%.2f'));
                axis([-10 10 -10 10])
            end
            frame = getframe(gcf);
            writeVideo(currObj,frame);
        end
    catch ME
        close(currObj);
        rethrow(ME);
    end
end

