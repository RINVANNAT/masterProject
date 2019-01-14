function showImage()

close all;
clear all;
clc;
[measured_val, boundingBox]= Data_v1();
 videoread = vision.VideoFileReader('/Users/mac/Desktop/object_detection/official_video2.mov'); % own mac
 frame_mat = step(videoread);
 [leftLine, rightLine] = houghLines(frame_mat);
  directoryName = '/Users/mac/Desktop/object_detection/manipulated_frame2/with_no_meas'; % path on my own mac
 loopIn = 1;
 instance =5;
 index = 100;
 measured_val(index,:)
 boundingBox(index,:)
 true_val = zeros(2,200);
 
 newBoundingBoxData = zeros(4,200);
 
 while ~ isDone(videoread)
     currentFrame = step(videoread);
      fileName = [sprintf('%03d', loopIn) '.jpg'];
      fullname = fullfile(directoryName, fileName);
     
     if loopIn >= 10  && loopIn < 1001
         if (mod(loopIn, instance) == 0)
              index = (loopIn/5)-1;
              
              bbWidth = boundingBox(index, 3);
              bbheight = boundingBox(index, 4);
              bbX = boundingBox(index, 1);
              bbY = boundingBox(index, 2);
              bbY = bbY - (bbheight/2);
              bbWidth = bbWidth - 5;
              bbheight = bbheight + (bbheight/2);
              midX = bbX+(bbWidth/2);
              midY = bbY + (bbheight/2);
              
              newBoundingBoxData(:,index) = [bbX; bbY; bbWidth; bbheight];
              

%               imshow(currentFrame);
%               hold on;
%               plot( bbX, bbY, 'r*', 'LineWidth',1);
%               
%               rectangle('Position',[bbX, bbY, bbWidth, bbheight])
%               
%               plot( measured_val(index, 1), measured_val(index,2), 'g+', 'LineWidth',1);
%               plot( midX, midY, 'c*', 'LineWidth',1);
%               
%               plot( leftLine.point2(1, 1), leftLine.point2(1,2), 'y+', 'LineWidth',1);
%               title(strcat('img', num2str(loopIn), 'jpg'));
              
              currentFrame = insertShape(currentFrame,'rectangle', [bbX, bbY, bbWidth, bbheight], 'Color', 'blue','LineWidth',1);
              currentFrame = insertMarker(currentFrame,[midX,midY],'*','color','yellow','size',2);
              currentFrame = insertMarker(currentFrame,[bbX,bbY],'+','color','green','size',2);
%               currentFrame = insertMarker(currentFrame,[ measured_val(index, 1), measured_val(index,2)],'*','color','yellow','size',4);
             
              true_val(:,index) = [midX;  midY];
              true_val(:,index+1) = measured_val(index,:);
              
%               imwrite((currentFrame), fullname);
         end
     end
     
     loopIn = loopIn + 1;
    
     loopIn
 end
  newBoundingBoxData
end