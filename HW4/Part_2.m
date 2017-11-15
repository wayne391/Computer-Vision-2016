clc; clear all; close all;
%%
addpath(genpath('.\vlfeat-0.9.20'))
scene_data = dir('./part2_data/*.jpg');
scene_center = imread(['./part2_data/', scene_data(1).name]);
scene_left = imread(['./part2_data/', scene_data(2).name]);
scene_right = imread(['./part2_data/', scene_data(3).name]);
%%  get  transformed img
close all;
% 
% t_left_img = get_trans_img(  scene_left ,scene_center, 0.20, 40);
% figure;
% imshow(t_left_img)
% %%
% t_right_img = get_trans_img(  scene_right ,scene_center, 0.20, 40);
% figure;
% imshow(t_right_img)
%% 
% imwrite(t_left_img, 'trans_left_img.jpg');
% imwrite(t_right_img, 'trans_right_img.jpg');
%% Combine Pictures

t_left_img = imread('trans_left_img.jpg');
st_pt = [42,110];
[ht, wt,~ ] = size(t_left_img);
[hc, wc,~ ] = size(scene_center);
is_used = zeros(ht, wc + st_pt(2));
cimg = zeros(ht, wc + st_pt(2), 3);
for  i = 1:ht
    for  j = 2:wt
        cimg(i, j, :) = t_left_img(i,j,:);
        if(sum(cimg(i, j, :)) > 45)
            is_used(i, j) = 1;
        end
    end
end

for i =  1:hc
    for j = 1:wc
        if(is_used(i+st_pt(1), j+st_pt(2)))
            cimg(i+st_pt(1), j+st_pt(2), :) = double(0.5 * cimg(i+st_pt(1), j+st_pt(2), :)) + double(0.5 * scene_center(i,j , :));
        else
            cimg(i+st_pt(1), j+st_pt(2), :) = double( cimg(i+st_pt(1), j+st_pt(2), :)) + double(scene_center(i,j , :));
        end
    end
end

st_pt = [21,-190];
t_right_img = imread('trans_right_img.jpg');
[ht, wt,~ ] = size(cimg);
[hc, wc,~ ] = size(t_right_img);
is_used = zeros(hc + st_pt(1), wc + wt + st_pt(2));
ccimg = zeros(hc + st_pt(1), wc  + wt + st_pt(2), 3);

for  i = 1:ht
    for  j = 2:wt
        ccimg(i + st_pt(1), j, :) = cimg(i,j,:);
        if(sum(cimg(i, j, :)) > 45)
            is_used(i+ st_pt(1), j) = 1;
        end
    end
end

for i =  1:hc
    for j = 1:wc
        if(is_used(i, j+wt+st_pt(2)) && (sum(t_right_img(i,j , :)) > 45))
            ccimg(i, j+wt+st_pt(2), :) = double(0.5 * ccimg(i, j+wt+st_pt(2), :)) + double(0.5 * t_right_img(i,j , :));
        else
            ccimg(i, j+wt+st_pt(2), :) = double( ccimg(i, j+wt+st_pt(2), :)) + double(t_right_img(i,j , :));
        end
    end
end

figure;
imshow(uint8(ccimg))