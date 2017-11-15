function [corres, Fb,Db, Fs,Ds] = get_sift_and_corres(book_img,  scene_img, distRatioThres)
    book_img_pros = single(rgb2gray(book_img));
    scene_img_pros = single(rgb2gray(scene_img));
    [Fb,Db] = vl_sift(book_img_pros);
    [Fs,Ds] = vl_sift(scene_img_pros);
%     Fs([2,1],:) = Fs(1:2,:);
%     Fb([2,1],:) = Fb(1:2,:);
    corres = [];
    
    for i = 1:length(Db)
        dist = sqrt(sum((repmat(Db(:, i), 1, length(Ds)) - Ds).^2));
        [v, p] = min(dist);
        dist(p) = nan;
        [v2, p2] = min(dist);
        if(( (v2 - v) / v) > distRatioThres)
            corres= [corres;i, p];
        end
    end
end

