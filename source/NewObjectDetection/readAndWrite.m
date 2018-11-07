function readAndWrite()

close all;
clear;
clc;

% images = cell(3,1);
% writerObj = VideoWriter('/Users/mac/Desktop/object_detection/n_v_1.avi');
% writerObj.FrameRate = 25;
% open(writerObj);
directoryName = '/Users/mac/Desktop/object_detection/newEx/f2';
    %----reading video for displaying 
     videoread = vision.VideoFileReader('/Users/mac/Desktop/object_detection/1.mov');
     frame  = step(videoread);
     
     [imgHeight, imgWidth, dim] = size(frame);
     
     loopIndex = 1;
     while ~ isDone(videoread)
         tic
        currentFrame = step(videoread);
        currentFrame= imresize(currentFrame, [imgHeight/2 ,imgWidth/2]);
        
%         images{loopIndex} = double(currentFrame);
        fileName = [sprintf('%03d', loopIndex) '.jpg'];
        fullname = fullfile(directoryName, fileName);
        
        
%          if loopIndex >= 1980 && loopIndex <= 2650
%               frameToWrite = im2frame(images{loopIndex});
%               writeVideo(writerObj, frameToWrite);
%               
%          end
    
            
             imwrite((currentFrame), fullname);
            loopIndex=loopIndex+1;
            toc
     end
     
     
end