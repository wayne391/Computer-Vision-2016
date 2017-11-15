function image_new = prob2_C_sub(H, image, texture)

    [h, w, ~] = size(texture);
    [m, n, ~] = size(image);
    image_new = zeros(size(image));
    image_cand = cell(size(image));
    
    for i = 1:m
        for j = 1:n
            image_cand{i, j} = double([0, 0, 0, 0]);
        end
    end
        
    for i = 1:h
        for j = 1:w
            
            a =H*[i;j;1];
            proj_point = [round(a(1)/a(3)), round(a(2)/a(3))];
            proj_color = texture(i, j, :);
            
            area_weight = diagonal_area(proj_point);
            plt = floor(proj_point)';
            point = [plt, plt+[1;0],  plt+[1;1], plt+[0;1]];
            image_cand{point(1,1), point(2,1)} = image_cand{point(1,1), point(2,1)} + double([proj_color(1) * area_weight(1), proj_color(2) * area_weight(1), proj_color(3) * area_weight(1),  area_weight(1)]);
            image_cand{point(1,2), point(2,2)} = image_cand{point(1,2), point(2,2)} + double([proj_color(1) * area_weight(2), proj_color(2) * area_weight(2), proj_color(3) * area_weight(2),  area_weight(2)]);
            image_cand{point(1,3), point(2,3)} = image_cand{point(1,3), point(2,3)} + double([proj_color(1) * area_weight(3), proj_color(2) * area_weight(3), proj_color(3) * area_weight(3),  area_weight(3)]);
            image_cand{point(1,4), point(2,4)} = image_cand{point(1,4), point(2,4)} + double([proj_color(1) * area_weight(4), proj_color(2) * area_weight(4), proj_color(3) * area_weight(4),  area_weight(4)]);
                                           
        end
    end

    for i = 1:m
        for j = 1:n
            temp = image_cand{i, j};
            image_new(i, j , 1) = temp(1) / temp(4);
            image_new(i, j , 2) = temp(2) / temp(4);
            image_new(i, j , 3) = temp(3) / temp(4);
        end
    end
     
    for i = 1:m
        for j = 1:n
            temp = image_cand{i, j};
            if(temp(4) == 0)
                image_new(i, j, :) = image(i, j, :);
            end
        end
    end
      
end
function area_weight = diagonal_area(proj_point)
    plt = floor(proj_point);
    a =  proj_point(1) - plt(1);
    b = proj_point(2) - plt(2);
    area_weight = [(1- a)*(1-b), a *(1-b), a*b, b*(1-a)];  
end
