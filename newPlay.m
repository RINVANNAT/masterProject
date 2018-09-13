function erere = newPlay(I1)



%      I1 = imread('/Users/vannat/Desktop/001.jpg');
%     I1 = im2double(img);
     
%      p1 = [310,230];
%      p2 = [630,310];
%      p3 = [0,280];
%      p4 = [0,305];

p1 = [310,230];
     p2 = [630,310];
     p3 = [120, 300];
     p4 = [0,0];
     
     [height, width]= size(I1);
     res = zeros(height, width);
     
     for i = 230: height-50
         for j=1:width
             if I1(i, j) > 0.2
                 
               checkPoint = [j,i];
               trueValue = checkComponent(p3, p2, p1, checkPoint);
               if (trueValue == 1)
                       res(i,j)= 1;
               else
                   if (p4(1,1) ~= 0) || (p4(1,2) ~= 0)
                       trueValue_ = checkComponent(p4, p2, p3, checkPoint);
                       if (trueValue_ == 1)
                            res(i,j)= 1;
                       end
                   end

               end
             end
         end
     end
     
     erere = res;
     
end