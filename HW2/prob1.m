clc; clear; close all;

%% Part A
ch1 = load('chessboard1.mat');
ch2 = load('chessboard2.mat');
load('chessboard1.mat');
[MSVD1,  MEIG1] = prob1_A(ch1.point2D, ch1.point3D)
[MSVD2,  MEIG2] = prob1_A(ch2.point2D, ch2.point3D);
%% part B
[K1, R1, t1] = prob1_B(MEIG1);
[K2, R2, t2] = prob1_B(MEIG2);
%% part C 
rms1 = prob1_C(K1, R1, t1, ch1.point2D, ch1.point3D, 'chessboard1.jpg');
rms2 = prob1_C(K2, R2, t2, ch2.point2D, ch2.point3D, 'chessboard2.jpg');
fprintf('SVD: %f \nEIG: %f\n', rms1, rms2);
%% part D
visualizeCamera( point3D, R1, t1, R2, t2)
