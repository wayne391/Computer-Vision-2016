clc; clear all; close all;
%% Initialization

addpath(genpath('.\vlfeat-0.9.20'))
book_data = dir('./part1_data/*.jpg');
book_img = cell(3, 1);
for i = 1:3
    book_img{i} = imread(['./part1_data/', book_data(i).name]);
end
scene_img = imread(['./part1_data/', book_data(4).name]);
%% Prob. A

for i = 1:3
    filename = book_img{i};
    
    % high thres
    [corres, Fb,Db, Fs,Ds] =  get_sift_and_corres(book_img{i},  scene_img, 0.20);
    fig_high = visualization_corres( book_img{i},  scene_img, Fb, Fs, corres);
    
    % low thres
    [corres, Fb,Db, Fs,Ds] =  get_sift_and_corres(book_img{i},  scene_img, 0.02);
    fig_low = visualization_corres( book_img{i},  scene_img, Fb, Fs, corres);
    
    saveas(fig_low,['./result/', book_data(i).name(1:end-4), '_low_thres', '.png'])
    saveas(fig_high,['./result/', book_data(i).name(1:end-4), '_high_thres', '.png'])
end
disp('done!!')
%% Prob. B, C

% % get book corner
% corner_list = cell(3,1);
% for bi = 1:3
%     imshow(book_img{bi});
%     corner = [];
%     hold on;
%     for i = 1:4
%         [clickX,clickY] = ginput(1);
%         corner = [corner;clickX, clickY];
%         scatter( clickX, clickY, 100, 'lineWidth', 3.5 , 'MarkerEdgeColor',[.3 .3 .3]);
%     end
%     corner_list{bi} = corner;
%     close all;
% end
% save('corner_list.mat', 'corner_list')

load('corner_list.mat')
for current_i = 1:3
    bimg = book_img{current_i};
    [best_H, corres, Fb, Fs,best_inlier,  inlier_trans] = myRANSAC(bimg,  scene_img, 0.04, 30, 5000);
    visualization_corres( book_img{current_i },  scene_img, Fb, Fs, corres, best_inlier,  inlier_trans );
    visualizeHomo( best_H, corner_list{current_i} , book_img{current_i}, scene_img)
end
