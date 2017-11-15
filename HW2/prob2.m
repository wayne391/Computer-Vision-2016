clear all; clc; close all;

% %%
% [points_left, points_right] = clicker_prob2('C:\CV HW2\HW2_release\data\\debate.jpg');
% save('pointsLR','points_left','points_right');
%% Part A

load('pointsLR.mat')
[MSVD,  MEIG] = prob2_A(points_left, points_right);
%% Part B

imagePath = 'C:\CV HW2\HW2_release\data\\debate.jpg';
image = imread(imagePath);

prob2_B(MEIG, points_left, points_right, image);
% part2_B(MSVD, points_left, points_right, image, 'SVD');
%% Part C

% Click
% [points_wall_left, points_wall_right] = clicker_prob2('C:\CV HW2\HW2_release\data\\debate.jpg');
% save('pointsLR_wall.mat', 'points_wall_left', 'points_wall_right');
% %%
clear all; clc; close all;

load('pointsLR_wall.mat');
load('pointsLR.mat')
texture = imread('texture_big.jpg');
imagePath = 'C:\CV HW2\HW2_release\data\\debate.jpg';
image = imread(imagePath);

[ht,wt,~] = size(texture);
points_txt = [1,1;ht,1;ht,wt;1,wt];
imshow(texture);
[MSVD_cl,  MEIG_cl] = prob2_A(points_txt, points_wall_left);
[MSVD_cr,  MEIG_cr] = prob2_A(points_txt, points_wall_right);

image_result = prob2_C(MSVD_cl,  MSVD_cr, image, texture, points_left, points_right);
