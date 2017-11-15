function [best_H, corres,  Fb, Fs, best_inlier,  inlier_trans ] = myRANSAC(bimg,  scene_img, thres_ratio, thres,max_iter)

    iter = 1;
    numOfSeed = 4;
    [corres, Fb,Db, Fs,Ds] =  get_sift_and_corres(bimg,  scene_img, thres_ratio);
    
    best_inlier = [];
    best_inlier_num = -Inf;
    best_H = [];
    while iter < max_iter

        rand_idx_all = randperm(length(corres));
        rand_idx = rand_idx_all(1:numOfSeed);
        cand_idx = corres(rand_idx, 1);
        cand_map_idx = corres(rand_idx, 2);

        pts_book_c = Fb(1:2,corres(:,1))';
        pts_scene_c = Fs(1:2,corres(:,2))';

         pts_book_r = Fb(1:2,cand_idx)';
         pts_scene_r = Fs(1:2,cand_map_idx)';
         [~,  H] = prob2_A(pts_book_r, pts_scene_r);

        % Homography
        tran_pts = zeros(length(pts_book_c), 2);
        for i=1:length(pts_book_c )
            tmp_p = H*[pts_book_c(i,:) 1]';
            tran_pts(i, :) = [tmp_p(1)/tmp_p(3) tmp_p(2)/tmp_p(3)];
        end    

        % Distance and Thres
        dist =  sqrt(sum((pts_scene_c - tran_pts).^2, 2));
        inlier =  find(dist < thres);
        

        % Record
        if(best_inlier_num < length(inlier))
            best_inlier_num = length(inlier);
            best_inlier = inlier;
            inlier_trans = tran_pts(inlier, :);
            best_H = H;
        end
        iter = iter +1;
    end

end

