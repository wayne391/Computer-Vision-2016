clc; clear all; close all;
%% Load Video
v = VideoReader('data/jaguar.avi');


frame_array = cell (v.NumberOfFrame, 1);
for i = 1:v.NumberOfFrame
    frame_array{i} = read(v, i);
end

%% Kmeans
imshow(frame_array{3});
image = im2double(frame_array{3});
[H, W, C] = size(image);
stream_pts = reshape(image, H*W, 3)';

K = 4;
[Y, X] = ginput(K);
close all;

mean_cluster = [];
for i = 1:length(X)  
    mean_cluster = [mean_cluster, reshape( image(int16(X(i)), int16(Y(i)), :),3,1)];
end

[lab, mean_cluster, J] = myKmeans(stream_pts,  0.01, K, mean_cluster);
%%
% background: label 3 & 4
subplot(4,1,1)
plot(1:5, 'color', mean_cluster(:,1))
subplot(4,1,2)
plot(1:5, 'color', mean_cluster(:,2))
subplot(4,1,3)
plot(1:5, 'color', mean_cluster(:,3))
subplot(4,1,4)
plot(1:5, 'color', mean_cluster(:,4))
    
%% Apply to Video

background = imread('background.jpg');
background =  im2double(imresize(background, [H, W]));
back_stream = reshape(background, H*W, 3)';
%%
vn = VideoWriter('new.avi');
open(vn);

for f = 1:v.NumberOfFrame
    stream_pts = reshape(  im2double(frame_array{f}), H*W, 3)';
    dis = [];
    for k = 1:K
        dis = [dis ;  sum((stream_pts - repmat(mean_cluster(:, k), 1, size(stream_pts, 2))) .^ 2).^0.5];
    end
        
    [~, lab]= min(dis);
    stream_pts(:, lab == 3) = back_stream(:, lab == 3);
    stream_pts(:, lab == 4) = back_stream(:, lab == 4);

%     figure;
    new_img = reshape(stream_pts', H, W, 3);
    imshow(new_img);
    writeVideo(vn, new_img)
%     writeVideo(vn,new_img)
end
close(vn)