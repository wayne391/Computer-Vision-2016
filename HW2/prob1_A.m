function [MSVD,  MEIG] = prob1_A(point2D, point3D )
    [n, ~] = size(point3D(:,1));
    Ai = [point3D(:,1), point3D(:,2), point3D(:,3), ones(n, 1), ...
          zeros(n, 1), zeros(n, 1), zeros(n, 1), zeros(n, 1), ...
          -point2D(:,1).*point3D(:,1),  -point2D(:,1).*point3D(:,2), -point2D(:,1).*point3D(:,3), -point2D(:,1)];
    Aj = [zeros(n, 1), zeros(n, 1), zeros(n, 1), zeros(n, 1), ...
         point3D(:,1), point3D(:,2), point3D(:,3), ones(n, 1), ...   
          -point2D(:,2).*point3D(:,1),  -point2D(:,2).*point3D(:,2), -point2D(:,2).*point3D(:,3), -point2D(:,2)];
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
    matrix = zeros(3,4);
    matrix(1, :) = vector(1:4); 
    matrix(2, :) = vector(5:8);
    matrix(3, :) = vector(9:12); 
end
