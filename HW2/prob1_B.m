function [ K, R, t ] = prob1_B( PM )
   
    [Q, R] = myQR(inv(PM(1:3,1:3)));
    K = inv(R);
    t = inv(K)*PM(:,4);
    
    A = PM(1:3, 1:3);
    a1 = A(1,:)';
    a2 = A(2,:)';
    a3 = A(3,:)';
    
    R = inv(Q);
   
end

function [Q,R] = myQR(A)
    [~, nc] = size(A);
    R = zeros(nc);
    Q = [];
    B = [];
    for i = 1:3
        temp =  A(:, i);
        for j = 1:i-1
            temp = temp - dot(A(:, i), Q(:, j)) * Q(:, j);
        end
        B = [B, temp];
        Q = [Q, B(:, i) / norm(B(:, i))];
    end

    for i =1:nc
        for j =i:nc
                R(i, j) = A(:, j)'*Q(:, i);
        end
    end
end



    
