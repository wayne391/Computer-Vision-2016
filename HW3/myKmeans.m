function [lab, mean_cluster, J] = myKmeans(stream_pts, threshold, K, mean_cluster)
    
    % ini
    len = size(stream_pts, 2);
    if(isempty(mean_cluster))
        ini_ptr = randi(len,1,K);
        mean_cluster = stream_pts(:, ini_ptr);
    end
    iteration_max = 50;
    iter = 1;
    
    % kmeans
    while(iter <= iteration_max)
        dis = [];
        for k = 1:K
            dis = [dis; sum( (stream_pts - repmat(mean_cluster(:, k), 1, len)).^2, 1)];
        end
        [~, lab] = min(dis);
        mean_old = mean_cluster;
        mean_cluster = [];
        for k = 1:K
            mean_cluster = [mean_cluster, mean(stream_pts(:, find(lab == k)), 2)];
        end
        
        J =   sum(sum((mean_cluster-mean_old).^2));
        if( J.^(1/2)/K < threshold ) break; end
        iter =  iter +1;
    end
end

