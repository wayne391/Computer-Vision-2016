function [ points_left, points_right] = clicker_prob2(imagePath)
    
    thisWindow = largeDarkFigure();
    points_left = zeros(4,2);
    image = imread(imagePath);
    imshow(image);
    hold on;
    for i=1:4
        [clickY,clickX] = ginput(1);
        points_left(i,1) = clickX; points_left(i,2) = clickY;
        scatter( clickY, clickX, 100, 'lineWidth', 3.5 , 'MarkerEdgeColor',[.3 .3 .3]);
    end

    points_right = zeros(4,2);
    for i=1:4
        [clickY,clickX] = ginput(1);
        points_right(i,1) = clickX; points_right(i,2) = clickY;
        scatter( clickY, clickX, 100, 'lineWidth', 3.5 , 'MarkerEdgeColor',[.2 .2 .2]);
    end
    hold off;

    close(thisWindow);
end

