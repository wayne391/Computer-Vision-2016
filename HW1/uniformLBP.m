function U = uniformLBP(image )

    [h,w] = size(image);
    U = zeros(h,w);
    U2 = zeros(h,w);

    table = zeros(1, 256);
    label = 1;
    for k = 0:255,
        bits = bitand(k, 2.^(0:7)) > 0;
        if nnz(diff(bits([1:end, 1]))) == 2 || nnz(diff(bits([1:end, 1]))) == 0,
            table(k+1) = label;
            label = label + 1;
        else
            table(k+1) = 0;
        end
    end
    
    for i = 2 : h-1
        for j = 2 : w-1
            temp = 0;
            maskt = [image(i-1,j-1),image(i-1,j), image(i-1,j+1), image(i,j+1), image(i+1,j+1), image(i+1,j), image(i+1,j-1),image(i,j-1)];
            
            for l = 1:8
                if(maskt(l) < image(i,j))
                    maskt(l) = 0;
                else
                    maskt(l) = 1;
                end
            end

            for k =1:8
                temp = temp + pow2(8-k) * maskt(k);
            end
            
            U(i,j) = table(temp+1);
        end
    end

    U = U(2:end-1, 2:end-1);

end

