clear all;
clc;
% Reading Rect.jpg and make it's blob image
Iblob = imread('/Users/vannat/Desktop/012.jpg');

% Iblob = imclearborder(I,4);

% measure perimeter and bounding box for each blob
stats = regionprops(Iblob,{'Area','BoundingBox','perimeter', 'Centroid'});
stats = struct2table(stats);

[labeledImage, numberOfObjects] = bwlabel(Iblob);
 imshow(Iblob); hold on
%  vislabels(labeledImage);
 numberOfObjects
 stats
 pause;



% 1st metric: ratio between perimeter and round length of its bounding box
stats.Metric1 = 2*sum(stats.BoundingBox(:,3:4),2)./stats.Perimeter;
idx1 = abs(1 - stats.Metric1) < 0.1;
% 2nd metric: ratio between blob area and it's bounding box's area
stats.Metric2 = stats.Area./(stats.BoundingBox(:,3).*stats.BoundingBox(:,4));
idx2 = stats.Metric2 > 0.8;
idx = idx1 & idx2;
stats(~idx,:) = [];
% show the result
imshow(Iblob);
hold on
for kk = 1:height(stats)
rectangle('Position', stats.BoundingBox(kk,:),...
    'LineWidth',    3,...
    'EdgeColor',    'g',...
    'LineStyle',    ':');
end




