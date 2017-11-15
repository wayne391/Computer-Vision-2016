function  fig  = visualization_corres( book_img,  scene_img, Fb, Fs, corres, inlier,  inlier_trans )
    show_img = book_img;
    [ph, pw , ~] = size(scene_img);
    show_img(ph, pw, :) = 0;
    show_img = [show_img, scene_img];

    fig = figure();
    imshow(uint8(show_img))
    
    if nargin >= 6
        plot_inlier = 0;
    end
    
    for i =1:length(corres)
        idx = corres(i, 1);
        idx_map = corres(i, 2);
        
        hold on;
        plot([Fb(1,idx), 1200 + Fs(1, idx_map)], [Fb(2,idx), Fs(2, idx_map)], '-', 'Color', 'g');
        if nargin >= 6
            if(~isempty(find(inlier== i)))
                hold on;
                plot([Fb(1,idx), 1200 + Fs(1, idx_map)], [Fb(2,idx), Fs(2, idx_map)], '-', 'Color', 'r');
                
            end
        end    
    end

    if nargin >= 6
        map_idx = corres(inlier, 2);
        figure;
        imshow(scene_img)
        hold on;
        scatter(Fs(1, map_idx),Fs(2, map_idx), 2.2,'filled', 'r');
        hold on;
 -      scatter(inlier_trans(:, 1), inlier_trans(:,2), 2.2,'filled','g');
 
        size(map_idx)
        for pi = 1:length(inlier)
             hold on;
             plot([Fs(1, map_idx(pi)) inlier_trans(pi, 1)], [Fs(2, map_idx(pi)) inlier_trans(pi, 2)], '-', 'Color', 'b');
        end
    end
end

