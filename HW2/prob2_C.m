function [imageALL, image_final] = prob2_C(MSVD_cl,  MSVD_cr, image, texture, points_left, points_right)

       imageL = prob2_C_sub(MSVD_cl, image, texture);
       figure;
       imshow(uint8(imageL ))
       imageALL = prob2_C_sub(MSVD_cr, imageL, texture);
       figure;
       imshow(uint8(imageALL ))
       
       image_final = imageALL;
       [m, n] = size(image);
       mask = poly2mask( points_left(:,2), points_left(:,1), m, n );
       for i = 1:m
           for j = 1:n
               if(mask(i,j))
                   image_final(i, j,:) = image(i ,j,:); 
               end
           end
       end
       mask = poly2mask( points_right(:,2), points_right(:,1), m, n );
       for i = 1:m
           for j = 1:n
               if(mask(i,j))
                   image_final(i, j,:) = image(i ,j,:); 
               end
           end
       end
       
       figure;
       imshow(uint8(image_final))

end
