
function New_Three_Diff_Method_2()

clear all;
close all;
clc;

   
     directoryName = '/Users/mac/Desktop/object_detection/manipulated_frame2/f2'; % path on my own mac
     directoryName1 = '/Users/mac/Desktop/object_detection/manipulated_frame2/f3'; % path on my own mac
%      directoryName ='/Users/vannat/Desktop/Matlab_space/object_detection/f1'; % path on school mac
    %----reading video for displaying 
     videoread = vision.VideoFileReader('/Users/mac/Desktop/object_detection/official_video1.mov'); % own mac
%      videoread = vision.VideoFileReader('/Users/vannat/Desktop/Matlab_space/video_sample/official_video1.mov'); % school mac
     frame  = step(videoread);
     frame = rgb2gray(frame);
     [frameHeight, frameWidth ] = size(frame);
     frame = imresize(frame, [frameHeight/2 frameWidth/2]);
     [point_, rightLine, slopeRightLine, interceptRightLine, leftLine, slopeLeftLine, interceptLeftLine] = get_ROI(frame);
    
     vanishingThreshold = 0;
     p1 = [ceil(point_(1,1)),ceil(point_(1,2))- vanishingThreshold];
     [p2, p3, p4, p5 ] = laneMonitoring(rightLine, leftLine, frame);
     propRight = [slopeRightLine, interceptRightLine];
     propLeft = [slopeLeftLine, interceptLeftLine];
     mask = mask_binary(frame, p1, p2, p3, p4, point_, propRight, propLeft);
   
    [tri_diff_frame, tri_frames, dual_diff_frames ] = init_three_frame(frame, mask, point_);
    
     
   
    loopIndex = 1;
    instance =100000000;
    secondInstance = 5;
%     previouseRightLine = rightLine;
%     previouseLeftLine = leftLine;
    previouseSlopeRight = slopeRightLine;
    previouseSlopeLeft = slopeLeftLine;
    previousVanishingPoint = point_;
    SE_2 = strel('disk',2);
    
    true = 0;
    
        %% main loop 
         while ~ isDone(videoread)
             currentFrame = step(videoread);
             currentFrame = rgb2gray(currentFrame);
             currentFrame = imresize(currentFrame, [frameHeight/2 frameWidth/2]);
            % --- create file image name for writing image
            fileName = [sprintf('%03d', loopIndex) '.jpg'];
            fullname = fullfile(directoryName, fileName);
            fullname1 = fullfile(directoryName1, fileName);
            
            %==========end===========================

            if loopIndex >= 1 && loopIndex <=inf
                
               
                if (mod(loopIndex, secondInstance) == 0)
                    
%                     if loopIndex == 5
%                         imshow(currentFrame);
%                         figure();
%                     end
                    if loopIndex == secondInstance
                        for idx=1:2
                         tri_frames(:, :, idx) = tri_frames(:, :, idx+1);
                        end
                        tri_frames(:,:,3) = currentFrame;
                    else
                        % mean index:[ 1==> image1, 2==> image5, 3==> image10 ]
                        for idx=1:2
                             tri_frames(:, :, idx) = tri_frames(:, :, idx+1);
                         end
                         tri_frames(:,:,3) = currentFrame;
                        
                         
                         %% recalculating lane marking
                        if (mod(loopIndex,instance) == 0)
                            check = 'do nothing'
                            tic
                            [currentVanishingPoint, currentRightLine, currentSlopeRightLine, currentInterceptRightLine, currentLeftLine, currentSlopeLeftLine, currentInterceptLeftLine] =  get_ROI(currentFrame);
        %                     currentVanishingPoint
                            if ~isempty(currentVanishingPoint)

                                 propRight = [currentSlopeRightLine, currentInterceptRightLine];
                                 propLeft = [currentSlopeLeftLine, currentInterceptLeftLine];
                                p1 = [ceil(currentVanishingPoint(1,1)),ceil(currentVanishingPoint(1,2))- vanishingThreshold];
                                [ p2, p3, p4, p5 ] = laneMonitoring(currentRightLine, currentLeftLine, currentFrame);
                                firstCriterionleft = 0;
                                firstCriterionright = 0;
                                secondCriterion = 0;

                                if currentSlopeLeftLine ~= 0 && currentSlopeRightLine ~= 0 
