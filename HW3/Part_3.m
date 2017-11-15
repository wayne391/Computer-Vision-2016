clc; clear all; close all;

type = 'LUV'; % RGB
max_iter = 15;

image = im2double(imread('data/AmumuPoro.jpg'));
if(strcmp(type, 'LUV')) 
    image = RGB2Luv(image);
    bandwidth =  10; % for LUV
    thres_similar =  5; % for LUV
else
    bandwidth =  50/255;
    thres_similar =  25/255;   
end

[H, W, C] = size(image);

thres = 0.2;
stream_pts = reshape(image, H*W, 3)';
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
            dis = center_map - repmat(center,1, len);
            ifKer = abs(dis);
            col = sum((ifKer <= bandwidth));
            sim = sum((ifKer <= thres_similar));
            shift_vec = mean(dis(:, col == 3), 2);
              
            % migrate similar pts with shift vec
            tmp_center_map(:, sim == 3) = repmat(center_map(:, i) + shift_vec, 1, length(sim(sim == 3)));
            vis(sim == 3) = 1;           
        end
    end
    
    center_map = tmp_center_map;
    iter = iter + 1;
end

%% Visualization
if(strcmp(type, 'LUV')) 
    % before distribution
    figure;
    densed_pts = unique(stream_pts','rows')';
    scatter3(densed_pts(1,:), densed_pts (2,:), densed_pts (3,:), 3);
    
    figure;
    ttt = unique(center_map','rows')';
    scatter3(ttt(1,:),ttt(2,:), ttt(3,:),3);
    
else
    % before distribution
    figure;
    densed_pts = unique(stream_pts','rows')';
    scatter3(densed_pts(1,:), densed_pts (2,:), densed_pts (3,:), 3, densed_pts');

    % after
    figure;
    ttt = unique(center_map','rows')';
    scatter3(ttt(1,:),ttt(2,:), ttt(3,:),3,  ttt(3,:));
end

new_img = reshape(center_map', H, W, 3);
if(strcmp(type, 'LUV')) new_img = Luv2RGB(new_img);end
figure;
imshow(new_img)