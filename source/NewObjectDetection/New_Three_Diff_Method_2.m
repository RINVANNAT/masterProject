
function New_Three_Diff_Method_2()

clear all;
close all;
clc;
      
        
     [I, x_o, H_k, Q_k, F_k, R_k, P_o] = setUpParametersKF();
%      x = zeros(8, 1);
     k =1;
     estimated_value = zeros(8, 1);
     estimated_value(:, 1) = x_o;
     prediction_value = zeros(8, 1);
     prediction_value = x_o;
     
     
     directoryName = '/Users/mac/Desktop/object_detection/manipulated_frame2/no_shifted/f4'; % path on my own mac
     directoryName1 = '/Users/mac/Desktop/object_detection/manipulated_frame2/no_shifted/f5'; % path on my own mac
     directoryName2 = '/Users/mac/Desktop/object_detection/manipulated_frame2/no_shifted/f6'; % path on my own mac
%      directoryName ='/Users/vannat/Desktop/Matlab_space/object_detection/f1'; % path on school mac
    %----reading video for displaying 
     videoread = vision.VideoFileReader('/Users/mac/Desktop/object_detection/official_video2.mov'); % own mac
%      videoread = vision.VideoFileReader('/Users/vannat/Desktop/Matlab_space/video_sample/official_video1.mov'); % school mac
     frame  = step(videoread);
     frame = rgb2gray(frame);
%      [frameHeight, frameWidth ] = size(frame);
     [point_, rightLine, slopeRightLine, interceptRightLine, leftLine, slopeLeftLine, interceptLeftLine, footCut] = get_ROI(frame);
    
     vanishingThreshold = 0;
     p1 = [ceil(point_(1,1)),ceil(point_(1,2))- vanishingThreshold];
     [p2, p3, p4, p5 ] = laneMonitoring(rightLine, leftLine, frame);
     propRight = [slopeRightLine, interceptRightLine];
     propLeft = [slopeLeftLine, interceptLeftLine];
     mask = mask_binary(frame, p1, p2, p3, p4, point_, propRight, propLeft, footCut);
    
   
    [tri_diff_frame, tri_frames, dual_diff_frames ] = init_three_frame(frame, mask, point_);
    loopIndex = 1;
    secondInstance = 5;
    previousVanishingPoint = point_;
    SE_2 = strel('disk',2);
    
    true = 1;
    CollectMeasureValue = zeros(2, 1);
    CollectBoundingBoxValue = zeros(4, 1);
    meas = zeros(4,1);
    checkLength = 0;
    detectionStatus = 0;
    startIndex = 0;
    doOnlyOnce =1;
    
        %% main loop 
         while ~ isDone(videoread)
             
              % --- create file image name for writing image
            fileName = [sprintf('%03d', loopIndex) '.jpg'];
            fullname = fullfile(directoryName, fileName);
            fullname1 = fullfile(directoryName1, fileName);
            fullname2 = fullfile(directoryName2, fileName);
             currentFrame = step(videoread);
%              imwrite((currentFrame), fullname);
             currentFrame = rgb2gray(currentFrame);
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
                         
                         
                         

                       if loopIndex >=1
                           
                           
                          
                           if detectionStatus == 1000
                               
                                level2_thres = 0.08;
                               mask  = newMask (stateVector, currentFrame, point_);
                               [dual_diff_frames(:,:,1), edge_S1]= frame_substraction(tri_frames(:,:,1), tri_frames(:,:,2), previousVanishingPoint, mask);
                                [dual_diff_frames(:,:,2), edge_S2]= frame_substraction(tri_frames(:,:,3), tri_frames(:,:,2), previousVanishingPoint, mask);
                                tri_diff_frame =  dual_diff_frames(:,:,1) + dual_diff_frames(:,:,2) ;
                                tri_diff_frame = imbinarize(tri_diff_frame, level2_thres);% won mac
                                resEdges = edge(edge_S1 ,'sobel');
                                tri_diff_frame = tri_diff_frame | resEdges;
                                
                                 tri_diff_frame = bwareaopen(tri_diff_frame, 9);
                                  mat =  imdilate(tri_diff_frame, SE_2);
                                 
                                
                           else
                                level2_thres = 0.055;
                                [dual_diff_frames(:,:,1), edge_S1]= frame_substraction(tri_frames(:,:,1), tri_frames(:,:,2), previousVanishingPoint, mask);
                                [dual_diff_frames(:,:,2), edge_S2]= frame_substraction(tri_frames(:,:,3), tri_frames(:,:,2), previousVanishingPoint, mask);
                                tri_diff_frame =  dual_diff_frames(:,:,1) + dual_diff_frames(:,:,2) ;
                                tri_diff_frame = imbinarize(tri_diff_frame, level2_thres);% won mac
                                resEdges = edge(edge_S1 ,'sobel');
                                [tri_diff_frame, resEdges] = hello(resEdges, tri_diff_frame, point_, p1,p2,p3,p4, propRight,propLeft);
                                tri_diff_frame = tri_diff_frame | resEdges;
                                tri_diff_frame = bwareaopen(tri_diff_frame, 5);
                                mat =  imdilate(tri_diff_frame, SE_2);
                               
                           end
                              if true == 1
                                 
                                 [stats, mat, meas,  CollectBoundingBoxValue, CollectMeasureValue] = blobDetection(mat, CollectBoundingBoxValue, CollectMeasureValue, detectionStatus, checkLength);
                                  if ~isempty(stats)
                                      detectionStatus =1;
                                      startIndex = startIndex +1;
                                  else
                                      detectionStatus = 0;
                                      
                                  end
                                  
%                                   [x, estimated_value, P_o] = realKF(meas, I, x_o, H_k, Q_k, F_k, R_k, P_o, x,estimated_value, (k-1));
%                                    imwrite((mat), fullname);
                              end
                               imwrite((currentFrame), fullname1);
                               imwrite((tri_diff_frame), fullname2);
                               estimated_value
                               prediction_value
                       end
                    end
                end
                
            end
            
            loopIndex=loopIndex+1;
           
            

         end
         %% end while loop
         estimated_value
   CollectMeasureValue
   CollectBoundingBoxValue
         
end






