function [MSVD,  MEIG] = prob2_A(pointsA, pointsB)
    [n, ~] = size(pointsA(:,1));
    Ai = [pointsA(:,1), pointsA(:,2), ones(n, 1), ...
          zeros(n, 1), zeros(n, 1), zeros(n, 1),...
          -pointsB(:,1).*pointsA(:,1),  -pointsB(:,1).*pointsA(:,2) -pointsB(:,1)];
    Aj = [zeros(n, 1), zeros(n, 1), zeros(n, 1),  ...
         pointsA(:,1), pointsA(:,2), ones(n, 1), ...   
          -pointsB(:,2).*pointsA(:,1),  -pointsB(:,2).*pointsA(:,2), -pointsB(:,2)];
    A = [];
    for i = 1:n
        A = [A; Ai(i, :); Aj(i, :)];
    end
    
    [V,D] = eig( A'*A );
    index = max(D) == min(max(D));
    eigenvector_min = V(:, index);
    [~, S, V] = svd( A'*A);
    index = max(S) == min(max(S));
    singular_min = V(:, index);   
    MSVD = transformVector2Matrix(singular_min);
    MEIG = transformVector2Matrix(eigenvector_min);
 
end
function matrix = transformVector2Matrix(vector) 
    matrix = zeros(3,3);
    matrix(1, :) = vector(1:3); 
    matrix(2, :) = vector(4:6);
    matrix(3, :) = vector(7:9); 
end
