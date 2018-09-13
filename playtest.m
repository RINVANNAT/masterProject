function playtest()

clear all;
close all;
clc;
%      I1 = imread('/Users/vannat/Desktop/Matlab_space/object_detection/manipulate_frame2/f6/005.jpg');
%      I2 = imread('/Users/vannat/Desktop/Matlab_space/object_detection/manipulate_frame2/f6/010.jpg');
%      I3 = imread('/Users/vannat/Desktop/Matlab_space/object_detection/manipulate_frame2/f6/015.jpg');
%      
%      I1=im2double(I1);
%      I2=im2double(I2);
%      I3=im2double(I3);
%     
%      
%      [height, width] = size(I1);
%      subRes1 = zeros(height, width);
%      subRes2 = zeros(height, width);
%      for i = 220:height
%          
%          for j=1:width
%              
%             a = I1(i,j);
%             b =  I2(i,j);
%             c = I3(i,j);
%             if abs(a-b) > 0.065
%                       
%                 subRes1(i, j) = 1;
%             else
%                 subRes1(i, j) = 0;
%             end
%             if abs(b-c) > 0.065
%                       
%                 subRes2(i, j) = 1;
%             else
%                 subRes2(i, j) = 0;
%             end
%              
%              
%          end
%      end
%      SE_1 = strel('disk',1);
      SE_2 = strel('disk',1);
      
%      
%      res1 = (subRes1 & subRes2);
%     
%      
%      imshow(res1);title('&_operation');
%      figure();
%      res = (res1 | subRes1) | subRes2;
     
     tt = imread('/Users/vannat/Desktop/001.jpg');
     tt = im2double(tt);
     res = newPlay(tt);
      imshow(res);title('res before morphology');
     figure();
     
     res = imdilate(res, SE_2);
     imshow(res);title(' morphology');
     figure();
     
     [labeledImage, numberOfObjects] = bwlabel(res);
       
     stats = regionprops(labeledImage,{'Area','BoundingBox','perimeter', 'Centroid', 'Orientation', 'BoundingBox', 'ConvexImage'});
   
     ccc = struct2table(stats);
     ccc
     ccc.Metric1 = 2*sum(ccc.BoundingBox(:,3:4),2)./ccc.Perimeter;
     ccc.Metric1
     abs(1 - ccc.Metric1)
     check_id1 = abs(1 - ccc.Metric1) < 0.3;
     check_id1
     
     
     ccc.Metric2 = ccc.Area./(ccc.BoundingBox(:,3).*ccc.BoundingBox(:,4));
     
     
     check_id2 =  ccc.Metric2 > 0.5;
     check_id2 
     
     check_id3 =  ccc.Area >= 150;
     check_id3
     
     finalize_check = (check_id1 & check_id2) & check_id3;
     finalize_check
     index = find(  finalize_check == 1 );
   index
     ccc(~finalize_check,:) = [];

     res = ismember(labeledImage, index);
      
%        imshow((subRes1));title('duel1');
%        figure();
%        imshow((subRes2));title('duel2');
%        figure();
       imshow(res);title('res');
       
       hold on
        for kk = 1:8
        rectangle('Position', ccc.BoundingBox(kk,:),...
            'LineWidth',    3,...
            'EdgeColor',    'g',...
            'LineStyle',    ':');
        end
       
      
       
     
end