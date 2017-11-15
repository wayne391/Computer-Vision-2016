clc; clear all; close all;

type = 'RGB'; % RGB
max_iter = 15;

image = im2double(imread('data/AmumuPoro.jpg'));
bandwidth_sp = 30;
thres_similar_sp = 2;
if(strcmp(type, 'LUV')) 
    image = RGB2Luv(image);
    bandwidth =  10; % for LUV
    thres_similar =  5; % for LUV
else
    bandwidth =  30/255;
    thres_similar =  25/255;   
end
bandwidth = [bandwidth; bandwidth; bandwidth; bandwidth_sp; bandwidth_sp];
thres_similar = [thres_similar; thres_similar; thres_similar; thres_similar_sp; thres_similar_sp];
[H, W, C] = size(image);

ex_img = zeros(H, W, C+2);
for i = 1:H
    for j = 1:W
        ex_img(i, j, 1:3) = image(i, j, :);
        ex_img(i, j, 4) = i;
        ex_img(i, j, 5) = j;
    end
end
stream_pts = reshape(ex_img, H*W, 5)';
%% mean-shift

len = length(stream_pts);

iter = 1;
center_map = stream_pts;
tmp_center_map = center_map;
while(iter <= max_iter)   
    iter
    vis = zeros(1, len);
    for i = 1:len
        % for every un-shifted pt
        if(~vis(i))
            % compute mean shift
            center = center_map(:, i);
            dis = (center_map - repmat(center,1, len));
            ifKer = abs(dis);
            col = sum((ifKer <= repmat(bandwidth, 1, len)));
            sim = sum((ifKer <= repmat(thres_similar, 1, len)));
                
            shift_vec_c = mean(dis(1:3, col == 5), 2);
            shift_vec_s = mean(dis(4:5, col == 5), 2);
%             shift_vec_s = mean(dis(:, col == 5), 2);  
            
            % migrate similar pts with shift vec
            tmp_center_map(1:3, sim == 5) = repmat(center_map(1:3, i) + shift_vec_c, 1, length(sim(sim == 5)));
            tmp_center_map(4:5, sim == 5) = repmat(center_map(4:5, i) + shift_vec_s, 1, length(sim(sim == 5)));
%             tmp_center_map(:, sim == 5) = repmat(center_map(:, i) + shift_vec_s, 1, length(sim(sim == 5)));
            vis(sim == 5) = 1;           
        end
    end
    
    center_map = tmp_center_map;
    iter = iter + 1;
end

%% Visualization

new_img = reshape(center_map(1:3,:)', H, W, 3);
if(strcmp(type, 'LUV')) new_img = Luv2RGB(new_img);end
figure;
imshow(new_img)