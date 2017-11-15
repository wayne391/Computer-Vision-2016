function rms = Prob1_C(K, R, t, point2D, point3D, imagePath)

    new_point2D = [];
    [n, ~] = size(point3D(:,1));
    for i=1:n
        temp = K*[R t]*[point3D(i,:)'; 1];
         new_point2D = [new_point2D; temp(1)/temp(3), temp(2)/temp(3)];
    end 
       
    % draw
    figure;
    imshow(imagePath);
    hold on;
    scatter(point2D(:,1),point2D(:,2), 40,'MarkerEdgeColor', [.2 1 .5], 'MarkerFaceColor',[.2 1 .5],'LineWidth',2);
    scatter(new_point2D(:,1),new_point2D(:,2), 30,'MarkerEdgeColor', [1 .2 .6],'LineWidth',2);
    hold off;
    
    sum = 0;
    for i=1:108
        sum = sum + (new_point2D(i,:)-point2D(i,:))*(new_point2D(i,:)-point2D(i,:))';
    end  
    rms = (sum/n).^(0.5);        
end