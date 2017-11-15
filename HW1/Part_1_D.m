function N = Part_1_D(A, eigen_img, eigen_thres)

    r = 3; 
    [h, w]= size(eigen_img);
    N = zeros(h, w);
    for i=1+r:h-r 
        for j=1+r:w-r
            if max(max(eigen_img(i-r:i+r, j-r:j+r)))==eigen_img(i,j) && nnz(N(i-r:i+r, j-r:j+r))==0
                    N(i,j) = 1;
            end
        end
     end

    N(eigen_img <= eigen_thres) = 0;
%     figure;
%     imshow(N)
    tA1 = A(:,:,1) * 0.5;
    tA2 = A(:,:,2) * 0.0;
    tA3 = A(:,:,3) * 0.0;
    tA1(N == 1) = 256;
    tA2(N == 1) = 256;
    tA3(N == 1) = 256;
    tA(:,:,1) = tA1;
    tA(:,:,2) = tA2;
    tA(:,:,3) = tA3;

    figure;
    imshow(tA)

end

