function [leftLine, rightLine, footerCut] = houghLines(frame_mat)
[frameHeight, frameWidth ] = size(frame_mat);

       arrayLines_left = {[80,frameHeight-20],[315,218]};
       key_left = {'point1','point2'};
       leftLine = cell2struct(arrayLines_left,key_left,2);
       arrayLines_right = {[410,frameHeight-20],[315,218]};
       key_right = {'point1','point2'};
       rightLine = cell2struct(arrayLines_right,key_right,2);
        frame_mat(1:ceil(frameHeight/2), :) = 0;
        frame_mat(frameHeight-20:frameHeight, :) = 0;
       
%         imshow(frame_mat);
%         hold on;
%         plot([leftLine.point1(1,1), leftLine.point2(1,1)],[leftLine.point1(1,2), leftLine.point2(1,2)],'LineWidth',2,'Color','green');
%         plot([rightLine.point1(1,1), rightLine.point2(1,1)],[rightLine.point1(1,2), rightLine.point2(1,2)],'LineWidth',2,'Color','green');
%         pause;
      

%----- night video
%       arrayLines_left = {[80,360],[330,160]};
%       key_left = {'point1','point2'};
%       leftLine = cell2struct(arrayLines_left,key_left,2);
%       arrayLines_right = {[555,360],[330,160]};
%       key_right = {'point1','point2'};
%       rightLine = cell2struct(arrayLines_right,key_right,2);
      
      footerCut = 50;
end