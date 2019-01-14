function [falseDetection] =  MyBlobDetection(currentFrame, mat, dir, falseDetection)

[labeledImage, numberOfObjects] = bwlabel(mat);
    stats = regionprops(labeledImage,{'Area','BoundingBox','perimeter', 'Centroid', 'Orientation', 'ConvexImage'});

    if length(stats) ~= 1
        stats = struct2table(stats);
        checkLength=0;
    else
        checkLength = 1;
    end
    
    
% 1st metric: ratio between perimeter and round length of its bounding box
     stats.Metric1 = 2*sum(stats.BoundingBox(:,3:4),2)./stats.Perimeter;
     idx1 = abs(1 - stats.Metric1) < 0.3;
%2nd metric: ratio between blob area and it's bounding box's area
     stats.Metric2 = stats.Area./(stats.BoundingBox(:,3).*stats.BoundingBox(:,4));   
     idx2 = stats.Metric2 >= 0.45;
     
% 3rd metic: approximation of area size
     idx3 =  stats.Area >= 300;
     idx4 = stats.Orientation >= -10;
     finalIndex = idx1 & idx2 & idx3 & idx4;
     stats
     stats(~finalIndex,:) = [];
     stats
     
     if isempty(stats)
         falseDetection = falseDetection +1;
     else
         idFound = find(finalIndex==1);
         mat = ismember(labeledImage, idFound) ;
         boundingBox = stats.BoundingBox(1,:);
         index =1;
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
          newBoundingBoxData = transpose(newBoundingBoxData);

          imGG = mat;
          testFrame = currentFrame;
          if checkLength == 0
              for kk = 1:height(stats)
               imGG = insertShape(uint8(imGG),'rectangle', stats.BoundingBox(kk,:), 'LineWidth',2);
               testFrame = insertShape((currentFrame),'rectangle', newBoundingBoxData, 'LineWidth',2, 'color', 'green');
              end
          else 
              imGG = insertShape(uint8(imGG),'rectangle', stats.BoundingBox(1,:), 'LineWidth',2);
              testFrame = insertShape((currentFrame),'rectangle', newBoundingBoxData, 'LineWidth',2, 'color', 'green');

          end


          mat = mat | imGG;
    %        imwrite((testFrame), dir);
           imwrite((mat), dir);
     end
     




end