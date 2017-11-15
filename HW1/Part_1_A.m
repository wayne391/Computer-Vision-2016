function A_gau = Part_1_A( A, hsize, sigma)
% Apply Gaussian Filter

    A_gau = imfilter(A, fspecial('gaussian', hsize, sigma));

end