%                                     aleft = abs(previouseSlopeLeft - currentSlopeLeftLine)
%                                     maxxxleft = max(0.2*currentSlopeLeftLine, 0.1)
%                                     aright = abs(previouseSlopeRight - currentSlopeRightLine)
%                                     maxright = max(0.2*currentSlopeRightLine, 0.1)
%                                     currentVanishingPoint
%                                     pause;

                                    if abs(previouseSlopeLeft - currentSlopeLeftLine) < max(0.2*currentSlopeLeftLine, 0.1)
                                        
                                        firstCriterionleft = 1;
                                    end

                                    if abs(previouseSlopeRight - currentSlopeRightLine) < max(0.2*currentSlopeRightLine, 0.1)
                                        firstCriterionright = 1;
                                    end
                %                     firstCriterionleft
                %                     firstCriterionright

                                    if firstCriterionleft ~=1 || firstCriterionright ~=1
                                        mask = mask_binary(currentFrame, p1, p2, p3, p4, currentVanishingPoint, propRight, propLeft);
                                        previouseSlopeRight = currentSlopeRightLine;
                                        previouseSlopeLeft = currentSlopeLeftLine;
                                        previousVanishingPoint = currentVanishingPoint;
                                    end

                                end

                            end

                            toc
                        end
                        %% end of recalculating lane mark
                        
                        
                        
%                         for i = 1:2
%                             [dual_diff_frames(:,:,i), edge_S]= frame_substraction(tri_frames(:,:,i), tri_frames(:,:,i + 1), previousVanishingPoint, mask);
%                         end
                        [dual_diff_frames(:,:,1), edge_S1]= frame_substraction(tri_frames(:,:,1), tri_frames(:,:,2), previousVanishingPoint, mask);
                        [dual_diff_frames(:,:,2), edge_S2]= frame_substraction(tri_frames(:,:,3), tri_frames(:,:,2), previousVanishingPoint, mask);
                        
%                         imshow(dual_diff_frames(:,:,1));
%                         figure();
%                         imshow(dual_diff_frames(:,:,2));
%                         figure();
                        
                        
                          level1_thres = 0.015;
                          level2_thres = 0.035;
%                           binary1 = imbinarize(dual_diff_frames(:,:,1), level1_thres);% own mac
%                           binary2 = imbinarize(dual_diff_frames(:,:,2), level2_thres);% won mac
%                           binary1
                          
%                           binary1 = im2bw(dual_diff_frames(:,:,1), level1_thres); % school mac
%                           binary2 = im2bw(dual_diff_frames(:,:,2), level2_thres); % school mac
                          
                           tri_diff_frame =  dual_diff_frames(:,:,1) + dual_diff_frames(:,:,2) ;
                           tri_diff_frame = imbinarize(tri_diff_frame, level2_thres);% won mac
                           
%                            imshow(tri_diff_frame);
%                            title('without edge');
%                            figure();
                           
%                            imshow(tri_diff_frame);
%                            figure();
%                               resEdges = edge(edge_S1 ,'canny');
%                                resEdges = cannydetector(edge_S1);
                           
%                              tri_diff_frame = currentFrame.* mask;
%                                tri_diff_frame = tri_diff_frame | resEdges;
                               
%                                mat = hello(tri_diff_frame, point_, p1,p2,p3,p4, propRight,propLeft);
                               
%                                mat = bwareaopen(mat, 5);
%                                mat =  imdilate(mat, SE_2);
                               imwrite((currentFrame), fullname);
                               imwrite((tri_diff_frame), fullname1);
                              
                              
                              if true == 1
                                           
                                [labeledImage, numberOfObjects] = bwlabel(mat);
                                stats = regionprops(labeledImage,{'Area','BoundingBox','perimeter', 'Centroid', 'Orientation', 'ConvexImage'});
                                stats = struct2table(stats);
    % 
    %                            % 1st metric: ratio between perimeter and round length of its bounding box
                                 stats.Metric1 = 2*sum(stats.BoundingBox(:,3:4),2)./stats.Perimeter;
                                 idx1 = abs(1 - stats.Metric1) < 0.3;

    %                             %2nd metric: ratio between blob area and it's bounding box's area
                                 stats.Metric2 = stats.Area./(stats.BoundingBox(:,3).*stats.BoundingBox(:,4));   
                                idx2 = stats.Metric2 > 0.5;

    %                             % 3rd metic: approximation of area size
                                 idx3 =  stats.Area >= 300;
    %                              stats

                                 idx4 = stats.Orientation >= 0;
    % 
                                 finalIndex = idx1 & idx2 & idx3 & idx4;
                                 stats(~finalIndex,:) = [];
    %                              stats
                                 idFound = find(finalIndex==1);



    %                             
                                   mat = ismember(labeledImage, idFound) ;

                                  imGG = mat;
                                  for kk = 1:height(stats)
                                   imGG = insertShape(uint8(imGG),'rectangle', stats.BoundingBox(kk,:), 'LineWidth',1);
                                  end
            %                         imGG = im2bw(imGG);
                                   mat = mat | imGG;
            %                                imshow(mat);
            %                                pause;
                                       imwrite((mat), fullname);
                              end
                              
%                         
                          
                          
                    end
                end
                
            end
            
            loopIndex=loopIndex+1;
            loopIndex

         end
         %% end while loop
   
         
end






