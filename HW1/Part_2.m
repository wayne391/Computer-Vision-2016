clc; clear all; close all;

A = rgb2gray(imread('kobeFace.png'));
B = rgb2gray(imread('gasolFace.png'));
%% Part A


LBP_A = myLBP(A);
LBP_B = myLBP(B);

figure;
imshow(uint8(LBP_A))
figure;
imshow(uint8(LBP_B))
%% Part B

LBP_A_histogram = zeros(1,256);
LBP_B_histogram = zeros(1,256);
[h, w]= size(LBP_A);

for i=1:h
    for j=1:w
        LBP_A_histogram(LBP_A(i, j)+1) = LBP_A_histogram(LBP_A(i, j)+1) +1;
    end
end

for i=1:h
    for j=1:w
        LBP_B_histogram(LBP_B(i, j)+1) = LBP_B_histogram(LBP_B(i, j)+1) +1;
    end
end

LBP_A_histogram_n  = LBP_A_histogram/norm(LBP_A_histogram);
LBP_B_histogram_n  = LBP_B_histogram/norm(LBP_B_histogram);
inner_product_LBP = LBP_A_histogram_n * LBP_B_histogram_n'
figure;
bar(LBP_A_histogram_n )
figure;
bar(LBP_B_histogram_n )
%% PartC

n = [2, 3, 4, 9, 20];

for ni = 1: length(n)
    shift = 360/n(ni);

    for i = 1:shift:360
        for j = 1:shift:360
           
            tempA = A(i:i + shift -1, j:j + shift -1);
            tempB = B(i:i + shift -1, j:j + shift -1);
            d_LBP_A_histogram = zeros(1,256);
            d_LBP_B_histogram = zeros(1,256);

            tempLBP_A = myLBP(tempA);
            tempLBP_B = myLBP(tempB);

            histo_v_A = [];
            histo_v_B = [];

            for k = 1:shift-2
                for l = 1:shift-2 
                    
                    d_LBP_A_histogram(tempLBP_A(k, l)+1) = d_LBP_A_histogram(tempLBP_A(k, l)+1) +1;
                    d_LBP_B_histogram(tempLBP_B(k, l)+1) = d_LBP_B_histogram(tempLBP_B(k, l)+1) +1;
                end
            end     
            
            histo_v_A = [histo_v_A, d_LBP_A_histogram];            
            histo_v_B = [histo_v_B, d_LBP_B_histogram];
            
        end
    end
    
   
    histo_v_A = histo_v_A/norm(histo_v_A);
    histo_v_B  = histo_v_B/norm(histo_v_B);
     
    inner_product_LBP_d = histo_v_A *histo_v_B';
    
    fprintf('%2dx%2d = %f\n', n(ni),n(ni),  inner_product_LBP_d)
end
% figure;
% bar(histo_v_A )
% figure;
% bar(histo_v_B )

%% Part D


u_LBP_A = uniformLBP( A );
u_LBP_B = uniformLBP( B );

figure;
imshow(uint8(u_LBP_A))
figure;
imshow(uint8(u_LBP_B))

%% Part E

u_LBP_A_histogram = zeros(1,59);
u_LBP_B_histogram = zeros(1,59);
[h, w]= size(LBP_A);

for i=1:h
    for j=1:w
        u_LBP_A_histogram(u_LBP_A(i, j)+1) = u_LBP_A_histogram(u_LBP_A(i, j)+1) +1;
    end
end

for i=1:h
    for j=1:w
        u_LBP_B_histogram(u_LBP_B(i, j)+1) = u_LBP_B_histogram(u_LBP_B(i, j)+1) +1;
    end
end

u_LBP_A_histogram_n  = u_LBP_A_histogram/norm(u_LBP_A_histogram);
u_LBP_B_histogram_n  = u_LBP_B_histogram/norm(u_LBP_B_histogram);
inner_product_u_LBP = u_LBP_A_histogram_n * u_LBP_B_histogram_n'
figure;
bar(u_LBP_A_histogram_n )
figure;
bar(u_LBP_B_histogram_n )
%% Part F
clc;
n = [2, 3, 4, 9, 20];

for ni = 1: length(n)
    shift = 360/n(ni);

    for i = 1:shift:360
        for j = 1:shift:360
            tempA = A(i:i + shift -1, j:j + shift -1);
            tempB = B(i:i + shift -1, j:j + shift -1);

            d_uLBP_A_histogram = zeros(1,256);
            d_uLBP_B_histogram = zeros(1,256);

            tempLBP_A = uniformLBP( tempA );
            tempLBP_B = uniformLBP( tempB );

            histo_v_A = [];
            histo_v_B = [];

            for k = 1:shift-2
                for l = 1:shift-2                 
                    d_uLBP_A_histogram(tempLBP_A(k, l)+1) = d_uLBP_A_histogram(tempLBP_A(k, l)+1) +1;
                    d_uLBP_B_histogram(tempLBP_B(k, l)+1) = d_uLBP_B_histogram(tempLBP_B(k, l)+1) +1;
                end
            end
            histo_v_A = [histo_v_A, d_uLBP_A_histogram];
            histo_v_B = [histo_v_B, d_uLBP_B_histogram];
        end
    end

    histo_v_A = histo_v_A/norm(histo_v_A);
    histo_v_B = histo_v_B/norm(histo_v_B);
    inner_product_u_LBP_d = histo_v_A *histo_v_B';
    fprintf('%2dx%2d = %f\n', n(ni),n(ni),  inner_product_u_LBP_d)
end
% figure;
% bar(histo_v_A )
% figure;
% bar(histo_v_B )
