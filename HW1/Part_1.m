clc; clear all; close all;

A = imread('J4Poro.png');
A_gray = rgb2gray(A);
sigma = 5;
GX = [-1, 0, 1 ; -2, 0, 2; -1, 0, 1];
GY = [-1, -2, -1 ; 0, 0, 0 ; 1, 2, 1] ;
%% Part A

hsize = [3, 3];
A_gau1 = Part_1_A(A_gray, hsize, sigma);
figure;
imshow(A_gau1)

hsize = [30, 30];
A_gau2 = Part_1_A(A_gray, hsize, sigma);
figure;
imshow(A_gau2)
%% Part B

thres = 20;
A_gau = A_gau2;

[magnitude, direction] = Part_1_B(A_gau, thres);

temp = uint8(magnitude);
figure;
imshow(temp);

Map = colorMapGenerator();

direction_vis = (direction+pi) / (2*pi) ;
direction_vis( magnitude == 0) = 0;
figure;
imshow( direction_vis, 'ColorMap', Map );
%% Part C

win_size = 3;
eigen_thres = 1100;

A_gau1 = double(A_gau1);
A_gau2 = double(A_gau2);

grad_1 = {conv2(A_gau1, GX, 'same'), conv2(A_gau1, GY, 'same')};
grad_2 = {conv2(A_gau2, GX, 'same'), conv2(A_gau2, GY, 'same')};

eigen_13 = Part_1_C(A, grad_1, 3, eigen_thres,1);
eigen_15 = Part_1_C(A, grad_1, 5, eigen_thres,1);
eigen_23 = Part_1_C(A, grad_2, 3, eigen_thres,1);
eigen_25 = Part_1_C(A, grad_2, 5, eigen_thres,1);
%% Part D
can_n = Part_1_D(A, eigen_13 , eigen_thres);
Part_1_D(A, eigen_15 , eigen_thres);
Part_1_D(A, eigen_23 , eigen_thres);
Part_1_D(A, eigen_25 , eigen_thres);
%% Part E

    % Rotation
hsize = [3, 3];

B = imrotate(A,30);
B_gray = rgb2gray(B);
B_gau1 = Part_1_A(B_gray, hsize, sigma);
B_gau1 = double(B_gau1);
grad_b = {conv2(B_gau1, GX, 'same'), conv2(B_gau1, GY, 'same')};
eigen_1_b = Part_1_C(B, grad_b, 3, eigen_thres,0);
eigen_2_b = Part_1_C(B, grad_b, 5, eigen_thres,0);
rotate_3 = Part_1_D(B, eigen_1_b , eigen_thres);
rotate_5 = Part_1_D(B, eigen_2_b , eigen_thres);

    % Scale
B = imresize(A,0.5);
B_gray = rgb2gray(B);
B_gau1 = Part_1_A(B_gray, hsize, sigma);
B_gau1 = double(B_gau1);
grad_b = {conv2(B_gau1, GX, 'same'), conv2(B_gau1, GY, 'same')};
eigen_1_b = Part_1_C(B, grad_b, 3, eigen_thres,0);
eigen_2_b = Part_1_C(B, grad_b, 5, eigen_thres,0);
scale_3 = Part_1_D(B, eigen_1_b , eigen_thres);
scale_5 = Part_1_D(B, eigen_2_b , eigen_thres);

%% Part F

    % Fix Rotate
C = imrotate(rotate_3,-30);
[ori_h, ori_w, ~]= size(A);
[pos_h, pos_w, ~]= size(C);
shift_h = abs(round((ori_h - pos_h)/2));
shift_w = abs(round((ori_w - pos_w)/2));
can_c = C(shift_h:end-shift_h, shift_w:end-shift_w, :);

    % Fix Scale
can_r = zeros(ori_h, ori_w); 
[in_x, in_y] = find(scale_3 == 1);
imshow(scale_3)
in_x = in_x*2;
in_y = in_y*2;
for i = 1:length(in_x)
    can_r(in_x(i),in_y(i)) = 1;
end

% figure;
% imshow(can_c);
% figure;
% imshow(can_r);
% figure;
% imshow(can_n);

Compare = zeros(size(A));
Compare(:,:,1) = can_c;
Compare(:,:,2) = can_r;
Compare(:,:,3) = can_n;
% imshow(Compare);

Compare_ori = zeros(size(A));
Compare_ori(:,:,1) = A(:,:,1) * 0.12 + uint8(Compare(:,:,1))*256;
Compare_ori(:,:,2) = A(:,:,2) * 0.12 + uint8(Compare(:,:,2))*256;
Compare_ori(:,:,3) = A(:,:,3) * 0.12 + uint8(Compare(:,:,3))*256;

imshow(uint8(Compare_ori));