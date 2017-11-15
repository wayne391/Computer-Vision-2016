function  eigenvalue_min = Part_1_C(A, grad, win_size, eigen_thres, vis)
    Ixx = grad{1} .^2;
    Iyy = grad{2} .^2;
    Ixy = grad{1}.*grad{2};

    [h,w] = size(Ixy);
    H = zeros(2,2, h, w);
    filter = ones(win_size, win_size);
    
    H(1,1,:,:) = conv2(Ixx, filter, 'same');
    H(1,2,:,:) = conv2(Ixy, filter, 'same');
    H(2,1,:,:) = conv2(Ixy, filter, 'same');
    H(2,2,:,:) = conv2(Iyy, filter, 'same');
    
    [~,~, h, w] = size(H);
    eigenvalue_min = zeros(h,w);
    for i=1:h
        for j=1:w
           [V, D] = eig(H(:,:, i, j));
            eigenvalue_min(i, j) = min(max(D));
        end
    end

    eigenvalue_min_vis = zeros(size(eigenvalue_min));
    eigenvalue_min_vis(eigenvalue_min >  eigen_thres) = 1;

    tA1 = A(:,:,1) * 0.5;
    tA2 = A(:,:,2) * 0.0;
    tA3 = A(:,:,3) * 0.0;
    tA1(eigenvalue_min_vis == 1) = 256;
    tA2(eigenvalue_min_vis == 1) = 256;
    tA3(eigenvalue_min_vis == 1) = 256;
    tA(:,:,1) = tA1;
    tA(:,:,2) = tA2;
    tA(:,:,3) = tA3;
    
    if(vis)
        figure;
        imshow(tA)
    end

end

