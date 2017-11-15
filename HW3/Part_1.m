clc; clear all; close all;

image = im2double(imread('data/CaitlinPoro.jpg'));
image_luv = RGB2Luv(image);
[H, W, C] = size(image);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Here for parameter setting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set RGB or LUV
type = 'RGB'; %'RGB'; % 'LUV'
K = 11;


if(strcmp(type, 'RGB')) stream_pts = reshape(image, H*W, 3)';end
if(strcmp(type, 'LUV')) stream_pts = reshape(image_luv, H*W, 3)'; end
%% K-means (Random Initialization) 
% for part1 A & C



best = Inf;
best_model = 0;
for iter = 1:50
    [lab, mean_cluster, J] = myKmeans(stream_pts,  0.01, K, []);
    if(best > J)
        best = J;
        best_model = mean_cluster;
    end
    fprintf('iter #%d=> J = %f\n', iter, J);
end

disp('OK');
for i = 1:length(stream_pts)
    stream_pts(:, i) = mean_cluster(:,lab(i));
end

new_img = reshape(stream_pts', H, W, 3);
if(strcmp(type, 'LUV')) new_img = Luv2RGB(new_img);end
imshow(new_img);
%% K-means (Manual Initialization)
% for part1 B & C

figure;
imshow(image);
[Y, X] = ginput(K);
close all;

mean_cluster = [];
for i = 1:length(X)  
    if(strcmp(type, 'RGB'))  mean_cluster = [mean_cluster, reshape( image(int16(X(i)), int16(Y(i)), :),3,1)];end
    if(strcmp(type, 'LUV'))  mean_cluster = [mean_cluster, reshape( image_luv(int16(X(i)), int16(Y(i)), :),3,1)];end
end
[lab, mean_cluster, J] = myKmeans(stream_pts,  0.01, K, mean_cluster);

for i = 1:length(stream_pts)
    stream_pts(:, i) = mean_cluster(:,lab(i));
end
new_img = reshape(stream_pts', H, W, 3);
if(strcmp(type, 'LUV')) new_img = Luv2RGB(new_img);end
imshow(new_img);