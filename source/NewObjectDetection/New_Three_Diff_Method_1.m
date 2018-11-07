
function New_Three_Diff_Method_1()

clear all;
close all;
clc;

    %----reading video for displaying 
    v = VideoReader('/Users/vannat/Desktop/Matlab_space/video_sample/2.mov');
%     videoREADER = vision.VideoFileReader('/Users/mac/Desktop/object_detection/newVideoTest1_.mov');
%     info = get(videoREADER)
%     
%     pause;
    tic
     directoryName = '/Users/vannat/Desktop/Matlab_space/object_detection/manipulate_frame/NewExperiment/f3';
     
    videoread = read(v,[1, inf]);
    toc
    
    
    firstFrame = videoread(:,:,:,1);
    secondFrame = videoread(:,:,:,2);
    firstFrame = rgb2gray(firstFrame);
    secondFrame = rgb2gray(secondFrame);
    %--------end

    [frame1, point_,  RightLine, leftLine ] = get_ROI(firstFrame);
%     [sPL, ePL, sPR, ePR, x_intercept, y_intercept, botEndPR, botIntx, botInty] = getInitialStep(point_, frame1) ;
     p1 = [ceil(point_(1,1)),ceil(point_(1,2))];
     [p2, p3, p4, p5 ] = laneMonitoring(RightLine, leftLine, frame1);
     
     mask = mask_binary(frame1, p1, p2, p3, p4, point_);

   
    %----Mian Loob 
    
    prev1 = firstFrame;
    prev2 = secondFrame;
     SE_2 = strel('disk',1);
     SE_1 = strel('disk',1);
     instance = 1;
     loopIndex = 5;
     count = 1;
    for index=3:size(videoread,4)
        
            
            fileName = [sprintf('%03d', index) '.jpg'];
            fullname = fullfile(directoryName, fileName);
            currentFrame =  videoread(:,:,:,index);
            currentFrame = rgb2gray(currentFrame);
            
            if (mod(index,instance) == 0)
                
                
                if mod(index,10) == 0
                    tic
                    [frame, point_,  RightLine, leftLine ] = get_ROI(currentFrame);
                    p1 = [ceil(point_(1,1)),ceil(point_(1,2))];
                    [p2, p3, p4, p5 ] = laneMonitoring(RightLine, leftLine, frame);
                    mask = mask_binary(frame, p1, p2, p3, p4, point_);
                    toc
                end
                
                 tri_diff_frame = tri_diff_frame .* mask;
                
                
%                 [diff1, edgeFrame1] = frame_substraction_1(prev1, prev2, point_, mask) ;
%                 [diff2, edgeFrame2] = frame_substraction_1(prev2, currentFrame, point_, mask);

%                 level1_thres = 0.05;
%                 level2_thres = 0.05;
%                 binary1 = im2bw(diff1, level1_thres);
%                 binary2 = im2bw(diff2, level2_thres);
%                   tri_diff_frame =  binary1 & binary2 ;
%                     resEdges = edge(edgeFrame2 ,'sobel');
%                    resEdges1 = edge(edgeFrame1 ,'sobel');
%                     tri_diff_frame = tri_diff_frame | resEdges;
%                     tri_diff_frame = hello(tri_diff_frame, point_, p1,p2,p3,p4);
                  
%                      tri_diff_frame = bwareaopen(tri_diff_frame, 3);
%                       tri_diff_frame =  imdilate(tri_diff_frame, SE_1);
%                       tri_diff_frame = classifyObject(tri_diff_frame);
                      imwrite((tri_diff_frame), fullname);
                

                prev1 = prev2;
                prev2 = currentFrame; 
            end
        
            loopIndex = loopIndex +1;
           
           
    end
end






