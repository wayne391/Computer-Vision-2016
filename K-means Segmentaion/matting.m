function [result, alpha] = matting(input, K, background_label, background_img)
    if(nargin < 4)
        bck = 0;
    else
        bck = 1;
    end
    input_format = input(end-2:end);
    
    
    if(strcmp(input_format, 'avi') || strcmp(input_format, 'mp4') )
        format = 2; % 2 for video
        v = VideoReader(input);
        frame_array = cell (v.NumberOfFrame, 1);
        for i = 1:v.NumberOfFrame
            frame_array{i} = read(v, i);
        end
        ref_img = frame_array{1};
    end
    if(strcmp(input_format, 'jpg') || strcmp(input_format, 'png') )
        format = 1; % 1 for image
        ref_img = imread(input);
    end

    
    %- Get Input -%
    imshow(ref_img);
    image = im2double(ref_img);
    [H, W, C] = size(image);
    stream_pts = reshape(image, H*W, 3)';

    [Y, X] = ginput(K);
    close all;
    
    mean_cluster = [];
    for i = 1:length(X)  
        mean_cluster = [mean_cluster, reshape( image(int16(X(i)), int16(Y(i)), :),3,1)];
    end
    
    color_check_input = zeros(100 , 100 * K, 3);
    for i = 0:K-1
        color_check_input( : , (i * 100 ) + 1: (i + 1 ) *100 , 1) = mean_cluster(1, i + 1);
        color_check_input( : , (i * 100 ) + 1: (i + 1 ) *100 , 2) = mean_cluster(2, i + 1);
        color_check_input( : , (i * 100 ) + 1: (i + 1 ) *100 , 3) = mean_cluster(3, i + 1);
    end

    %- Kmeans -%
    [lab, mean_cluster, J] = myKmeans(stream_pts,  0.01, K, mean_cluster);
    
    color_check_result = zeros(100 , 100 * K, 3);
    for i = 0:K-1
        color_check_result( : , (i * 100 ) + 1: (i + 1 ) *100 , 1) = mean_cluster(1, i + 1);
        color_check_result( : , (i * 100 ) + 1: (i + 1 ) *100 , 2) = mean_cluster(2, i + 1);
        color_check_result( : , (i * 100 ) + 1: (i + 1 ) *100 , 3) = mean_cluster(3, i + 1);
    end
    
    
    figure;
    subplot(2,1,1)
    imshow(color_check_input)
    title('User Input')
    subplot(2,1,2)
    imshow(color_check_result)
    title('Kmeans Result')
    
    %- Background Setting-%
    if(bck)
        background = imread(background_img);
        background =  im2double(imresize(background, [H, W]));
        back_stream = reshape(background, H*W, 3)';
    end
    
    %- Video -%
    if(format == 2)
        vn = VideoWriter('result.avi');
        v_alpha = VideoWriter('alpha.avi');
        open(vn);
        open(v_alpha);

        for f = 1:v.NumberOfFrame
            stream_pts = reshape(  im2double(frame_array{f}), H*W, 3)';
            stream_pts_alpha = ones(size( stream_pts));

            dis = [];
            for k = 1:K
                dis = [dis ;  sum((stream_pts - repmat(mean_cluster(:, k), 1, size(stream_pts, 2))) .^ 2).^0.5];
            end

            [~, lab]= min(dis);
            for li = 1:length(background_label)
                if(bck)
                    stream_pts(:, lab == background_label(li)) = back_stream(:, lab == background_label(li));
                else
                    stream_pts(:, lab == background_label(li)) = 0;
                end
                stream_pts_alpha(:, lab == background_label(li)) = 0;
            end
            
        %     figure;
            new_img = reshape(stream_pts', H, W, 3);
            new_img_alpha = reshape(stream_pts_alpha', H, W, 3);
        %     imshow(new_img);
            writeVideo(vn, new_img)
            writeVideo(v_alpha, new_img_alpha)
        %     imshow(new_img_alpha)
        end
        close(vn)
        close(v_alpha)
        result = vn;
        alpha = v_alpha;
    end
    
    %- Image -%
    if(format == 1)
         stream_pts = reshape(  im2double(ref_img), H*W, 3)';
         stream_pts_alpha = ones(size( stream_pts));
         dis = [];
         for k = 1:K
            dis = [dis ;  sum((stream_pts - repmat(mean_cluster(:, k), 1, size(stream_pts, 2))) .^ 2).^0.5];
         end

         [~, lab]= min(dis);
         for li = 1:length(background_label)
            if(bck)
                    stream_pts(:, lab == background_label(li)) = back_stream(:, lab == background_label(li));
            else
                stream_pts(:, lab == background_label(li)) = 0;
            end
            stream_pts_alpha(:, lab == background_label(li)) = 0;
         end
         
         result = reshape(stream_pts', H, W, 3);
         alpha = reshape(stream_pts_alpha', H, W, 3);
    end
    
end

