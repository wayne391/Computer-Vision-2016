function [ magnitude, direction] = Part_1_B(A_gau , thres)
    
    A_gau = double(A_gau);
	GX = [-1, 0, 1 ; -2, 0, 2; -1, 0, 1];
    GY = [-1, -2, -1 ; 0, 0, 0 ; 1, 2, 1] ;

    resX = conv2(A_gau, GX, 'same');
    resY = conv2(A_gau, GY,'same');

    magnitude = sqrt(resX.^2 + resY.^2);
    direction = atan2(resY,resX);
    magnitude(magnitude < thres) = 0;

end

