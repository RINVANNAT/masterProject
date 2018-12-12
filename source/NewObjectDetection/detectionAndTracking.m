function detectionAndTracking()

    clear all;
    close all;
    clc;
    %% ---initialization of parameters---
    directoryName = '/Users/mac/Desktop/object_detection/manipulated_frame2/no_shifted/f4';
    directoryName1 = '/Users/mac/Desktop/object_detection/manipulated_frame2/no_shifted/f5';
    videoread = vision.VideoFileReader('/Users/mac/Desktop/object_detection/official_video2.mov'); 
    frame  = step(videoread);
    frame = rgb2gray(frame);
    [leftLine, rightLine, bottomTheshold] = houghLines(frame);
    vanishingPoint = leftLine.point2;
    p1 = vanishingPoint;
    mask = shaddingMask(p1, leftLine.point1, rightLine.point1, vanishingPoint, frame, bottomTheshold);
    [tri_diff_frame, tri_frames, dual_diff_frames ] = init_three_frame(frame, mask, vanishingPoint);
    
    %% ---end of initalization---
    
    
    
    countNumberFrame = 1;
    intervalShiftingFrame = 1;
    binaryThresold = 0.055;
    detectionStatus = 0;
    %% --- start the main loop of video ---
    tic
     while ~ isDone(videoread)
            fileName = [sprintf('%03d', countNumberFrame) '.jpg'];
            fullname = fullfile(directoryName, fileName);
            fullname1 = fullfile(directoryName1, fileName);
            currentFrame = step(videoread);
            currentFrame = rgb2gray(currentFrame);
         if (mod(countNumberFrame, intervalShiftingFrame) == 0)% condition for shifting the frame interval
             
             if countNumberFrame == intervalShiftingFrame % condition for updating the frame into the array of three-frame-differences in the first iteration
                  tri_frames = updateFrameInStackArray(tri_frames, currentFrame);
             else
                 tri_frames = updateFrameInStackArray(tri_frames, currentFrame); % updating the frame into the stack array of three-frame-differences
                 [dual_diff_frames(:,:,1), getFrame1]= frame_substraction(tri_frames(:,:,1), tri_frames(:,:,2), vanishingPoint, mask);
                 [dual_diff_frames(:,:,2), getFrame2]= frame_substraction(tri_frames(:,:,3), tri_frames(:,:,2), vanishingPoint, mask);
                 tri_diff_frame =  dual_diff_frames(:,:,1) + dual_diff_frames(:,:,2) ;
                 tri_diff_frame = imbinarize(tri_diff_frame, binaryThresold);
                 edgeDetection = edge(getFrame2, 'sobel');
                  tri_diff_frame = bwareaopen(tri_diff_frame, 5);
                 edgeDetection = bwareaopen(edgeDetection, 5);
                 [tri_diff_frame, edgeDetection] = hello(edgeDetection, tri_diff_frame, vanishingPoint, p1, leftLine.point1, rightLine.point1,p4, propRight,propLeft);
                 tri_diff_frame = tri_diff_frame | edgeDetection;
                 
                
                 
                 if countNumberFrame == 500
                     imshow(tri_diff_frame);
                 end
                 
             end
             
             
         end
         countNumberFrame = countNumberFrame +1;
         countNumberFrame
     end
     toc
     %% --- end the main loop of video ---







end