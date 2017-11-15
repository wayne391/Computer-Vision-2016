clc; clear all; close all;
%% Movie 

input = './data/mov.avi';
background = './data/background.jpg';
K = 5;
background_label = [1,2];
[~, ~] = matting(input, K, background_label, background); % Directly Saved
%% Image

input = './data/example.jpg';
K = 7;
background_label = [1];
background = './data/background2.jpg';
[output, alpha] = matting(input, K, background_label, background);

figure;
imshow(output)
figure;
imshow(alpha)