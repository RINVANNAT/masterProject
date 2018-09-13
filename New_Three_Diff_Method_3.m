
function New_Three_Diff_Method_3()

clear all;
close all;
clc;
    directoryName = '/Users/vannat/Desktop/Matlab_space/object_detection/manipulate_frame2/f17';
    %----reading video for displaying 
     videoread = vision.VideoFileReader('/Users/vannat/Desktop/Matlab_space/video_sample/v_1.mov');
     frame  = step(videoread);
   
     [ maskBinary, vanishingPoint] = initializationProcess(frame);
   
    %--------end
    % -------- to play the transformed video
%          videoplay = vision.VideoPlayer; 
    %------end-----
    SE_2 = strel('disk',2);
    loopIndex = 1;
    instance =1;
     while ~ isDone(videoread)
         currentFrame = step(videoread);
         currentFrame = rgb2gray(currentFrame);
        % --- create file image name for writing image
        fileName = [sprintf('%03d', loopIndex) '.jpg'];
        fullname = fullfile(directoryName, fileName);
        %==========end===========================
        
        
        if (mod(loopIndex,instance) == 0)
          
             [ROI_segment] = ROISegementation(currentFrame, maskBinary, vanishingPoint);
             tic
              resEdges = edge(ROI_segment ,'sobel');
              testEdge = resEdges;
              toc
               tic
               resEdges1 =  newPlay(resEdges);
               
               toc
               resEdges = bwareaopen(resEdges1, 10);
               resEdges =  imdilate(resEdges, SE_2);
               [labeledImage, numberOfObjects] = bwlabel(resEdges);
               stats = regionprops(labeledImage,{'Area','BoundingBox','perimeter', 'Centroid', 'Orientation', 'BoundingBox', 'ConvexImage'});
               stats = struct2table(stats);
               
               % 1st metric: ratio between perimeter and round length of its bounding box
                stats.Metric1 = 2*sum(stats.BoundingBox(:,3:4),2)./stats.Perimeter;
                idx1 = abs(1 - stats.Metric1) < 0.3;
               
                %2nd metric: ratio between blob area and it's bounding box's area
                stats.Metric2 = stats.Area./(stats.BoundingBox(:,3).*stats.BoundingBox(:,4));
                idx2 = stats.Metric2 > 0.5;
                
                % 3rd metic: approximation of area size
                check_id3 =  stats.Area >= 200;
                
                finalIndex = idx1 & idx2 & check_id3;
                idFound = find(finalIndex==1);
                
                resEdges = ismember(labeledImage, idFound) ;
                
                imGG = resEdges;
                for kk = 1:height(stats)
                 imGG = insertShape(uint8(imGG),'rectangle', stats.BoundingBox(kk,:), 'LineWidth',1);
                end
                  
                    
                     imGG = im2bw(imGG);
                     resEdges = resEdges | imGG;
                    imwrite((resEdges), fullname);
        end
          loopIndex=loopIndex+1;
      end

          
       
         
         
end






