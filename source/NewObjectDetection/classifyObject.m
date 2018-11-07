function object = classifyObject(tri_diff_frame)

                    [labeledImage, numberOfObjects] = bwlabel(tri_diff_frame);
                     stats = regionprops(labeledImage,{'Area','BoundingBox','perimeter', 'Centroid', 'Orientation', 'BoundingBox', 'ConvexImage'});
                     stats = struct2table(stats);
% % 
%                     % 1st metric: ratio between perimeter and round length of its bounding box
                      stats.Metric1 = 2*sum(stats.BoundingBox(:,3:4),2)./stats.Perimeter;
                      idx1 = abs(1 - stats.Metric1) < 0.3;
                      

  
                      %2nd metric: ratio between blob area and it's bounding box's area
                     stats.Metric2 = stats.Area./(stats.BoundingBox(:,3).*stats.BoundingBox(:,4));
                      idx2 = stats.Metric2 > 0.5;
%  
%                      % 3rd metic: approximation of area size
                      idx3 =  stats.Area >= 100;
%  
                      finalIndex = idx1 & idx2 & idx3 ;
                      stats(~finalIndex,:) = [];
  
%                     
%                      
%                      
                     
                      tri_diff_frame = ismember(labeledImage, idx3) ;
                      imGG = tri_diff_frame;
                      for kk = 1:height(stats)
                       imGG = insertShape(uint8(imGG),'rectangle', stats.BoundingBox(kk,:), 'LineWidth',1);
                      end
% 
                      imGG = im2bw(imGG);
                      object = tri_diff_frame | imGG;
                      
                     
end