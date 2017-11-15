function ouput_img = get_trans_img(  scene ,scene_center, thers_ratio, thres)
     [best_H, corres, Fb, Fs,best_inlier,  inlier_trans] = myRANSAC(scene,scene_center ,  thers_ratio, thres, 5000);
    corner = [1, 1;269, 1;269, 407; 1, 407];
 	visualizeHomo( best_H, corner , scene, scene_center)
    for i = 1:4  
        tmp_p = best_H*[corner(i,:) 1]';
        corner_tran(i, :) = [tmp_p(1)/tmp_p(3) tmp_p(2)/tmp_p(3)];
    end

    tr_min =floor(min(corner_tran));
    tr_max = ceil(max(corner_tran));
    new_img = zeros(ceil(tr_max(1) - tr_min(1)), ceil(tr_max(2) - tr_min(2)), 3);

    shift_x = 1 - tr_min(1);
    shift_y = 1 - tr_min(2);
    [h,w, ~] =size(new_img);
    mask = poly2mask( corner_tran(:,2) + shift_y, corner_tran(:,1) + shift_x, h, w );
    % figure;
    % imshow(mask)
    % 
    for i = 1:h
        for j = 1:w
            if(mask(i, j))
                temp = inv(best_H)* [i - shift_x; j - shift_y; 1];
    %             tp = [temp(1)/temp(3); temp(2)/temp(3)];
                tp = [temp(2)/temp(3); temp(1)/temp(3)];
                new_img(i, j, :)  = Color_bilinear(tp, scene);%scene_left(round(tp(2)), round(tp(1)), :);
            end
        end
    end
    
    ouput_img = fliplr(imrotate(uint8(new_img), -90));
%     figure;
%     imshow(ouput_img)

end

