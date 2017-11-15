function prob2_B(H, points_R, points_L, image)

    image_RL = changePoints(image, image, points_R, H);
%     figure;
%     imshow(image_result);
    image_LR = changePoints(image, image_RL, points_L, inv(H));
    figure;
    imshow(image_LR);
end

function image_new = changePoints(image, image_new, points, H)

    [h, w, ~] = size(image);
    mask = poly2mask( points(:,2), points(:,1), h, w );


    for i=1:h
        for j=1:w
            
            if(mask(i, j) == 1)  
                temp = H*[i;j;1];
                image_new(i, j, :)  = Color_bilinear([temp(1)/temp(3); temp(2)/temp(3)], image);
            end
            
        end
    end

end
function color_new = Color_bilinear(point_new, image)

    plt = floor(point_new);
    
    point = [plt, plt+[1;0],  plt+[1;1], plt+[0;1]];
    
    alpha = point_new(1) - plt(1);
    beta = point_new(2) - plt(2);
    
    color_new = (1 - alpha) * (1 - beta) *  image(point(1,1), point(2,1), :) + ...
                alpha * (1 - beta) * image(point(1,2), point(2,2), :) + ...
                (1 - alpha) * beta * image(point(1,3), point(2,3), :) + ...
                alpha * beta * image(point(1,4), point(2,4), :);
end
