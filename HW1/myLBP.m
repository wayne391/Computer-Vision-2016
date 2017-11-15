function LBP = myLBP(A)

    r = 1;
    [h, w] = size(A);
    LBP = zeros(h,w);
    for i=1+r:h-r 
        for j=1+r:w-r
            thres = A(i,j);
            temp_thres = zeros(1, 8);
            temp = [A(i-1, j-1:j+1), A(i, j+1), A(i+1, j+1:-1:j-1), A(i, j-1)] - thres;
            temp_thres(temp > 0) = 1;
            temp_thres(temp <= 0) = 0;
            LBPv = 0;
            for k =1:8
                LBPv = LBPv + pow2(8-k) * temp_thres(k);
            end
            LBP(i, j) = LBPv;
        end
    end
    
    LBP = LBP(2:end-1,2:end-1);

end

