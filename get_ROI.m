function [frame_, referencePoint] = get_ROI(frame)

%  for  i = 1:1
   
%   filename = strcat(num2str(i), '.jpg'); 
%   path_file = strcat('/Users/mac/Documents/MATLAB/pic/', filename);
%   frame = imread(path_file);
%   frame = rgb2gray(frame);
 
  
  height = size(frame,1);
  width = size(frame,2);
  pos1 = (2*width)/7;
  pos2 = height/4;
  pos3 = (5*width)/7 - (2*width)/7;
  pos4 = (3*height)/4 -height/4 ;
  pos = [pos1 pos2 pos3 pos4];
%   boxBounding(pos, frame);
  [referencePoint, final_point1, final_point2,frame_ ] = getRefPoint(frame);
  
%     imshow(frame);
%     hold on
%    plot( referencePoint(1,1),referencePoint(1,2),'x','LineWidth',4,'Color','red');
  
%    reference_point
   
  
    
%  end
 




end
