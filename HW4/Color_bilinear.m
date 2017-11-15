function color_new = Color_bilinear(point_new, image)

    plt = floor(point_new);
    
    point = [plt, plt+[1;0],  plt+[1;1], plt+[0;1]];
%     point = [plt, plt+[0;1],  plt+[1;1], plt+[1;0]];
    
    alpha = point_new(1) - plt(1);
    beta = point_new(2) - plt(2);
    try
        color_new = (1 - alpha) * (1 - beta) *  image(point(1,1), point(2,1), :) + ...
                alpha * (1 - beta) * image(point(1,2), point(2,2), :) + ...
                (1 - alpha) * beta * image(point(1,3), point(2,3), :) + ...
                alpha * beta * image(point(1,4), point(2,4), :);
    catch
        color_new = [0;0;0];
    end
end