function visualizeHomo( best_H, corner , book_img, scene_img)
    corner_t = zeros(4, 2);
    figure;
    imshow(book_img);
    hold on;
    plot([corner(1, 1) corner(2, 1)], [corner(1, 2) corner(2, 2)],  '-', 'Color', 'r', 'LineWidth',5);
    hold on;
    plot([corner(2, 1) corner(3, 1)], [corner(2, 2) corner(3, 2)], '-', 'Color', 'y', 'LineWidth', 5);
    hold on;
    plot([corner(3, 1) corner(4, 1)], [corner(3, 2) corner(4, 2)], '-', 'Color', 'b', 'LineWidth', 5);
    hold on;
    plot([corner(4, 1) corner(1, 1)], [corner(4, 2) corner(1, 2)], '-', 'Color', 'g', 'LineWidth', 5);

    for i = 1:4  
        tmp_p = best_H*[corner(i,:) 1]';
        corner_t(i, :) = [tmp_p(1)/tmp_p(3) tmp_p(2)/tmp_p(3)];
    end
    figure;
    imshow(scene_img);
    hold on;
    plot([corner_t(1, 1) corner_t(2, 1)], [corner_t(1, 2) corner_t(2, 2)],  '-', 'Color', 'r', 'LineWidth',5);
    hold on;
    plot([corner_t(2, 1) corner_t(3, 1)], [corner_t(2, 2) corner_t(3, 2)], '-', 'Color', 'y', 'LineWidth', 5);
    hold on;
    plot([corner_t(3, 1) corner_t(4, 1)], [corner_t(3, 2) corner_t(4, 2)], '-', 'Color', 'b', 'LineWidth', 5);
    hold on;
    plot([corner_t(4, 1) corner_t(1, 1)], [corner_t(4, 2) corner_t(1, 2)], '-', 'Color', 'g', 'LineWidth', 5);

end

