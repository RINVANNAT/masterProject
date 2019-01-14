function [stats, mat, meas,  CollectBoundingBoxValue, CollectMeasureValue] = blobDetection(mat, CollectBoundingBoxValue, CollectMeasureValue, detectionStatus, checkLength)



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
     idx4 = stats.Orientation >= -3;
     finalIndex = idx1 & idx2 & idx3 & idx4;
     stats(~finalIndex,:) = [];
     
     idFound = find(finalIndex==1);
     mat = ismember(labeledImage, idFound) ;
   
      imGG = mat;
      if checkLength == 0
          for kk = 1:height(stats)
           imGG = insertShape(uint8(imGG),'rectangle', stats.BoundingBox(kk,:), 'LineWidth',1);
          end
      else 
          imGG = insertShape(uint8(imGG),'rectangle', stats.BoundingBox(1,:), 'LineWidth',1);

      end

      CollectBoundingBoxValue = [CollectBoundingBoxValue,transpose(stats.BoundingBox) ];
      CollectMeasureValue = [CollectMeasureValue, transpose(stats.Centroid)];
      meas = 0;
%       if detectionStatus >0
%            meas = transpose(stats.BoundingBox);
%       else
%           [bbX, bbY, midX, midY, bbWidth, bbheight] = addJustingThreshold(transpose(stats.BoundingBox));
%           meas = [ midX; midY; bbWidth; bbheight];
%       end
      
      mat = mat | imGG;
      
      
      
      
end